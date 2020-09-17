module cmp1(input wire a, b, output wire Eq, Gt);  // Signal names

// Inputs:  1-bit signals  a and  b
// Outputs: 1-bit signals  Eq and Gt   
   

   // Set Eq to 1 if a equals b; else set Eq to 0.
   // Set Gt to 1 if a is greater than b; else set Gt to 0.

      
endmodule // cmp


module comparator(input wire [3:0] x, y,  output wire EQ, LT);
   
// Inputs: 4-bit signals x and y
// Outputs: 1-bit signals EQ and LT

   // Set EQ to 1 if the 4-bit number x and  y are equal; else set EQ to 0
   // Set LT to 1 if  x is less than y (treated as 4-bit unsigned integers); else set LT to 0
   
   // METHOD: Instantiate a 1-bit comparator module  for each  bit comparison.
   //         Add  glue logic and wires as needed
   

endmodule // comparator

