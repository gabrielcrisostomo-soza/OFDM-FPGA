`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:16 02/10/2025 
// Design Name: 
// Module Name:    source_gen1 
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
module source_gen1(
	input wire reset,
	input wire aclk,
	input wire ready,
	
	output reg [7:0] data,
	output reg valid

    );
	 
	reg [7:0] lfsr;

	//assign valid = 1;
	
	always @(posedge aclk or posedge reset) begin
		if (reset) begin
			lfsr <= 8'h1;
			data <= 8'h1;
			valid <= 0;
		end else if (ready) begin
			lfsr <= {lfsr[6:0], lfsr[7]^lfsr[5]^lfsr[4]^lfsr[3]};
			data <= lfsr;
			valid <= 1;
		end else begin
			valid <= 1;
		end
		
	end


endmodule
