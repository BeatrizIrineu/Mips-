module Mips (
		input CLOCK_50, 
		input pause, 
		input reset, 
		output Branch, MemRead, MemWrite, ALUSrc, RegWrite,RegDst, Jump, Jal,
		output [31:0] ALU_result, read_register_1,read_register_2, instruction, signal_extended,
		output [3:0] ALUCtrl,
		output [1:0] ALUOp, MemtoReg
		
);

//	wire Branch, MemRead, MemWrite, ALUSrc, RegWrite, RegDst, Jump, Jal;
	
//	wire [1:0] ALUOp, MemtoReg;
	
//	wire [3:0] ALUCtrl;
	
	wire [4:0]target_or_destination;
	
	wire [31:0] inicial_pc, offset, adress_pc_out, jumpAdress, read_data, write_data, read_data_2, final_pc, mux_pc_1,;

	PCCounter PCCounter_inst(.clk(CLOCK_50),.pause(pause),.reset(reset),.adress_pc_in(final_pc),.adress_pc_out(adress_pc_out));
	
	PCAdder PCAdder_inst(.adress_to_add(adress_pc_out), .adress_added(inicial_pc));
	
	InstructionMemory InstructionMemory_inst(.clk(CLOCK_50), .adress_memory_in(adress_pc_out), .pause(pause), .instruction(instruction));
	
	shiftLeft2 shiftLeft2_inst(.signToShift(instruction[25:0]), .adress_to_add(inicial_pc[31:28]), .jumpAdress(jumpAdress)); 
	
	Mux_N #(31,0) mux_0(.flag(Jump), .input_1(inicial_pc), .input_2(jumpAdress), .input_3(JumpAdress), .mux_output(mux_pc_1));
	
	ControlUnit ControlUnit_inst(.opcode(instruction[31:26]), .funct(instruction[5:0]), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump), .Jal(Jal));
	
	Mux_N #(4,0) mux_1(.flag(RegDst), .input_1(instruction[20:16]), .input_2(instruction[15:11]),.input_3(instruction[15:11]), .mux_output(target_or_destination));
	
   BankRegister BankRegister_inst(.clk(CLOCK_50), .reset(reset), .RegWrite(RegWrite), .Jal(Jal), .source(instruction[25:21]), .target(instruction[20:16]), .target_or_destination(target_or_destination), .read_register_1(read_register_1), .read_register_2(read_register_2), .write_data(write_data), .pc(inicial_pc));
	
	signExtend signExtend_inst(.Jal(Jal), .sign_to_extend(instruction[26:0]), .signal_extended(signal_extended));
	
	Mux_N #(31,0) mux_2(.flag(ALUSrc), .input_1(read_register_2), .input_2(signal_extended), .input_3(signal_extended), .mux_output(read_data_2));
	
	ALUControl(.funct(instruction[5:0]), .shamt(instruction[10:6]), .ALUOp(ALUOp), .ALUCtrl(ALUCtrl));
	
	ArithmeticLogicUnit ArithmeticLogicUnit_inst(.Jal(Jal), .pc(mux_pc_1), .source(instruction[25:21]), .read_data_1(read_register_1), .read_data_2(read_data_2), .ALUCtrl(ALUCtrl), .shamt(instruction[10:6]), .ALU_result(ALU_result));
	
	Mux_N #(31,0) mux_3(.flag(Jal), .input_1(mux_pc_1), .input_2(ALU_result), .input_3(ALU_result), .mux_output(final_pc));
	
	DataMemory DataMemory_inst(.write_data_ram(read_register_2), .address(ALU_result[31:0]), .MemWrite(MemWrite), .MemRead(MemRead), .clk(CLOCK_50), .read_data(read_data));
	
	Mux_N #(31,1) mux_4(.flag(MemtoReg), .input_1(ALU_result), .input_2(read_data), .input_3(signal_extended), .mux_output(write_data));
	
endmodule

	
	
	
	