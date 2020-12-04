/*
 * Module: program_counter
 * Description: Program counter.
 *              Increments by instruction word (2 bytes) every cycle unless halted.
 *              Changes program counter to target address if a branch or jump is valid. 
 */
module program_counter (
		input 	      clk_pi,
		input 	      clk_en_pi,
		input 	      reset_pi,
		
		input 	      branch_taken_pi,
		input [5:0]   branch_immediate_pi, // Needs to be sign extended		
		input 	      jump_taken_pi,
		input [11:0]  jump_immediate_pi, // Needs to be sign extended
			
		output [15:0] pc_po
		);

   reg [15:0] 		      PC;  // Program Counter   
   
	initial begin
		PC <= 16'hFFFF;  // Do not remove. Assumed by the Testbench and results files.
	end


	always @(posedge clk_pi) begin
		if (reset_pi) begin
			//Reset stuff
			PC <= 16'd0; // Make sure this is the right thing
		end else begin // If not reset vv
			if (clk_en_pi) begin
				if (branch_taken_pi) begin
					//Branch taken stuff // Includes sign extension
					PC <= PC + {{10{branch_immediate_pi[5]}}, branch_immediate_pi[5:0]}; // Unsure about this line, but it should be right
				end else if (jump_taken_pi) begin
					//Jump taken stuff // Includes sign extension
					PC <= PC + {{4{jump_immediate_pi[11]}}, jump_immediate_pi[11:0]};
				end 
				
				PC <= PC + 16'd2; // If none of ^^ , increment by 2
			end
		end // From reset's else
	end
   
	assign pc_po = PC;
endmodule



