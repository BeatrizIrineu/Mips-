module Mips (
		input CLOCK_50, 
		input pause, 
		input reset, 
		input ALUSro,
		input RegDst,
		input jal,
		input write,
		input ALUControl,
		output wire[31:0]out_rs, 
		output wire[31:0]out_rt, 
		output wire[31:0]out_rd, 
		output wire [4:0]writeReg,
		output wire[31:0]instruction
		);

	wire [31:0]adress_pc_out;
	wire [31:0]adress_pc_in;
	wire [31:0]data;
	
	wire [31:0]offset;
	wire [31:0]readData2;
	
	
	PCCounter PCCounter_inst(.clk(CLOCK_50),.pause(pause),.reset(reset),.adress_pc_in(adress_pc_in),.adress_pc_out(adress_pc_out));
	
	PCAdder PCAdder_inst(.adress_to_add(adress_pc_out), .adress_added(adress_pc_in));
	
	InstructionMemory InstructionMemory_inst(.clk(CLOCK_50), .adress_memory_in(adress_pc_out), .instruction(instruction));
	
	mux_1 mux_inst(.RegDst(RegDst), .rt(instruction[20:16]), .rd(instruction[15:11]), .WriteReg(writeReg));
	
   BankRegister BankRegister_inst(.clk(CLOCK_50), .PC(adress_pc_out), .write(write), .reset(reset), .jal(jal),  .rs(instruction[25:21]), .rt(instruction[20:16]), .rd(WriteReg), .out_rs(out_rs), .out_rt(out_rt), .out_rd(out_rd), .data(data));
	
	//signExtend();
	
//	mux_2(.ALUSro(ALUSro), .out_rt(out_rt), .offset(offset), .readData2(readData2), .ALUControl(ALUControl));
	
endmodule

	
	
	
	