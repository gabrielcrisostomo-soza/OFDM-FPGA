`timescale 1ns / 1ps

module gen_tb2;

	// Inputs
	reg reset;
	reg aclk;
	reg ready;

	// Outputs
	wire [7:0] data;
	wire valid;

	// Instantiate the Unit Under Test (UUT)
	source_gen1 uut (
		.reset(reset), 
		.aclk(aclk), 
		.ready(ready), 
		.data(data), 
		.valid(valid)
	);

	// Clock Generation (100MHz)
	always #5 aclk = ~aclk; // 10ns period

	initial begin
		// Initialize Inputs
		reset = 1;
		aclk = 0;
		ready = 0;

		// Global Reset
		#100;
		reset = 0;
		#10;  // ? Ensure clock cycles before starting

		// Synchronize `ready` with `aclk`
		@(posedge aclk);
		ready = 1;
		
		// Run for 500 ns
		#500;
		$finish; // ? Stop simulation
	end
      
endmodule