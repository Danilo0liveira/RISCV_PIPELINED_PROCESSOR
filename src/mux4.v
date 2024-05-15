module Mux4
(
	input [11:0] a, b, c, 
  	input [1:0] ctrl,
  	output reg [11:0] mout
);

	always@*
	begin
		case(ctrl)
			2'b00 : mout = a;
			2'b01 : mout = b;
			2'b10 : mout = c;
		default:
			mout = 12'b0;
		endcase
	end
endmodule