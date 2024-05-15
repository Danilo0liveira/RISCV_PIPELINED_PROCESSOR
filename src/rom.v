module InstructionMem
(
	input [7:0] address,
	output reg [31:0] rd
);
	always@*
	begin
		case(address)
			8'h00 : rd = 32'h00300193;
			8'h04 : rd = 32'h00000293;
			8'h08 : rd = 32'h00328223;
			8'h0c : rd = 32'h00428383;
          	8'h10 : rd = 32'h0033f133;
          	8'h14 : rd = 32'h00718663;
          	8'h18 : rd = 32'h0033f333;
          	8'h1c : rd = 32'h00000463;
          	8'h20 : rd = 32'h40338333;   
          
			default : rd = 32'b0;
		endcase
	end
endmodule