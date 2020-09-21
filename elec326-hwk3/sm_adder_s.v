module ripple_carry_adder(input wire [n-1:0]x, y, input wire cin, output wire [n-1:0] Sum, output wire Cout);  // Parameterized Ripple Carry Adder
   parameter n = 8;
   assign {Cout, Sum} = x + y + cin;
endmodule // ripple_carry_adder

module comparator(input wire [n-1:0] x, y,  output wire EQ, GT);  // Parametrized Comparator
   parameter n = 8;
   assign EQ = (x == y);
   assign GT = (x > y);
endmodule // comparator

module mux2(input wire c, input wire [n-1:0] a,b, output wire [n-1:0] X); // Parameterized 2-input n-bit MUX
   parameter n = 1;
   assign X = (c) ? a : b;
endmodule // mux2

   
module sm_adder_s( input wire [4:0] a, b, output wire [4:0] SUM, output wire OVFLW);

   // Instantiate the modules defined above as required by your schematic.
   // Glue modules together using simple assign statements to implement gate logic.

 
endmodule // sm_adder


//***************************************************************************************/ 
module foo_testbench;                   // Testbench program will exercise your design with input test vectors

   reg [4:0] p, q;                     
   wire [4:0] S; 
   wire	      OV;
   
   sm_adder_s  mySmAdder(p, q, S, OV);   

   
initial begin
   p = 5'b00000; 
   q = 5'b00000;    
   $display("*************************************"); 
   $display("Time\tp   q\t\tS   OV\n");
end
   
   integer i, j;  // Regular program variable used here for sequencing
	 
   always @(*) begin

      
      for (i=0; i < 32; i= i+1)
	begin
	   for (j=0; j < 32; j = j+1)
	     begin
		#1;   // Delay for 1 time unit
		$display("%3d\t%s%d   %s%d\t\t%s%d   %b", $time, (p[4]) ? "-" : "+", p[3:0], (q[4]) ? "-":"+", q[3:0], (S[4])? "-":"+", S[3:0], OV);	
		{p, q} = {p, q} + 1;  // Cycle through the assigments
	     end
	end
      $finish;
   end
endmodule // foo_testbench






