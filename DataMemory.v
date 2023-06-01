// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module DataMemory 

(
	input [31:0] write_data,
	input [5:0] address,
	input MemWrite, MemRead, clk,
	output [31:0] read_data
);

	// Declare the RAM variable
	reg [31:0] ram[31:0];
	// Variable to hold the registered read address
	
	always @ (posedge clk)
	begin
		// Write
		if (MemWrite)
			ram[address] <= write_data;	
	end
		
	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign read_data = ram[address];

endmodule
