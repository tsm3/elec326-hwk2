//  Multiple ways of specifying a 1-bit comparator

module  foo3(input wire a, b, output  wire v, w, x, y, z);

assign v = (a & b) | (~a & ~b);   
assign w = ~(a^b);
assign x = ((a == 1) && (b == 1)) || ( (a == 0) && (b == 0));
assign y =  (a == b)? 1 : 0;
assign z =  (a == 1)? b : ~b;

endmodule  // foo3



module foo_testbench;  // Testbench program will exercise design with input test vectors

   reg p, q;     
   wire V, W, X, Y, Z; 
   
  foo3  myFoo3(p, q, V, W,  X, Y, Z); 
 
initial   begin
   p = 1'b0;
   q = 1'b0;
   $display("Time\tp q\tV  W  X  Y  Z\n");
 end
   
   integer i;  // Regular program variable used here for sequencing
	 
   always @(*) begin
      for (i=0; i < 4; i= i+1)
	begin
	   #1; $display("%3d\t%x %x\t%x  %x  %x  %x  %x\n", $time, p, q, V, W, X, Y, Z);
	   {p, q} = {p, q} + 1; 
	end
   $finish;
   end  
endmodule



