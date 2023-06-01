module Mux_N #(parameter N=31, parameter M=0)
 (input [N:0] input_1, input [N:0] input_2, input [N:0] input_3, input [M:0] flag, output [N:0] mux_output);

	assign mux_output = (flag == 0) ? input_1 : ((flag == 1) ? input_2 : input_3);
 
endmodule