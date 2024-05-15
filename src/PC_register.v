module ProgamCounter
(
	input clk, rst, en, 
  	input [7:0] pcin,
  	output reg [7:0] pc
);

  	always@(posedge clk or negedge rst)
	begin
      if(!en)
		pc <= rst ? pcin : 0;
      else
        pc <= pc;
	end
	
endmodule