`timescale 1 ns / 1 ns

module tb_window();
	reg clk;
	reg [11:0] in1, in2;
	wire [11:0] out1, out2;
	wire next;
	wire [2:0] state;
	integer i;
	
	initial clk = 0;
	always #400 clk = ~clk;

	windowing windowing_inst (.clk(clk), .in1(in1), .in2(in2), .out1(out1),
				.out2(out2), .next(next), .state(state));
	
	initial begin
		in1 <= 12'b010000000000;
		in2 <= 12'b010000000000;
		//$monitor("state = %h", state);
		
		@(posedge next);
		for(i = 0; i < 2048; i = i + 2) begin

			@(posedge clk);
			@(posedge clk);
			#100;
			$display("i = %d, out = %d", i, out1);
			$display("i = %d, out = %d", i+1, out2);
		end
		
		#1000;
		$finish;
	end			
	
	always @ (posedge clk) begin
		//$display("state = %h", state);
	end
		
endmodule
