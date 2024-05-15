module WriteBackPipelineRegister
(
  input clk, RegWriteM,
  input [1:0] ResultSrcM,
  input [7:0] ReadDataM, ALUResultM, pcPlus4M,
  input [2:0] RdM,
  output reg RegWriteW,
  output reg [1:0] ResultSrcW,
  output reg [7:0] ALUResultW, ReadDataW, pcPlus4W,
  output reg [2:0] RdW
);
  
  always@(posedge clk)
    begin
      RegWriteW <= RegWriteM;
      ResultSrcW <= ResultSrcM;
      ALUResultW <= ALUResultM;
      ReadDataW <= ReadDataM;
      pcPlus4W <= pcPlus4M;
      RdW <= RdM;
    end
endmodule