`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:44:01 02/10/2025
// Design Name:   qam_mapper
// Module Name:   D:/Desktop/tcc/ofdm_transmitter/tb_qam.v
// Project Name:  ofdm_transmitter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: qam_mapper
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_qam;

	// Inputs
	reg aclk;
	reg reset;
	reg [7:0] s_data_in;       //!!!!!!
	reg s_dvalid;
	reg m_dready;

	// Outputs
	wire s_dready;
	wire [31:0] m_data_out;
	wire m_dvalid;
	wire m_dlast;
	wire [9:0] m_symbol_index;
	//wire fft_valid;
	wire [5:0] delay_c;
	wire [15:0] carry_over;
	wire [5:0] co_count;
	wire [8:0] load_count;
	//wire load_check;
	

	// Instantiate the Unit Under Test (UUT)//
	qam_mapper #(.B(8)) uut (
		.aclk(aclk), 
		.reset(reset), 
		.s_data_in(s_data_in), 
		.s_dvalid(s_dvalid), 
		.s_dready(s_dready), 
		.m_data_out(m_data_out), 
		.m_dready(m_dready), 
		.m_dvalid(m_dvalid), 
		.m_dlast(m_dlast), 
		.m_symbol_index(m_symbol_index), //!!
		//.fft_valid(fft_valid),
		.delay_c(delay_c),
		.carry_over(carry_over),
		.co_count(co_count),
		.load_count(load_count)//,
		//.load_check(load_check)
		
	);

	always #5 aclk = ~aclk;

	initial begin
		// Initialize Inputs
		aclk = 0;
		reset = 1;
		s_data_in = 0;
		s_dvalid = 0;
		m_dready = 0;

		// Wait 100 ns for global reset to finish
		#50;
		reset = 0;
		#50;
		
		m_dready = 1;
		
		s_data_in = 8'h05;
		s_dvalid = 1;
		#10;
		//s_dvalid =0;
		
		#20;
		s_data_in = 8'h39;
		s_dvalid = 1;
		#10;
		//s_dvalid =0;

		#20;
		s_data_in = 8'h77;
		s_dvalid = 1;
		#10;
		s_dvalid =0;

		#20;
		s_data_in = 8'hfa;
		s_dvalid = 1;
		#10;
		s_dvalid =0;		
		
		#20;
		s_data_in = 8'hc6;
		s_dvalid = 1;
		#10;
		s_dvalid =0;	
		
		#20;
		s_data_in = 8'h88;
		s_dvalid = 1;
		#10;
		s_dvalid =0;	
		

		
		
        
		// Add stimulus here

	end
      
endmodule

