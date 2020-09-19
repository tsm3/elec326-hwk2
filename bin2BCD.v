module binary2BCD(input wire [7:0] a, output wire [11:0] BCD);


// Input:  8-bit wire  representing a binary unsigned number in the range 0 to 255
// Output: 12-bit wire representing a 3-digit BCD equivalent of the input

  
 /*     
   METHOD:   Instantiate 5 copies of the "doubleBCD" module of Part 2 of the assignement.
             Each instance of "doubleBCD" can be used to multiply a BCD number by 2.
             Connect up the 5 modules appropriately using any glue logic if needed.
  
                Note: We can skip the first three iterations of the conversion algorithm by 
                      directly expressing the first three MSBs (a7 a6 a5) directly as a BCD 
                      integer [0000] [0000] [0 a7 a6 a5].
  
   */

   wire[11:0] connector1;
   wire[11:0] connector2;
   wire[11:0] connector3;
   wire[11:0] connector4;
   wire[11:0] connector5;
   wire[11:0] last;

   assign connector1 = {10'd0,a[7:5]};

   doubleBCD doubler1(connector1, connector2);
   assign connector2[0] = a[4];
   doubleBCD doubler2(connector2, connector3);
   assign connector3[0] = a[3];
   doubleBCD doubler3(connector3, connector4);
   assign connector4[0] = a[2];
   doubleBCD doubler4(connector4, connector5);
   assign connector5[0] = a[1];
   doubleBCD doubler5(connector5, last);
   assign last[0] = a[0];
   assign BCD = last;

   always@(*) begin
      $display("con1 = %b\n", connector1);

      $display("con2 = %b\n", connector2);

      $display("con3 = %b\n", connector3);

      $display("con4 = %b\n", connector4);

      $display("con5 = %b\n", connector5);

      $display("last = %b\n", last);

      $display("BCD- = %b\n", BCD);
   end
         
  endmodule // binary2BCD









