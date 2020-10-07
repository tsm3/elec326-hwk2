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
	wire[3:0] OPCODE = instruction_pi[15:12]; // Don't know if this should be wire or reg or what, can always just put this in the case statement instead of "OPCODE"


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
		reg_immediate_po = instruction_pi[11:0]; // Probably change this
		reg_arith_2op_po = 1'b0;
		reg_arith_1op_po = 1'b0;
		reg_movi_lower_po = 1'b0;
		reg_movi_higher_po = 1'b0;
		reg_addi_po = 1'b0;
		reg_subi_po = 1'b0;
		reg_load_po = 1'b0;
		reg_store_po = 1'b0;
		reg_branch_eq_po = 1'b0;
		reg_branch_ge_po = 1'b0;
		reg_branch_le_po = 1'b0;
		reg_branch_carry_po = 1'b0;
		reg_jump_po = 1'b0;
		reg_stc_cmd_po = 1'b0;
		reg_stb_cmd_po = 1'b0;
		reg_halt_cmd_po = 1'b0;
		reg_rst_cmd_po = 1'b0;

		
		// Start by assigning all outputs to 0 and only change those necessary?? UPDATE: this is set in reg's above

		case (OPCODE) // In this case, no default because we know OPCODEs span all 16 possibilities
			
			//`NOP: do nothing?;

			`ARITH_2OP: begin
				reg_arith_2op_po = 1'b1;
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_source_reg1_po = instruction_pi[8:6];
				//reg_source_reg2_po = instruction_pi[5:3];
				//reg_alu_func_po = instruction_pi[2:0];
			end

			`ARITH_1OP: begin
				reg_arith_1op_po = 1'b1;
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_source_reg1_po = instruction_pi[8:6]; // Source 2 is 3'b000, already set
				//reg_alu_func_po = instruction_pi[2:0];
			end

			`MOVI: begin
				reg_movi_lower_po = ~instruction_pi[8]; // Want LHS=1 when RHS=0
				reg_movi_higher_po = instruction_pi[8]; // Want LHS=1 when RHS=1
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_immediate_po = {4'b0000, instruction_pi[7:0]}; // Only 8 bit intermediate
			end
			
			`ADDI: begin
				reg_addi_po = 1'b1;
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_source_reg1_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]};
			end

			`SUBI: begin
				reg_subi_po = 1'b1;
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_source_reg1_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]};
			end

			`LOAD: begin
				reg_load_po = 1'b1;
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_source_reg1_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]};
			end

			`STOR: begin
				reg_store_po = 1'b1;
				//reg_destination_reg_po = instruction_pi[11:9];
				//reg_source_reg1_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]};
			end

			`BEQ: begin
				reg_branch_eq_po = 1'b1;
				reg_source_reg1_po = instruction_pi[11:9];
				reg_source_reg2_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]}; // I don't know what they mean about the signed shit, but I think I just throw it out here
			end

			`BGE: begin
				reg_branch_ge_po = 1'b1;
				reg_source_reg1_po = instruction_pi[11:9];
				reg_source_reg2_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]}; // I don't know what they mean about the signed shit, but I think I just throw it out here

			end

			`BLE: begin
				reg_branch_le_po = 1'b1;
				reg_source_reg1_po = instruction_pi[11:9];
				reg_source_reg2_po = instruction_pi[8:6];
				//reg_immediate_po = {6'd0, instruction_pi[5:0]}; // I don't know what they mean about the signed shit, but I think I just throw it out here

			end

			`BC: begin
				reg_branch_carry_po = 1'b1; // This one guarantees in[11:6] = 0
				//reg_immediate_po = {6'd0, instruction_pi[5:0]}; // I don't know what they mean about the signed shit, but I think I just throw it out here
			end

			`J: begin
				reg_jump_po = 1'b1;
				reg_immediate_po = instruction_pi[11:0]; // See above comments about signed ints for immediate
			end

			`CONTROL: case (instruction_pi[11:0]) // This one says exactly what in[11:0] is
				`STC: reg_stc_cmd_po = 1'b1;
				`STB: reg_stb_cmd_po = 1'b1;
				`RESET: reg_rst_cmd_po = 1'b1;
				`HALT: reg_halt_cmd_po = 1'b1;
			endcase

			 
		endcase

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
