module Reader(input in, input sw0, input sw1, input sw2, input sw3, output [3:0] input_register);
	
	reg [3:0] sw;
	
	assign input_register = (in == 1) ? {sw3, sw2, sw1, sw0} : 0;
		
	
endmodule
