`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:47:05 02/11/2025
// Design Name:   ifft_manager
// Module Name:   D:/Desktop/tcc/ofdm_16qam_n8_2n16_cp4/cfgloader_tb.v
// Project Name:  ofdm_16qam_n8_2n16_cp4
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

module cfgloader_tb;

	// Inputs
	reg aclk;
	reg aresetn;
	reg [31:0] s_axis_data_tdata;
	reg s_axis_data_tvalid;
	reg s_axis_data_tlast;
	reg m_axis_data_tready;

	// Outputs
	wire s_axis_data_tready;
	wire [31:0] m_axis_data_tdata;
	wire [7:0] m_axis_data_tuser;
	wire m_axis_data_tvalid;
	wire m_axis_data_tlast;
	wire [15:0] m_axis_real_unsigned;
////
	// Instantiate the Unit Under Test (UUT)
	ifft_manager uut (
		.aclk(aclk), 
		.aresetn(aresetn), 
		.s_axis_data_tdata(s_axis_data_tdata), 
		.s_axis_data_tvalid(s_axis_data_tvalid), 
		.s_axis_data_tlast(s_axis_data_tlast), 
		.s_axis_data_tready(s_axis_data_tready), 
		.m_axis_data_tdata(m_axis_data_tdata), 
		.m_axis_data_tuser(m_axis_data_tuser), 
		.m_axis_data_tvalid(m_axis_data_tvalid), 
		.m_axis_data_tlast(m_axis_data_tlast), 
		.m_axis_data_tready(m_axis_data_tready), 
		.m_axis_real_unsigned(m_axis_real_unsigned)
	);

   always #5 aclk = ~aclk; // 100MHz clock (10ns period)

	initial begin
		// Initialize Inputs
		aclk = 0;
		aresetn = 0;
		
		s_axis_data_tdata = 32'b0;
		s_axis_data_tvalid = 0;
		s_axis_data_tlast = 0;
		
		m_axis_data_tready = 1;



		// Wait 100 ns for global reset to finish
		#100;
		aresetn = 1;
		#10;
        
		// Add stimulus here
      @(posedge aclk);

      s_axis_data_tvalid = 1;
      s_axis_data_tdata = 32'h0; //0
      @(posedge aclk);
      s_axis_data_tdata = 32'h7FE07FE0; //1
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //2
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //3
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //4
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //5
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //6
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //7
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //8
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //9
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //10
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //11
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //12
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //13
      @(posedge aclk);
      s_axis_data_tdata = 32'h0; //14
      @(posedge aclk);
      s_axis_data_tdata = 32'h7FE08020; //15
		
        
      // Mark last sample
      @(posedge aclk);
      s_axis_data_tvalid = 0;

        
      // Wait for FFT processing to complete
      wait(m_axis_data_tlast);
        
      // Monitor results

        
      #10000;
      $stop;
		

	end
      
endmodule

