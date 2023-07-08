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
	output clk, print, in,
	output [3:0] input_register,
	output [31:0] print_register, read_register_1, read_register_2,ALU_result, instruction, adress_pc_out, 
	output Branch, MemRead, MemWrite, ALUSrc, RegWrite, Jump, Jal,
	output [1:0] MemtoReg, bits_16_26, RegDst,
	output [3:0] ALUCtrl,
	output [4:0]target_or_destination,
	output [31:0] read_data, write_data, read_data_2, signal_extended, pc
		
);
	//wire [31:0] ALU_result, read_register_1, read_register_2;
	//wire [16:0] input_register;
	
	
	FrequencyDivider FrequencyDivider_inst(.clk_in(CLOCK_50),.clk_out(clk));
	
	Reader Reader_inst(.in(in), .sw0(sw0), .sw1(sw1), .sw2(sw2), .sw3(sw3), .input_register(input_register));
	
	GambDatapath GambDatapath_inst(.clk(clk), .reset(sw6), .pause(sw7), .enter(sw8), .input_register(input_register), .print_register(print_register), .read_register_1(read_register_1), .read_register_2(read_register_2), .ALU_result(ALU_result), .instruction(instruction), .adress_pc_out(adress_pc_out), .print(print), .in(in), .Branch(Branch), .MemRead(MemRead), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump), .Jal(Jal), .MemtoReg(MemtoReg), .bits_16_26(bits_16_26), .RegDst(RegDst), .ALUCtrl(ALUCtrl), .target_or_destination(target_or_destination), .read_data(read_data), .write_data(write_data), .read_data_2(read_data_2), .signal_extended(signal_extended), .pc(pc));
	
	FPGA FPGA_inst( .clk(clk), .print(print), .in(in), .read_register_1(read_register_1), .read_register_2(read_register_2), .print_register(print_register), .pc(pc),  .opcode(instruction[31:26]), .funct(instruction[5:0]), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6), .HEX7(HEX7));
	
	
	
endmodule

	
	
	
	