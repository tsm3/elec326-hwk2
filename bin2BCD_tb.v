module bin2BCD_tb;   // Testbench program to  exercise your design with input test vectors

   

   reg [7:0] p;                     // Variables that will be assigned values in this testbench
   wire [11:0] Q;
   integer 	      i;
      

binary2BCD  test(p, Q);      


   always begin
      $display("Binary\t\tBCD\t (Shown as 3-digit hex numbers)\n");
           
      for (i=0; i < 256; i= i+1) begin
	 p = i;
	 #1; $display("%x\t\t%x\n", p,  Q);
      end
      $finish;      
   end
endmodule // bin2BCD_tb






