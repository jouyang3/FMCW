/* 
	Testbench for ADF4158 PLL Module 
	By Hsiang-Yi Chung 
	February, 2016
*/

`timescale 1 ns / 1 ps
module pll_testbench;
	reg Clock;
	wire writeData;
	wire loadEnable;
	wire pll_clk;
	
	PLL_ADF4158 pll (.clk(Clock), .reset_n(1), .writeData(writeData), .loadEnable(loadEnable), .pll_clk(pll_clk));

	initial begin
		Clock = 0;
		forever #25 Clock = ~Clock; //50ns clock period
	end
endmodule
