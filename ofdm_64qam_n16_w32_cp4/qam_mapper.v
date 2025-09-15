`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:05:59 02/10/2025 
// Design Name: 
// Module Name:    qam_mapper 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module qam_mapper #(
	parameter B = 8
)(
	
	input	wire				aclk,
	input	wire				reset,
	input wire	[7:0]		carrier_control,
	//slv
	input	wire	[B-1: 0]	s_data_in,
	input	wire				s_dvalid,
	output reg				s_dready,
	
	//mstr
	output reg	[31: 0]	m_data_out,
	input	wire				m_dready,
	output reg				m_dvalid,
	output reg				m_dlast,
	
	//testing regs
	output reg	[9 : 0]	m_symbol_index
	//output reg				fft_valid,
	//output reg	[5 : 0]  delay_c,
	//output reg  [2*B-1:0] carry_over,
	//output reg	[5:0]		co_count,
	//output reg	[8:0]		load_count
	//output reg				load_check

	);
	
	//Parameters
	parameter	N				= 16;  // number of samples holding data in fft frame
	localparam	FFT_INPUTS	= 2*N;// total number of samples in fft frame including mirrored conjugates
	
	parameter	M				= 64;
	parameter	LOG2M			= 6;
	parameter	FLIP			= 4'b0100;
	
	parameter	CP_LEN		= 4;	//cyclic prefix sample size
	
	parameter	DATA_HOLD	= 3;
	
	localparam	MAX_ITER		= 2*B/LOG2M;
	localparam	DELAY			= 2*(B/LOG2M) +(B%LOG2M!=0) -2;
	localparam	CP_GUARD		= DELAY + ((FFT_INPUTS + CP_LEN)	- ((2*B/LOG2M + (B%LOG2M!=0))*(LOG2M*N/B) ));
	
	localparam	MID			= (N/2);
	localparam	SB_SIZE		= (N-4)/4;
	
	
	//Internal signals
	reg			[(LOG2M-1) : 0]	qam_symbol	[(FFT_INPUTS-1) : 0];
	reg			[8 : 0]				load_count;
	reg			[5 : 0]				delay_c;
	reg			[7 : 0]				cp_padding;	
	reg			[2*B-1: 0]			carry_over;
	reg			[5 : 0]				co_count; //carry-over
//	reg			[5 : 0]				next_co_count;
	reg									load_check;
	reg									fft_valid;
	//reg			[9:0]					m_symbol_index;
	
	
	// Lookup table -- see LUT.txt for each M table
	reg signed	[15: 0]				qam_real		[(M-1) : 0];
	reg signed	[15: 0]				qam_imag		[(M-1) : 0];
	//				16-bit resolution to
	//				to match DAC
																										 //HEX // OCT
	initial begin
		qam_real[0]  	= -32736; qam_imag[0]  	= -32736; //-7   	-j7 // 8020 8020 //00 // 00            ---Conj = 04
		qam_real[1]  	= -32736; qam_imag[1]  	= -23383; //-7   	-j5 // 8020 A4A9 //01 // 01            ---Conj = 05
		qam_real[2]  	= -32736; qam_imag[2]  	=  -4677; //-7   	-j1 // 8020 EDBB //02 // 02            ---Conj = 06
		qam_real[3]  	= -32736; qam_imag[3]  	= -14030; //-7   	-j3 // 8020 C932 //03 // 03            ---Conj = 07
		qam_real[4]  	= -32736; qam_imag[4]  	=  32736; //-7		+j7 // 8020 7FE0 //04 // 04            ---Conj = 00
		qam_real[5]  	= -32736; qam_imag[5]  	=  23383; //-7 	+j5 // 8020 5B57 //05 // 05            ---Conj = 01
		qam_real[6]  	= -32736; qam_imag[6]  	=   4677; //-7 	+j1 // 8020 1245 //06 // 06            ---Conj = 02
		qam_real[7]  	= -32736; qam_imag[7]  	=  14030; //-7 	+j3 // 8020 36CE //07 // 07            ---Conj = 03
		
		qam_real[8]  	= -23383; qam_imag[8]  	= -32736; //-5   	-j7 // A4A9 8020 //08 // 10            ---Conj = 14
		qam_real[9]  	= -23383; qam_imag[9]  	= -23383; //-5   	-j5 // A4A9 A4A9 //09 // 11            ---Conj = 15
		qam_real[10] 	= -23383; qam_imag[10] 	=  -4677; //-5   	-j1 // A4A9 EDBB //0A // 12            ---Conj = 16
		qam_real[11] 	= -23383; qam_imag[11] 	= -14030; //-5   	-j3 // A4A9 C932 //0B // 13            ---Conj = 17
		qam_real[12] 	= -23383; qam_imag[12] 	=  32736; //-5		+j7 // A4A9 7FE0 //0C // 14            ---Conj = 10
		qam_real[13] 	= -23383; qam_imag[13] 	=  23383; //-5 	+j5 // A4A9 5B57 //0D // 15            ---Conj = 11
		qam_real[14] 	= -23383; qam_imag[14] 	=   4677; //-5 	+j1 // A4A9 1245 //0E // 16            ---Conj = 12
		qam_real[15]	= -23383; qam_imag[15] 	=  14030; //-5 	+j3 // A4A9 36CE //0F // 17            ---Conj = 13
		
		
		qam_real[16]  	=  -4677; qam_imag[16] 	= -32736; //-1   	-j7 // EDBB 8020 //10 // 20            ---Conj = 24
		qam_real[17]  	=  -4677; qam_imag[17]  = -23383; //-1   	-j5 // EDBB A4A9 //11 // 21            ---Conj = 25
		qam_real[18]  	=  -4677; qam_imag[18]  =  -4677; //-1   	-j1//  EDBB EDBB //12 // 22            ---Conj = 26
		qam_real[19]  	=  -4677; qam_imag[19]  = -14030; //-1   	-j3 // EDBB C932 //13 // 23            ---Conj = 27
		qam_real[20]  	=  -4677; qam_imag[20]  =  32736; //-1		+j7//  EDBB 7FE0 //14 // 24            ---Conj = 20
		qam_real[21]  	=  -4677; qam_imag[21]  =  23383; //-1 	+j5 // EDBB 5B57 //15 // 25            ---Conj = 21
		qam_real[22]  	=  -4677; qam_imag[22]  =   4677; //-1 	+j1 // EDBB 1245 //16 // 26            ---Conj = 22
		qam_real[23]  	=  -4677; qam_imag[23]  =  14030; //-1 	+j3 // EDBB 36CE //17 // 27            ---Conj = 23
		
		qam_real[24]  	= -14030; qam_imag[24]  = -32736; //-3   	-j7//  C932 8020 //18 // 30            ---Conj = 34
		qam_real[25]  	= -14030; qam_imag[25]  = -23383; //-3   	-j5 // C932 A4A9 //19 // 31            ---Conj = 35
		qam_real[26] 	= -14030; qam_imag[26] 	=  -4677; //-3   	-j1//  C932 EDBB //1A // 32            ---Conj = 36
		qam_real[27] 	= -14030; qam_imag[27] 	= -14030; //-3   	-j3 // C932 C932 //1B // 33            ---Conj = 37
		qam_real[28] 	= -14030; qam_imag[28] 	=  32736; //-3		+j7//  C932 7FE0 //1C // 34            ---Conj = 30
		qam_real[29] 	= -14030; qam_imag[29] 	=  23383; //-3 	+j5 // C932 5B57 //1D // 35            ---Conj = 31
		qam_real[30] 	= -14030; qam_imag[30] 	=   4677; //-3 	+j1 // C932 1245 //1E // 36            ---Conj = 32
		qam_real[31] 	= -14030; qam_imag[31] 	=  14030; //-3 	+j3 // C932 36CE //1F // 37            ---Conj = 33
	
		
		qam_real[32]  	=  32736; qam_imag[32]  = -32736; // 7   	-j7//  7FE0 8020 //20 // 40            ---Conj = 44
		qam_real[33]  	=  32736; qam_imag[33]  = -23383; // 7   	-j5 // 7FE0 A4A9 //21 // 41            ---Conj = 45
		qam_real[34]  	=  32736; qam_imag[34]  =  -4677; // 7   	-j1//  7FE0 EDBB //22 // 42            ---Conj = 46
		qam_real[35]  	=  32736; qam_imag[35]  = -14030; // 7   	-j3 // 7FE0 C932 //23 // 43            ---Conj = 47
		qam_real[36]  	=  32736; qam_imag[36]  =  32736; // 7		+j7//  7FE0 7FE0 //24 // 44            ---Conj = 40
		qam_real[37]  	=  32736; qam_imag[37]  =  23383; // 7 	+j5 // 7FE0 5B57 //25 // 45            ---Conj = 41
		qam_real[38]  	=  32736; qam_imag[38]  =   4677; // 7 	+j1 // 7FE0 1245 //26 // 46            ---Conj = 42
		qam_real[39]  	=  32736; qam_imag[39]  =  14030; // 7 	+j3 // 7FE0 36CE //27 // 47            ---Conj = 43
	
		qam_real[40]  	=  23383; qam_imag[40]  = -32736; // 5   	-j7 // 5B57 8020 //28 // 50            ---Conj = 54
		qam_real[41]  	=  23383; qam_imag[41]  = -23383; // 5   	-j5 // 5B57 A4A9 //29 // 51            ---Conj = 55
		qam_real[42] 	=  23383; qam_imag[42] 	=  -4677; // 5   	-j1 // 5B57 EDBB //2A // 52            ---Conj = 56
		qam_real[43] 	=	23383; qam_imag[43] 	= -14030; // 5   	-j3 // 5B57 C932 //2B // 53            ---Conj = 57
		qam_real[44] 	=  23383; qam_imag[44] 	=  32736; // 5		+j7 // 5B57 7FE0 //2C // 54            ---Conj = 50
		qam_real[45] 	=  23383; qam_imag[45] 	=  23383; // 5 	+j5 // 5B57 5B57 //2D // 55            ---Conj = 51
		qam_real[46] 	=  23383; qam_imag[46] 	=   4677; // 5 	+j1 // 5B57 1245 //2E // 56            ---Conj = 52
		qam_real[47] 	=  23383; qam_imag[47] 	=  14030; // 5 	+j3 // 5B57 36CE //2F // 57            ---Conj = 53
		
		
		qam_real[48] 	=   4677; qam_imag[48]  = -32736; // 1   	-j7 // 1245 8020 //30 // 60            ---Conj = 64
		qam_real[49]  	=   4677; qam_imag[49]  = -23383; // 1   	-j5 // 1245 A4A9 //31 // 61            ---Conj = 65
		qam_real[50]  	=   4677; qam_imag[50]  =  -4677; // 1   	-j1//  1245 EDBB //32 // 62            ---Conj = 66
		qam_real[51]  	=   4677; qam_imag[51]  = -14030; // 1   	-j3 // 1245 C932 //33 // 63            ---Conj = 67
		qam_real[52]  	=   4677; qam_imag[52]  =  32736; // 1		+j7//  1245 7FE0 //34 // 64            ---Conj = 60
		qam_real[53]  	=   4677; qam_imag[53]  =  23383; // 1 	+j5 // 1245 5B57 //35 // 65            ---Conj = 61
		qam_real[54]  	=   4677; qam_imag[54]  =   4677; // 1 	+j1 // 1245 1245 //36 // 66            ---Conj = 62
		qam_real[55]  	=   4677; qam_imag[55]  =  14030; // 1 	+j3 // 1245 36CE //37 // 67            ---Conj = 63
		
		qam_real[56]  	=  14030; qam_imag[56]  = -32736; // 3   	-j7//  36CE 8020 //38 // 70            ---Conj = 74
		qam_real[57]  	=  14030; qam_imag[57]  = -23383; // 3   	-j5 // 36CE A4A9 //39 // 71            ---Conj = 75
		qam_real[58] 	=	14030; qam_imag[58] 	=  -4677; // 3   	-j1//  36CE EDBB //3A // 72            ---Conj = 76
		qam_real[59] 	=  14030; qam_imag[59] 	= -14030; // 3   	-j3 // 36CE C932 //3B // 73            ---Conj = 77
		qam_real[60] 	=  14030; qam_imag[60] 	=  32736; // 3		+j7//  36CE 7FE0 //3C // 74            ---Conj = 70
		qam_real[61] 	=  14030; qam_imag[61] 	=  23383; // 3 	+j5 // 36CE 5B57 //3D // 75            ---Conj = 71
		qam_real[62] 	=  14030; qam_imag[62] 	=   4677; // 3 	+j1//  36CE 1245 //3E // 76            ---Conj = 72
		qam_real[63] 	=  14030; qam_imag[63] 	=  14030; // 3 	+j3 // 36CE 36CE //3F // 77            ---Conj = 73
	end	
	 
	integer i;
	integer j;
	
	
	always @(posedge aclk or posedge reset) begin		//INPUT LOGIC
		//integer temp_co_count;
		//temp_co_count = co_count;
		
		
		if (reset) begin
			load_count		<=	0;
			//m_symbol_index	<=	0;
			fft_valid 		<= 0;
			s_dready			<= 1;
			delay_c			<= 0;
			co_count			<= 0;
			carry_over		<= 0;
			load_check		<= 0;
		
		end else begin
			if (m_symbol_index == FFT_INPUTS -1) begin
				fft_valid <= 0;
			end
			case({s_dready, s_dvalid})
			
				2'b11: begin			//take in data and wait a bit
					load_check <= 1;
				
					if (load_count <  N -((B+co_count)/LOG2M)) begin
					
						qam_symbol[load_count] <= (M-1) & ( (carry_over<<(LOG2M-co_count)) | (s_data_in>>(B-LOG2M+co_count)) );
							
						for (i = 1; i < MAX_ITER; i = i+1) begin
							if ( (B+co_count) >= (i+1)*LOG2M ) begin
								qam_symbol[load_count+i] = (M-1) & (s_data_in >> ((B+co_count) - (i+1)*(LOG2M))); 
							end /*else begin
								break;
							end*/
						end
						
						co_count <= (B+co_count) - ((B+co_count)/LOG2M)*LOG2M;
						carry_over <= s_data_in & ((1'b1 << ((B+co_count) - ((B+co_count)/LOG2M)*LOG2M)) -1);
						load_count <= load_count + (B+co_count)/LOG2M;
						
						delay_c <= DELAY;
							
					end else begin////
							
						qam_symbol[load_count] = (M-1) & ( (carry_over<<(LOG2M-co_count)) | (s_data_in>>(B-LOG2M+co_count)) );
						qam_symbol[FFT_INPUTS-load_count] <= FLIP ^((M-1) & ( (carry_over<<(LOG2M-co_count)) | (s_data_in>>(B-LOG2M+co_count)) ));
						
						
						for (i = 1; i < MAX_ITER; i = i+1) begin
							if ( (B+co_count) >= (i+1)*LOG2M ) begin
								qam_symbol[load_count+i] = (M-1) & (s_data_in >> ((B+co_count) - (i+1)*(LOG2M)));
								qam_symbol[FFT_INPUTS-(load_count+1)] = FLIP^((M-1) & (s_data_in >> ((B+co_count) - (i+1)*(LOG2M))));
							end /*else begin
								break;
							end*/
						end
						
						for (j=0;j<N;j=j+1) begin
							qam_symbol[N+j] = FLIP^qam_symbol[N-j];
						end
						
						co_count <= (B+co_count) - ((B+co_count)/LOG2M)*LOG2M;
						carry_over <= s_data_in & ((1'b1 << ((B+co_count) - ((B+co_count)/LOG2M)*LOG2M)) -1);
						load_count <= 0;
						load_check <= 0;
						
						
						delay_c <= CP_GUARD; 		
						
						
					
					end
					
					s_dready <= 0;
					//delay_c <= DELAY;
							

					
				//if "next load count" is less than N				--> next load count will be load count + 

					
					
					
				
				end
				2'b00, 2'b01: begin	//not ready to take in any data, delay set to perform continuous communication
					
					delay_c <= delay_c -1;
					s_dready <= delay_c == 0;
					
					if ((load_count>= N/2) && (delay_c == 0)) begin
						fft_valid <= 1;
					end //else if(m_symbol_index == FFT_INPUTS -1) begin
						//fft_valid <= 0;//(CP_LEN > 0)? 0 : load_check;
					//end
					
					
				end
				2'b10: begin			//stand-by
					load_check <= 0;
				end
			
			endcase
		
		end
		
	
	
	end
	 
	
	always @(posedge aclk or posedge reset) begin
		if (reset) begin
			m_data_out <= 32'h00000000;
			m_dlast <= 0;
			m_dvalid <= 0;
			m_symbol_index	<=	0;
		end else if (fft_valid) begin
			m_dvalid <= 1;
			//disable carriers 0 and N
			if ((m_symbol_index == 0)||(m_symbol_index == N)) begin //LOGIC SWAPPED HERE PLEASE NOTICE
				m_data_out <= 32'h00000000;
				
			end else if ((m_symbol_index == 1)||(m_symbol_index == FFT_INPUTS-1)) begin
				m_data_out <= ((carrier_control>>1)&1'b1) ? 
									32'h7fe07fe0 : 
									32'h0;
				
			end else if ((m_symbol_index == MID)||(m_symbol_index == FFT_INPUTS-MID)) begin
				m_data_out <= ((carrier_control>>4)&1'b1) ?
									32'h7fe07fe0 :
									32'h0;
				
			end else if ((m_symbol_index == (N-1))||(m_symbol_index == FFT_INPUTS-(N-1))) begin
				m_data_out <= ((carrier_control>>7)&1'b1) ?
									32'h7fe07fe0 :
									32'h0;
				
			end else if (m_symbol_index < MID)begin
				m_data_out <= ((carrier_control>>(((m_symbol_index-2)/SB_SIZE)+2))&1'b1) ?
									32'h7fe07fe0 :
									32'h0;
			
			end else if (m_symbol_index < N) begin
				m_data_out <= ((carrier_control>>(((m_symbol_index-3)/SB_SIZE)+3))&1'b1) ?
									{qam_real[qam_symbol[m_symbol_index]], qam_imag[qam_symbol[m_symbol_index]]} :
									32'h0;			
			
			end else if (m_symbol_index < FFT_INPUTS-MID)begin
				m_data_out <= ((carrier_control>>((((FFT_INPUTS-m_symbol_index)-3)/SB_SIZE)+3))&1'b1) ?
									{qam_real[qam_symbol[m_symbol_index]], qam_imag[qam_symbol[m_symbol_index]]} :
									32'h0;			
			
			end else if(m_symbol_index < FFT_INPUTS) begin	
				m_data_out <= ((carrier_control>>((((FFT_INPUTS-m_symbol_index)-2)/SB_SIZE)+2))&1'b1) ?
									{qam_real[qam_symbol[m_symbol_index]], qam_imag[qam_symbol[m_symbol_index]]} :
									32'h0;
				
			end
			
			
			if (m_symbol_index == FFT_INPUTS -1) begin
				//fft_valid <= (CP_LEN>0) ? 0 : load_check;
				m_dlast <= 1;
				m_symbol_index <= 0;
			end else if (m_symbol_index < FFT_INPUTS) begin
				m_symbol_index <= m_symbol_index +1;
				m_dlast <= 0;
			end		
		end else begin
			m_dvalid <= 0;
			m_dlast <= 0;
		end
	end
	
	
	

endmodule
