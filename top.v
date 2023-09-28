`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2023 22:25:06
// Design Name: 
// Module Name: top
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


module top
#(
    parameter BUS_WIDTH = 16,
    parameter OP_WIDTH  = 6,
    parameter PUL_WIDTH = 3
)
(
    input wire                              clk,
    input wire                            reset,
    input wire  [BUS_WIDTH - 1:0]    i_switches,
    //input wire  [PUL_WIDTH - 1:0]    i_pulsador,
    input wire      i_pulsador0,
    input wire      i_pulsador1,
    input wire      i_pulsador2,
    output wire [BUS_WIDTH - 1:0]      o_result
    //Revisar como utilizar los switchs de las placas    
);
 
    wire [BUS_WIDTH - 1:0] datoA;
    wire [BUS_WIDTH - 1:0] datoB;
    wire [OP_WIDTH - 1:0] operacion; 
    
    register inst_reg_a (
        .clk(clk),
        .reset(reset),
        .switches(i_switches),
        .button(i_pulsador0),
        .register(datoA)
    );
    
    register inst_reg_b (
        .clk(clk),
        .reset(reset),
        .switches(i_switches),
        .button(i_pulsador1),
        .register(datoB)
    );   
    
    register #(6) inst_opcode (
        .clk(clk),
        .reset(reset),
        .switches(i_switches),
        .button(i_pulsador2),
        .register(operacion)
    );   
    
    //Instancia del modulo de la ALU
    ALU alu_inst (
        .i_valA(datoA),
        .i_valB(datoB),
        .opcode(operacion),
        .o_result(o_result)
    );
    

    
endmodule
