module DataMemory
(
	input rst, clk, write_enable,
	input [7:0] address, write_data,
	output reg [7:0] rd
);

	reg [7:0] memory [255:0];
	
	always@*
	begin
		rd = memory[address];
	end
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst)
		begin
			integer i;
			for(i=0; i<256;i=i+1)
			begin
				memory[i] <= 8'b0;
			end
		end
		else if(write_enable)
			memory[address] <= write_data;
	end
endmodule