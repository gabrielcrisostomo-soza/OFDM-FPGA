`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:32:18 02/04/2025 
// Design Name: 
// Module Name:    ifft_manager 
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
module ifft_manager (
    input wire aclk,              // 100MHz Clock
    input wire aresetn,           // Active-low reset
	 
	 
    input wire [31:0] s_axis_data_tdata,    // 16-bit real, 16-bit imaginary
    input wire s_axis_data_tvalid,        // Data valid flag
	 input wire s_axis_data_tlast,
    output wire s_axis_data_tready,

	 
	 output wire [31:0] m_axis_data_tdata,
	 output wire [7:0] m_axis_data_tuser,
	 output wire m_axis_data_tvalid,
	 output wire m_axis_data_tlast,
    input wire m_axis_data_tready, // Now an input, controls when FFT output is accepted
	 
 // Ready for data // Ready for config
    output wire [15:0] m_axis_real_unsigned // Unsigned real output
);

	// Internal Signals
	// FFT Configuration Signals
	wire [23:0] s_axis_config_tdata = {5'b00000, 3'b000 ,1'b0, 4'b0000, 3'b100, 3'b000, 5'b00100}; // Configuration settings
	reg s_axis_config_tvalid;
	wire s_axis_config_tready;
	 
	assign m_axis_real_unsigned = m_axis_data_tdata[31:16] + 16'h8000;
	 

    // FFT Core Instance
    xfft_v8_0 fft_core (
        .aclk(aclk),
        //.aresetn(aresetn),
        
        // Configuration Interface
        .s_axis_config_tvalid(s_axis_config_tvalid),
        .s_axis_config_tready(s_axis_config_tready),
        .s_axis_config_tdata(s_axis_config_tdata),
        
        // Data Input Interface
        .s_axis_data_tdata(s_axis_data_tdata),
        .s_axis_data_tvalid(s_axis_data_tvalid),
        .s_axis_data_tlast(s_axis_data_tlast),
        .s_axis_data_tready(s_axis_data_tready),

        
        // Data Output Interface
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_data_tready(m_axis_data_tready), // Controlled externally now
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tuser(m_axis_data_tuser),
        .m_axis_data_tlast(m_axis_data_tlast)
    );


    // Configuration and Data Input Handling
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            s_axis_config_tvalid <= 1'b1; // Assert config valid on reset
        end else begin
            if (s_axis_config_tready) begin
                s_axis_config_tvalid <= 1'b0; // Deassert after one cycle
            end
        end
    end

endmodule


