`timescale 1 ns / 1 ns
module tb_memory();
	reg clk;
	reg [10:0] addr_a, addr_b;
	wire [7:0] data_a, data_b;
	integer i;
	
	initial clk = 0;
	always #100 clk = ~clk;
	
	memory memory_inst (.addr_a(addr_a), .addr_b(addr_b),
							  .clk(clk), .q_a(data_a), .q_b(data_b));

	initial begin
		addr_a <= 0;
		addr_b <= 1;
		
		for(i = 0; i < 1024; i = i + 1) begin
			@(posedge clk); #10;
			$display("Address = %b, contect = %b.", addr_a, data_a);
			$display("Address = %b, contect = %b.", addr_b, data_b);
			addr_a = addr_a + 2;
			addr_b = addr_b + 2;
		end
		
		#100; 
		$finish;
	end
endmodule
