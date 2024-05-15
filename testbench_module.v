
module test_pipeline_processor();
  reg rst, clk, zero_flag;
  wire [7:0] m_out_pc, m_in_pcPlus4, m_in_pcPlusImm;
  wire [7:0] pcF, pcD, pcE;
  wire [7:0] pcPlus4F, pcPlus4D, pcPlus4E, pcPlus4M, pcPlus4W;
  wire [7:0] immExtD, immExtE;
  wire [7:0] w_rd1, w_rd2;
  wire [31:0] rom_out, InstrD;
  wire [7:0] rd1E, rd2E, PcTargetE, SrcAE, SrcBE, mout_srcB2, ALUResultE;
  wire [2:0] RdE, RdM, RdW;
  wire [7:0] ALUResultM, WriteDataM, ReadDataM;
  wire [7:0] ALUResultW, ReadDataW, ResultW;
  wire [2:0] ALUControlE, ALUControlD;
  wire [1:0] ImmSrcD, ResultSrcD, ResultSrcE, ResultSrcM, ResultSrcW;
  wire ALUSrcD, RegWriteD, MemWriteD, BranchD;
  wire ALUSrcE, RegWriteE, MemWriteE, BranchE;
  reg PcSrcE;
  wire RegWriteM, MemWriteM;
  wire RegWriteW;
  reg [7:0] r0, r1, r2, r3, r4, r5, r6, r7;
  wire [2:0] Rs1D, Rs2D, Rs1E, Rs2E;
  wire [1:0] ForwardAE, ForwardBE;
  wire FlushD, FlushE, StallD, StallF;
  reg rst_ctrl;
  
  ProgamCounter pczinho(.clk(clk), .en(StallF & rst_ctrl), .rst(rst), .pcin(m_out_pc), .pc(pcF));
  
  assign pcPlus4F = pcF + 8'h4;
  assign m_out_pc = (PcSrcE) ? PcTargetE : pcPlus4F;
  
  InstructionMem romzinha(.address(pcF), .rd(rom_out));
  
  FetchPipeRegister fetch_registrinho(
    .clk(clk), .en(StallD & rst_ctrl), .clr(FlushD),
    .rom_out(rom_out), .pcF(pcF), .pcPlus4F(pcPlus4F),
    .InstrD(InstrD), .pcD(pcD), .pcPlus4D(pcPlus4D)
  );
  
  RegisterFile registrinho(
    .clk(clk), .rst(rst), .write_enable(RegWriteW),
    .write_data(ResultW), .write_address(RdW),
    .ra1(InstrD[17:15]), .ra2(InstrD[22:20]), .rd1(w_rd1), .rd2(w_rd2),
    .r0(r0), .r1(r1), .r2(r2), .r3(r3), 
    .r4(r4), .r5(r5), .r6(r6), .r7(r7)
  );
  
  Mux4 imm_muxinho(
    .a(InstrD[31:20]),
    .b({InstrD[31:25], InstrD[11:7]}),
    .c({InstrD[7], InstrD[30:25], InstrD[11:8], 1'b0}),
    .ctrl(ImmSrcD),
    .mout(immExtD)
  );
  
  assign Rs1D = InstrD[17:15];
  assign Rs2D = InstrD[22:20];
  
  DecodePipeRegister decode_registrinho(
    .clk(clk), .RegWriteD(RegWriteD), .MemWriteD(MemWriteD),
    .BranchD(BranchD), .ALUSrcD(ALUSrcD), .clr(FlushE & rst_ctrl),
    .rd1(w_rd1), .rd2(w_rd2), .pcD(pcD), .pcPlus4D(pcPlus4D), 
    .immExtD(immExtD), .RdD(InstrD[9:7]), .ALUControlD(ALUControlD),
    .ResultSrcD(ResultSrcD), .RegWriteE(RegWriteE), .MemWriteE(MemWriteE),
    .BranchE(BranchE), .ALUSrcE(ALUSrcE), .rd1E(rd1E), .rd2E(rd2E), 
    .RdE(RdE), .ALUControlE(ALUControlE), .immExtE(immExtE),
    .pcE(pcE), .pcPlus4E(pcPlus4E), .ResultSrcE(ResultSrcE),
    .Rs1D(Rs1D), .Rs2D(Rs2D),
    .Rs1E(Rs1E), .Rs2E(Rs2E) 
  );
  
  assign PcTargetE = pcE + immExtE;
  assign SrcBE = (ALUSrcE) ? immExtE : mout_srcB2;
  
  always@*
    begin
      PcSrcE = BranchE & zero_flag;
    end
   
  Mux4 mux_srcA(
    .a(rd1E), .b(ResultW), .c(ALUResultM),
    .ctrl(ForwardAE), .mout(SrcAE)
  );
  
   Mux4 mux_srcB2(
     .a(rd2E), .b(ResultW), .c(ALUResultM),
     .ctrl(ForwardBE), .mout(mout_srcB2)
  );
  
  ALU aluzinha(
    .src_a(SrcAE), .src_b(SrcBE), .ctrl(ALUControlE),
    .result(ALUResultE), .z(zero_flag)
  );
  
  MemoryPipeRegister memory_registrinho(
    .clk(clk), .RegWriteE(RegWriteE), .MemWriteE(MemWriteE),
    .ALUResultE(ALUResultE), .WriteDataE(mout_srcB2),
    .pcPlus4E(pcPlus4E), .ResultSrcE(ResultSrcE), .RdE(RdE),
    .RegWriteM(RegWriteM), .MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM), 
    .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .pcPlus4M(pcPlus4M),
    .RdM(RdM)
  );
  
  DataMemory ramzinha(
    .clk(clk), .rst(rst), .write_enable(MemWriteM),
    .address(ALUResultM), .write_data(WriteDataM), .rd(ReadDataM)
  );
  
  WriteBackPipeRegister write_back_registrinho(
    .clk(clk), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM),
    .ReadDataM(ReadDataM), .ALUResultM(ALUResultM),.pcPlus4M(pcPlus4M), 
    .RdM(RdM), .ALUResultW(ALUResultW), .ReadDataW(ReadDataW),
    .pcPlus4W(pcPlus4W), .RdW(RdW),
    .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW)
  );
  
  Mux4 wb_mux(
    .a(ALUResultW), .b(ReadDataW), .c(pcPlus4W), 
    .ctrl(ResultSrcW), .mout(ResultW)
  );
  
  ControlUnit controlinho(
    .op_code(InstrD[6:0]), .func7(InstrD[31:25]), .func3(InstrD[14:12]),
    .ALUControlD(ALUControlD), .ImmSrcD(ImmSrcD), .ALUSrcD(ALUSrcD), 
    .RegWriteD(RegWriteD), .MemWriteD(MemWriteD), .ResultSrcD(ResultSrcD),
    .BranchD(BranchD)
  );
  
  HazardUnit hazardinho(
    .rst(rst), .PcSrcE(PcSrcE), .FlushD(FlushD),
    .RegWriteM(RegWriteM), .RegWriteW(RegWriteW), .ResultSrcE0(ResultSrcE[0]),
    .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E),
    .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW),
    .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
    .FlushE(FlushE), .StallD(StallD), .StallF(StallF)
  );
  
  initial
    begin
      $dumpvars(0, test_pipline_processor);
      PcSrcE = 0;
      clk = 0;
      rst = 0;
      rst_ctrl = 0;
      #1 rst = 1;
      #1 rst = 0;
      #1 rst = 1;
      #1 clk = 1;
      #1 clk = 0;
      rst_ctrl = 1;

      #1000 $finish;
    end
  
  always
    begin
      #20 clk = 1;
      #20 clk = 0;
    end
endmodule