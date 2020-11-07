// Testbench

module decoder_testbench;                   // Testbench program will exercise design with different instructi
   parameter NUM_INSTRUCTIONS = 32;

   reg [15:0] instruction;
   
   wire [2:0] alu_func;
	
   wire [2:0] destination_reg;
   wire [2:0] source_reg1;
   wire [2:0] source_reg2;
   
   wire [11:0] immediate;
   
   wire        arith_2op;
   wire        arith_1op; 
   
   wire      movi_lower;
   wire      movi_higher;
	
   wire      addi;
   wire      subi;
   
   wire      load;
   wire      store;
   
   wire      branch_eq;
   wire      branch_ge;
   wire      branch_le;
   wire      branch_carry;
	
   wire      jump;
   wire      stc_cmd;
   wire      stb_cmd;
   wire      halt_cmd;
   wire      rst_cmd;


decoder myDecoder(
.instruction_pi(instruction),
.alu_func_po(alu_func),
.destination_reg_po(destination_reg),
.source_reg1_po(source_reg1),
.source_reg2_po(source_reg2), 
.immediate_po(immediate),
.arith_2op_po(arith_2op),
.arith_1op_po(arith_1op),
.movi_lower_po(movi_lower), 
.movi_higher_po(movi_higher), 
.addi_po(addi),
.subi_po(subi), 
.load_po(load), 
.store_po(store),  
.branch_eq_po(branch_eq),
.branch_ge_po(branch_ge),
.branch_le_po(branch_le),
.branch_carry_po(branch_carry),
.jump_po(jump),
.stc_cmd_po(stc_cmd),
.stb_cmd_po(stb_cmd),
.halt_cmd_po(halt_cmd),
.rst_cmd_po(rst_cmd)
); 

   reg [15:0] INSTRUCTION[31:0];
   integer i;
   
   
initial begin
   for (i = 0; i < NUM_INSTRUCTIONS; i= i+1) begin
case (i)
0: INSTRUCTION[0] =  16'b0001100010011000;  // ADD $4 $2 $3
1: INSTRUCTION[1] =  16'b0001100100100001;  // ADDC $4 $4 $4
2: INSTRUCTION[2] =  16'b1111000000000001;  // STC
3: INSTRUCTION[3] =  16'b0001100100100001;  // ADDC $4 $4 $4
4: INSTRUCTION[4] =  16'b0100011011110101;  // ADDI $3 $3 0x35
5: INSTRUCTION[5] =  16'b0001100011010010;  // SUB $4 $3 $2   
6: INSTRUCTION[6] =  16'b0001101011010011;  // SUBB $5 $3 $2
7: INSTRUCTION[7] =  16'b1111000000000010;  // STB
8: INSTRUCTION[8] =  16'b0001101100011011;  // SUBB $5 $4 $3
9: INSTRUCTION[9] =  16'b0101100100000010;  // SUBI $4 $4 0x2 
10: INSTRUCTION[10] = 16'b0001111111101110; // XOR $7 $7 $5
11: INSTRUCTION[11] = 16'b0001100110111111; // XNOR $4 $6 $7
12: INSTRUCTION[12] = 16'b0001111101110100; // AND $7 $5 $6
13: INSTRUCTION[13] = 16'b0001111111010101; // OR $7 $7 $2
14: INSTRUCTION[14] = 16'b0011110110101010; // MOVIH $6 0xAA
15: INSTRUCTION[15] = 16'b0011110010111011; // MOVIL $6 0xBB
16: INSTRUCTION[16] = 16'b0010111111000000; // NOT $7 $7
17: INSTRUCTION[17] = 16'b0010110111000011; // CP $6 $7
18: INSTRUCTION[18] = 16'b0010011011000010; // SHIFTR $3 $3
19: INSTRUCTION[19] = 16'b0010111000000001; // SHIFTL $7 $0 
20: INSTRUCTION[20] = 16'b0111001001011000; // ST $1 0x18($1)
21: INSTRUCTION[21] = 16'b0110001011100100; // LD $1 0x24($3)  
22: INSTRUCTION[22] = 16'b1100111100001110; // J 0xf0e  
23: INSTRUCTION[23] = 16'b1000001001111111; // BEQ $1, $1, 0x3f 
24: INSTRUCTION[24] = 16'b1000001010111110; // BEQ $1, $2, 0x3e
25: INSTRUCTION[25] = 16'b1001001001111111; // BGE $1, $1, 0x3f 
26: INSTRUCTION[26] = 16'b1001001010111110; // BGE $1, $2, 0x3e
27: INSTRUCTION[27] = 16'b1010001001111111; // BLE $1, $1, 0x3f 
28: INSTRUCTION[28] = 16'b1010001010111110; // BLE $1, $2, 0x3e
29: INSTRUCTION[29] = 16'b1011000000111111; // BC  0x3f 
30: INSTRUCTION[30] = 16'b1111101010101010;  // RESET
31: INSTRUCTION[31] = 16'b1111111111111111;  // HALT
default INSTRUCTION[i] = 16'b0;
endcase // case (i) 
 end
     
   $display("*************************************");  // Verilog version of print
   $display("\tNo.\tInstruction\t\tDecoded Signals\n"); 
end
   
   
   always @(*) begin
      for (i=0; i < NUM_INSTRUCTIONS; i=i+1)  begin
	#1;	instruction = INSTRUCTION[i];

	#1;     $display("%d.\t%x\t\t%o %o %o %o %o\t%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b\n", i, instruction, alu_func, destination_reg, source_reg1, source_reg2, immediate, arith_2op, arith_1op, movi_lower, movi_higher, addi,  subi, load, store,  branch_eq, branch_ge, branch_le, branch_carry, jump, stc_cmd, stb_cmd, halt_cmd, rst_cmd);
      end // endfor
      
       $finish;
   end
   
endmodule // foo_testbench

