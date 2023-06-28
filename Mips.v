module Mips (
		input clk, 
		input reset, pause,
		output [31:0] ALU_result, read_register_1, read_register_2
);

	wire Branch, MemRead, MemWrite, ALUSrc, RegWrite,RegDst, Jump, Jal;
	
	wire [1:0] MemtoReg;
	
	wire [3:0] ALUCtrl;
	
	wire [4:0]target_or_destination;
	
	wire [31:0] read_data, write_data, read_data_2, adress_pc_out, signal_extended, instruction, pc;

	PCCounter PCCounter_inst(.clk(clk),.pause(pause),.reset(reset),.adress_pc_in(pc),.adress_pc_out(adress_pc_out));
	
	InstructionMemory InstructionMemory_inst(.adress_memory_in(adress_pc_out), .pause(pause), .instruction(instruction));
	
	ControlUnit ControlUnit_inst(.opcode(instruction[31:26]), .funct(instruction[5:0]), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg),.MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump), .Jal(Jal));
	
	ALUControl ALUControl_inst(.opcode(instruction[31:26]), .funct(instruction[5:0]), .shamt(instruction[10:6]),  .ALUCtrl(ALUCtrl));
	
	signExtend signExtend_inst(.Jal(Jal), .sign_to_extend(instruction[26:0]), .signal_extended(signal_extended));
	
	Mux_Y #(4,0) mux_1(.flag(RegDst), .input_1(instruction[20:16]), .input_2(instruction[15:11]), .mux_output(target_or_destination));
	
   Mux_Y #(31,0) mux_2(.flag(ALUSrc), .input_1(read_register_2), .input_2(signal_extended), .mux_output(read_data_2));
	
	BankRegister BankRegister_inst(.clk(clk), .reset(reset), .RegWrite(RegWrite), .Jal(Jal), .source(instruction[25:21]), .target(instruction[20:16]), .target_or_destination(target_or_destination), .read_register_1(read_register_1), .read_register_2(read_register_2), .write_data(write_data), .pc(adress_pc_out));
	
	ArithmeticLogicUnit ArithmeticLogicUnit_inst(.source(instruction[25:21]), .read_data_1(read_register_1), .read_data_2(read_data_2), .ALUCtrl(ALUCtrl), .shamt(instruction[10:6]), .signal_extended(signal_extended), .ALU_result(ALU_result));
	
	DataMemory DataMemory_inst(.write_data_ram(read_register_2), .address(ALU_result[31:0]), .MemWrite(MemWrite), .MemRead(MemRead), .clk(clk), .read_data(read_data));
	
	Mux_N #(31,1) mux_5(.flag(MemtoReg), .input_1(ALU_result), .input_2(read_data), .input_3(signal_extended), .mux_output(write_data));
	
	PCAdder PCAdder_inst(.adress_to_add(adress_pc_out), .adress_added(pc), .Jal(Jal), .Jump(Jump), .JR(JR), .Branch(Branch), .jumpLinkAdress(instruction[26:0]), .jumpAdress(instruction[26:0]), .jumpRegister(read_register_1), .branchAdress(ALU_result));
	
	
endmodule

	
	
	
	