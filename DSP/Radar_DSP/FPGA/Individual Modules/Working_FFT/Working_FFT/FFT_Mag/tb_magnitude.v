`timescale 100 ps / 100 ps 
module tb_magnitude();
	reg clk;
	
	initial clk = 0;
	always #10000 clk = ~clk;
	wire [11:0] mag1, mag2;
	reg [11:0] Y0, Y1, Y2, Y3;

	magnitude magnitude_inst(.Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3), .mag1(mag1), .mag2(mag2));
	
	
	initial begin
		@(posedge clk);
		Y0 <= 12'b111111111101;
 		Y1 <= 12'b111111111110;
		Y2 <= 12'b111111111111;
		Y3 <= 12'b111111111110;
		#10;
		$display("Y0 = %d, Y1 = %d, Y2 = %d, Y3 = %d.", Y0, Y1, Y2, Y3);
		
		@(posedge clk);
		$display("mag1 = %d, mag2 = %d", mag1, mag2);
		Y0 <= 12'b000000010110;
 		Y1 <= 12'b000001000100;
		Y2 <= 12'b000001001110;
		Y3 <= 12'b000011110011;
		#10;
		$display("Y0 = %d, Y1 = %d, Y2 = %d, Y3 = %d.", Y0, Y1, Y2, Y3);
		
		@(posedge clk);
		$display("mag1 = %d, mag2 = %d", mag1, mag2);
		Y0 <= $random;
 		Y1 <= $random;
		Y2 <= $random;
		Y3 <= $random;
		#10;
		$display("Y0 = %d, Y1 = %d, Y2 = %d, Y3 = %d.", Y0, Y1, Y2, Y3);
		
		@(posedge clk);
		$display("mag1 = %d, mag2 = %d", mag1, mag2);
		Y0 <= $random;
 		Y1 <= $random;
		Y2 <= $random;
		Y3 <= $random;
		#10;
		$display("Y0 = %d, Y1 = %d, Y2 = %d, Y3 = %d.", Y0, Y1, Y2, Y3);
		
		@(posedge clk);
		$display("mag1 = %d, mag2 = %d", mag1, mag2);
		Y0 <= $random;
 		Y1 <= $random;
		Y2 <= $random;
		Y3 <= $random;
		#10;
		$display("Y0 = %d, Y1 = %d, Y2 = %d, Y3 = %d.", Y0, Y1, Y2, Y3);
		
		@(posedge clk);
		$display("mag1 = %d, mag2 = %d", mag1, mag2);
		Y0 <= $random;
 		Y1 <= $random;
		Y2 <= $random;
		Y3 <= $random;
		#10;
		$display("Y0 = %d, Y1 = %d, Y2 = %d, Y3 = %d.", Y0, Y1, Y2, Y3);
		
		@(posedge clk);
		$display("mag1 = %d, mag2 = %d", mag1, mag2);
		
		#1000 $finish;
	end



endmodule
