`include "top.v"
`timescale 1ns/10ps
module tb;
    reg clock;
    reg reset;
    top uut (.clk(clock), .reset(reset));
    always begin
        #5 clock = ~clock;
    end
    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0, uut);
    end
    initial begin
        clock = 0; reset = 1;
        @(negedge clock) reset = 0;
        #200
        $finish;
    end
endmodule
