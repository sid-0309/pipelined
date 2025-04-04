`timescale 1ns / 1ps

module main();
    reg clk;

    wire RegDst;
    wire ALUSrc;
    wire Branch;
    wire JumpSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire [2:0] ALUOp;
    

// wires

    // IF
    wire [31:0] New_PC;
    wire [31:0] PC_out;
    wire [31:0] inst;
    wire [31:0] PC_plus4;
    wire PC_of;

    // ID
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] sign_extend_out;


    // EX
    wire [31:0] Branch_target;
    wire [31:0] sign_extend_ls2;
    wire Branch_target_of;
    wire [31:0] ALU_in_2_IF_ID;
    wire [31:0] ALU_result;
    wire ALU_zero;
    wire [2:0] op;
    wire [4:0] write_register_addr;

    // MEM
    wire PCSrc;
    wire [31:0] mem_read_data;

    // WB
    wire [31:0] write_reg_data;

    // Pipeline Registers
    reg [63:0] IF_ID;
    reg [153:0] ID_EX;
    reg [106:0] EX_MEM;
    reg [70:0] MEM_WB;

    // Hazard Detection

    wire PC_write, IF_ID_write, clear_control;

    hazard_detection hzd(ID_EX[144], ID_EX[9:5], IF_ID[25:21], IF_ID[20:16], {PC_write, IF_ID_write, clear_control});


    // Data Forwarding

    wire [1:0] fw_a, fw_b;
    wire [31:0] ALU_in_1;
    wire [31:0] ALU_in_2;

    forwarding fw_logic(EX_MEM[105], EX_MEM[4:0], ID_EX[153:149], ID_EX[9:5], MEM_WB[70], MEM_WB[4:0], fw_a, fw_b);




    // IF

    mux32_2 PC_mux(PC_plus4, EX_MEM[101:70],PCSrc, New_PC);

    reg32_cond PC(clk, PC_write, New_PC, PC_out);

    inst_mem inst_mem_1(PC_out,inst);

    add32 PC_increment(PC_out, 32'd4, PC_plus4, PC_of);

    // ID


    reg_mem reg_mem_1(clk, MEM_WB[70], IF_ID[25:21], IF_ID[20:16], MEM_WB[4:0], write_reg_data, ReadData1, ReadData2);

    sign_extend sign_extend_1(IF_ID[15:0], sign_extend_out);

    main_control mc1(IF_ID[31:26],RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, JumpSrc);

    

    // EX
    assign sign_extend_ls2 = ID_EX[41:10] << 2;

    add32 branch_target_calculator(ID_EX[137:106], sign_extend_ls2, Branch_target, Branch_target_of);

    mux32_2 ALUSrc_sel(ID_EX[73:42], ID_EX[41:10], ID_EX[147], ALU_in_2_IF_ID);

    mux32_4 FW_1_sel(ID_EX[105:74], write_reg_data, EX_MEM[68:37], 32'hxxxxxxxx, fw_a, ALU_in_1);

    mux32_4 FW_2_sel(ALU_in_2_IF_ID, write_reg_data, EX_MEM[68:37], 32'hxxxxxxxx, fw_b, ALU_in_2);

    alu_control alu_control_1(ID_EX[141:139], ID_EX[15:10], op);

    alu alu_1(ALU_in_1, ALU_in_2, op, ALU_result, ALU_zero);

    mux5_2 RegDst_sel(ID_EX[9:5], ID_EX[4:0], ID_EX[148], write_register_addr);

    
    // MEM

    assign PCSrc = EX_MEM[69] & EX_MEM[102];

    mem mem_1(clk, EX_MEM[68:37], EX_MEM[104], EX_MEM[103], EX_MEM[36:5], mem_read_data);

    // WB

    mux32_2 MemtoReg_sel(MEM_WB[36:5], MEM_WB[68:37], MEM_WB[69], write_reg_data);


    always @(posedge clk) begin
        if (IF_ID_write) begin
        IF_ID <= {PC_plus4, inst};
        end
        if (clear_control) begin
            ID_EX <= {IF_ID[25:21], 11'd0, IF_ID[63:32], ReadData1, ReadData2, sign_extend_out, IF_ID[20:11]};
        end
        else begin
            ID_EX <= {IF_ID[25:21], RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, JumpSrc, IF_ID[63:32], ReadData1, ReadData2, sign_extend_out, IF_ID[20:11]};
        end
        EX_MEM <= {ID_EX[146], ID_EX[145], ID_EX[144], ID_EX[143], ID_EX[142], Branch_target, ALU_zero, ALU_result, ID_EX[73:42], write_register_addr};
        MEM_WB <= {EX_MEM[105], EX_MEM[106], mem_read_data, EX_MEM[68:37], EX_MEM[4:0]};

    end

    initial begin
        $dumpfile("output1.vcd");  // Specify output file
        $dumpvars(0, main);   // 0 = dump all hierarchy levels

        clk = 0;
        EX_MEM[102] = 0;
        EX_MEM[69] = 0;
        ID_EX[144] = 0;
        EX_MEM[105] = 0;
        ID_EX[145] = 0;
        

        // Setting PCSrc
        IF_ID[31:0] = 32'h80000000;


        #5 clk = 1;

        #5 clk = 0;
        EX_MEM[102] = 0;
        EX_MEM[69] = 0;
        ID_EX[144] = 0;
        ID_EX[145] = 0;
        EX_MEM[105] = 0;
        
        repeat(40)
        #5 clk = ~clk;
    end


endmodule
