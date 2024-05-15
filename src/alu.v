module ALU
(
  input [7:0] src_a, src_b, 
  input [2:0] ctrl,
  output reg [7:0] result, 
  output reg z
);

	always@*
	begin
		case(ctrl)
			3'b000 : result = src_a + src_b;
			3'b001 : result = src_a + ~src_b + 1;
			3'b010 : result = src_a & src_b;
			3'b011 : result = src_a  | src_b;
			3'b100 : result = src_a^src_b;
			3'b101 : result = (src_a < src_b) ? 1 : 0;
			default:
				result = 3'b0;
		endcase
		z = (result == 8'b0) ? 1 : 0;
	end
endmodule