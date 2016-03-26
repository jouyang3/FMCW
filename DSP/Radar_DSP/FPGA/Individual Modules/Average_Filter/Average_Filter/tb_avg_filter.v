/* 
	Testbench for Average Filter 
	By Hsiang-Yi Chung 
	February, 2016
*/

`timescale 1 ns / 1 ps
module tb_avg_filter;
	reg [11:0] in;
	reg [10:0] dummy;
	reg clk;
	wire out_ready;
	wire [11:0] out1;
	wire [11:0] out2;
	reg [16:0] test;
	reg [5:0] i,j;
	reg [16:0] tb_result1, tb_result2;
	Average_Filter filter (.in(in), .clk(clk), .reset_n(1'b1), .out_ready(out_ready), .out1(out1), .out2(out2));

	initial begin
		test = 0;
		for (j = 0; j < 16; j = j + 1) begin
			
			for (i = 0; i < 16; i = i + 1) begin
			  in = $random;
			  test = test + in;
			  if(i == 7) begin
					tb_result1 = test >> 3;
					test = 0;
			  end else if (i == 15) begin
					tb_result2 = test >> 3;
					test = 0;
			  end
			  
			  if(out_ready) begin
					if((tb_result1 == out1) && (tb_result2 == out2))
						$display("Correct: tb_result1 = %d, Out1 = %d, tb_result2 = %d, Out2 = %d. ", tb_result1, out1, tb_result2, out2);
					else
						$display("Error: tb_result1 = %d, Out1 = %d, tb_result2 = %d, Out2 = %d. ", tb_result1, out1, tb_result2, out2);
			  end
			  @(posedge clk);
			  @(posedge clk);
			end		
		end
		#1000 $finish;
	end
	
	initial begin
		clk = 0;
		forever #25 clk = ~clk; //50ns clock period (twice the 10Mhz ADC sampling rate)
	end
endmodule
