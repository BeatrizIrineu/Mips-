module Mux_Y #(parameter N=31, parameter M=0)
(input [M:0] flag, input [N:0] input_1, input [N:0] input_2, output [N:0] mux_output);

	  assign mux_output = (flag == 0) ? input_1 : input_2;
 
endmodule
	
