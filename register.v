`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2023 01:07:50
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module register 
#(
    parameter SW = 16
)
(
    input wire              clk,           // Entrada de reloj
    input wire [SW - 1:0]   switches,      // Entrada de los switchs
    input wire              button,        // Entrada de un pulsador
    input wire              reset,
    output wire [SW - 1:0]   register       // Salida del registro de 16 bits
);

    reg [SW -1:0] dato;
    // Proceso siempre activo por flanco de subida del reloj
    
    always @(posedge clk) begin
        if (reset) begin
            dato <= 16'b0;
        end
        if (button) begin
            // Si el botón está presionado, actualiza el registro con los valores de los interruptores
            dato <= switches;
        end
    end
    
    assign register = dato;
    
endmodule

