module ExecutePipelineRegister
(
  input clk, RegWriteD, MemWriteD, BranchD, ALUSrcD, clr,
  input [7:0] rd1, rd2,
  input [2:0] Rs1D, Rs2D,
  input [7:0] pcD, pcPlus4D,
  input [7:0] immExtD,
  input [2:0] RdD, ALUControlD,
  input [1:0] ResultSrcD,
  output reg [2:0] Rs1E, Rs2E,
  output reg RegWriteE, MemWriteE, BranchE, ALUSrcE,
  output reg [7:0] rd1E, rd2E,
  output reg [2:0] RdE, ALUControlE,
  output reg [1:0] ResultSrcE,
  output reg [7:0] immExtE,
  output reg [7:0] pcE, pcPlus4E
);
  
  always@(posedge clk)
    begin
      Rs1E <= Rs1D;
      Rs2E <= Rs2D;
      rd1E <= rd1;
      rd2E <= rd2;
      RdE <= RdD;
      immExtE <= immExtD;
      pcE <= pcD;
      pcPlus4E <= pcPlus4D;
      RegWriteE <= RegWriteD;
      MemWriteE <= MemWriteD;
      BranchE <= BranchD;
      ALUSrcE <= ALUSrcD;
      ALUControlE <= ALUControlD;
      ResultSrcE <= ResultSrcD;
      
      if(clr)
        begin
          Rs1E <= 8'b0;
          Rs2E <= 8'b0;
          rd1E <= 8'b0;
          rd2E <= 8'b0;
          RdE <= 3'b0;
          immExtE <= 8'b0;
          pcE <= 8'b0;
          pcPlus4E <= 8'b0;
          RegWriteE <= 0;
          MemWriteE <= 0;
          BranchE <= 0;
          ALUSrcE <= 0;
          ALUControlE <= 3'b0;
          ResultSrcE <= 2'b0; 
        end
    end      
endmodule