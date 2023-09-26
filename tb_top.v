`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.09.2023 08:06:03
// Design Name: 
// Module Name: tb_top
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


module tb_top
#(
    parameter BUS_WIDTH = 16,
    parameter OP_WIDTH  = 6,
    parameter PUL_WIDTH = 3
);

    //Señales que se usan para probar la ALU
    reg  [BUS_WIDTH-1:0]      i_switches;
    reg  [PUL_WIDTH-1:0]      i_pulsador;
    wire  [BUS_WIDTH-1:0]        o_result;
    reg  clk;
    reg reset;

    // Generador de reloj
    always begin
        #5 clk = ~clk; // Cambia el reloj cada 5 unidades de tiempo
    end

    // Simulación de entrada
    initial begin
        clk = 0;
        reset             = 1                         ;
        #10 reset         = 0                         ;   
        i_switches        = 16'b000000                ;
        i_pulsador        = 3'b000                    ;
        #110 i_switches   = 16'b0000_0000_0000_0100   ;
        #110 i_pulsador   = 3'b001                    ;
        #115 i_pulsador   = 3'b000                    ;
        #120 i_switches   = 16'b001111                ;
        #120 i_pulsador   = 3'b010                    ;
        #125 i_pulsador   = 3'b000                    ;
        #130 i_switches   = 16'b100000                ;
        #125 i_pulsador   = 3'b100                    ;
        #130 i_pulsador   = 3'b000                    ;
        $finish                                       ;

    end
    
    // Instancia del módulo top
    top #(
        .BUS_WIDTH(16),
        .OP_WIDTH(6),
        .PUL_WIDTH(3)
    ) uut (
        .clk(clk),
        .reset(reset),
        .i_switches(i_switches),
        .i_pulsador(i_pulsador),
        .o_result(o_result)
    );

endmodule