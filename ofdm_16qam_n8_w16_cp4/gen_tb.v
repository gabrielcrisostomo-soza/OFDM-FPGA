`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:32:34 02/10/2025
// Design Name:   source_gen1
// Module Name:   D:/Desktop/tcc/ofdm_16qam_n8_2n16_cp4/gen_tb.v
// Project Name:  ofdm_16qam_n8_2n16_cp4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: source_gen1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module gen_tb;

	// Inputs
	reg reset;
	reg aclk;
	reg ready;

	// Outputs
	wire [7:0] data;
	wire valid;

	// Instantiate the Unit Under Test (UUT)
	source_gen1 uut (
		.reset(reset), 
		.aclk(aclk), 
		.ready(ready), 
		.data(data), 
		.valid(valid)
	);
	
	always #5 aclk = ~aclk;

	initial begin
		// Initialize Inputs
		reset = 1;
		aclk = 0;
		ready = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		#10;
		
		@(posedge aclk);
		ready = 1;
		#500;
      $finish;
		// Add stimulus here

	end
      
endmodule

