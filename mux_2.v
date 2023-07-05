module mux_2(input ALUSro, input [31:0]out_rt, input [31:0]offset, output reg [31:0]readData2);
	always @(ALUSro)
		begin
		if (ALUSro == 1)
			begin 
			readData2 <= out_rt; 
			end 
		else
			begin
			readData2 <= offset; 
			end
		end 
endmodule 