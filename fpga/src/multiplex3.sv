// Joseph Abdelmalek
// jabdelmalek@hmc.edu
// 9/23/24
// Multiplex module for Lab 3 (same as lab 2)

module multiplex(
	input	logic	reset, clk,
	input 	logic	[3:0] n1, n2,
	output	logic	d1, d2,
	output 	logic 	[3:0] s
);

	logic [24:0] counter;
	
	// Multiplex Frequency of switching
	parameter plextime = 'd50000;

	// State Initiation
	typedef enum logic [1:0] {s0 = 0, s1 = 1, s2 = 2} statetype;
	statetype state, nextstate;

	// State Register
	always_ff @(posedge clk) begin
		if (~reset)	begin
			state <= s0;
			counter <= 'd0; 
		end
		else if (counter >= plextime) begin
			counter <= 'd0;
			state <= nextstate;
		end
		else begin
			counter <= counter + 25'd1;
			state <= nextstate;
		end
	end
	
	//Next State Logic
	always_comb
		case (state)
			s0: nextstate = s1;
			s1: if (counter >= plextime) nextstate = s2;
				else nextstate = s1;
			s2: if (counter >= plextime) nextstate = s1;
				else nextstate = s2;
			default: nextstate = s0;
		endcase
	
	// Output Logic
	always_comb
		case(state)
			s0: begin
					d1 = 'b1;
					d2 = 'b1;
					s = 'b1111;
				end
			s1: begin
					d1 = 'b0;
					d2 = 'b1;
					s = n1;
				end
			s2: begin
					d1 = 'b1;
					d2 = 'b0;
					s = n2;
				end
			default: begin
						d1 = 'b1;
						d2 = 'b1;
						s = 'b1111;
					end
		endcase
endmodule