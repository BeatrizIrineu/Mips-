module GambDatapath
(
	input clk, 
	input reset, enter,
	input [3:0] input_register,
	output [31:0] print_register, read_register_1, read_register_2, ALU_result, instruction, adress_pc_out, 
	output print, in, pause,
	output Branch, MemRead, MemWrite, ALUSrc, RegWrite, Jump, Jal, 
	output [1:0] MemtoReg, bits_16_26, RegDst,
	output [3:0] ALUCtrl,
	output [4:0]target_or_destination,
	output [31:0] read_data, write_data, read_data_2, signal_extended, pc
);
	
	
	PCCounter PCCounter_inst(.clk(clk),.pause(pause), .enter(enter), .in(in), .reset(reset),.adress_pc_in(pc),.adress_pc_out(adress_pc_out));
	
	InstructionMemory InstructionMemory_inst(.adress_memory_in(adress_pc_out), .instruction(instruction));
	
	ControlUnit ControlUnit_inst(.opcode(instruction[31:26]), .funct(instruction[5:0]), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg),.MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump), .Jal(Jal), .print(print), .in(in), .bits_16_26(bits_16_26), .pause(pause));
	
	ALUControl ALUControl_inst(.opcode(instruction[31:26]), .funct(instruction[5:0]), .shamt(instruction[10:6]),  .ALUCtrl(ALUCtrl));
	
	signExtend signExtend_inst(.bits_16_26(bits_16_26), .sign_to_extend_1(instruction[26:0]), .sign_to_extend_2(input_register), .signal_extended(signal_extended));
	
	Mux_N #(4,1) mux_0(.flag(RegDst), .input_1(instruction[20:16]), .input_2(instruction[15:11]), .input_3(instruction[25:21]), .mux_output(target_or_destination));
	
	//Mux_Y #(4,0) mux_1(.flag(RegDst), .input_1(instruction[20:16]), .input_2(instruction[15:11]), .mux_output(target_or_destination));
	
   Mux_Y #(31,0) mux_2(.flag(ALUSrc), .input_1(read_register_2), .input_2(signal_extended), .mux_output(read_data_2));
	
	BankRegister BankRegister_inst(.clk(clk), .pause(pause), .reset(reset), .RegWrite(RegWrite), .Jal(Jal), .source(instruction[25:21]), .target(instruction[20:16]), .target_or_destination(target_or_destination), .print_adress(instruction[15:11]), .read_register_1(read_register_1), .read_register_2(read_register_2), .print_register(print_register), .write_data(write_data), .pc(adress_pc_out));
	
	ArithmeticLogicUnit ArithmeticLogicUnit_inst(.source(instruction[25:21]), .read_data_1(read_register_1), .read_data_2(read_data_2), .ALUCtrl(ALUCtrl), .shamt(instruction[10:6]), .signal_extended(signal_extended), .ALU_result(ALU_result));
	
	DataMemory DataMemory_inst(.write_data_ram(read_register_2), .address(ALU_result[31:0]), .MemWrite(MemWrite), .MemRead(MemRead), .clk(clk), .read_data(read_data));
	
	Mux_N #(31,1) mux_5(.flag(MemtoReg), .input_1(ALU_result), .input_2(read_data), .input_3(signal_extended), .mux_output(write_data));
	
	PCAdder PCAdder_inst(.adress_to_add(adress_pc_out), .adress_added(pc), .Jal(Jal), .Jump(Jump), .JR(JR), .Branch(Branch), .jumpLinkAdress(signal_extended), .jumpAdress(signal_extended), .jumpRegister(read_register_1), .branchAdress(ALU_result));
	
	

endmodule
