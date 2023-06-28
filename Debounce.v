module Debounce(
    input clk_in, btn_in,
    output reg clk_out
);

    reg [3:0] debounce_counter;
    reg btn_stable;
    reg btn_previous;

    parameter DEBOUNCE_DELAY = 1000000; // Número de ciclos para aguardar antes de considerar o sinal estável

    always @(posedge clk_in) begin
        // Verifica se o botão mudou de estado
        if (btn_in != btn_previous) begin
            debounce_counter <= DEBOUNCE_DELAY - 1; // Inicia o contador de debounce
            btn_stable <= 0; // Sinal do botão não estável
        end
        else begin
            // Decrementa o contador de debounce
            if (debounce_counter > 0)
                debounce_counter <= debounce_counter - 1;
            else
                btn_stable <= 1; // Sinal do botão estável
        end

        // Armazena o estado atual do botão para a próxima iteração
        btn_previous <= btn_in;

        // Saída clock_out recebe o estado estável do botão
        clk_out <= btn_stable;
    end

endmodule
