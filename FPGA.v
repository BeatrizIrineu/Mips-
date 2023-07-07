module FPGA (
  input clk,print, in, 
  input [31:0] read_register_1, read_register_2, print_register, pc,
  input [6:0] opcode, funct,
	output reg [6:0] HEX7,
	output reg [6:0] HEX6,
	output reg [6:0] HEX5,
	output reg [6:0] HEX4,
	output reg [6:0] HEX3,
	output reg [6:0] HEX2,
	output reg [6:0] HEX1,
	output reg [6:0] HEX0
  
);
 

 always @(clk, pc, in)
	begin 
	
	if (pc == 1)
	begin 
		HEX0 =  7'b1000000; // 0
		HEX1 =  7'b1000000; // 0
		HEX2 =  7'b1000000; // 0
		HEX3 =  7'b1111001; // 0
		HEX4 =  7'b1111001; // 0
		HEX5 =  7'b1000000; // 0
		HEX6 =  7'b1000000; // 0
		HEX7 =  7'b1000000; // 0
	end 
	
	else 
	begin
		integer first_digit_pc;
		integer second_digit_pc;
				
		first_digit_pc	= (pc / 10);
		second_digit_pc = (pc % 10);
		
		if (in == 1)
		begin 
			HEX2 =  7'b1111001; // 1
			HEX3 =  7'b1111001; // 1
		end
		else if(in != 1)
		begin
			case (first_digit_pc)
				0: HEX3 =  7'b1000000; // 0
				1: HEX3 =  7'b1111001; // 1
				2: HEX3 = 7'b0100100; // 2
				3: HEX3 = 7'b0110000; // 3
				4: HEX3 = 7'b0011001; // 4
				5: HEX3 = 7'b0010010; // 5
				6: HEX3 = 7'b0000010; // 6
				7: HEX3 = 7'b1111000; // 7
				8: HEX3 = 7'b0000000; // 8
				9: HEX3 = 7'b0010000; // 9
			endcase

			case (second_digit_pc)
				0: HEX2 = 7'b1000000; // 0
				1: HEX2 = 7'b1111001; // 1
				2: HEX2 = 7'b0100100; // 2
				3: HEX2 = 7'b0110000; // 3
				4: HEX2 = 7'b0011001; // 4
				5: HEX2 = 7'b0010010; // 5
				6: HEX2 = 7'b0000010; // 6
				7: HEX2 = 7'b1111000; // 7
				8: HEX2 = 7'b0000000; // 8
				9: HEX2 = 7'b0010000; // 9
			endcase
		end
		if (print === 1)
		begin
			integer first_digit_register_1;
			integer second_digit_register_1;
					
			integer first_digit_register_2;
			integer second_digit_register_2;
					
			integer first_digit_print_register;
			integer second_digit_print_register;
					
			first_digit_register_1	= (read_register_1 / 10);
			second_digit_register_1 = (read_register_1 % 10);
					
			first_digit_register_2 = (read_register_2 / 10);
			second_digit_register_2 = (read_register_2 % 10);
									
					
			first_digit_print_register = (print_register / 10);
			second_digit_print_register = (print_register % 10);
					
					
			case (first_digit_register_1)
				0: HEX7 = 7'b1000000; // 0
				1: HEX7 = 7'b1111001; // 1
				2: HEX7 = 7'b0100100; // 2
				3: HEX7 = 7'b0110000; // 3
				4: HEX7 = 7'b0011001; // 4
				5: HEX7 = 7'b0010010; // 5
				6: HEX7 = 7'b0000010; // 6
				7: HEX7 = 7'b1111000; // 7
				8: HEX7 = 7'b0000000; // 8
				9: HEX7 = 7'b0010000; // 9
			endcase

			case (second_digit_register_1)
				0: HEX6 =  7'b1000000; // 0
				1: HEX6 =  7'b1111001; // 1
				2: HEX6 = 7'b0100100; // 2
				3: HEX6 = 7'b0110000; // 3
				4: HEX6 = 7'b0011001; // 4
				5: HEX6 = 7'b0010010; // 5
				6: HEX6 = 7'b0000010; // 6
				7: HEX6 = 7'b1111000; // 7
				8: HEX6 = 7'b0000000; // 8
				9: HEX6 = 7'b0010000; // 9
			endcase
					
			case (first_digit_register_2)
				0: HEX5 =  7'b1000000; // 0
				1: HEX5 =  7'b1111001; // 1
				2: HEX5 = 7'b0100100; // 2
				3: HEX5 = 7'b0110000; // 3
				4: HEX5 = 7'b0011001; // 4
				5: HEX5 = 7'b0010010; // 5
				6: HEX5 = 7'b0000010; // 6
				7: HEX5 = 7'b1111000; // 7
				8: HEX5 = 7'b0000000; // 8
				9: HEX5 = 7'b0010000; // 9
			endcase

			case (second_digit_register_2)
				0: HEX4 =  7'b1000000; // 0
				1: HEX4 =  7'b1111001; // 1
				2: HEX4 = 7'b0100100; // 2
				3: HEX4 = 7'b0110000; // 3
				4: HEX4 = 7'b0011001; // 4
				5: HEX4 = 7'b0010010; // 5
				6: HEX4 = 7'b0000010; // 6
				7: HEX4 = 7'b1111000; // 7
				8: HEX4 = 7'b0000000; // 8
				9: HEX4 = 7'b0010000; // 9
			endcase
					
			case (first_digit_print_register)
				0: HEX1 =  7'b1000000; // 0
				1: HEX1 =  7'b1111001; // 1
				2: HEX1 = 7'b0100100; // 2
				3: HEX1 = 7'b0110000; // 3
				4: HEX1 = 7'b0011001; // 4
				5: HEX1 = 7'b0010010; // 5
				6: HEX1 = 7'b0000010; // 6
				7: HEX1 = 7'b1111000; // 7
				8: HEX1 = 7'b0000000; // 8
				9: HEX1 = 7'b0010000; // 9
			endcase

			case (second_digit_print_register)
				0: HEX0 =  7'b1000000; // 0
				1: HEX0 =  7'b1111001; // 1
				2: HEX0 = 7'b0100100; // 2
				3: HEX0 = 7'b0110000; // 3
				4: HEX0 = 7'b0011001; // 4
				5: HEX0 = 7'b0010010; // 5
				6: HEX0 = 7'b0000010; // 6
				7: HEX0 = 7'b1111000; // 7
				8: HEX0 = 7'b0000000; // 8
				9: HEX0 = 7'b0010000; // 9
			endcase
		end	
	end		
end
	
endmodule
