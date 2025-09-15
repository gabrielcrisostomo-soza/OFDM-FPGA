`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:52:08 02/10/2025
// Design Name:   spi_16
// Module Name:   D:/Desktop/tcc/ofdm_transmitter/spi_tb.v
// Project Name:  ofdm_transmitter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: spi_16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module spi_tb;

	// Inputs
	reg sclk;
	reg reset;
	reg [15:0] data_in;
	//wire [15:0] spi_data;
	reg valid;
	//reg sclk;

	// Outputs
	wire mosi;
	wire cs_n;

	// Instantiate the Unit Under Test (UUT)
	spi_16 uut (
		.sclk(sclk), 
		.reset(reset), 
		//.spi_data(spi_data),
		.data_in(data_in), 
		.valid(valid),  
		.mosi(mosi), 
		.cs_n(cs_n)
	);

	always #5 sclk = ~sclk; 

	initial begin
		// Initialize Inputs
		sclk = 0;
		reset = 1;
		data_in = 0;
		valid = 0;

		// Wait 100 ns for global reset to finish
		#50;
		reset = 0;
		#50;
		
		valid =1;
		data_in = 16'ha5a5;
		#180;
		data_in = 16'h73ac; 
		#180;
		data_in = 16'h0123;
		#180;
		data_in = 16'h4567;
		#180;
		data_in = 16'h89ab;
		#180;		
      
		// Add stimulus here

	end
      
endmodule

