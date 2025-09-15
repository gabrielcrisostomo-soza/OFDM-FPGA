`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:58:06 02/10/2025
// Design Name:   ofdm_top_module
// Module Name:   D:/Desktop/tcc/ofdm_16qam_n8_2n16_cp4/top_module_tb.v
// Project Name:  ofdm_16qam_n8_2n16_cp4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ofdm_top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////


//testlog
//set data gen to fixed value (stimulate 3+3j symbol always) -QAM
//		-data generator data value 8'haa in reset and default
//deactivated every carrier but one and its correspondent conjugate
//		--qam mod output logic if statement
// result not super conclusive.

//removed cyclic prefix expecting pure sine wave
//		--qam mod cp_len = 0
//		--qam mod last logic delay = default delay instead of cp_guard
//		--ifft manager config cp set to 0
//still wrong ifft output -- other files with same setting also found that output is slightly off expected
//suspicion on cp addition on core generation and different config data sizes and meaning
//		--regenerating core to see if it makes a difference
//regenerating core returned to expected result
//problem on config data when cp is enabled on core
//solved through brute force trying to find where to put schaling schedule
//
//now recovering original other configs
//		data gen still fixed value for testing
//		qam mod output also maintained
//		--qam mod cp_len = 4
//		--qam mod last logic delay = cp guard
//		--ifft manager config cp set to 4, along with brute force scaling solution

//		removing testing outputs of internal signals
//
//		working for test -- implementing on board
module top_module_tb;

	// Inputs
	reg clk;
	reg reset;



	// Outputs verify
	wire sclk;
	wire aclk;
	
	//DATA GENERATOR
	wire [7:0] gen_data;
	wire gen_valid;
	//reg map_ready;
	
	//SYMBOL MAP
	wire [31:0] qam_out;
	wire qam_valid;
	wire qam_last;
	//reg fft_ready;
	wire map_ready;
	//
	//IFFT
	
	wire [31:0] ofdm_rawdata;
	wire [7:0] ofdm_index;
	wire ofdm_valid;
	wire ofdm_last;
	wire [15:0] ofdm_digital_out;
	wire fft_ready;
	
	//SPI DAC
	wire cs_n;
	wire mosi;
	
	
	

	// Instantiate the Unit Under Test (UUT)
	ofdm_top_module uut (
		.clk(clk), 
		.reset(reset), 
		
		.sclk(sclk),/* 
		.aclk(aclk),
		
		.gen_data(gen_data),
		.gen_valid(gen_valid),
		//.map_ready(map_ready),
		
		.qam_out(qam_out),
		.qam_valid(qam_valid),
		.qam_last(qam_last),
		//.fft_ready(fft_ready),
		.map_ready(map_ready),
		
		.ofdm_rawdata(ofdm_rawdata),
		.ofdm_index(ofdm_index),
		.ofdm_last(ofdm_last),
		.ofdm_valid(ofdm_valid),
		.ofdm_digital_out(ofdm_digital_out),
		.fft_ready(fft_ready),
		*/
		.cs_n(cs_n),
		.mosi(mosi)
		
		
	);

	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		//map_ready = 0;
		//fft_ready = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		#10;
		//map_ready = 1;
		//fft_ready = 1;
		
		#10000;
        
		// Add stimulus here

	end
      
endmodule

