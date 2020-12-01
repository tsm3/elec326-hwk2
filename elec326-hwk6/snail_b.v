/* ************************************************************************************************** */

`define zero 4'b0000
`define ones 4'b1111

module  babysnail_moore(input wire reset, clk, x_pi, output wire y_po);
      
     // Declare register variables for state and wires as needed

   reg[0:3] state;
   reg out;
     
   always @(posedge reset, posedge clk)  begin   // Asynchronous Reset

      // At posedge of reset initialize to starting state.

      // Add reset code here.
      if (reset) begin
         state[0:3] <= `zero;
         out <= 1'b0;
      end else begin

      #1; 	// Delay of 1 time unit to model the  propagation delay from clock to FF outputs. Do not remove.
      
      // Add main code here.

      case (state[0:3])         
         `zero : begin
            state[0:3] <= x_pi ? 4'b0001 : `zero; // Append x_pi to right
            // state[0:3] <= {state[1:3], x_pi}; // Append x_pi to right
            out <= 1'b0;
         end
         4'b0001: begin
            state[0:3] <= x_pi ? 4'b0011 : `zero;
            // state[0:3] <= x_pi ? {state[1:3], x_pi} : `zero;
            out <= 1'b0;
         end
         4'b0011: begin 
            state[0:3] <= x_pi ? 4'b0111 : 4'b0110; // Append x_pi to right
            // state[0:3] <= {state[1:3], x_pi}; // Append x_pi to right
            out <= 1'b0;
         end
         4'b0111: begin
            state[0:3] <= x_pi ? 4'b0111 : 4'b1110;
            // state[0:3] <= x_pi ? state[0:3] : {state[1:3], x_pi};
            out <= 1'b0;
         end
         4'b0110: begin 
            state[0:3] <= x_pi ? 4'b1101 : `zero;
            // state[0:3] <= x_pi ? {state[1:3], x_pi} : `zero;
            out <= 1'b0;
         end
         4'b1110: begin
            state[0:3] <= x_pi ? 4'b1101 : `zero;
            // state[0:3] <= x_pi ? {state[1:3], x_pi} : `zero;
            out <= 1'b1;
         end
         4'b1101: begin
            state[0:3] <= x_pi ? 4'b0011 : `zero;
            out <= 1'b1;
         end
         default : $display("help");
      endcase



      end
   end
   
// Use "assign" statement to set output y_po
  assign y_po = out;
 endmodule // babysnail_moore

/* ************************************************************************************************** */



// Comment out the Moore module and uncomment the Mealy module as needed
/*
module  babysnail_mealy(input wire reset, clk, x_pi, output wire y_po);
     
     // Declare register variables for state and wires as needed
     
   always @(posedge reset, posedge clk)  begin / Asynchronous Reset

// At posedge of reset initialize to starting state.
// Add reset code here.
   
#1;   // Delay 1 time unit to model the  propagation delay from clock to FF  output. Do not remove.

// Add main code here. 
   end
   

// Use "assign" statement to set output y_po
  
 endmodule // babysnail_mealy
*/

/* ************************************************************************************************** */

// Testbench module
module generic_tb;
 reg CLK, RESET, X;
   wire  Y;

	 babysnail_moore  MO_BABYSNAIL(RESET, CLK, X, Y); // Instantiate the babysnail_moore module
	 
// Comment out line above and uncomment line below when testing the Mealy implementation
	// babysnail_mealy  ME_BABYSNAIL(RESET, CLK, X, Y); // Instantiate the babysnail_mealy module

      initial
	begin
	   CLK = 0;	  // Clock with period 10
	   X = 0;            // initialize input signal

	   // Assert RESET  between time T=1 and T=2
	   	
	   #1; RESET= 1;
	   #1;	 RESET = 0;
	end

   

      always @(*)  // Positive clock transitions at T=5, 15, 25, .....
	     while ($time < 110)  
	       begin
		  #5;  CLK = ~CLK;
	       end

/*
 For test sequence 1 the assignment "#7: X = 1;" should be  commented out (as is done below)
 For test sequence 2 the assignment "#3: X = 1;" should be commented out and the 
  assignment "#7: X=1;" should be uncommented.  
*/

   always begin
      #3;     X = 1; 
//    #7;     X = 1;
      #30;    X = 0;
      #10;    X = 1;
      #40;    X = 0;
      #20;    X = 1;      
      $finish;
   end // always begin
   
always @(*) begin
  $monitor("Time: %g X: %b Y: %b", $time,  X, Y);
end
   
endmodule // generic_tb
