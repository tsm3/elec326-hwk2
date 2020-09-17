// Testbench
module doubleBCD_tb;  // Testbench program will exercise design with input test vectors
   reg [11:0] p;              // Test input BCD number
   wire [11:0] Q;            // Result

   integer 	      i, j, k;
   
doubleBCD test(p, Q);   
   
   always @(*) begin
      for (i=0; i < 5; i = i+1) begin
	 for (j=0; j < 10; j = j+1) begin
	    for (k=0; k < 10; k = k+1) begin
		  p = i * 256 + j * 16 + k;  // Generate inputs 0 through 499
	       #1; $display("p = %x\tQ = %x\n", p,  Q);
	    end
	 end
      end
      $finish;      
   end
endmodule // doubleBCD_tb

