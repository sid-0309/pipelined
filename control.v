`timescale 1ns / 1ps

module main_control(
    input [5:0] opcode,
    output RegDst,
    output ALUSrc,
    output MemtoReg,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output Branch,
    output [2:0] ALUOp,
    output JumpSrc
    );

    assign RegDst = (opcode == 6'b100000) ? 1'b1 : // add
                    (opcode == 6'b100010) ? 1'b1 : // sub
                    (opcode == 6'b100100) ? 1'b1 : // and
                    (opcode == 6'b100101) ? 1'b1 : // or
                    (opcode == 6'b101010) ? 1'b1 : // slt
                    (opcode == 6'b100011) ? 1'b0 : // lw
                    (opcode == 6'b101011) ? 1'b0 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b0 : // addi
                    (opcode == 6'b001100) ? 1'b0 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b0; // ori

    assign ALUSrc = (opcode == 6'b100000) ? 1'b0 : // add
                    (opcode == 6'b100010) ? 1'b0 : // sub
                    (opcode == 6'b100100) ? 1'b0 : // and
                    (opcode == 6'b100101) ? 1'b0 : // or
                    (opcode == 6'b101010) ? 1'b0 : // slt
                    (opcode == 6'b100011) ? 1'b1 : // lw
                    (opcode == 6'b101011) ? 1'b1 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b1 : // addi
                    (opcode == 6'b001100) ? 1'b1 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b1; // ori

    assign MemtoReg = (opcode == 6'b100000) ? 1'b0 : // add
                    (opcode == 6'b100010) ? 1'b0 : // sub
                    (opcode == 6'b100100) ? 1'b0 : // and
                    (opcode == 6'b100101) ? 1'b0 : // or
                    (opcode == 6'b101010) ? 1'b0 : // slt
                    (opcode == 6'b100011) ? 1'b1 : // lw
                    (opcode == 6'b101011) ? 1'b0 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b0 : // addi
                    (opcode == 6'b001100) ? 1'b0 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b0; // ori

    assign RegWrite = (opcode == 6'b100000) ? 1'b1 : // add
                    (opcode == 6'b100010) ? 1'b1 : // sub
                    (opcode == 6'b100100) ? 1'b1 : // and
                    (opcode == 6'b100101) ? 1'b1 : // or
                    (opcode == 6'b101010) ? 1'b1 : // slt
                    (opcode == 6'b100011) ? 1'b1 : // lw
                    (opcode == 6'b101011) ? 1'b0 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b1 : // addi
                    (opcode == 6'b001100) ? 1'b1 : // andi
                    (opcode == 6'b000000) ? 1'b1 : // sll
                    1'b1; // ori

    assign MemRead = (opcode == 6'b100000) ? 1'b0 : // add
                    (opcode == 6'b100010) ? 1'b0 : // sub
                    (opcode == 6'b100100) ? 1'b0 : // and
                    (opcode == 6'b100101) ? 1'b0: // or
                    (opcode == 6'b101010) ? 1'b0 : // slt
                    (opcode == 6'b100011) ? 1'b1 : // lw
                    (opcode == 6'b101011) ? 1'b0 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b0 : // addi
                    (opcode == 6'b001100) ? 1'b0 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b0; // ori

    assign MemWrite = (opcode == 6'b100000) ? 1'b0 : // add
                    (opcode == 6'b100010) ? 1'b0 : // sub
                    (opcode == 6'b100100) ? 1'b0 : // and
                    (opcode == 6'b100101) ? 1'b0 : // or
                    (opcode == 6'b101010) ? 1'b0 : // slt
                    (opcode == 6'b100011) ? 1'b0 : // lw
                    (opcode == 6'b101011) ? 1'b1 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b0 : // addi
                    (opcode == 6'b001100) ? 1'b0 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b0; // ori

    assign Branch = (opcode == 6'b100000) ? 1'b0 : // add
                    (opcode == 6'b100010) ? 1'b0 : // sub
                    (opcode == 6'b100100) ? 1'b0 : // and
                    (opcode == 6'b100101) ? 1'b0 : // or
                    (opcode == 6'b101010) ? 1'b0 : // slt
                    (opcode == 6'b100011) ? 1'b0 : // lw
                    (opcode == 6'b101011) ? 1'b0 : // sw
                    (opcode == 6'b000100) ? 1'b1 : // beq
                    (opcode == 6'b000010) ? 1'b0 : // j
                    (opcode == 6'b001000) ? 1'b0 : // addi
                    (opcode == 6'b001100) ? 1'b0 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b0; // ori

    assign ALUOp = (opcode == 6'b100000) ? 3'b010 : // add
                    (opcode == 6'b100010) ? 3'b010 : // sub
                    (opcode == 6'b100100) ? 3'b010 : // and
                    (opcode == 6'b100101) ? 3'b010 : // or
                    (opcode == 6'b101010) ? 3'b010 : // slt
                    (opcode == 6'b100011) ? 3'b000 : // lw
                    (opcode == 6'b101011) ? 3'b000 : // sw
                    (opcode == 6'b000100) ? 3'b110 : // beq
                    (opcode == 6'b000010) ? 3'b000 : // j
                    (opcode == 6'b001000) ? 3'b100 : // addi
                    (opcode == 6'b001100) ? 3'b101 : // andi
                    (opcode == 6'b000000) ? 3'b110 : // sll
                    3'b001; // ori

    assign JumpSrc = (opcode == 6'b100000) ? 1'b0 : // add
                    (opcode == 6'b100010) ? 1'b0 : // sub
                    (opcode == 6'b100100) ? 1'b0 : // and
                    (opcode == 6'b100101) ? 1'b0 : // or
                    (opcode == 6'b101010) ? 1'b0 : // slt
                    (opcode == 6'b100011) ? 1'b0 : // lw
                    (opcode == 6'b101011) ? 1'b0 : // sw
                    (opcode == 6'b000100) ? 1'b0 : // beq
                    (opcode == 6'b000010) ? 1'b1 : // j
                    (opcode == 6'b001000) ? 1'b0 : // addi
                    (opcode == 6'b001100) ? 1'b0 : // andi
                    (opcode == 6'b000000) ? 1'b0 : // sll
                    1'b0; // ori
    
endmodule

module alu_control(
    input [2:0] ALUOp,
    input [5:0] f,
    output [2:0] op
    );

    // assign op = (ALUOp == 2'b00) ? 3'b010 :
    //             (ALUOp == 2'b01) ? 3'b110 :
    //             (ALUOp == 2'b10) ? (
    //                 (f[3:0] == 4'b0000) ? 3'b010 :
    //                 (f[3:0] == 4'b0010) ? 3'b110 :
    //                 (f[3:0] == 4'b0100) ? 3'b000 :
    //                 (f[3:0] == 4'b0101) ? 3'b001 :
    //                 3'b111) :
    //             3'b101;



    // 3-bit ALUOp 
    assign op = (ALUOp == 3'b000) ? 3'b010 :
                (ALUOp == 3'b001) ? 3'b110 :
                ((ALUOp == 3'b010) | (ALUOp == 3'b011)) ? (
                    (f[3:0] == 4'b0000) ? 3'b010 :
                    (f[3:0] == 4'b0010) ? 3'b110 :
                    (f[3:0] == 4'b0100) ? 3'b000 :
                    (f[3:0] == 4'b0101) ? 3'b001 :
                    3'b111) :
                (ALUOp == 3'b100) ? 3'b010 :
                (ALUOp == 3'b101) ? 3'b000 : 
                (ALUOp == 3'b110) ? 3'b101 :
                3'b001; 

    
endmodule

module forwarding(
    input ex_mem_regwrite,
    input [4:0] ex_mem_rd,
    input [4:0] id_ex_rs,
    input [4:0] id_ex_rt,
    input mem_wb_regwrite,
    input [4:0] mem_wb_rd,
    output [1:0] fw_a,
    output [1:0] fw_b
);
    assign fw_a =   (ex_mem_regwrite & ~(ex_mem_rd == 5'd0) & (ex_mem_rd == id_ex_rs)) ? 2'b10 :
                    (mem_wb_regwrite & ~(mem_wb_rd == 5'd0) & (mem_wb_rd == id_ex_rs)) ? 2'b01 :
                    2'b00;

    assign fw_b =   (ex_mem_regwrite & ~(ex_mem_rd == 5'd0) & (ex_mem_rd == id_ex_rt)) ? 2'b10 :
                    (mem_wb_regwrite & ~(mem_wb_rd == 5'd0) & (mem_wb_rd == id_ex_rt)) ? 2'b01 :
                    2'b00;

endmodule

module hazard_detection(
    input id_ex_memread,
    input [4:0] id_ex_rt,
    input [4:0] if_id_rs,
    input [4:0] if_id_rt,
    output [2:0] stall
);

    assign stall = (id_ex_memread & ((id_ex_rt == if_id_rs) | (id_ex_rt == if_id_rt))) ? 3'b001 : 3'b110;

endmodule