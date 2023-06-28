module GambDatapath
(
input CLOCK_50, btn_in,
input [17:0] switches,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
output [6:0] HEX7,
output [6:0] HEX6,
output [6:0] HEX5,
output [6:0] HEX4,
output [6:0] HEX3,
output [6:0] HEX2,
output [6:0] HEX1,
output [6:0] HEX0,
output [8:0] LEDG,
output [17:0] LEDR,
inout [7:0] LCD_DATA
);
	
	wire clk, reset;
	wire [48:0] display;
	wire [31:0] ALU_result, read_register_1, read_register_2;
	
	Debounce Debounce_inst(.clk_in(CLOCK_50), .btn_in(btn_in), .clk_out(clk));
	
	Mips Mips(.clk(clk), .reset(switches[0]), .pause(switches[1]), .ALU_result(ALU_result), .read_register_1(read_register_1), .read_register_2(read_register_2));
	
	FPGA FPGA_inst(.clk(CLOCK_50), .read_register_1(read_register_1), .read_register_2(read_register_2), .ALU_ALU_result(ALU_ALU_result), .LCD_ON(LCD_ON),.LCD_BLON(LCD_ON),.LCD_RW(LCD_RW),.LCD_EN(LCD_EN), .LCD_RS(LCD_RS), .LCD_DATA(LCD_DATA));
	
	

endmodule
