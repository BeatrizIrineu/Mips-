module mux_1( input [4:0]rt, input [4:0]rd, input RegDst, output [4:0]WriteReg);
	
	  assign WriteReg = (RegDst == 0) ? rt : rd;
	  
endmodule 