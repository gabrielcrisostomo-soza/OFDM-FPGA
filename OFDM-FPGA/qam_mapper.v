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
	output reg				m_dlast
	
	//testing regs
	//output reg	[9 : 0]	m_symbol_index,
	//output reg				fft_valid,
	//output reg	[5 : 0]  delay_c,
	//output reg  [2*B-1:0] carry_over,
	//output reg	[5:0]		co_count,
	//output reg	[8:0]		load_count,
	//output reg				load_check

	);
	
	//Parameters
	parameter	N				= 8;  // number of samples holding data in fft frame
	localparam	FFT_INPUTS	= 2*N;// total number of samples in fft frame including mirrored conjugates
	
	parameter	M				= 16;
	parameter	LOG2M			= 4;
	parameter	FLIP			= 4'b0010;
	
	parameter	CP_LEN		= 4;	//cyclic prefix sample size
	
	parameter	DATA_HOLD	= 4;
	
	localparam	MAX_ITER		= 2*B/LOG2M;
	localparam	DELAY			= 2*(B/LOG2M)-2;
	localparam	CP_GUARD		= DELAY + ((FFT_INPUTS + CP_LEN)	- ((2*B/LOG2M + (B%LOG2M!=0))*(LOG2M*N/B) ));
	
	
	
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
	reg			[9:0]					m_symbol_index;
	
	//wire			[7:0]					carrier_control = 8'b00000010;
	
	
	// Lookup table -- see LUT.txt for each M table
	reg signed	[15: 0]				qam_real		[(M-1) : 0];
	reg signed	[15: 0]				qam_imag		[(M-1) : 0];
	//				16-bit resolution to
	//				to match DAC
	
	initial begin
		qam_real[0]  = -32736; qam_imag[0]  = -32736; //-1   -j1 //   8020 8020 //0             ---Conj = 2
		qam_real[1]  = -32736; qam_imag[1]  = -10803; //-1   -j.33 // 8020 D5CD //1             ---Conj = 3
		qam_real[2]  = -32736; qam_imag[2]  =  32736; //-1   +j1 //   8020 7FE0 //2             ---Conj = 0
		qam_real[3]  = -32736; qam_imag[3]  =  10803; //-1   +j.33 // 8020 2A33 //3             ---Conj = 1
		qam_real[4]  = -10803; qam_imag[4]  = -32736; //-.33 -j1 //   D5CD 8020 //4             ---Conj = 6
		qam_real[5]  = -10803; qam_imag[5]  = -10803; //-.33 -j.33 // D5CD D5CD //5             ---Conj = 7
		qam_real[6]  = -10803; qam_imag[6]  =  32736; //-.33 +j1 //   D5CD 7FE0 //6             ---Conj = 4
		qam_real[7]  = -10803; qam_imag[7]  =  10803; //-.33 +.33j // D5CD 2A33 //7             ---Conj = 5
		qam_real[8]  =  32736; qam_imag[8]  = -32736; //1   -j1 //    7FE0 8020 //8             ---Conj = A
		qam_real[9]  =  32736; qam_imag[9]  = -10803; //1   -j.33 //  7FE0 D5CD //9             ---Conj = B
		qam_real[10] =  32736; qam_imag[10] =  32736; //1   +j1 //    7FE0 7FE0 //A             ---Conj = 8
		qam_real[11] =  32736; qam_imag[11] =  10803; //1   +j.33 //  7FE0 2A33 //B             ---Conj = 9
		qam_real[12] =  10803; qam_imag[12] = -32736; //.33 -j1 //    2A33 8020 //C             ---Conj = E
		qam_real[13] =  10803; qam_imag[13] = -10803; //.33 -j.33 //  2A33 D5CD //D             ---Conj = F
		qam_real[14] =  10803; qam_imag[14] =  32736; //.33 +j1 //    2A33 7FE0 //E             ---Conj = C
		qam_real[15] =  10803; qam_imag[15] =  10803; //.33 +j.3 //  2A33 2A33 //F             ---Conj = D
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
							
						qam_symbol[load_count] <= (M-1) & ( (carry_over<<(LOG2M-co_count)) | (s_data_in>>(B-LOG2M+co_count)) );
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
					end else if(m_symbol_index == FFT_INPUTS -1) begin
						fft_valid <= (CP_LEN > 0)? 0 : load_check;
					end
					
					
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
			end else if ( (m_symbol_index < N) && (1'b1 & (carrier_control >> m_symbol_index))) begin
				m_data_out <= {qam_real[qam_symbol[m_symbol_index]], qam_imag[qam_symbol[m_symbol_index]]};
			end else if  ((m_symbol_index > N) && (1'b1 & (carrier_control >> (FFT_INPUTS - m_symbol_index)))) begin
				m_data_out <= {qam_real[qam_symbol[m_symbol_index]], qam_imag[qam_symbol[m_symbol_index]]};
			end else if(m_symbol_index < FFT_INPUTS) begin	
				m_data_out <= 32'h00000000;
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
