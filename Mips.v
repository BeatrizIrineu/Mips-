module Mips (
		input CLOCK_50, 
		input pause, 
		input reset, 
		output Branch, MemRead, MemWrite, ALUSrc, RegWrite,
		output [31:0] out_rd, ALU_result, out_rs, out_rt,instruction,adress_pc_out, 
		output [3:0] ALUCtrl,
		output [1:0] ALUOp, RegDst, MemtoReg
		
);

//	wire Branch, MemRead, MemWrite, ALUSrc, RegWrite;
	
//	wire [1:0] ALUOp, RegDst, MemtoReg;
	
//	wire [3:0] ALUCtrl;
	
	wire [4:0]write_Reg;
	
	wire [31:0] adress_pc_in, offset, data, read_data, read_data_2, write_data, signal_extended;
	
	PCCounter PCCounter_inst(.clk(CLOCK_50),.pause(pause),.reset(reset),.adress_pc_in(adress_pc_in),.adress_pc_out(adress_pc_out));
	
	PCAdder PCAdder_inst(.adress_to_add(adress_pc_out), .adress_added(adress_pc_in));
	
	InstructionMemory InstructionMemory_inst(.clk(CLOCK_50), .adress_memory_in(adress_pc_out), .pause(pause), .instruction(instruction));
	
	ControlUnit ControlUnit_inst(.opcode(instruction[31:26]), .funct(instruction[5:0]), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
	
	Mux_N #(4,0) mux_1(.flag(RegDst), .input_1(instruction[20:16]), .input_2(instruction[15:11]),.input_3(instruction[15:11]), .mux_output(write_Reg));
	
   BankRegister BankRegister_inst(.clk(CLOCK_50), .PC(adress_pc_out), .RegWrite(RegWrite), .reset(reset), .rs(instruction[25:21]), .rt(instruction[20:16]), .rd(write_Reg), .out_rs(out_rs), .out_rt(out_rt), .out_rd(out_rd), .write_data(write_data));
	
	signExtend signExtend_inst(.sign_to_extend(instruction[15:0]), .signal_extended(signal_extended));
	
	Mux_N mux_2(.flag(ALUSrc), .input_1(out_rt), .input_2(signal_extended), .input_3(signal_extended), .mux_output(read_data_2));
	
	ALUControl(.funct(instruction[5:0]), .shamt(instruction[10:6]), .ALUOp(ALUOp), .ALUCtrl(ALUCtrl));
	
	ArithmeticLogicUnit ArithmeticLogicUnit_inst(.read_data_1(out_rs), .read_data_2(read_data_2), .ALUCtrl(ALUCtrl), .shamt(instruction[10:6]), .ALU_result(ALU_result));
	
	DataMemory DataMemory_inst(.write_data(read_data_2), .address(ALU_result[31:0]), .MemWrite(MemWrite), .MemRead(MemRead), .clk(CLOCK_50), .read_data(read_data));
	
	Mux_N #(31,1) mux_3(.flag(MemtoReg), .input_1(ALU_result), .input_2(read_data), .input_3(signal_extended), .mux_output(write_data));
	
endmodule

	
	
	
	