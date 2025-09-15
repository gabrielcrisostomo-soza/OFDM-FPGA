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
	 
	reg [15:0] lfsr16;
	reg [31:0] lfsr32;

	//assign valid = 1;
	
	always @(posedge aclk or posedge reset) begin
		if (reset) begin
			lfsr16 <= 16'hACE1;
			lfsr32 <= 32'hDEADBEEF;
			data <= 8'b1;
			//data <= 8'haa;
			valid <= 0;
		end else if (ready) begin
			lfsr16 <= {lfsr16[14:0], lfsr16[15]^lfsr16[13]^lfsr16[12]^lfsr16[10]};
			lfsr32 <= {lfsr32[30:0], lfsr32[31]^lfsr32[21]^lfsr32[1]^lfsr32[0]};
			data <= (lfsr16[7:0]^lfsr32[15:8]);
			//data <= 8'haa;
			valid <= 1;
		end else begin
			valid <= 1;
		end
		
	end


endmodule
