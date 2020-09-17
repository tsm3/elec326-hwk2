// Conditional Add3 module

module cAdd3(input wire [3:0] x, output wire [3:0] Y);

// Input: 4-bit wire "x" (representing a BCD digit)
// Output: 4-bit wire "Y" 
   
//  Conditionally increment x by 3 if it is 5 or greater.

   
endmodule 


module doubleBCD(input wire [11:0] a, output wire [11:0] B);
  
// Input:  12-bit wire "a" representing BCD integer  between 0 and 499.
// Output: 12 bit wire "B" representing BCD integer  "2 x a". 
   
// Note: There is no overflow as long as the input is less than 500.
// METHOD: Instantiate 3 "cAdd3" modules. Wire up the modules using any glue logic needed.
   
   
   
endmodule 


