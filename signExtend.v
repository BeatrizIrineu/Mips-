module signExtend(
  input [15:0] sign_to_extend,
  output [31:0] signal_extended
);

	assign signal_extended = {16'b0, sign_to_extend};
		
		
endmodule