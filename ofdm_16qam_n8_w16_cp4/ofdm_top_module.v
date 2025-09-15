`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:48:28 02/10/2025 
// Design Name: 
// Module Name:    ofdm_top_module 
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
module ofdm_top_module(

	//actual inputs
	input wire clk,
	input wire reset,
	
	//actual outputs
	//output reg cs_n,
	//output reg mosi,
	//output reg sclk,
	
	//nonsense
	
	//clock
	output wire sclk,
	output wire aclk,
	
	
	
	//generator
	output wire [7:0] gen_data,
	output wire gen_valid,
	//input wire map_ready, //(map output)
	
	//mapper
	output wire [31:0] qam_out,
	output wire qam_valid,
	output wire qam_last,
	//input wire fft_ready, //(fft output)
	output wire map_ready,
	
	
	//fft
	output wire [31:0] ofdm_rawdata,
	output wire [7:0] ofdm_index,
	output wire ofdm_valid,
	output wire ofdm_last,
	output wire [15:0] ofdm_digital_out,
	output wire fft_ready,
	
	
	//spi
	output wire cs_n,
	output wire mosi
	

	
    );
	 
	//instantiation
	
	master_clk_divisor clk_gen (
			.clk_in(clk), 
			.reset(reset), 
			.spi_sclk(sclk), 
			.aclk(aclk)
    );
	 
	source_gen1 data_generator (
			.reset(reset),
			.aclk(aclk),
			.ready(map_ready),
			.data(gen_data),
			.valid(gen_valid)
    );

    qam_mapper #(.B(8)) qam_mod (
        .aclk(aclk),
        .reset(reset),
        .s_data_in(gen_data), //get gen data
        .s_dvalid(gen_valid),
        .s_dready(map_ready),  // Ready signal back to `source_gen1`
        .m_data_out(qam_out),
        .m_dready(fft_ready),  // Assume always ready for now
        .m_dvalid(qam_valid),
        .m_dlast(qam_last)
    );
	 
	 ifft_manager ifft_inst (
        .aclk(aclk),
        .aresetn(~reset),  // Active-low reset
        .s_axis_data_tdata(qam_out),  // Input data from QAM mapper
        .s_axis_data_tvalid(qam_valid),
        .s_axis_data_tlast(qam_last),
        .s_axis_data_tready(fft_ready),
        .m_axis_data_tdata(ofdm_rawdata),
        .m_axis_data_tuser(ofdm_index),
        .m_axis_data_tvalid(ofdm_valid),
        .m_axis_data_tlast(ofdm_last),
        .m_axis_data_tready(1'b1),  // Assume always ready for now
        .m_axis_real_unsigned(ofdm_digital_out)
    );
	 
    spi_16 spi_dac (
        .sclk(sclk),             // SPI clock
        .reset(reset),               // Reset signal
        .data_in(ofdm_digital_out), // IFFT real output as SPI input
        .valid(ofdm_valid),          // Send data when IFFT output is valid
        .mosi(mosi),                 // SPI MOSI line
        .cs_n(cs_n)                  // SPI chip select (active low)
    );

endmodule
