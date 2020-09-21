//  Unit under Test

module foo1(input wire a, b, output wire y1, y2, y3);  

   // Input ports: 1-bit signals a, b
   // Output ports: 1-bit  sigals y1, y2, y3 
   
   assign y1 = a & b; // AND
   assign y2 = a | b; // OR
   assign y3 = a^b;   // Exclusive OR

endmodule // foo


// Testbench
module foo1_tb;                     // Testbench program will exercise module "foo1"  with input test vectors

   reg p, q;                        // Testbench variables used as inputs to "foo1" 
   wire  X, Y, Z;                   // Testbench variables used as outputs from "foo1"
   
   foo1  myFoo(p, q, X, Y, Z);      // Create an instance of "foo1" called "myFoo"
                                    // "myFoo" inputs driven by signals  p, q and its outputs drive signals X, Y, Z
                                    //  Signals p, q will be connected to input ports "a" and "b"
                                    //  Output ports "y1", "y2", "y3" connected to signals X, Y, Z

initial begin
   p = 1'b0;                        // Initialize p to 0  (1'b means a 1 bit signal with value binary 0)
   q = 1'b0;                      
   $display("Time\tp q\tX  Y  Z\n");
end

   integer i;  // Regular program variable used here for sequencing

   always @(*) begin

      for (i=0; i < 4; i= i+1)
	begin
	   #1;   // Delay for 1 time unit
	   $display("%3d\t%x %x\t%x  %x  %x\n", $time, p, q, X, Y, Z);

	   {p, q} = {p, q} + 1;  // Cycle through the assigments (0,0) (0, 1), (1, 0), (1, 1)
	end
      $finish;
   end
 endmodule // foo_testbench
