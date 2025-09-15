`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:56:09 02/09/2025
// Design Name:   master_clk_divisor
// Module Name:   D:/Desktop/tcc/ofdm_transmitter/tb_clks.v
// Project Name:  ofdm_transmitter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: master_clk_divisor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_clks;

	// Inputs
	reg clk_in;
	reg reset;

	// Outputs
	wire spi_sclk;
	wire aclk;

	// Instantiate the Unit Under Test (UUT)
	master_clk_divisor uut (
		.clk_in(clk_in), 
		.reset(reset), 
		.spi_sclk(spi_sclk), 
		.aclk(aclk)
	);


	always #5 clk_in = ~clk_in; // 100MHz clock (10ns period)	

	initial begin
		// Initialize Inputs
		clk_in = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#95;
		reset = 0;
		
        
		// Add stimulus here
		
		#10000;

	end
      
endmodule

