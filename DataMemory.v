// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module single_port_ram 

(
	input [31:0] data,
	input [5:0] address,
	input Write, clk,
	output [31:0] read_data
);

	// Declare the RAM variable
	reg [31:0] ram[31:0];
	// Variable to hold the registered read address
	
	always @ (posedge clk)
	begin
		// Write
		if (Write)
			ram[address] <= data;	
	end
		
	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign read_data = ram[address];

endmodule