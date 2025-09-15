`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:10 02/09/2025 
// Design Name: 
// Module Name:    master_clk_divisor 
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
module master_clk_divisor(

	input		wire	clk_in,
	input		wire	reset,
	output	reg	spi_sclk,	//50MHz, DAC max sclk speed
	output	reg	aclk			//~2,78 MHz = sclk/(spi_len) -> Max DAC sps

	);

	parameter a_div = 18*2;
	integer acounter = 0;
	 
	always @(posedge clk_in or posedge reset) begin
   
		if (reset) begin
			acounter <= 0;
			aclk 		<= 0;
			spi_sclk <= 0;
	
		end else begin
			spi_sclk <= ~spi_sclk;	//every 100MHz(clk posedge) clock toggle = 50MHz
			
			if (acounter == (a_div/2) -1) begin
				aclk <= ~aclk;
				acounter <= 0;
			
			end else begin
				acounter <= acounter + 1;
				
			end
		end
	end
endmodule
