module Mux_Y #(parameter N=31)
				(input [N:0] input_1, input [N:0] input_2, input flag, output [N:0] out);

	assign mux_output = (flag==0) ? input_1:input_2;
 
endmodule