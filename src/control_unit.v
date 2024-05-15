module ControlUnit
(
	input [6:0] op_code, func7,
	input [2:0] func3,
  	output reg [2:0] ALUControlD,
  	output reg [1:0] ImmSrcD, ResultSrcD,
	output reg ALUSrcD, RegWriteD, MemWriteD, BranchD
);
	always@*
	begin
		casez({op_code, func3, func7})
			17'b0110011_000_0000000 : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'bxx, 1'b0, 3'b000, 1'b0, 2'b00, 1'b0};
			17'b0110011_000_0100000 : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'bxx, 1'b0, 3'b001, 1'b0, 2'b00, 1'b0};
			17'b0110011_111_0000000 : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'bxx, 1'b0, 3'b010, 1'b0, 2'b00, 1'b0};	
			17'b0110011_110_0000000 : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'bxx, 1'b0, 3'b011, 1'b0, 2'b00, 1'b0};	
			17'b0110011_100_0000000 : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'bxx, 1'b0, 3'b100, 1'b0, 2'b00, 1'b0};
			17'b0110011_010_0000000 : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'bxx, 1'b0, 3'b101, 1'b0, 2'b00, 1'b0};
         	17'b0010011_000_??????? : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'b00, 1'b1, 3'b000, 1'b0, 2'b00, 1'b0};
			17'b0000011_000_??????? : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b1, 2'b00, 1'b1, 3'b000, 1'b0, 2'b01, 1'b0};
			17'b0100011_000_??????? : {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b0, 2'b01, 1'b1, 3'b000, 1'b1, 2'bxx, 1'b0};
			17'b1100011_000_???????	: {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b0, 2'b10, 1'b0, 3'b001, 1'b0, 2'bxx, 1'b1};
			default: {RegWriteD, ImmSrcD, ALUSrcD, ALUControlD, MemWriteD, ResultSrcD, BranchD} = {1'b0, 2'b00, 1'b0, 3'b000, 1'b0, 2'b00, 1'b0};
		endcase
	end
endmodule