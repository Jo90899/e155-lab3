// Joseph Abdelmalek
// jabdelmalek@hmc.edu
// 9/23/24
// Module to update the digits when an input is collected from the keypad

module updater(
	input	logic	reset, clk,
	input 	logic	[3:0] s,
	input 	logic 	[3:0] n1_in, n2_in,
	output 	logic 	[3:0] n1_out, n2_out
);
	
	// State Initiation
	typedef enum logic [1:0] {s0 = 0, s1 = 1, s2 = 2} statetype;
	statetype state, nextstate;

	// State Register
	always_ff @(posedge clk) begin
		if (~reset)	begin
			state <= s0;
		end
		else
			state <= nextstate;
	end
	
	//Next State Logic
	always_comb
		case (state)
			s0: nextstate = s1;
			s1: if (s != n2_in) nextstate = s2;
				else nextstate = s1;
			s2: if (s == n2_in) nextstate = s1;
				else nextstate = s2;
			default: nextstate = s0;
		endcase

	//Output Logic
	always_comb
		case(state)
			s0: begin
					n1_out = 'b1111;
					n2_out = 'b1111;
				end
			s1: begin
					n1_out = n1_in;
					n2_out = n2_in;
				end
			s2: begin
					n1_out = n2_in;
					n2_out = s;
				end
			default: begin
						n1_out = 'b1111;
						n2_out = 'b1111;
					end
		endcase
endmodule