module Average_Filter(
	input [11:0] in,
	input clk,
	input reset_n,
	output reg out_ready,
	output reg [11:0] out1,
	output reg [11:0] out2
	);
	
	localparam s0 = 3'b000;
	localparam s1 = 3'b001;
	localparam s2 = 3'b010;
	localparam s3 = 3'b011;
	localparam s4 = 3'b100;
	localparam s5 = 3'b101;
	localparam s6 = 3'b110;
	localparam s7 = 3'b111;
	reg [2:0] nextState, state;
	reg [11:0] sample_array1 [7:0];
	reg [11:0] sample_array2 [7:0];
	reg [7:0] counter1, counter2;
	reg inc_count1, inc_count2, reset_count1, reset_count2, compute_avg,
			update_array1, update_array2;
	reg [14:0] temp;
	initial begin
		counter1 = 0;
		counter2 = 0;
		state = 0;
	end
	
	always @ (posedge clk) begin
		if(!reset_n) begin
			state <= s0;
		end
		else begin
			state <= nextState;
		end
	end
	
	always @ (posedge clk) begin
		if(inc_count1) begin
			counter1 <= counter1 + 1;
		end
		
		if(inc_count2) begin
			counter2 <= counter2 + 1;
		end
		
		if(reset_count1) begin
			counter1 <= 0;
		end
		
		if(reset_count2) begin
			counter2 <= 0;
		end
		
		if(compute_avg) begin
			temp = sample_array1[0] + sample_array1[1] + sample_array1[2] + sample_array1[3] + sample_array1[4] + 
					 sample_array1[5] + sample_array1[6] + sample_array1[7];
			out1 = temp >> 3;
			
			temp = sample_array2[0] + sample_array2[1] + sample_array2[2] + sample_array2[3] + sample_array2[4] + 
					 sample_array2[5] + sample_array2[6] + sample_array2[7];
			out2 = temp >> 3;
		end
		
		if(update_array1) begin
			sample_array1[counter1[2:0]] <= in;
		end
		
		if(update_array2) begin
			sample_array2[counter2[2:0]] <= in;
		end
	end
	
	always @ * begin
		inc_count1 = 0; inc_count2 = 0; reset_count1 = 0; reset_count2 = 0; out_ready = 0; compute_avg = 0;
		update_array1 = 0; update_array2 = 0;
		
		case(state)
			s0: begin
				update_array1 = 1;
				nextState = s1;
			end
			
			s1: begin
				if(counter1 == 7) begin
					reset_count1 = 1;
					nextState = s2;
				end else begin
					inc_count1 = 1;
					nextState = s0;
				end
			end
			
			s2: begin
				update_array2 = 1;
				nextState = s3;
			end
			
			s3: begin
				if(counter2 == 7) begin
					reset_count2 = 1;
					nextState = s4;
				end else begin
					inc_count2 = 1;
					nextState = s2;
				end
			end
			
			s4: begin
				update_array1 = 1;
				compute_avg = 1;
				nextState = s5;
			end
			
			s5: begin
				inc_count1 = 1;
				out_ready = 1;
				nextState = s0;
			end
		endcase
	end
endmodule
