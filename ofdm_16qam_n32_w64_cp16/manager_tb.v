`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:48:33 02/04/2025
// Design Name:   ifft_manager
// Module Name:   D:/Desktop/tcc/deftestda3/manager_tb.v
// Project Name:  deftestda3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ifft_manager
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module manager_tb;
    
    reg aclk;
    reg aresetn;
    reg start;
    reg [31:0] data_in;
    reg data_valid;
    reg m_axis_data_tready;
    
    wire busy;
    wire done;
    wire [31:0] data_out;
    wire data_out_valid;
    wire s_axis_data_tready;
    wire s_axis_config_tready;
    wire [15:0] m_axis_real_unsigned;
    ////
    // Instantiate the FFT Manager
    ifft_manager uut (
        .aclk(aclk),
        .aresetn(aresetn),
        .start(start),
        .data_in(data_in),
        .data_valid(data_valid),
        .m_axis_data_tready(m_axis_data_tready),
        .busy(busy),
        .done(done),
        .data_out(data_out),
        .data_out_valid(data_out_valid),
        .s_axis_data_tready(s_axis_data_tready),
        .s_axis_config_tready(s_axis_config_tready),
        .m_axis_real_unsigned(m_axis_real_unsigned)
    );
    
    // Clock generation
    always #5 aclk = ~aclk; // 100MHz clock (10ns period)
    
    initial begin
        // Initialize signals
        aclk = 0;
        aresetn = 0;
        start = 0;
        data_in = 32'd0;
        data_valid = 0;
        m_axis_data_tready = 1;
        
        // Reset sequence
        #100;
        aresetn = 1;
        #10;
        
        // Apply FFT configuration
        @(posedge aclk);
        start = 1;
        
        // Provide the same test inputs as in ifft_tb
        data_valid = 1;
        data_in = 32'h0; //0
        @(posedge aclk);
        data_in = 32'h8020D5CD; //1
        @(posedge aclk);
        data_in = 32'h80208020; //2
        @(posedge aclk);
        data_in = 32'h80207FE0; //3
        @(posedge aclk);
        data_in = 32'h80208020; //4
        @(posedge aclk);
        data_in = 32'hD5CD8020; //5
        @(posedge aclk);
        data_in = 32'h80208020; //6
        @(posedge aclk);
        data_in = 32'h7FE08020; //7
        @(posedge aclk);
        data_in = 32'h0; //8
        @(posedge aclk);
        data_in = 32'h7FE07FE0; //9
        @(posedge aclk);
        data_in = 32'h80207FE0; //10
        @(posedge aclk);
        data_in = 32'hD5CD7FE0; //11
        @(posedge aclk);
        data_in = 32'h80207FE0; //12
        @(posedge aclk);
        data_in = 32'h80208020; //13
        @(posedge aclk);
        data_in = 32'h80207FE0; //14
        @(posedge aclk);
        data_in = 32'h780202A33; //15
		  
        
        // Mark last sample
        @(posedge aclk);
        data_valid = 0;
        start = 0;
        
        // Wait for FFT processing to complete
        wait(done);
        
        // Monitor results
        $display("FFT Completed. Output Data:");
        $monitor("Time=%0t | data_out=%h | real_unsigned=%h | valid=%b", 
                 $time, data_out, m_axis_real_unsigned, data_out_valid);
        
        #10000;
        $stop;
    end
    
endmodule

