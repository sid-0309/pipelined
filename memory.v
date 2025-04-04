`timescale 1ns / 1ps

module inst_mem(
    input [31:0] pc,
    output [31:0] inst
    );
    
    reg [7:0] mem[47:0];
    initial begin
    // Each block of 4 is one instruction.
    // sw r4,0(r0)
    mem[0] = 8'hac;
    mem[1] = 8'h04;
    mem[2] = 8'h00;
    mem[3] = 8'h00;

    // add r4,r3,r2
    mem[4] = 8'h80;
    mem[5] = 8'h62;
    mem[6] = 8'h20;
    mem[7] = 8'h00;

    // add r5,r2,r0
    mem[8] = 8'h80;
    mem[9] = 8'h40;
    mem[10] = 8'h28;
    mem[11] = 8'h00;

    // add r6,r4,r5
    mem[12] = 8'h80;
    mem[13] = 8'h85;
    mem[14] = 8'h30;
    mem[15] = 8'h00;

    // lw r4,0(r0)
    mem[16] = 8'h8c;
    mem[17] = 8'h04;
    mem[18] = 8'h00;
    mem[19] = 8'h00;

    // add r7,r4,r0
    mem[20] = 8'h80;
    mem[21] = 8'h80;
    mem[22] = 8'h38;
    mem[23] = 8'h00;

    // add r7,r7,r0
    mem[24] = 8'h80;
    mem[25] = 8'he0;
    mem[26] = 8'h38;    
    end
    assign inst = {mem[pc],mem[pc+1],mem[pc+2],mem[pc+3]};
endmodule

module mem(
    input clk,
    input [31:0] addr,
    input MemRead,
    input MemWrite,
    input [31:0] datain,
    output [31:0] dataout
    );

    reg [7:0] mem[47:0];


    initial begin
    // 1
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h01;

    // 2
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h04;

    // 3
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h07;

    // 4
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h02;

    // 5
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h06;

    // 6
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h03;

    // 7
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h08;  

    // 8
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h09; 

    // 9
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h0a; 

    // 10
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    mem[3] = 8'h05; 
    end

    always @(posedge clk) begin

        if (MemWrite) begin
            mem[addr] <= datain[31:24];
            mem[addr+1] <= datain[23:16];
            mem[addr+2] <= datain[15:8];
            mem[addr+3] <= datain[7:0];
        end
    end

    assign dataout = MemRead ? {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]} : 32'hxxxxxxxx;


endmodule


// Register memory. Have initialized some default values. Combinational read and sequential write at the end of the clock cycle.
module reg_mem(
    input clk,
    input RegWrite,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    
    reg [31:0] mem[31:0];
    
    initial begin
    mem[0] = 32'h00000000;
    mem[17] = 32'h0000000a;
    mem[2] = 32'h00000002;
    mem[3] = 32'h00000003;
    mem[4] = 32'h00000004;
    mem[5] = 32'h00000005;
    end
    
    // assign ReadData1 = mem[ReadReg1];
    // assign ReadData2 = mem[ReadReg2];
    
    assign ReadData1 = mem[ReadReg1];
    assign ReadData2 = mem[ReadReg2];

    always @(posedge clk) begin
        if (RegWrite) begin
            mem[WriteReg] <= WriteData;
        end
    end
    
endmodule

module reg32_cond(
    input clk,
    input cond,
    input [31:0] datain,
    output [31:0] dataout
);

    reg [31:0] reg32_data;

    initial begin
        reg32_data = 32'd0;
    end

    always @(posedge clk) begin
        if (cond) begin
            reg32_data <= datain;
        end
    end

    assign dataout = reg32_data;
endmodule


module reg32(
    input clk,
    input [31:0] datain,
    output [31:0] dataout
);

    reg [31:0] reg32_data;

    initial begin
        reg32_data = 32'd0;
    end

    always @(posedge clk) begin
        reg32_data <= datain;
    end
    
    assign dataout = reg32_data;
endmodule
