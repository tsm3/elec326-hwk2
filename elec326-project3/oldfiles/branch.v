`timescale 1ns/1ns

module branch (
input        branch_eq_pi,
input        branch_ge_pi,
input        branch_le_pi,
input        branch_carry_pi,
input [15:0] reg1_data_pi,
input [15:0] reg2_data_pi,
input        alu_carry_bit_pi,

output  is_branch_taken_po);

wire eq;
wire ge;
wire le;
wire carry;

assign eq = branch_eq_pi & (reg1_data_pi == reg2_data_pi); // Only one of the pi signals will be 1 at a time, so either 0 or 1 OR terms are ever 1
assign ge = branch_ge_pi & (reg1_data_pi >= reg2_data_pi);
assign le = branch_le_pi & (reg1_data_pi <= reg2_data_pi);
assign carry = branch_carry_pi & alu_carry_bit_pi;

assign is_branch_taken_po = eq | ge | le | carry;

endmodule // branch_comparator
