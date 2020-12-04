`timescale 1ns/1ns

/*
 * Module: processor
 * Description: The top module of this lab 
 */
module processor (
	input CLK_pi,
	input CPU_RESET_pi
); 
 
   wire       cpu_clk_en; // Used to slow down the system clock CLK_pi

   // Define additional wires to connect up all input and output ports of the modules
	//Will list these by module outputs:
	//Program Counter outputs
	wire[15:0] PC_wire;
	//Instruction Memory
	wire[15:0] ins_wire;
	//Instruction Decoder (Decoder)
	wire[2:0] alu_func_wire, destination_reg_wire, source_reg1_wire, source_reg2_wire;
	wire[11:0] immediate_wire;
	wire arith_2op_wire, arith_1op_wire, movi_lower_wire, movi_higher_wire,
	addi_wire, subi_wire, load_wire, store_wire, branch_eq_wire, branch_ge_wire,
	branch_le_wire, branch_carry_wire, jump_wire, stc_cmd_wire, stb_cmd_wire, halt_cmd_wire, rst_cmd_wire;
	//Register File
	wire[15:0] reg1_data_wire, reg2_data_wire, regD_data_wire;
	wire current_carry_wire, current_borrow_wire;
	//ALU
	wire[15:0] alu_result_wire;
	wire carry_out_wire, borrow_out_wire;
	//Branch
	wire is_branch_taken_wire;
	//Data Memory
	wire[15:0] rdata_wire;

	//See declaration in tb_regfile.v
	wire wr_destination_reg_bool_wire; // Bool
	assign wr_destination_reg_bool_wire = arith_2op_wire | arith_1op_wire | movi_lower_wire | movi_higher_wire | addi_wire | subi_wire | load_wire;

	//See declaration in tb_regfile.v // Actually idk ab this one
	// wire dest_result_data_wire;
	// assign dest_result_data_wire = load_wire ? 
	
// Instantiate the modules for different components:
// Program Counter 
// Instruction Memory 
// Instruction Decoder 
// Register File
// ALU 
// Branch Module
// Data Memory

	//done
	program_counter program_counter(
		.clk_pi(CLK_pi),
		.clk_en_pi(cpu_clk_en),
		.reset_pi(CPU_RESET_pi),

		.branch_taken_pi(is_branch_taken_wire),
		.branch_immediate_pi(immediate_wire[5:0]),// ?
		.jump_taken_pi(jump_wire),
		.jump_immediate_pi(immediate_wire),//?

		.pc_po(PC_wire)

	);
	//Done
	instruction_mem instruction_mem(
		.pc_pi(PC_wire),
		.instruction_po(ins_wire)
	);
	//Done
	decoder decoder(
		.instruction_pi(ins_wire),
		.alu_func_po(alu_func_wire),
		.destination_reg_po(destination_reg_wire),
		.source_reg1_po(source_reg1_wire),
		.source_reg2_po(source_reg2_wire),
		.immediate_po(immediate_wire),
		.arith_2op_po(arith_2op_wire),
		.arith_1op_po(arith_1op_wire),
		.movi_lower_po(movi_lower_wire),
		.movi_higher_po(movi_higher_wire),
		.addi_po(addi_wire),
		.subi_po(subi_wire),
		.load_po(load_wire),
		.store_po(store_wire),
		.branch_eq_po(branch_eq_wire),
		.branch_ge_po(branch_ge_wire),
		.branch_le_po(branch_le_wire),
		.branch_carry_po(branch_carry_wire),
		.jump_po(jump_wire),
		.stc_cmd_po(stc_cmd_wire),
		.stb_cmd_po(stb_cmd_wire),
		.halt_cmd_po(halt_cmd_wire),
		.rst_cmd_po(rst_cmd_wire)
	);
	//Not Done
	regfile regfile(
		.clk_pi(CLK_pi),
		.clk_en_pi(cpu_clk_en),
		.reset_pi(rst_cmd_wire || CPU_RESET_pi), //HELP
		.source_reg1_pi(source_reg1_wire),
		.source_reg2_pi(source_reg2_wire),
		.destination_reg_pi(destination_reg_wire),
		.wr_destination_reg_pi(wr_destination_reg_bool_wire), // Help
		.dest_result_data_pi(alu_result_wire), // Hmm // This is part of how it's declared in tb_regfile.v
		.movi_lower_pi(movi_lower_wire),
		.movi_higher_pi(movi_higher_wire),
		.immediate_pi(immediate_wire[7:0]), //Fixed bitlength here after the compiler bitched
		.new_carry_pi(carry_out_wire), //Help // Comes from ALU -> DOC
		.new_borrow_pi(borrow_out_wire), //Help // Comes from ALU -> DOC
		.reg1_data_po(reg1_data_wire),
		.reg2_data_po(reg2_data_wire),
		.regD_data_po(regD_data_wire),
		.current_carry_po(current_carry_wire),
		.current_borrow_po(current_borrow_wire)
	);
	//Done
	alu alu(
		.arith_1op_pi(arith_1op_wire),
		.arith_2op_pi(arith_2op_wire),
		.alu_func_pi(alu_func_wire),
		.addi_pi(addi_wire),
		.subi_pi(subi_wire),
		.load_or_store_pi(load_wire||store_wire), //Help // This is how this is in tb_regfile.v
		.reg1_data_pi(reg1_data_wire),
		.reg2_data_pi(reg2_data_wire),
		.immediate_pi(immediate_wire[5:0]), //Fixed bitlength here after compiler bitched
		.stc_cmd_pi(stc_cmd_wire),
		.stb_cmd_pi(stb_cmd_wire),
		.carry_in_pi(current_carry_wire), //Help
		.borrow_in_pi(current_borrow_wire), //Help
		.alu_result_po(alu_result_wire),
		.carry_out_po(carry_out_wire),
		.borrow_out_po(borrow_out_wire)
	);
	//Done
	branch branch(
		.branch_eq_pi(branch_eq_wire),
		.branch_ge_pi(branch_ge_wire),
		.branch_le_pi(branch_le_wire),
		.branch_carry_pi(branch_carry_wire),
		.reg1_data_pi(reg1_data_wire),
		.reg2_data_pi(reg2_data_wire),
		.alu_carry_bit_pi(current_carry_wire), //Help
		.is_branch_taken_po(is_branch_taken_wire)
	);
	//Not Done
	data_mem data_mem(
		.clk_pi(CLK_pi),
		.clk_en_pi(cpu_clk_en),
		.reset_pi(rst_cmd_wire || CPU_RESET_pi), //HELP
		.write_pi(wr_destination_reg_bool_wire), //!!??
		.wdata_pi(alu_result_wire), // idk, but it is 16 bits
		.addr_pi(destination_reg_wire), // This is only 3 bits, where it wants 16
		.rdata_po(rdata_wire)
	);
	//Done before me
	clkdiv clock_divide(
		.clk_pi(CLK_pi),
		.clk_en_po(cpu_clk_en)
	);

endmodule 



/*
 * Module: seconds_clkdiv
 * Description: Generates a clk_en signal.
 * This trivially runs at the same frequency as clk
 * See the module below for a clock that reduces the frequency of a 100 MHz clock to 1 Hz
*/

module clkdiv ( 
	input clk_pi,
	output clk_en_po);
    assign clk_en_po = 1'b1;
	endmodule //clkdiv




/* ***************************************************************************************
 * Module: seconds_clkdiv
 * Description: Generates a clk_en signal that triggers once per second from a 100MHz clk input


module seconds_clkdiv (
	input clk_pi,
	output clk_en_po
);
	reg [31:0] counter;

	initial begin
		counter <= 32'h0;
	end
	
	always @(posedge clk_pi) begin
	if(counter == 32'h5F5E100)  
			counter <= 32'h0;
		else
			counter <= counter + 1;
	end
	
	assign clk_en_po = (counter == 32'h0); 
	
endmodule // seconds_clock
 ****************************************************************************************/


