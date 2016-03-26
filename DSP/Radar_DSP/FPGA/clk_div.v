//=======================================================================
//
//  Hsiang-Yi Chung
//  March 2016
//
//  This Module divides the input clock by 16 and 32
//
//=======================================================================

module clk_div(
	input clk,
	output reg clk_div_32,
	output reg clk_div_16);
	
	reg [3:0] div_32_counter;
	reg [2:0] div_16_counter;
	
	initial begin
		div_32_counter = 8; //to make ure div16 and div32 are in phase
		div_16_counter = 0;
		clk_div_32 = 0;
		clk_div_16 = 0;
	end
	
	always @ (posedge clk) begin
		if(div_32_counter == 15) begin
			div_32_counter <= 0;
			clk_div_32 <= ~clk_div_32;
		end else begin
			div_32_counter <= div_32_counter + 1;
		end
		
		if(div_16_counter == 7) begin
			div_16_counter <= 0;
			clk_div_16 <= ~clk_div_16;
		end else begin
			div_16_counter <= div_16_counter + 1;
		end
	end
endmodule
