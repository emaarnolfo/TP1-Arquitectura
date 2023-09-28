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

    //Se�ales que se usan para probar la ALU
    reg  [BUS_WIDTH-1:0]      i_switches;
    wire [BUS_WIDTH-1:0]        o_result;
    reg                      i_pulsador0;
    reg                      i_pulsador1;
    reg                      i_pulsador2;
    reg                              clk;
    reg                            reset;
    integer rand, i;
    integer datoA, datoB, opcode, resultado;

    // Instancia del m�dulo top
    top #(
        .BUS_WIDTH(16),
        .OP_WIDTH(6),
        .PUL_WIDTH(3)
    ) uut (
        .clk(clk),
        .reset(reset),
        .i_switches(i_switches),
        .i_pulsador0(i_pulsador0),
        .i_pulsador1(i_pulsador1),
        .i_pulsador2(i_pulsador2),
        .o_result(o_result)
    );

    // Generador de reloj
    always begin
        #5 clk = ~clk; // Cambia el reloj cada 5 unidades de tiempo
    end

    // Simulaci�n de entrada
    initial begin
        for (i = 0; i<100000; i = i + 1) begin
            
            clk = 0;
            reset             = 1                       ;
            
            //Se reinicia todo en 0
            #50 reset         = 0                       ;   
            i_switches        = 16'b000000              ; // Se setea todo en 0
            i_pulsador0       = 1'b0                    ; // Se setea todo en 0
            i_pulsador1       = 1'b0                    ; // Se setea todo en 0
            i_pulsador2       = 1'b0                    ; // Se setea todo en 0
            
            // Se carga el dato A
            rand = $random                              ;
            #50 i_switches   = rand[15:0]               ; // Switches = 15
            datoA = rand;
            #50 i_pulsador0  = 1'b1                     ; // Pulsador[0] = RegA
            #50 i_pulsador0  = 1'b0                     ;
            
            // Se carga el dato B
            rand = $random                              ;
            #50 i_switches   = rand[15:0]               ; // Switches = 3
            datoB = rand;
            #50 i_pulsador1  = 1'b1                     ; // Pulsador[1] = RegB
            #50 i_pulsador1  = 1'b0                     ;
            
            // Se carga el opcode
            rand = $random                              ;
            opcode = rand;
            #50 i_switches   = rand[6:0]                ; // Switches = NOR
            #50 i_pulsador2  = 1'b1                     ; // Pulsador[2] = Opcode
            #50 i_pulsador2  = 1'b0                     ;

            case (opcode)
                6'b100_000: resultado = datoA + datoB;       // ADD bit a bit
                6'b100_010: resultado = datoA - datoB;       // SUB bit a bit
                6'b100_100: resultado = datoA & datoB;       // AND bit a bit
                6'b100_101: resultado = datoA | datoB;       // OR bit a bit
                6'b100_110: resultado = datoA ^ datoB;       // XOR bit a bit
                6'b000_011: resultado = $signed(datoA) >>> datoB;     // SRA de i_regA hacia la derecha en n bits
                6'b000_010: resultado = datoA >> datoB;      // Ejemplo: SRL
                6'b100_111: resultado = ~(datoA | datoB);    // NOR entre i_regA e i_regB
                default:    resultado = 16'b0;
            endcase

            if (resultado != o_result) begin;
                $display("Fallo de simulacion");
                $finish;
            end

            #50
            $display("Test pasado correctamente");
            $finish;

        end
    
    end
    
endmodule