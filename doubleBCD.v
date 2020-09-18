// Conditional Add3 module

module cAdd3(input wire [3:0] x, output wire [3:0] Y);

    // Input: 4-bit wire "x" (representing a BCD digit)
    // Output: 4-bit wire "Y" 
    
    //  Conditionally increment x by 3 if it is 5 or greater.

    assign Y = (x >= 5) ? x + 2'd3 : x;

   
endmodule 

// Note to self: these BCD digits are in nibbles not bytes

module doubleBCD(input wire [11:0] a, output wire [11:0] B);
  
// Input:  12-bit wire "a" representing BCD integer  between 0 and 499.
// Output: 12 bit wire "B" representing BCD integer  "2 x a". 
   
// Note: There is no overflow as long as the input is less than 500.
// METHOD: Instantiate 3 "cAdd3" modules. Wire up the modules using any glue logic needed.
   
   // Convert to binary then left shift then convert to BCD?

    assign nib1 = (a[11:8] > 4) ? a[11:8] + 2'd3 : a[11:8];
    assign nib2 = (a[7:4] > 4) ? a[7:4] + 2'd3 : a[7:4];
    assign nib3 = (a[3:0] > 4) ? a[3:0] + 2'd3 : a[3:0];

    assign B[11:8] = nib1 << 1;
    assign B[7:4] = nib2 << 1;
    assign B[3:0] = nib3 << 1;  

   
endmodule 


