module cmp1(input wire a, b, output wire Eq, Gt);  // Signal names //1-bit comp

// Inputs:  1-bit signals  a and  b
// Outputs: 1-bit signals  Eq and Gt   
   assign Eq = a == b;
   assign Gt = a > b;

   // Set Eq to 1 if a equals b; else set Eq to 0.
   // Set Gt to 1 if a is greater than b; else set Gt to 0.

      
endmodule // cmp


module comparator(input wire [3:0] x, y,  output wire EQ, LT); //4-bit comp
   
// Inputs: 4-bit signals x and y
// Outputs: 1-bit signals EQ and LT

// Working in Big Endian (bit 0 is rightmost)

wire[3:0] lileq, lilgt, lillt; // less writing than having 8 diff. wires

cmp1 comp0 (x[0], y[0], lileq[0], lilgt[0]);
cmp1 comp1 (x[1], y[1], lileq[1], lilgt[1]);

cmp1 comp2 (x[2], y[2], lileq[2], lilgt[2]);
cmp1 comp3 (x[3], y[3], lileq[3], lilgt[3]);

// Here, did logic algebra to prove to self that NOT eq AND NOT gt = lt (bitwise here)
assign lillt = ~lileq & ~lilgt; // This is bit-wise and

assign EQ = (lileq == 4'b1111) ? 1'b1 : 1'b0;
// Here, did more scratchwork to find this expression, checks if MSB is LT, and if not, evals other bits seperately iff MSB is EQ
assign LT = lillt[3] || (lileq[3] && lillt[2]) || (lileq[3] && lileq[2] && lillt[1]) || (lileq[3] && lileq[2] && lileq[1] && lillt[0]);

   // Set EQ to 1 if the 4-bit number x and  y are equal; else set EQ to 0
   // Set LT to 1 if  x is less than y (treated as 4-bit unsigned integers); else set LT to 0
   
   // METHOD: Instantiate a 1-bit comparator module  for each  bit comparison.
   //         Add  glue logic and wires as needed
   

endmodule // comparator

