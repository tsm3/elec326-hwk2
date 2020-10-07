module  fa(input wire  a, b, cin, output wire S, Co);
    // 1-bit Full Adder (FA) module
   
   assign {Co, S} = a + b + cin; 
endmodule 



module rca(input wire [3:0] v1, v2, input wire Cin, output wire [3:0] Sum, output wire Cout);

   // 4-bit Ripple Carry Adder module using four Full Adder (FA) mdoules
   
   // Input ports: 4-bit operands for addition  "v1, v2", and carry input to adder "Cin"
   // Output ports: 4-bit result of addition "Sum" and carry out signal "Carry"
   
   wire c0, c1, c2, c3;  // Carry-out from each full adder used as carry-in for the next bit

   assign c0 = Cin;

   // Instantiate 4 FA  modules fa0, fa1, fa2, fa3 and connect carry-out of one FA to the carry-in of the next.
   fa  fa0(v1[0], v2[0], c0, Sum[0], c1);  
   fa  fa1(v1[1], v2[1], c1, Sum[1], c2);
   fa  fa2(v1[2], v2[2], c2, Sum[2], c3);
   fa  fa3(v1[3], v2[3], c3, Sum[3], Cout);  

endmodule


module rca_tb;                     // Testbench program will exercise module "rca"  with input test vectors
   
   reg [3:0] p, q;                  // Testbench variables used as inputs to "rca" 
   wire [3:0] SUM;                  // Testbench variable used as outputs from "rca"
   wire       CARRY_OUT;            // Testbench variable used as outputs from "rca"
   
   rca  myRCA(p, q, 1'b0, SUM, CARRY_OUT);     // Create an instance of "rca" called "myRCA"
                                               // "myRCA" inputs driven by signals  p,q and 1-bit 0
                                               // "myRCA" outputs drive 4-bit signal SUM and 1-bit signal CARRY_OUT
   initial begin
      p = 4'b0;                   // Initialize p and q to 0
      q = 4'b0; 
      $display("Time\tp\tq\tSUM\tCARRY_OUT");
   end

   integer i, j;  // Regular program variables used here for sequencing
	 
   always @(*) begin
      for (i=0; i < 16; i = i+1) begin
            for (j=0; j < 16; j = j+1) begin
	       #1;     $display("%3d\t%x\t%x\t %x\t   %x", $time, p, q, SUM, CARRY_OUT);
	      {p, q} = {p, q} + 1;  // Cycle through the 256 possible input assignemnts
	    end
	 end
      $finish;      
   end
   
endmodule 


