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
//  Source file: /afs/ir.stanford.edu/users/r/p/rprabala/ee271/assignment/assignment2/verif/clocker.vp
//  Source template: clocker
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter Period 	= 1000
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

// Simulation module for generating a clock
// by Ofer Shacham shacham@stanford.edu

/* ***************************************************************************
 * Change bar:
 * -----------
 * Date           Author    Description
 * Sep 22, 2012   jingpu    ported from Ofer's original code to Genesis
 *                          
 * ***************************************************************************/

/******************************************************************************
 * PARAMETERIZATION
 * ***************************************************************************/
// Period (_GENESIS2_INHERITANCE_PRIORITY_) = 0x3e8
//

module clocker_unq1  
    (
    output logic clk
     );
   
   initial begin
      while(1) begin
	 #500 clk = 1'b0;
	 #500 clk = 1'b1;
      end
   end   
 
endmodule // clocker
