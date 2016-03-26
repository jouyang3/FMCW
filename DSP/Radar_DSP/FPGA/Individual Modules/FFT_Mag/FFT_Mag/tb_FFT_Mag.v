`timescale 100 ps / 100 ps 
module tb_FFT_Mag();
   reg clk, reset, next;
   wire next_out;
   integer i, j, k, l, m;
   reg [15:0] counter;
   reg [11:0] in [3:0];
   wire [11:0] X0;
   wire [11:0] Y0;
   wire [11:0] X1;
   wire [11:0] Y1;
   wire [11:0] X2;
   wire [11:0] Y2;
   wire [11:0] X3;
   wire [11:0] Y3;
   reg clrCnt;
   assign X0 = in[0];
   assign X1 = in[1];
   assign X2 = in[2];
   assign X3 = in[3];
	reg [11:0] input_vector [0:2047];
	integer file;
	
   initial clk = 0;

   always #10000 clk = ~clk;
	
	wire [11:0] mag1, mag2;
   // Instantiate top-level module of core 'X' signals are system inputs
   // and 'Y' signals are system outputs
   FFT_Mag FFT_Mag_instance (.clk(clk), .reset(reset), .next(next), .next_out(next_out),
    .X0(X0), .X1(X1), .X2(X2), .X3(X3), .mag1(mag1), .mag2(mag2));

	
	 

   // You can use this counter to verify that the gap and latency are as expected.
   always @(posedge clk) begin
      if (clrCnt) counter <= 0;
      else counter <= counter+1;
      
      if(counter % 500 == 0)
        $display("Counter = %d.", counter);
   end


   initial begin
      @(posedge clk);
      @(posedge clk);

      // On the next cycle, begin loading input vector.
      next <= 1;
      clrCnt <= 1;
      @(posedge clk);
      clrCnt <= 0;
      next <= 0;

		
		$readmemb("FFT_Input.txt", input_vector);
		for (j=0; j < 2046; j = j+2) begin
			in[0] <= input_vector[j];
			in[1] <= 0;
			in[2] <= input_vector[j+1];
			in[3] <= 0;
			
			//output the values read from .txt file
			$display("%d, counter = %d", input_vector[j],counter);
			$display("%d", input_vector[j+1]);
         @(posedge clk);
      end
      j = 2046;
      in[0] <= input_vector[j];
		in[1] <= 0;
		in[2] <= input_vector[j+1];
		in[3] <= 0;
		$display("Done input vector, counter = %d", counter);
   end


   initial begin
      // set initial values
      in[0] <= 0;
      in[1] <= 0;
      in[2] <= 0;
      in[3] <= 0;
      next <= 0;
      reset <= 0;

      @(posedge clk);
      reset <= 1;
      @(posedge clk);
      reset <= 0;
      @(posedge clk);
      @(posedge clk);
      // Wait until next_out goes high, then wait one clock cycle and begin receiving data
      @(posedge next_out);
      @(posedge clk); #1000;
      $display("--- begin output ---");
		file = $fopen("FFT_output.txt") ;
		
		for(m = 0; m < 1023; m = m + 1) begin
			$fdisplay(file, "%b", mag1) ;
			$fdisplay(file, "%b", mag2) ;
			@(posedge clk); #1000;
		end
			$fdisplay(file, "%b", mag1) ;
			$fdisplay(file, "%b", mag2) ;
		$fclose(file) ;
		$display("--- done output ---");
      $finish;
   end
endmodule
