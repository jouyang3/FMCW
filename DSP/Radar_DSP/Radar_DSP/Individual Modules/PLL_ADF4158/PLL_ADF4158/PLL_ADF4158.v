/* 
	Code for Setting up ADF4158 PLL Module 
	By Hsiang-Yi Chung 
	February, 2016
*/

module PLL_ADF4158(
	input clk,
	input reset_n,
	output reg writeData,
	output reg loadEnable,
	output pll_clk
	);
	
	localparam s0 = 2'b00;
	localparam s1 = 2'b01;
	localparam s2 = 2'b10;
	localparam s3 = 2'b11;
	localparam num_registers_to_set = 8;
	
	reg [31:0] writeDataArray [num_registers_to_set - 1:0];
	reg [31:0] current_register;
	reg [1:0] nextState, state;
	reg [4:0] bit_counter;
	reg [2:0] register_counter;
	reg dec_register_counter, dec_bit_counter;

	assign pll_clk = clk;
	
	initial begin
		state = s0;
		bit_counter = 31;
		register_counter = num_registers_to_set - 1;
		dec_register_counter = 0;
		dec_bit_counter = 0;
		loadEnable = 0;
		writeDataArray[0] = 32'b1_0000_000011000110_000000000000_000;       //reg 0
		writeDataArray[1] = 32'b0000_0000000000000_000000000000_001;        //reg 1
		writeDataArray[2] = 32'b000_0_1111_0_1_1_0_00001_000000000001_010;  //reg 2
		writeDataArray[3] = 32'b0000000000000000_1_0_00_01_0_0_0_0_0_0_0_011; //reg 3
		writeDataArray[4] = 32'b0_00000_0_11_00_11_000000000001_0000_100;   //reg 4
		writeDataArray[5] = 32'b00_0_0_00_0_0_0_0000_0010010101110010_101;  //reg 5 DEV SEL = 0
		writeDataArray[6] = 32'b00000000_0_00000011011010110000_110;        //reg 6 STEP SEL = 0
		writeDataArray[7] = 32'b0000_0000_0000_0000_0000_0000_0000_0_111;   //reg 7
	end
	
	
	always @ (negedge clk) begin
		if(!reset_n) begin
			state <= s0;
		end
		else begin
			state <= nextState;
		end
	end
	
	always @(negedge clk) begin
		if(dec_register_counter == 1) begin
			register_counter <= register_counter - 1;
		end
		
		if(dec_bit_counter == 1) begin
			bit_counter <= bit_counter - 1;
		end
	end
	
	
	always @ * begin
		dec_bit_counter = 0;
		dec_register_counter = 0;
		loadEnable = 0;
		current_register = writeDataArray[register_counter];
		writeData = current_register[bit_counter];
		
		case(state)
			s0: begin
				dec_bit_counter = 1;
				nextState = s1;
			end
			
			s1: begin
				if(bit_counter == 0) begin
					nextState = s2;
				end else begin
					nextState = s1;
					dec_bit_counter = 1;
				end
			end
			
			s2: begin
				loadEnable = 1;
				if(register_counter != 0) begin
					nextState = s0;
					dec_register_counter = 1;
					dec_bit_counter = 1;
				end else begin
					nextState = s3;
				end
			end
			
			s3: begin
				nextState = s3;
			end
		endcase
	end
endmodule 
