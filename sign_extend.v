module sign_extend (
	input [15:0] DataIn,
	output [31:0] DataOut
);
	reg [31:0] DataOut;
	always @(DataIn) begin
		DataOut = {{16{DataIn[15]}}, DataIn};
	end
endmodule
