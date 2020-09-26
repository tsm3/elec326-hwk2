module ripple_carry_adder(input wire [n-1:0]x, y, input wire cin, output wire [n-1:0] Sum, output wire Cout);  // Parameterized Ripple Carry Adder - 8 bit
   parameter n = 8;
   assign {Cout, Sum} = x + y + cin;
endmodule // ripple_carry_adder

module comparator(input wire [n-1:0] x, y,  output wire EQ, GT);  // Parametrized Comparator - 8 bit
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

   wire[3:0] X2, Y2;
   
   wire EQ, GT, A;
   wire cIN;
   wire X4cIN, Y4cIN;
   wire tempOV;


   assign cIN = a[4] ^ b[4]; //XOR -> 1 if sign bits are different, 0 if same, need the 1 because it functions as the 2s complement's "add one"
   

   comparator #(4) comp(a[3:0], b[3:0], EQ, GT);

   assign A = (a[4] & GT) | (b[4] & ~GT); // if GT, then sign should match a, else should match b, if sign(a)=sign(b), then can match either, and if EQ, then the 0 case is handled later



   assign X4cIN = cIN & ~GT; // this decides which of the signals to 2s complement for subtraction (if either) (we want to make the smaller number neg. so we only have to 2s complement once)
   assign Y4cIN = cIN & GT; // since we have an extra bit for the sign, we don't need the sign to be correct for the subtraction (when we subtract), just need magnitude

   //mux2 muxX(X4cIN, a[3:0], ~a[3:0], X2); // Don't need this MUX becasue of the XOR below
   assign X2 = a[3:0] ^ {4{X4cIN}}; // {n{m}} concatenates n copies of m, so this would be a 4 bit long extension of X4cIN (this would flip 'a' if it was decided to 2s complement it above), else X2 = a[3:0]

   //mux2 muxY(Y4cIN, b[3:0], ~b[3:0], Y2); // Don't need this MUX because of the XOR below
   assign Y2 = b[3:0] ^ {4{Y4cIN}}; // this would flip 'b' if it was decided to 2s complement it above, else assigns b[3:0] to Y2

   ripple_carry_adder #(4) add(X2, Y2, cIN, SUM[3:0], tempOV); //tempOV just in case we have false overflow from 2s complement subtraction
   assign SUM[4] = A & (SUM[3] | SUM[2] | SUM[1] | SUM[0]); // if no 1s in SUM[3:0], make sure SUM[4] is 0 (positive 0s only)
   assign OVFLW = tempOV & ~cIN;



 
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






