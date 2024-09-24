// Joseph Abdelmalek
// jabdelmalek@hmc.edu
// 9/23/24
// Keypad scanner module for Lab 3

module keyscanner(
	input	logic	reset, clk,
	input 	logic	[3:0] row, col,
	output 	logic 	[3:0] s
);

	logic [6:0] count;
	logic [16:0] t;
	
	// Multiplex Frequency of switching
	parameter rowcheck = 'd20;
	parameter bouncecheck = 'd100000;

	// State Initiation
	typedef enum logic [3:0] {s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7, s8 = 8} statetype;
	statetype state, nextstate;

	// State Register
	always_ff @(posedge clk) begin
		if (~reset)	begin
			state <= s0;
			count <= 'd0; 
		end
		else
			state <= nextstate;
	end
	
	//Next State Logic
	always_comb
		case (state)
			s0: nextstate = s1;
			s1: if (row == 4'b1110) nextstate = s5;
				else if (count >= rowcheck) nextstate = s2;
				else nextstate = s1;
			s2: if (row == 4'b1101) nextstate = s6;
				else if (count >= rowcheck) nextstate = s3;
				else nextstate = s2;
			s3: if (row == 4'b1011) nextstate = s7;
				else if (count >= rowcheck) nextstate = s4;
				else nextstate = s3;
			s4: if (row == 4'b0111) nextstate = s8;
				else if (count >= rowcheck) nextstate = s1;
				else nextstate = s4;
			s5: if (row == 1111 && t >= bouncecheck) nextstate = s1;
				else nextstate = s5;
			s6: if (row == 1111 && t >= bouncecheck) nextstate = s2;
				else nextstate = s6;
			s7: if (row == 1111 && t >= bouncecheck) nextstate = s3;
				else nextstate = s7;
			s8: if (row == 1111 && t >= bouncecheck) nextstate = s4;
				else nextstate = s8;
			default: nextstate = s0;
		endcase
	
	// Output Logic
	always_comb
		case(state)
			s0: begin
					s = 'b1111;
				end
			s1: begin
					s = s;
					count = count + 7'd1;
					t = 0;
				end
			s2: begin
					s = s;
					count = count + 7'd1;
					t = 0;
				end
			s3: begin
					s = s;
					count = count + 7'd1;
					t = 0;
				end
			s4: begin
					s = s;
					count = count + 7'd1;
					t = 0;
				end
			s5: begin
					t = t + 17'd1;
					count = 0;
					if (col[0] == 0) s = 'b1110;		// Output 1
					else if (col[1] == 0) s = 'b1101;	// Output 2
					else if (col[2] == 0) s = 'b1100;	// Output 3
					else if (col[3] == 0) s = 'b0101;	// Output A (10)
					else s = s;
				end
			s6: begin
					t = t + 17'd1;
					count = 0;
					if (col[0] == 0) s = 'b1101;		// Output 4
					else if (col[1] == 0) s = 'b1010;	// Output 5
					else if (col[2] == 0) s = 'b1001;	// Output 6
					else if (col[3] == 0) s = 'b0100;	// Output B (11)
					else s = s;
				end
			s7: begin
					t = t + 17'd1;
					count = 0;
					if (col[0] == 0) s = 'b1000;		// Output 7
					else if (col[1] == 0) s = 'b0111;	// Output 8
					else if (col[2] == 0) s = 'b0110;	// Output 9
					else if (col[3] == 0) s = 'b0011;	// Output C (12)
					else s = s;
				end
			s8: begin
					t = t + 17'd1;
					count = 0;
					if (col[0] == 0) s = 'b0001;		// Output E (14)
					else if (col[1] == 0) s = 'b1111;	// Output 0
					else if (col[2] == 0) s = 'b0000;	// Output F (15)
					else if (col[3] == 0) s = 'b0010;	// Output D (13)
					else s = s;
				end
			default: begin
						count = 0;
						t = 0;
						s = 'b1111;
					end
		endcase
endmodule