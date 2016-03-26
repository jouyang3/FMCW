module windowing(
	input [11:0] in1,
	input [11:0] in2,
	input clk,
	output reg[11:0] out1,
	output reg[11:0] out2,
	output reg next,
	output reg [2:0] state
	);
	
	reg [10:0] addr_counter;
	wire [10:0] addr_a, addr_b;
	wire [7:0] data_a, data_b;
	reg [2:0] nextState; //state
	reg [13:0] gap_counter;
	reg reset_addr_counter, incre_addr_counter, update_output,
		incre_gap_counter, reset_gap_counter;
	reg [19:0] multiplier_temp_a, multiplier_temp_b;
	
	
	memory memory_inst (.addr_a(addr_a), .addr_b(addr_b),
							  .clk(clk), .q_a(data_a), .q_b(data_b));
							  
	localparam s0 = 3'b000;
	localparam s1 = 3'b001;
	localparam s2 = 3'b010;
	localparam s3 = 3'b011;
	localparam s4 = 3'b100;
	localparam s5 = 3'b101;
	localparam s6 = 3'b110;
	localparam s7 = 3'b111;

	initial 	begin
		addr_counter = 0;
		state = s0;
		nextState = s0;
		next = 0;
		gap_counter = 0;
	end
	
	assign addr_a = addr_counter;
	assign addr_b = addr_counter + 1;
	
	always @ (posedge clk) begin	
		state <= nextState;
	end
	
	always @ (posedge clk) begin
		if(reset_addr_counter)
			addr_counter <= 0;
		else if(incre_addr_counter)
			addr_counter <= addr_counter + 2;
		
		if(reset_gap_counter)
			gap_counter <= 0;
		else if(incre_gap_counter)
			gap_counter <= gap_counter + 1;
		
		
		if(update_output) begin
			//out1 <= ((in1 * data_a) >> 7);
			//out2 <= ((in2 * data_b) >> 7);
			multiplier_temp_a = in1 * data_a;
			multiplier_temp_b = in2 * data_b;
			
			out1 = multiplier_temp_a >> 7;
			out2 = multiplier_temp_b >> 7;
		end
			
	end
	
	always @ * begin
		update_output = 0;
		incre_addr_counter = 0;
		incre_gap_counter = 0;
		reset_gap_counter = 0;
		next = 0;
		case(state)
			//fft runs at 2x slower clock rate, so need two clk cycle to assert 'next' high
			s0: begin
				nextState = s1;
			end
			
			s1: begin
				next = 1;
				update_output = 1;
				incre_addr_counter = 1;
				nextState = s2;
			end
			
			s2: begin
				next = 1;
				nextState = s3;
			end
			
			s3: begin
				update_output = 1;
				incre_addr_counter = 1;
				nextState = s4;
			end
			
			s4: begin
				if(addr_counter == 2048) begin
					nextState = s5;
					reset_addr_counter = 1;
				end else
					nextState = s3;
			end
			
			s5: begin
				incre_gap_counter = 1;
				nextState = s6;
			end
			
			s6: begin
				if(gap_counter == 11290) 	 //gap for fft module
					nextState = s0;
				else	
					nextState = s5;
			end
		endcase
	end
	
	
	
	
	
endmodule
