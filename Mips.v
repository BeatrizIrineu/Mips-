module Mips (
	input CLOCK_50,
	input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8,
	output [6:0] HEX7,
	output [6:0] HEX6,
	output [6:0] HEX5,
	output [6:0] HEX4,
	output [6:0] HEX3,
	output [6:0] HEX2,
	output [6:0] HEX1,
	output [6:0] HEX0,
	output clk, print,
	output [31:0] ALU_result, read_register_1, read_register_2, instruction, adress_pc_out
		
);
	//wire [31:0] ALU_result, read_register_1, read_register_2;
	
	
	FrequencyDivider FrequencyDivider_inst(.clk_in(CLOCK_50),.clk_out(clk));
	
	//Reader Reader_inst(.pause(sw7), .read(sw8), .sw0(sw0), .sw1(sw1), .sw2(sw2), .sw3(sw3), .sw4(sw4), .sw5(sw5), instruction);
	
	GambDatapath GambDatapath_inst(.clk(clk), .reset(sw6), .pause(sw7), .read(sw8), .ALU_result(ALU_result), .read_register_1(read_register_1), .read_register_2(read_register_2), .instruction(instruction), .adress_pc_out(adress_pc_out), .print(print));
	
	FPGA FPGA_inst( .clk(clk), .print(print), .read_register_1(read_register_1), .read_register_2(read_register_2), .ALU_result(ALU_result), .opcode(instruction[31:26]), .funct(instruction[5:0]), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6), .HEX7(HEX7));
	
	
	
endmodule

	
	
	
	