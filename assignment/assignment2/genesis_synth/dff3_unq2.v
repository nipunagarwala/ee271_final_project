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
//  Source file: /afs/ir.stanford.edu/users/r/p/rprabala/ee271/assignment/assignment2/rtl/dff3.vp
//  Source template: dff3
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter Retime 	= YES
// Parameter PipelineDepth 	= 2
// Parameter ArraySize2 	= 2
// Parameter ArraySize1 	= 2
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
 This is a three dimentional array of DFFs
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
// ArraySize1 (_GENESIS2_INHERITANCE_PRIORITY_) = 2
//
// ArraySize2 (_GENESIS2_INHERITANCE_PRIORITY_) = 2
//
// PipelineDepth (_GENESIS2_INHERITANCE_PRIORITY_) = 2
//
// Retime (_GENESIS2_INHERITANCE_PRIORITY_) = YES
//

module dff3_unq2 (
		input logic [23:0]  in[1:0][1:0], 
		input logic 		       clk, reset, en, 
		output logic [23:0] out[1:0][1:0]
		);	
   
   dff2_unq2  dff2_0 
     (.in(in[0]) , 
      .clk(clk) , .reset(reset), .en(en),
      .out(out[0]));
   dff2_unq2  dff2_1 
     (.in(in[1]) , 
      .clk(clk) , .reset(reset), .en(en),
      .out(out[1]));
   
endmodule 
