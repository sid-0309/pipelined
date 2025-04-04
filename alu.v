`timescale 1ns / 1ps

module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] c,
    output [31:0] o,
    output z
    );
    wire [31:0]w1;
    wire [31:0]w2;
    wire [31:0]w3;                
    wire [31:0]w4;
    wire [31:0]w5;
    wire z1,z2;
    wire of1,of2;
    
    and32 and1(a,b,w1);
    add32 add1(a,b,w2,of1);
    or32 or1(a,b,w3);
    sub32 sub1(a,b,w4,of2);
    sll32 sll1(a,b,w5);
    
    assign z1 = (o==32'd0)?1'b1:1'b0;
    assign z2 = (o>32'd0)?1'b0:1'b1;

    mux32_8 mux_32_8_alu(w1,w3,w2,32'hxxxxxxxx, 32'hxxxxxxxx, w5, w4,w4, {c[2],c[1],c[0]},o);
    mux1_8 mux1_8_alu(z1,z1,z1,1'bx,1'bx,1'bx,z1,z2,c[2:0],z);

endmodule

module sll32(
    input [31:0] a,
    input [31:0] shamt,
    output [31:0] o
);

    assign o = a << shamt;
endmodule

module add32(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] o,
   output of
    );
    
    assign o = a+b;
    assign of = (a[31] == b[31]) & (a[31] != o[31]);
endmodule

module sub32(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] o,
   output of
    );
    
    assign o = a-b;
   assign of = (a[31] != b[31]) & (a[31] != o[31]);
endmodule

module and32(
    input [31:0] a,
    input [31:0] b,
    output [31:0] o
    );
    
    assign o = a&b;
endmodule

module or32(
    input [31:0] a,
    input [31:0] b,
    output [31:0] o
    );
    
    assign o = a|b;
endmodule

module sign_extend(
    input [15:0] data,
    output [31:0] exdata
    );
    
    wire signed [31:0] w1;

    assign w1[31:16] = data;
    assign exdata = w1>>>16;
endmodule 

module mux5_2(input [4:0]in0,input [4:0]in1,input sel,output [4:0]out);

    assign out = sel ? in1 : in0;
endmodule

module mux32_2(input [31:0]in0,input [31:0]in1, input sel, output [31:0] out);

    assign out = sel ? in1 : in0;
endmodule

module mux32_4(input [31:0]in0, input [31:0]in1, input [31:0]in2, input [31:0]in3, input [1:0]sel, output [31:0] out);

    assign out = sel[1] ? (sel[0] ? in3 : in2) : (sel[0]? in1 : in0);
endmodule

module mux32_8(input [31:0]in0, input [31:0]in1, input [31:0]in2, input [31:0]in3, input [31:0]in4, input [31:0]in5, input [31:0]in6, input [31:0]in7,  input [2:0]sel, output [31:0] out);

    assign out = sel[2] ? (sel[1] ? (sel[0] ? in7 : in6) : (sel[0]? in5 : in4)) : (sel[1] ? (sel[0] ? in3 : in2) : (sel[0]? in1 : in0));
endmodule

module mux1_8(input in0, input in1, input in2, input in3, input in4, input in5, input in6, input in7,  input [2:0]sel, output out);

    assign out = sel[2] ? (sel[1] ? (sel[0] ? in7 : in6) : (sel[0]? in5 : in4)) : (sel[1] ? (sel[0] ? in3 : in2) : (sel[0]? in1 : in0));
endmodule