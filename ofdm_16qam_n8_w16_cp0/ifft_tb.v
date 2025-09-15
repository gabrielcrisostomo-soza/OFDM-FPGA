`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:15:30 02/04/2025
// Design Name:   xfft_v8_0
// Module Name:   D:/Desktop/tcc/deftestda3/ifft_tb.v
// Project Name:  deftestda3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: xfft_v8_0
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ifft_tb;

	// Inputs
	reg aclk;
	reg s_axis_config_tvalid;
	reg s_axis_data_tvalid;
	reg s_axis_data_tlast;
	reg m_axis_data_tready;
	reg [23:0] s_axis_config_tdata;
	reg [31:0] s_axis_data_tdata;

	// Outputs
	wire s_axis_config_tready;
	wire s_axis_data_tready;
	wire m_axis_data_tvalid;
	wire m_axis_data_tlast;
	wire event_frame_started;
	wire event_tlast_unexpected;
	wire event_tlast_missing;
	wire event_status_channel_halt;
	wire event_data_in_channel_halt;
	wire event_data_out_channel_halt;
	wire [31:0] m_axis_data_tdata;
	wire [7:0] m_axis_data_tuser;

	// Instantiate the Unit Under Test (UUT)
	xfft_v8_0 uut (
		.aclk(aclk), 
		.s_axis_config_tvalid(s_axis_config_tvalid), 
		.s_axis_data_tvalid(s_axis_data_tvalid), 
		.s_axis_data_tlast(s_axis_data_tlast), 
		.m_axis_data_tready(m_axis_data_tready), 
		.s_axis_config_tready(s_axis_config_tready), 
		.s_axis_data_tready(s_axis_data_tready), 
		.m_axis_data_tvalid(m_axis_data_tvalid), 
		.m_axis_data_tlast(m_axis_data_tlast), 
		.event_frame_started(event_frame_started), 
		.event_tlast_unexpected(event_tlast_unexpected), 
		.event_tlast_missing(event_tlast_missing), 
		.event_status_channel_halt(event_status_channel_halt), 
		.event_data_in_channel_halt(event_data_in_channel_halt), 
		.event_data_out_channel_halt(event_data_out_channel_halt), 
		.s_axis_config_tdata(s_axis_config_tdata), 
		.s_axis_data_tdata(s_axis_data_tdata), 
		.m_axis_data_tdata(m_axis_data_tdata), 
		.m_axis_data_tuser(m_axis_data_tuser)
	);

	always #5 aclk = ~aclk;

	initial begin
		// Initialize Inputs
		aclk = 0;
		s_axis_config_tvalid = 0;
		s_axis_data_tvalid = 0;
		s_axis_data_tlast = 0;
		m_axis_data_tready = 1;
		s_axis_config_tdata = 0;
		s_axis_data_tdata = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		@(posedge aclk);
		s_axis_config_tdata = {5'b00000, 3'b000 ,1'b0, 4'b0000, 3'b010, 3'b000, 5'b00100};
		@(posedge aclk);
		s_axis_config_tvalid = 0;
		@(posedge aclk);
		s_axis_config_tvalid = 1;
		@(posedge aclk);
		s_axis_config_tvalid = 0;
		//
		@(posedge aclk);
		s_axis_data_tvalid = 1;
		s_axis_data_tdata = 32'h0; //0
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h80208020; //1
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h7fe07fe0;//32'h8020d5c5; //2
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h7fe07fe0;//32'h80207fe0;	//3
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h7fe07fe0;//32'h80202a33;	//4
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h7fe07fe0;//32'hd5cd8020;	//5
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h7fe07fe0;//32'hd5cdd5cd;	//6
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe07fe0;//32'h7fe07fe0;//32'hd5cd7fe0;	//7
		@(posedge aclk);
		s_axis_data_tdata = 32'h0;	//8
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h7fe08020;//32'hd5cd8020;	//9
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h7fe08020;//32'hd5cd2a33;	//10
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h7fe08020;//32'hd5cd7fe0;	//11
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h7fe08020;//32'h8020d5cd;	//12
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h7fe08020;//32'h80208020;	//13
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h7fe08020;//32'h80202a33;	//14
		@(posedge aclk);
		s_axis_data_tdata = 32'h7fe08020;//32'h80207fe0;	//15
		@(posedge aclk);
		s_axis_data_tvalid = 0;
		
		#10000;
        
		// Add stimulus here

	end
      
endmodule

