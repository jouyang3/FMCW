//============================================================
//
//  Hsiang-Yi Chung
//  March 2016
//
//  This Module is for transfering the data to a processor
//
//============================================================

module SerialInterface(
	input clk,
	input next_out,
	input reset_n,
	input [11:0] fft_out1,
	input [11:0] fft_out2,
	output reg next_data,
	output reg data
	);
	
	localparam s0 = 3'b000;
	localparam s1 = 3'b001;
	localparam s2 = 3'b010;
	localparam s3 = 3'b011;
	localparam s4 = 3'b100;
	localparam s5 = 3'b101;
	localparam s6 = 3'b110;
	localparam s7 = 3'b111;
	
	reg [2:0] state, nextState;
	reg [10:0] addr_counter;
	reg [3:0] bit_counter;
	reg [11:0] temp;
	reg reset_addr_counter, incre_addr_counter1, incre_addr_counter2, 
		 we_a, we_b, reset_bit_counter, incre_bit_counter, update_output;
	wire [11:0] q_a, q_b;
	wire [10:0] addr_a, addr_b;

	Serial_Ram ram_inst (.data_a(fft_out1), .data_b(fft_out2), 
								.addr_a(addr_a), .addr_b(addr_b),
								.we_a(we_a), .we_b(we_b),
								.q_a(q_a), .q_b(q_b), .clk(clk));
	
	initial begin
		addr_counter = 0;
		we_a = 0;
		we_b = 0;
		next_data = 0;
		data = 0;
		bit_counter = 0;
		update_output = 0;
	end
	
	assign addr_a = addr_counter;
	assign addr_b = addr_counter+1;
	
	always @ (posedge clk) begin
		if(!reset_n) begin
			state <= s0;
		end
		else begin
			state <= nextState;
		end
	end
	
	always @ (posedge clk) begin
		//address counter
		if(reset_addr_counter)
			addr_counter <= 0;
		else if(incre_addr_counter1)
			addr_counter <= addr_counter + 1;
		else if(incre_addr_counter2)
			addr_counter <= addr_counter + 2;
			
		//bit counter
		if(reset_bit_counter)
			bit_counter <= 0;
		else if(incre_bit_counter)
			bit_counter <= bit_counter + 1;
				
		if(update_output) begin
			data <= q_a[11-bit_counter];
		end
	end

	always @ * begin
		reset_addr_counter = 0; incre_addr_counter1 = 0; incre_addr_counter2 = 0;
      next_data = 0; we_a = 0; we_b = 0;
		reset_bit_counter = 0; incre_bit_counter = 0; update_output = 0;
		
		case(state)
			//Wait until the FFT starts to output
			s0: begin
				if(next_out)
					nextState = s1;
				else
					nextState = s0;
			end
			
			s1: begin
				nextState = s2;
				we_a = 1;
				we_b = 1;
			end
			
			//load fft magnitude into buffer
			s2: begin
				nextState = s3;
				we_a = 1;
				we_b = 1;
			end
			
			//check if received 2048 samples & increament counter if needed
			s3: begin
				we_a = 1;
				we_b = 1;
				if(addr_counter == 2046) begin
					reset_addr_counter = 1;
					nextState = s4;
				end else begin
					incre_addr_counter2 = 1;
					nextState = s2;
				end
			end
			
			//asserts the beginning of the output data stream		
			s4: begin
				next_data = 1;
				nextState = s5;
				we_a = 0;
				we_b = 0;
			end
			
			s5: begin
				update_output = 1;
				next_data = 1;
				nextState = s6;
				we_a = 0;
				we_b = 0;
			end
			
			s6: begin
				we_a = 0;
				we_b = 0;
				next_data = 1;
				
				if(bit_counter == 11 && addr_counter == 2047) begin
					reset_addr_counter = 1;
					reset_bit_counter = 1;
					nextState = s0;
					
				end else if(bit_counter == 11) begin
					reset_bit_counter = 1;
					incre_addr_counter1 = 1;
					nextState = s5;
				end else begin
					incre_bit_counter = 1;
					nextState = s5;
				end
			end
		endcase	
	end
endmodule
	