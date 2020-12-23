module alu (
    input  [31:0] a, b,
    input  [2:0] alu_control,
    output zero, c_out,
    output [31:0] alu_out
);
    wire [31:0] b_bar, b_bar_mux, f0, f1, f2, f3;
    assign b_bar = ~ b;
    assign b_bar_mux = (1'b0 == alu_control[2]) ? b : b_bar;
    assign f0 = a & b_bar_mux;
    assign f1 = a | b_bar_mux;
    assign {c_out, f2} = a + b_bar_mux + alu_control[2];
    assign f3 = {{31{1'b0}}, ((a[31] == b_bar[31]) && (f2[31] != a[31])) ? ~(f2[31]) : f2[31]};
    assign zero = ~| alu_out;
    assign alu_out = 2'b00 == alu_control[1:0] ? f0 : (2'b01 == alu_control[1:0] ? f1 : (2'b10 == alu_control[1:0] ? f2 : f3 ));
endmodule
