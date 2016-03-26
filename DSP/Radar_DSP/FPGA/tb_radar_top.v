`timescale 1 ns / 100 ps
module tb_radar_top();
	reg [11:0] adc_in;
	reg [15:0] counter;
	reg clk, reset_n;
	reg [11:0] input_vector [0:16383];
	wire fft_next_out, next_data, data, serial_clk;
	wire [11:0] mag_out1, mag_out2;
	integer file, j, m;
	
	initial clk = 0;
	always #25 clk = ~clk;  //20 MHz
	
	Radar_top radar_inst(.clk(clk), .reset_n(reset_n),
								.mag_out1(mag_out1), .mag_out2(mag_out2),
								.fft_next_out(fft_next_out), 
								.adc_in(adc_in),
								.next_data(next_data), .data(data), .clk_div_16(serial_clk));

	initial counter = 0;
	always @(posedge serial_clk) begin
		counter <= counter+1;
      
      if(counter % 1000 == 0)
        $display("Counter = %d.", counter/2);
   end
	
	initial begin
		adc_in <= 0;
		reset_n <= 1;
		@(posedge clk);

		$readmemb("FFT_Input_54k_96k.txt", input_vector);
		
		for (j=0; j < 16384; j = j+1) begin
			adc_in <= input_vector[j];
         @(posedge clk);
			@(posedge clk);
      end
		$display("Done input vector, counter = %d", counter);
   end
	
	initial begin
      @(posedge serial_clk);
      @(posedge serial_clk);
		@(posedge serial_clk);
      @(posedge next_data);
      @(posedge serial_clk);
		@(posedge serial_clk);
		@(posedge serial_clk); #100;
      $display("--- begin output ---");
		file = $fopen("Serial_output_final.txt") ;
		
		for(m = 0; m < 2048 * 12; m = m + 1) begin
			if(m % 12 == 0) begin
				$fwrite(file, "\n");
				//$write("\ndata=");
			end
			$fwrite(file, "%b", data);
			//$write("%b", data);
			@(posedge serial_clk);
			@(posedge serial_clk);#100;
		end
		
		$fdisplay(file, "%b", data);
		$fclose(file);
		$display("--- done output ---");
      $finish;
   end
endmodule
