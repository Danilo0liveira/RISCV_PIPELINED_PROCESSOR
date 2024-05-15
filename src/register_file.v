module RegisterFile
(
	input clk, rst, write_enable, 
	input [7:0] write_data,
	input [2:0] write_address, ra1, ra2,
  	output reg [7:0] rd1, rd2,
  	output reg [7:0] r0, r1, r2, r3, r4, r5, r6, r7
);
  	reg [7:0] registers [7:0];
  
  	always@*
	begin
		rd1 = registers[ra1];
		rd2 = registers[ra2];
      	r0 = registers[0];
		r1 = registers[1];
		r2 = registers[2];
		r3 = registers[3];
		r4 = registers[4];
		r5 = registers[5];
		r6 = registers[6];
		r7 = registers[7];
	end
  
  	always@(negedge clk or negedge rst)
	begin
		if(!rst)
		 begin
			registers[0] <= 8'b0;
			registers[1] <= 8'b0;
			registers[2] <= 8'b0;
			registers[3] <= 8'b0;
			registers[4] <= 8'b0;
			registers[5] <= 8'b0;
			registers[6] <= 8'b0;
			registers[7] <= 8'b0;
		 end
      else if(write_enable && (write_address!=3'b0))
		begin
			registers[write_address] <= write_data;
		end
	end
endmodule