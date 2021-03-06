module PosEdgeDFF
(
input clk, rst, D, enable,
output reg Q
);
	always @ (posedge clk)
	begin
		if(rst)
			Q <= 'b0;
		else if (enable)
			Q <= D;
	end
endmodule