module signExtend
( input Jal,
  input [31:0] sign_to_extend,
  output [31:0] signal_extended
);
	assign signal_extended = (Jal==0) ? {16'b0, sign_to_extend[15:0]}:{6'b0, sign_to_extend[25:0]};
	
endmodule