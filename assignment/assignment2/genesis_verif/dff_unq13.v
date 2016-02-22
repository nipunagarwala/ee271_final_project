//
//---------------------------------------------------------------------------
//  THIS FILE WAS AUTOMATICALLY GENERATED BY THE STANFORD GENESIS2 ENGINE
//  FOR MORE INFORMATION, CONTACT OFER SHACHAM FROM THE STANFORD VLSI GROUP
//  THIS VERSION OF GENESIS2 IS NOT TO BE USED FOR ANY COMMERCIAL USE
//---------------------------------------------------------------------------
//
//  
//	-----------------------------------------------
//	|            Genesis Release Info             |
//	|  $Change: 11012 $ --- $Date: 2012/09/13 $   |
//	-----------------------------------------------
//	
//
//  Source file: /afs/ir.stanford.edu/users/n/i/nipuna1/ee271/ee271_final_project/assignment/assignment2/rtl/dff.vp
//  Source template: dff
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter Retime 	= NO
// Parameter BitWidth 	= 4
// Parameter PipelineDepth 	= 3
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Command Line input (priority=4):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From XML input (priority=3):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Config File input (priority=2):
//
// ---------------- End Pre-Generation Pramameters Status Report ----------------

/*
 This is a Genesis wrapper of DW pipeline regs with en singal
 */

/* ***************************************************************************
 * Change bar:
 * -----------
 * Date           Author    Description
 * Sep 20, 2012   jingpu    init version
 *                          
 * ***************************************************************************/

/*******************************************************************************
 * PARAMETERIZATION
 * ****************************************************************************/
// BitWidth (_GENESIS2_INHERITANCE_PRIORITY_) = 4
//
// PipelineDepth (_GENESIS2_INHERITANCE_PRIORITY_) = 3
//
// Retime (_GENESIS2_INHERITANCE_PRIORITY_) = NO
//

module dff_unq13 (
		input logic [3:0]  in, 
		input logic 		    clk, reset, en, 
		output logic [3:0] out
		);

   
   /* synopsys dc_tcl_script_begin
    set_ungroup [current_design] true
    set_flatten true -effort high -phase true -design [current_design]
    set_dont_retime [current_design] true
    set_optimize_registers false -design [current_design]
    */
   
   //   DW03_pipe_reg #(3,4) dff ( .A(in) , .clk(clk) , .B(out) ) ;
   DW_pl_reg #(.stages(4),.in_reg(0),.out_reg(0),.width(4),.rst_mode(0)) dff ( .data_in(in) , .clk(clk) , .data_out(out), .rst_n(!reset), .enable({3{en}}) );
   
endmodule
