module foo2( input wire a, b, output wire [5:0] y); 

   // Input ports: 1-bit signals a, b
   // Output port: 6-bit  signal y. Can access individual bits as y[5], y[4], y[3], y[2], y[1], y[0].

   assign y[0] = a & b;  // AND
   assign y[1] = a | b;   // OR
   assign y[2] = a^b;    // XOR

   assign y[3] = ~(y[0] & y[1] & y[2]);   // 3-input NAND
   assign y[4] = ~(y[0] | y[1] | y[2]);   // 3-input NOR
   assign y[5] = ~(y[0] ^ y[1] ^ y[2]);   // 3-input XNOR

endmodule


module foo2_tb;                     // Testbench program will exercise module "foo2"  with input test vectors
   
   reg p, q;                        // Testbench variables used as inputs to "foo2" 
   wire [5:0] X;                    // Testbench variables used as outputs from "foo2"
 
   foo2  myFoo(p, q, X);            // Create an instance of "foo2" called "myFoo"
                                    // "myFoo" inputs driven by signals  p,q and its output drives 6-bit signal X
   
                                    // Signals p, q will be connected to input ports "a" and "b"
                                    // Output ports "y[i]" connected to signals "X[i]", i = 5, .., 0.
   initial begin
      p = 1'b0;
      q = 1'b0; 
      $display("Time\tp q\tAND OR XOR\tNAND NOR XNOR\n");
   end
   
   integer i; 
	 
   always @(*) begin
      for (i=0; i < 4; i= i+1)
	begin
	   #1; $display("%3d\t%x %x\t %x   %x  %x\t %x    %x    %x\n", $time, p, q, X[0], X[1], X[2], X[3], X[4], X[5]);
	   {p, q} = {p, q} + 1; // Cycle through inputs
	end
      $finish;
   end
endmodule // foo2_tb




