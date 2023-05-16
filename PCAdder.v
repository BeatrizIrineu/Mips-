module PCAdder(input PC, input [31:0]adress_to_add, output reg [31:0]adress_added);


	always @(adress_to_add)
		adress_added <= adress_to_add + 1;

endmodule