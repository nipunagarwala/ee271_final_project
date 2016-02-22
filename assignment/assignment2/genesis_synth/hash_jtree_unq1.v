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
//  Source file: /afs/ir.stanford.edu/users/n/i/nipuna1/ee271/ee271_final_project/assignment/assignment2/rtl/hash_jtree.vp
//  Source template: hash_jtree
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter Vertices 	= 3
// Parameter PipelineDepth 	= 2
// Parameter Colors 	= 3
// Parameter SigFig 	= 24
// Parameter Radix 	= 10
// Parameter Axis 	= 3
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
 *  Hashing Function
 * 
 *  Inputs:
 *    MicroPolygon and Sample Information
 * 
 *  Outputs:
 *    Jittered Sample Position and Buffered Micropolygon
 * 
 *  Function:
 *    Calc on offset for the sample.  This is used for
 *    stochastic sampling reasons.  Note that this is 
 *    a simplified hashing mechanism.  An in depth 
 *    discussion of stochastic sampling in rendering
 *    can be found here:
 *    http://doi.acm.org/10.1145/7529.8927 
 * 
 *    
 * Long Description:
 *    The basic idea is to use a tree of xor
 *    functions to generate a displacement 
 *    from the sample center.
 * 
 * 
 *   Author: John Brunhaver
 *   Created:      Thu 10/01/10
 *   Last Updated: Tue 10/15/10
 *
 *   Copyright 2009 <jbrunhaver@gmail.com>   
 *  
 */

/* ***************************************************************************
 * Change bar:
 * -----------
 * Date           Author    Description
 * Sep 19, 2012   jingpu    ported from John's original code to Genesis
 *                          
 * ***************************************************************************/

/******************************************************************************
 * PARAMETERIZATION
 * ***************************************************************************/
// SigFig (_GENESIS2_INHERITANCE_PRIORITY_) = 24
//
// Radix (_GENESIS2_INHERITANCE_PRIORITY_) = 10
//
// Vertices (_GENESIS2_INHERITANCE_PRIORITY_) = 3
//
// Axis (_GENESIS2_INHERITANCE_PRIORITY_) = 3
//
// Colors (_GENESIS2_INHERITANCE_PRIORITY_) = 3
//
// PipelineDepth (_GENESIS2_INHERITANCE_PRIORITY_) = 2
//
 
/* A Note on Signal Names:
 *
 * Most signals have a suffix of the form _RxxN 
 * where R indicates that it is a Raster Block signal
 * xx indicates the clock slice that it belongs to
 * and N indicates the type of signal that it is.
 * H indicates logic high, L indicates logic low,
 * U indicates unsigned fixed point, and S indicates
 * signed fixed point.
 * 
 */



module hash_jtree_unq1
(
  //Input Signals
  input logic signed    [24-1:0] poly_R14S[3-1:0][3-1:0],  //Micropolygon to Sample Test
  input logic unsigned  [24-1:0] color_R14U[3-1:0] ,         //Color of Poly
  input logic signed    [24-1:0] sample_R14S[1:0],                //Sample Location to Be Tested
  input logic        	             validSamp_R14H,                  //Sample and Micropolygon are Valid
  input logic         		     isQuad_R14H,                     //Micropygon is quad

  //Global Signals
  input	logic	                     clk,                // Clock
  input logic	                     rst,                // Reset
 
  //Control Signals
  input  logic          [3:0]        subSample_RnnnnU ,   //Subsample width 

  //Outputs
  output logic signed   [24-1:0] poly_R16S[3-1:0][3-1:0], // Micropolygon to Iterate Over
  output logic unsigned [24-1:0] color_R16U[3-1:0] ,        // Color of Poly
  output logic signed   [24-1:0] sample_R16S[1:0],               // Sample Location    
  output logic                       validSamp_R16H,                 // A valid sample location
  output logic                       isQuad_R16H                     //Micropolygon is quad

 );
   
   
   // output for retiming registers
   logic signed [24-1:0]     poly_R16S_retime[3-1:0][3-1:0]; // Micropolygon to Iterate Over
   logic 			     unsigned [24-1:0]   color_R16U_retime[3-1:0];      // Color of Poly
   logic signed [24-1:0]     sample_R16S_retime[1:0];   // Sample Location    
   logic 			     validSamp_R16H_retime;                    // A valid sample location
   logic 			     isQuad_R16H_retime;   //Micropolygon is quad  
   // output for retiming registers
   
   
   logic [8-1:0] 	     hash_mask_R14H ;
   logic [8-1:0] 	     jitt_val_R14H[1:0] ;
   logic [24-1:0] 		     sample_jitted_R14S[1:0] ;

   
   
   always_comb begin
      assert( $onehot(subSample_RnnnnU) ) ;
      unique case ( 1'b1 )
	(subSample_RnnnnU[3]): hash_mask_R14H = 8'b11111111 ; //MSAA = 1
	(subSample_RnnnnU[2]): hash_mask_R14H = 8'b01111111 ; //MSAA = 4
	(subSample_RnnnnU[1]): hash_mask_R14H = 8'b00111111 ; //MSAA = 16
	(subSample_RnnnnU[0]): hash_mask_R14H = 8'b00011111 ; //MSAA = 64
      endcase // case ( 1'b1 )
   end

   /*always @( posedge clk ) begin
      #100;
     $display( "SV: %.10x %.10x \n" , 
		{ sample_R14S[1][24-1:4] , sample_R14S[0][24-1:4]} ,
		{ sample_R14S[0][24-1:4] , sample_R14S[1][24-1:4]} );

      $display( "SV:  %.8b %.8b %.8b %.8b \n" , 
	       xjit_hash.arr32_RnnH[31:24], xjit_hash.arr32_RnnH[23:16],
	       xjit_hash.arr32_RnnH[15:8], xjit_hash.arr32_RnnH[7:0]);
      $display( "SV: %.8b %.8b \n" , 
		xjit_hash.arr16_RnnH[15:8], xjit_hash.arr16_RnnH[7:0]);  
      $display( "SV: %.8b \n" , 
		xjit_hash.arr16_RnnH[15:8] ^ xjit_hash.arr16_RnnH[7:0] );
      $display( "SV: %.8b \n" , 
		 jitt_val_R14H[0]);
 
      $display( "SV:  %.8b %.8b %.8b %.8b \n" , 
	       yjit_hash.arr32_RnnH[31:24], yjit_hash.arr32_RnnH[23:16],
	       yjit_hash.arr32_RnnH[15:8], yjit_hash.arr32_RnnH[7:0]);
      $display( "SV: %.8b %.8b  \n" , 
		yjit_hash.arr16_RnnH[15:8], yjit_hash.arr16_RnnH[7:0]);  
      $display( "SV: %.8b \n" , 
		yjit_hash.arr16_RnnH[15:8] ^ yjit_hash.arr16_RnnH[7:0] );
      $display( "SV: %.8b \n" , 
		 jitt_val_R14H[1]);

   end*/
   
   tree_hash_unq1   xjit_hash (
	      .in_RnnH( { sample_R14S[1][24-1:4] , sample_R14S[0][24-1:4]}   ),
	      .mask_RnnH( hash_mask_R14H ),
	      .out_RnnH( jitt_val_R14H[0] )
	      );
   
   tree_hash_unq1   yjit_hash (
	      .in_RnnH( { sample_R14S[0][24-1:4] , sample_R14S[1][24-1:4]} ),
	      .mask_RnnH( hash_mask_R14H ),
	      .out_RnnH( jitt_val_R14H[1] )
	      );

   //Jitter the sample coordinates
   assign sample_jitted_R14S[0] =  { sample_R14S[0][24-1:0] }       
                                 | { 14'b0,                 //23:10 = 14 bits
				     jitt_val_R14H[0][8-1:0], //7:0 = 8 bits
                                     2'b0 };     //1:0 = 2 bits  ==> 24 bits total  
   
   //Jitter the sample coordinates
   assign sample_jitted_R14S[1] =  { sample_R14S[1][24-1:0] }       
                                 | { 14'b0,                 //23:10 = 14 bits
				     jitt_val_R14H[1][8-1:0], //7:0 = 8 bits
                                     2'b0 };     //1:0 = 2 bits  ==> 24 bits total  

  

   //Flop R14 to R16_retime with retiming registers	
	dff3_unq5  d_hash_r1 (
					 .in(poly_R14S) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out(poly_R16S_retime));
					 
	dff2_unq5  d_hash_r2 (
					 .in(color_R14U) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out(color_R16U_retime));
					 
	dff2_unq6  d_hash_r3 (
					 .in(sample_jitted_R14S) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out(sample_R16S_retime));	
					 
	dff_unq8  d_hash_r4 (
				     .in({validSamp_R14H, isQuad_R14H}) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out({validSamp_R16H_retime, isQuad_R16H_retime}));		
   //Flop R14 to R16_retime with retiming registers			


	
   
	//Flop R16_retime to R16 with fixed registers
	dff3_unq3  d_hash_f1 (
					 .in(poly_R16S_retime) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out(poly_R16S));
					 
	dff2_unq3  d_hash_f2 (
					 .in(color_R16U_retime) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out(color_R16U));
					 
	dff2_unq4  d_hash_f3 (
					 .in(sample_R16S_retime) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out(sample_R16S));	
					 
	dff_unq4  d_hash_f4 (
				     .in({validSamp_R16H_retime, isQuad_R16H_retime}) , 
				     .clk(clk) , .reset(rst), .en(1'b1),
				     .out({validSamp_R16H, isQuad_R16H}));	
	//Flop R16_retime to R16 with fixed registers				 
	

   
endmodule 


   
