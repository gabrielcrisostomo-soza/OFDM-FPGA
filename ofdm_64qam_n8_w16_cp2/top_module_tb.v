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

module top_module_tb;

	// Inputs
	reg clk;
	reg reset;

	reg sw0;
	reg sw1;
	reg sw2;
	reg sw3;
	reg sw4;
	reg sw5;
	reg sw6;
	reg sw7;
	
	wire led0;
	wire led1;
	wire led2;
	wire led3;
	wire led4;
	wire led5;
	wire led6;
	wire led7;


	// Outputs verify
	wire sclk;
	//wire aclk;
	
	//DATA GENERATOR
	wire [7:0] gen_data;
	//wire gen_valid;
	//reg map_ready;
	
	//SYMBOL MAP
	wire [31:0] qam_out;
	wire qam_valid;
	wire qam_last;
	wire [9:0] qam_index;
	wire fft_ready;
	wire map_ready;
	
	//IFFT
	
	wire [31:0] ofdm_rawdata;
	wire [7:0] ofdm_index;
	//wire ofdm_valid;
	//wire ofdm_last;
	wire [15:0] ofdm_digital_out;
	//wire fft_ready;
	
	//SPI DAC
	wire cs_n;
	wire mosi;
	
	
	

	// Instantiate the Unit Under Test (UUT)
	ofdm_top_module uut (
		.clk(clk), 
		.reset(reset),
		
		.sw0(sw0),
		.sw1(sw1),
		.sw2(sw2),
		.sw3(sw3),
		.sw4(sw4),
		.sw5(sw5),
		.sw6(sw6),
		.sw7(sw7),
		
		.led0(led0),
		.led1(led1),
		.led2(led2),
		.led3(led3),
		.led4(led4),
		.led5(led5),
		.led6(led6),
		.led7(led7),
		
		.sclk(sclk), 
		//.aclk(aclk),
		
		.gen_data(gen_data),
		//.gen_valid(gen_valid),
		//.map_ready(map_ready),
		
		.qam_out(qam_out),
		.qam_valid(qam_valid),
		.qam_last(qam_last),
		.qam_index(qam_index),//aa
		.fft_ready(fft_ready),
		.map_ready(map_ready),
		
		.ofdm_rawdata(ofdm_rawdata),
		.ofdm_index(ofdm_index),
		//.ofdm_last(ofdm_last),
		//.ofdm_valid(ofdm_valid),
		.ofdm_digital_out(ofdm_digital_out),
		//.fft_ready(fft_ready),
		
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
		sw0 = 1;
		sw1 = 1;
		sw2 = 0;
		sw3 = 0;
		sw4 = 0;
		sw5 = 0;
		sw6 = 0;
		sw7 = 0;

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

