module Mips (
		input CLOCK_50, 
		input pause, 
		input reset, 
		input jal,
		input writeData
);

	wire [31:0]adress_pc_out, adress_pc_in, instruction;
	
	wire [31:0]out_rs, out_rt, out_rd; 
	
	wire [31:0]data;
	
	wire [31:0]offset;
	
	wire [31:0]read_data_2;
	
	wire [4:0]writeReg;
	
	wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	
	wire [2:0] ALUOp;
	
	PCCounter PCCounter_inst(.clk(CLOCK_50),.pause(pause),.reset(reset),.adress_pc_in(adress_pc_in),.adress_pc_out(adress_pc_out));
	
	PCAdder PCAdder_inst(.adress_to_add(adress_pc_out), .adress_added(adress_pc_in));
	
	InstructionMemory InstructionMemory_inst(.clk(CLOCK_50), .adress_memory_in(adress_pc_out), .instruction(instruction));
	
	ControlUnit ControlUnit_inst(instruction[31:26], RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
	
	Mux_N #(4) mux_1(.flag(RegDst), .input_1(instruction[20:16]), .input_2(instruction[15:11]), .out(writeReg));
	
   BankRegister BankRegister_inst(.clk(CLOCK_50), .PC(adress_pc_out), .writeData(writeData), .reset(reset), .jal(jal),  .rs(instruction[25:21]), .rt(instruction[20:16]), .rd(WriteReg), .out_rs(out_rs), .out_rt(out_rt), .out_rd(out_rd), .data(data));
	
	Mux_N mux_2(.flag(ALUSrc), .input_1(out_rt), .input_2(offset), .out(read_data_2));
	//signExtend();
	//	ArithmeticLogicUnit ArithmeticLogicUnit_inst();
	
	
endmodule

	
	
	
	