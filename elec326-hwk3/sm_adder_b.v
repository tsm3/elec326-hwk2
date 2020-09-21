module sm_adder_b(input wire [4:0] a, b, output reg [4:0] SUM, output reg OVFLW);
   
always @(*) begin
     OVFLW = 1'b0;
     if (a[4] ~^ b[4])  begin  // Same sign operands
	  {OVFLW, SUM[3:0]} = a[3:0] + b[3:0];  // Add the magnitudes; overflow if addition generates a carry out
	  SUM[4] = a[4];  // Sign is that of either operand
	 end 
     else if (a[3:0] > b[3:0]) // Operand signs different. Find larger magnitude.
       begin
	  SUM[3:0] = a[3:0] - b[3:0];
	  SUM[4] = a[4];
	  end
     else
       begin
	  SUM[3:0] = b[3:0] - a[3:0];
	  SUM[4] = b[4];
       end
     if (SUM[3:0] == 3'b0) // Always treat result of 0 as "+0"
       SUM[4] = 1'b0;
  end // always @ (*)
endmodule // sm_adder

//***************************************************************************************/ 
module foo_testbench;                   // Testbench program will exercise your design with input test vectors

   reg [4:0] p, q;                     
   wire [4:0] S; 
   wire	      OV;
   
   sm_adder_b  mySmAdder(p, q, S, OV);   

   
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






