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
	
	input wire sw0,
	input wire sw1,
	input wire sw2,
	input wire sw3,
	input wire sw4,
	input wire sw5,
	input wire sw6,
	input wire sw7,
	
	output wire led0,
	output wire led1,
	output wire led2,
	output wire led3,
	output wire led4,
	output wire led5,
	output wire led6,
	output wire led7,
	
	
	//actual outputs
	//output reg cs_n,
	//output reg mosi,
	//output reg sclk,
	
	//nonsense
	
	//clock
	output wire sclk,/*
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
	*/
	
	//spi
	output wire cs_n,
	output wire mosi
	

	
    );
	 
	wire aclk;
	
	wire mode;
	assign mode = sw0;
	wire [7:0] carrier_control;
	assign carrier_control = {sw7, sw6, sw5, sw4, sw3, sw2, sw1, 1'b0};
	
	assign led0 = sw0;
	assign led1 = sw1;
	assign led2 = sw2;
	assign led3 = sw3;
	assign led4 = sw4;
	assign led5 = sw5;
	assign led6 = sw6;
	assign led7 = sw7;
	
	
	
	
	
	//generator
	wire [7:0] gen_data;
	wire gen_valid;
	//input wire map_ready, //(map output)
	
	//mapper
	wire [31:0] qam_out;
	wire qam_valid;
	wire qam_last;
	//input wire fft_ready, //(fft output)
	wire map_ready;
	
	
	//fft
	wire [31:0] ofdm_rawdata;
	wire [7:0] ofdm_index;
	wire ofdm_valid;
	wire ofdm_last;
	wire [15:0] ofdm_digital_out;
	wire fft_ready;	

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
			.mode(mode),
			.data(gen_data),
			.valid(gen_valid)
    );

    qam_mapper #(.B(8)) qam_mod (
        .aclk(aclk),
        .reset(reset),
		  .carrier_control(carrier_control),
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
