module MemoryPipeRegister
(
  input clk, RegWriteE, MemWriteE,
  input [7:0] ALUResultE, WriteDataE, pcPlus4E,
  input [1:0] ResultSrcE,
  input [2:0] RdE,
  output reg RegWriteM, MemWriteM,
  output reg [1:0] ResultSrcM,
  output reg [7:0] ALUResultM, WriteDataM, pcPlus4M,
  output reg [2:0] RdM
);
  
  always@(posedge clk)
    begin
      RegWriteM <= RegWriteE;
      MemWriteM <= MemWriteE;
      ResultSrcM <= ResultSrcE;
      ALUResultM <= ALUResultE;
      WriteDataM <= WriteDataE;
      pcPlus4M <= pcPlus4E;
      RdM <= RdE;
    end
  
endmodule