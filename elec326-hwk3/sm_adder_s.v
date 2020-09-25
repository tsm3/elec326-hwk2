module ripple_carry_adder(input wire [n-1:0]x, y, input wire cin, output wire [n-1:0] Sum, output wire Cout);  // Parameterized Ripple Carry Adder - 8 bit
   parameter n = 4;
   assign {Cout, Sum} = x + y + cin;
endmodule // ripple_carry_adder

module comparator(input wire [n-1:0] x, y,  output wire EQ, GT);  // Parametrized Comparator - 8 bit
   parameter n = 4;
   assign EQ = (x == y);
   assign GT = (x > y);
endmodule // comparator

module mux2(input wire c, input wire [n-1:0] a,b, output wire [n-1:0] X); // Parameterized 2-input n-bit MUX
   parameter n = 4;
   assign X = (c) ? a : b;
endmodule // mux2

   
module sm_adder_s( input wire [4:0] a, b, output wire [4:0] SUM, output wire OVFLW);

   // Instantiate the modules defined above as required by your schematic.
   // Glue modules together using simple assign statements to implement gate logic.

   wire[3:0] tempsum;
   wire[3:0] X2, Y2;
   wire[3:0] bruh;
   
   wire[2:0] trashOUT, trashIn1, trashIn2;

   wire EQ, GT, A;
   wire cIN;
   wire X4cIN, Y4cIN;


   assign cIN = a[4] ^ b[4]; //XOR -> 1 if sign bits are different, 0 if same


   comparator comp(a[3:0], b[3:0], EQ, GT);
   mux2 muxSign(GT, {trashIn1, a[4]}, {trashIn2, b[4]}, {trashOUT, A}); //not sure how to fix this padding shit
   //assign SUM[4] = A & (EQ ~& cIN); //here trying to make sure no -0



   assign X4cIN = cIN & a[4];
   assign Y4cIN = cIN & b[4];

   //mux2 muxX(X4cIN, a[3:0], ~a[3:0], X2);
   assign X2 = a[3:0] ^ {4{X4cIN}};
   //mux2 muxY(Y4cIN, b[3:0], ~b[3:0], Y2);
   assign Y2 = b[3:0] ^ {4{Y4cIN}};
   ripple_carry_adder add(X2, Y2, cIN, SUM[3:0], OVFLW);
   assign SUM[4] = A & (SUM[3] | SUM[2] | SUM[1] | SUM[0]); // fucking stupid way to make sure never a -0




 
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






