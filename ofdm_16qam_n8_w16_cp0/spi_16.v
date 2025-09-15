`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:10 02/10/2025 
// Design Name: 
// Module Name:    spi_16 
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
module spi_16(

	input wire sclk,
	input wire reset,
	input wire [15:0] data_in,
	input wire valid,
	
	//output wire sclk_out,
	//output reg [15:0] spi_data,
	output reg mosi,
	output reg cs_n

    );
	 
    reg [15:0] spi_data;      // SPI data to send
    reg [5:0] bit_counter;    // Counter for bits sent
    reg [7:0] state;          // State machine
	 //reg cs_n;
    integer i;

	always @(posedge sclk or posedge reset) begin
		if (reset) begin
			state <= 0;
			cs_n <= 1;
			mosi <= 0;
			bit_counter <= 0;
			spi_data <= 16'b0;
			
		end else begin
			case (state)
				0: begin
					cs_n <= 1;
					
					if(valid) begin
						state <=1;
					end
				end
				1: begin
					cs_n <= 0;
					spi_data <= data_in;
					bit_counter <= 0;
					state <= 2;
				end
				2: begin
					if (bit_counter < 16) begin
						mosi <= spi_data[15];
						spi_data <= {spi_data[14:0],1'b0};
						bit_counter <= bit_counter +1;
					end else if (valid) begin
						cs_n <= 1;
						state <= 1;
					end else begin
						cs_n <= 1;
						state <= 0;
					end
				end
				default: begin
					state <= 0;
				end	
			endcase
		end	
	end

endmodule
