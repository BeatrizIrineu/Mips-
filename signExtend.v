module signExtend
( input [1:0] bits_16_26,
  input [26:0] sign_to_extend_1,
  input [3:0] sign_to_extend_2,
  input [4:0] input_register,
  output [31:0] signal_extended
);
	
	assign signal_extended = (bits_16_26==0) ? {6'b0, sign_to_extend_1[25:0]}: ((bits_16_26 == 1) ? {28'b0, sign_to_extend_2[3:0]} : {16'b0, sign_to_extend_1[15:0]});
	
endmodule