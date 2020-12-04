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
   
       initial
	PC <= 16'hFFFF;  // Do not remove. Assumed by the Testbench and results files.


   

endmodule



