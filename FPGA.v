module FPGA (
  input clk,
  input [31:0] read_register_1, read_register_2, ALU_result,
  output reg LCD_ON,LCD_BLON,LCD_RW,LCD_EN, LCD_RS,
  inout [7:0] LCD_DATA
);

  // Definição de comandos e caracteres para o LCD
  parameter CLEAR_DISPLAY = 8'b00000001;
  parameter SET_DDRAM_ADDRESS = 8'b10000000;
  
  // Delay após enviar um comando ou dado para o LCD
  parameter COMMAND_DELAY = 10;
  reg [7:0] lcd_data_internal = 8'b00000000;
  
 
  // Função para enviar comandos para o LCD
  task send_command;
	 reg [7:0] temp;  // Variável temporária
    input [7:0] command;
    begin
      LCD_RS = 1'b0;  // Seleciona modo de comando
      
      LCD_RW = 1'b0;  // Define para escrita
      
      lcd_data_internal = command;
      
      LCD_EN = 1'b1;  // Ativa sinal de enable
      
      #COMMAND_DELAY;
      
      LCD_EN = 1'b0;  // Desativa sinal de enable
      
      #COMMAND_DELAY;
    end
  endtask

  // Função para enviar caracteres para o LCD
  task send_character;
    input [7:0] character;
    begin
      LCD_RS = 1'b1;  // Seleciona modo de dados
      
      LCD_RW = 1'b0;  // Define para escrita
      
		lcd_data_internal = character;
    
      LCD_EN = 1'b1;  // Ativa sinal de enable
      
      #COMMAND_DELAY;
      
      LCD_EN = 1'b0;  // Desativa sinal de enable
      
      #COMMAND_DELAY;
    end
  endtask

  // Módulo principal
  initial begin
    // Inicializações
    LCD_ON = 1'b1;
    LCD_BLON = 1'b1;
    LCD_RW = 1'b0;
    
    // Aguarda a inicialização do LCD
    #1000;
    
    // Limpa o display
    send_command(CLEAR_DISPLAY);
    
    // Define a posição de escrita na primeira linha
    send_command(SET_DDRAM_ADDRESS | 1'b00000000);
    
    // Escreve a parte estática da mensagem
    send_character(8'b01101110);  // 'n'
    send_character(8'b01110101);  // 'u'
    send_character(8'b01101101);  // 'm'
    send_character(8'b00100000);  // ' '
    send_character(8'b00110001);  // '1'
    send_character(8'b00111010);  // ':'
    send_character(8'b00100000);  // ' '
    
    // Escreve o valor de read_register_1
    send_character(read_register_1[31:24]);
    send_character(read_register_1[23:16]);
    send_character(read_register_1[15:8]);
    send_character(read_register_1[7:0]);
    
    // Escreve a parte estática da mensagem
    send_character(8'b00100000);  // ' '
    send_character(8'b01101110);  // 'n'
    send_character(8'b01110101);  // 'u'
    send_character(8'b01101101);  // 'm'
    send_character(8'b00100000);  // ' '
    send_character(8'b00110010);  // '2'
    send_character(8'b00111010);  // ':'
    send_character(8'b00100000);  // ' '
    
    // Escreve o valor de read_register_2
    send_character(read_register_2[31:24]);
    send_character(read_register_2[23:16]);
    send_character(read_register_2[15:8]);
    send_character(read_register_2[7:0]);
    
    // Escreve a parte estática da mensagem
    send_character(8'b00100000);  // ' '
    send_character(8'b01110010);  // 'r'
    send_character(8'b01100101);  // 'e'
    send_character(8'b01110011);  // 's'
    send_character(8'b01110101);  // 'u'
    send_character(8'b01101100);  // 'l'
    send_character(8'b01110100);  // 't'
    send_character(8'b00111010);  // ':'
    send_character(8'b00100000);  // ' '
    
    // Escreve o valor de ALU_result
    send_character(ALU_result[31:24]);
    send_character(ALU_result[23:16]);
    send_character(ALU_result[15:8]);
    send_character(ALU_result[7:0]);
	 
  end
  
  
	assign LCD_DATA = lcd_data_internal;
	
endmodule
