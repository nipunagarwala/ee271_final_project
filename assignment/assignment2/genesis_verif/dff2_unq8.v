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
//  Source file: /afs/ir.stanford.edu/users/n/i/nipuna1/ee271/ee271_final_project/assignment/assignment2/rtl/dff2.vp
//  Source template: dff2
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter ArraySize1 	= 3
// Parameter Retime 	= NO
// Parameter PipelineDepth 	= 3
// Parameter BitWidth 	= 24
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
 This is a two dimentional array of DFFs
 */

/* ***************************************************************************
 * Change bar:
 * -----------
 * Date           Author    Description
 * Sep 20, 2012   jingpu    init version
 *                          
 * ***************************************************************************/

/******************************************************************************
 * PARAMETERIZATION
 * ***************************************************************************/
// BitWidth (_GENESIS2_INHERITANCE_PRIORITY_) = 24
//
// ArraySize1 (_GENESIS2_INHERITANCE_PRIORITY_) = 3
//
// PipelineDepth (_GENESIS2_INHERITANCE_PRIORITY_) = 3
//
// Retime (_GENESIS2_INHERITANCE_PRIORITY_) = NO
//

module dff2_unq8 (
		input logic [23:0]  in[2:0], 
		input logic 		       clk, reset, en, 
		output logic [23:0] out[2:0]
		);	
   
   dff_unq11  dff_0 
     (.in(in[0]) , 
      .clk(clk) , .reset(reset), .en(en),
      .out(out[0]));
   dff_unq11  dff_1 
     (.in(in[1]) , 
      .clk(clk) , .reset(reset), .en(en),
      .out(out[1]));
   dff_unq11  dff_2 
     (.in(in[2]) , 
      .clk(clk) , .reset(reset), .en(en),
      .out(out[2]));
   
endmodule 
