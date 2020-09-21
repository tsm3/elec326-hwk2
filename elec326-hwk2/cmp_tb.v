// Testbench
module cmp_tb;

   reg [3:0] p, q; // Test values
   wire EQL, LTR;  // Outputs from circuit under test

   comparator myComparator(p, q, EQL, LTR); 


 
   
   
initial begin
   p = 4'b0;              // Initialize p to 0
   q = 4'b0;          
   $display("Time\tp q\tEQ   LT\n");
end
   
   integer i, j;  // Regular program variable used here for sequencing
	 
   always @(*) begin

      for (i=0; i < 16; i = i+1) 	begin
	   for (j=0; j < 16; j = j+1)   begin
	      #1; $display("%3d\t%x %x\t%x   %x\n", $time, p, q, EQL, LTR);
	      {p, q} = {p, q} + 1;  // Cycle through the assigments 
	   end
	end
      $finish;
   end
endmodule // cmp_tb

