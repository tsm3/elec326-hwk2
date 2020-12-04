`timescale 1ns/1ns

/*
 * Module: processor
 * Description: The top module of this lab 
 */
module processor (
	input CLK_pi,
	input CPU_RESET_pi
); 
 
   wire       cpu_clk_en; // Used to slow down the system clock CLK_pi

   // Define additional wires to connect up all input and output ports of the modules
      
	
// Instantiate the modules for different components:
// Program Counter 
// Instruction Memory 
// Instruction Decoder 
// Register File
// ALU 
// Branch Module
// Data Memory

   
clkdiv clock_divide(
.clk_pi(CLK_pi),
.clk_en_po(cpu_clk_en)
);

endmodule 



/*
 * Module: seconds_clkdiv
 * Description: Generates a clk_en signal.
 * This trivially runs at the same frequency as clk
 * See the module below for a clock that reduces the frequency of a 100 MHz clock to 1 Hz
*/

module clkdiv ( 
	input clk_pi,
	output clk_en_po
);
	
   assign clk_en_po = 1'b1;
endmodule //clkdiv




/* ***************************************************************************************
 * Module: seconds_clkdiv
 * Description: Generates a clk_en signal that triggers once per second from a 100MHz clk input


module seconds_clkdiv (
	input clk_pi,
	output clk_en_po
);
	reg [31:0] counter;

	initial begin
		counter <= 32'h0;
	end
	
	always @(posedge clk_pi) begin
	if(counter == 32'h5F5E100)  
			counter <= 32'h0;
		else
			counter <= counter + 1;
	end
	
	assign clk_en_po = (counter == 32'h0); 
	
endmodule // seconds_clock
 ****************************************************************************************/


