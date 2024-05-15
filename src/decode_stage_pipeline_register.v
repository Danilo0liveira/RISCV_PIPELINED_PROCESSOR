module DecodePipelineRegister
(
  input clk, en, clr,
  input [31:0] rom_out,
  input [7:0] pcF, pcPlus4F,
  output reg [31:0] InstrD,
  output reg [7:0] pcD, pcPlus4D
);
  
  always@(posedge clk)
    begin
      if(!en)
        begin
          if(clr)
            begin
                InstrD <= 32'b0;
          		pcD <= 8'b0;
          		pcPlus4D <= 8'b0;
            end
          else
            begin
                InstrD <= rom_out;
          		pcD <= pcF;
          		pcPlus4D <= pcPlus4F;
            end
        end
      else if(clr)
        begin
          InstrD <= 32'b0;
          pcD <= 8'b0;
          pcPlus4D <= 8'b0;
        end
    end
endmodule