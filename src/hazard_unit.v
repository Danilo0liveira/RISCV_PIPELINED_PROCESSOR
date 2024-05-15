module HazardUnit
(
  input RegWriteM, RegWriteW, ResultSrcE0, rst, PcSrcE,
  input [2:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
  output reg FlushD, FlushE, StallD, StallF,
  output reg [1:0] ForwardAE, ForwardBE
);
  always@*
    begin
      if(((Rs1E == RdM) & RegWriteM) & Rs1E!=0)
        ForwardAE = 2'b10;
      else if(((Rs1E == RdW) & RegWriteW) & Rs1E!=0)
        ForwardAE = 2'b01;
      else
        ForwardAE = 2'b00;

      if(((Rs2E == RdM) & RegWriteM) & Rs2E!=0)
        ForwardBE = 2'b10;
      else if(((Rs2E == RdW) & RegWriteW) & Rs2E!=0)
        ForwardBE = 2'b01;
      else
        ForwardBE = 2'b00;


      casez(ResultSrcE0)
        1'bx : {FlushD, FlushE, StallD, StallF} = {PcSrcE, 1'b0 || PcSrcE, 1'b0, 1'b0};
        default:
          begin
            FlushD = PcSrcE;
            FlushE = (((Rs1D == RdE) || (Rs2D == RdE)) & ResultSrcE0) || PcSrcE;
            StallD = FlushE;
            StallF = StallD;
          end
      endcase
    end
endmodule