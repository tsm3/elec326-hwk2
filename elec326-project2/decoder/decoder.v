`timescale 1ns/1ns

`define NOP 4'b0000
`define ARITH_2OP 4'b0001
`define ARITH_1OP 4'b0010
`define MOVI 4'b0011
`define ADDI 4'b0100
`define SUBI 4'b0101
`define LOAD 4'b0110
`define STOR 4'b0111
`define BEQ 4'b1000
`define BGE 4'b1001
`define BLE 4'b1010
`define BC 4'b1011
`define J 4'b1100
`define CONTROL 4'b1111

`define ADD 3'b000
`define ADDC 3'b001
`define SUB 3'b010
`define SUBB 3'b011
`define AND 3'b100
`define OR 3'b101
`define XOR 3'b110
`define XNOR 3'b111

`define NOT 3'b000
`define SHIFTL 3'b001
`define SHIFTR 3'b010
`define CP 3'b011

`define STC    12'b000000000001
`define STB    12'b000000000010
`define RESET  12'b101010101010
`define HALT   12'b111111111111

/*
 * Module: instruction_decode
 * Description: Decodes the instruction.
 *              All outputs must be driven based upon instruction opcode and function.
 *              All logic should be combinational.
 */

module decoder(
	input [15:0] instruction_pi,
	
	output [2:0] alu_func_po,
	
	output [2:0] destination_reg_po,
	output [2:0] source_reg1_po,
	output [2:0] source_reg2_po,
	
	output  [11:0] immediate_po,
	
	output arith_2op_po,
	output arith_1op_po, 
	
	output movi_lower_po,
	output movi_higher_po,
	 
	output addi_po,
	output subi_po,
	 
	output load_po,
	output store_po,
	 
	output branch_eq_po,
	output branch_ge_po,
	output branch_le_po,
	output branch_carry_po,
	 
	output jump_po,
 
	output stc_cmd_po,
	output stb_cmd_po,
	output halt_cmd_po,
	output rst_cmd_po
);
   
   // Input signals have the suffix "_pi: and output signals the prefix "_po".
   // Use a series of assign statements to set the output signals.
   // You may (find it convenient to) define some auxiliary wire signals for compactness. 		


	// Me: I'm hesitant to think this always shit works tbh
	wire[3:0] OPCODE = instruction_pi[15:12]; // for quality of life


	reg[2:0] reg_alu_func_po = 3'b000; // Do these [] work??
	reg[2:0] reg_destination_reg_po = 3'b000;
	reg[2:0] reg_source_reg1_po = 3'b000;
	reg[2:0] reg_source_reg2_po = 3'b000;
	reg[11:0] reg_immediate_po = 12'b000000000000;
	reg reg_arith_2op_po = 1'b0;
	reg reg_arith_1op_po = 1'b0;
	reg reg_movi_lower_po = 1'b0;
	reg reg_movi_higher_po = 1'b0;
	reg reg_addi_po = 1'b0;
	reg reg_subi_po = 1'b0;
	reg reg_load_po = 1'b0;
	reg reg_store_po = 1'b0;
	reg reg_branch_eq_po = 1'b0;
	reg reg_branch_ge_po = 1'b0;
	reg reg_branch_le_po = 1'b0;
	reg reg_branch_carry_po = 1'b0;
	reg reg_jump_po = 1'b0;
	reg reg_stc_cmd_po = 1'b0;
	reg reg_stb_cmd_po = 1'b0;
	reg reg_halt_cmd_po = 1'b0;
	reg reg_rst_cmd_po = 1'b0;

	always @(*) begin

		reg_alu_func_po = instruction_pi[2:0]; 
		reg_destination_reg_po = instruction_pi[11:9];
		reg_source_reg1_po = instruction_pi[8:6];
		reg_source_reg2_po = instruction_pi[5:3];
		reg_immediate_po = instruction_pi[11:0]; 

		reg_arith_2op_po = OPCODE == `ARITH_2OP;
		reg_arith_1op_po = OPCODE == `ARITH_1OP;
		reg_movi_lower_po = (OPCODE == `MOVI) & ~instruction_pi[8];
		reg_movi_higher_po = (OPCODE == `MOVI) & instruction_pi[8];
		reg_addi_po = OPCODE == `ADDI;
		reg_subi_po = OPCODE == `SUBI;
		reg_load_po = OPCODE == `LOAD;
		reg_store_po = OPCODE == `STOR;

		reg_branch_eq_po = OPCODE == `BEQ;
		reg_branch_ge_po = OPCODE == `BGE;
		reg_branch_le_po = OPCODE == `BLE;
		reg_branch_carry_po = OPCODE == `BC;

		reg_jump_po = OPCODE == `J;
		reg_stc_cmd_po = (OPCODE == `CONTROL) && (instruction_pi[11:0] == `STC);
		reg_stb_cmd_po = (OPCODE == `CONTROL) && (instruction_pi[11:0] == `STB);
		reg_rst_cmd_po = (OPCODE == `CONTROL) && (instruction_pi[11:0] == `RESET);
		reg_halt_cmd_po = (OPCODE == `CONTROL) && (instruction_pi[11:0] == `HALT);


		// If any branch code, we must change where RS1 and RS2 are
		// RS1 and RD will be same, RS2 will be normal RS1

		if ((OPCODE == `BEQ) || (OPCODE == `BGE) || (OPCODE == `BLE) || (OPCODE == `BC)) begin
			reg_source_reg1_po = instruction_pi[11:9];
			reg_source_reg2_po = instruction_pi[8:6];
		end else begin // I feel like my thing should still be combinatorial even without this else statement since these values are already defined
					   // BUT I'm adding it out of caution
			reg_source_reg1_po = instruction_pi[8:6];
			reg_source_reg2_po = instruction_pi[5:3];
		end

		// Start by assigning all outputs to 0 and only change those necessary?? UPDATE: this is set in reg's above

	end

	assign alu_func_po = reg_alu_func_po;
	assign destination_reg_po = reg_destination_reg_po;
	assign source_reg1_po = reg_source_reg1_po;
	assign source_reg2_po = reg_source_reg2_po;
	assign immediate_po = reg_immediate_po;
	assign arith_2op_po = reg_arith_2op_po;
	assign arith_1op_po = reg_arith_1op_po;
	assign movi_lower_po = reg_movi_lower_po;
	assign movi_higher_po = reg_movi_higher_po;
	assign addi_po = reg_addi_po;
	assign subi_po = reg_subi_po;
	assign load_po = reg_load_po;
	assign store_po = reg_store_po;
	assign branch_eq_po = reg_branch_eq_po;
	assign branch_ge_po = reg_branch_ge_po;
	assign branch_le_po = reg_branch_le_po;
	assign branch_carry_po = reg_branch_carry_po;
	assign jump_po = reg_jump_po;
	assign stc_cmd_po = reg_stc_cmd_po;
	assign stb_cmd_po = reg_stb_cmd_po;
	assign halt_cmd_po = reg_halt_cmd_po;
	assign rst_cmd_po = reg_rst_cmd_po;

endmodule // decoder
