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
//  Source file: /afs/ir.stanford.edu/users/r/p/rprabala/EE271/assignment/assignment2/verif/zbuff.vp
//  Source template: zbuff
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter Radix 	= 10
// Parameter Filename 	= f_image.ppm
// Parameter Colors 	= 3
// Parameter Vertices 	= 3
// Parameter SigFig 	= 24
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
 *  zbuff.v
 * 
 *  Model of a z-buffer
 * 
 *  Inputs:
 *   Sample Location
 *   Sample Hit
 *   Sample Depth
 *   Sample Color
 * 
 *  Outputs:
 *   None -> Writes an image file at simulation end
 * 
 *  Function:
 *   Implement Zbuffer algorithm
 *   Write image at simualtion end
 * 
 * 
 *   Author: John Brunhaver
 *   Created:      Mon 10/18/10
 *   Last Updated: Mon 10/18/10
 * 
 *   Copyright 2010 <jbrunhaver@gmail.com>   
 * 
 */
 
  /****************************************************************************
 * Change bar:
 * -----------
 * Date           Author    Description
 * Sep 22, 2012   jingpu    ported from John's original code to Genesis
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
// Filename (_GENESIS2_INHERITANCE_PRIORITY_) = f_image.ppm
//
// TODO: comput log2 using perl function
// FB_log2 (_GENESIS2_DECLARATION_PRIORITY_) = 11
//
// FB (_GENESIS2_DECLARATION_PRIORITY_) = 0x800
//
// SS_log2 (_GENESIS2_DECLARATION_PRIORITY_) = 2
//
// SS (_GENESIS2_DECLARATION_PRIORITY_) = 4
//
// ColorP (_GENESIS2_DECLARATION_PRIORITY_) = 12
//


/* A Note on Signal Names:
 *
 * Most signals have a suffix of the form _RxxxxN 
 * where R indicates that it is a Raster Block signal
 * xxxx indicates the clock slice that it belongs to
 * and N indicates the type of signal that it is.
 * H indicates logic high, L indicates logic low,
 * U indicates unsigned fixed point, and S indicates
 * signed fixed point.
 * 
 */
 

import "DPI" pure function 
int zbuff_init( int w,    //Screen Width
		int h,    //Screen Width
		int ss_w  //Subsample Width
		); 

import "DPI" pure function    
int zbuff_rop(  int x ,   //Hit Loc. X
		int y ,   //Hit Loc. Y
		int ss_x ,  //4 Hit loc X
		int ss_y ,  //4 Hit Loc Y
		int d , //actually a uint
		int R , //actually a ushort
		int G , //actually a ushort
		int B   //actually a ushort
		) ;

import "DPI" pure function 
int write_ppm( );





module zbuff_unq1 
   ( 
     input logic                     clk,
     input logic                     rst,
     
     input logic signed [24-1:0] screen_RnnnnS[1:0],              // Input: Screen Dimensions
     input logic        [3:0]        subSample_RnnnnU,                // Input: SubSample_Interval
     input int                   ss_w_lg2_RnnnnS,
     
     input logic signed   [24-1:0] hit_R18S[3-1:0],
     input logic unsigned [24-1:0] color_R18U[3-1:0],
     input logic                       hit_valid_R18H
     
     );
   
    //                               

   logic unsigned [11-1:0]  x_ind;
   logic unsigned [11-1:0]  y_ind;
   logic unsigned [2-1:0]  x_ss_ind;
   logic unsigned [2-1:0]  y_ss_ind;
   logic unsigned [24-1:0] depth;
   logic unsigned [24-1:0] color[3-1:0];

   int unsigned     x_max ;
   int unsigned     y_max ;
   int unsigned     ss_max ;
   int unsigned     ss_rate ;
   
   
   logic [24-1:0]           zero ;                     //fudge signal to hold zero as a reset value
   logic [127:0] 		big_zero;                 //fudge signal to hold zero as a reset value

   assign big_zero = 128'd0;
   assign zero = big_zero[24-1:0];

   assign  depth = unsigned'(hit_R18S[2]);
   assign  x_ind = hit_R18S[0][(10+11-1):10];
   assign  y_ind = hit_R18S[1][(10+11-1):10];

   //Brittle Only works for 3=3
   assign color[0] = color_R18U[0];
   assign color[1] = color_R18U[1];
   assign color[2] = color_R18U[2];

   assign x_max = screen_RnnnnS[0][24-1:10];
   assign y_max = screen_RnnnnS[1][24-1:10];

   
   always_comb begin

      unique case ( subSample_RnnnnU )
	(4'b1000 ): x_ss_ind[2-1:0] =   zero[2-1:0] ;
	(4'b0100 ): x_ss_ind[2-1:0] = { zero[2-1:1] , hit_R18S[0][10-1] }  ;
	(4'b0010 ): x_ss_ind[2-1:0] = { zero[2-1:1] , hit_R18S[0][10-1:10-2] }  ;
	(4'b0001 ): x_ss_ind[2-1:0] = {                   hit_R18S[0][10-1:10-3] }  ;
      endcase // case ( subSample_RnnnnU )
      
      unique case ( subSample_RnnnnU )
	(4'b1000 ): y_ss_ind[2-1:0] =   zero[2-1:0] ;
	(4'b0100 ): y_ss_ind[2-1:0] = { zero[2-1:1] , hit_R18S[1][10-1] }  ;
	(4'b0010 ): y_ss_ind[2-1:0] = { zero[2-1:1] , hit_R18S[1][10-1:10-2] }  ;
	(4'b0001 ): y_ss_ind[2-1:0] = {                   hit_R18S[1][10-1:10-3] }  ;
      endcase // case ( subSample_RnnnnU )

      unique case ( subSample_RnnnnU )
	(4'b1000 ): ss_max = 1  ;
	(4'b0100 ): ss_max = 2  ;
	(4'b0010 ): ss_max = 4  ;
	(4'b0001 ): ss_max = 8  ;
      endcase // case ( subSample_RnnnnU )
 
      unique case ( subSample_RnnnnU )
	(4'b1000 ): ss_rate = 1  ;
	(4'b0100 ): ss_rate = 4  ;
	(4'b0010 ): ss_rate = 16 ;
	(4'b0001 ): ss_rate = 64 ;
      endcase // case ( subSample_RnnnnU )
 
   end
   

    
    
   always @(posedge clk) begin
      #25;
	 if( hit_valid_R18H && ~rst ) begin
	    zbuff_rop(  x_ind ,   //Hit Loc. X
			y_ind ,   //Hit Loc. Y
			x_ss_ind ,  //4 Hit loc X
			y_ss_ind ,  //4 Hit Loc Y
			depth , //actually a uint
			color[0] , //actually a ushort
			color[1] , //actually a ushort
			color[2]  //actually a ushort
		) ;
	 end			   
   end
     

   task init_buffers;
      begin
	 $display("time=%10t ************** Initializing FB and ZB *****************", $time);
	 #10;
	 
	 zbuff_init( x_max,    //Screen Width
		     y_max,    //Screen Width
		     ss_max  //Subsample Width
		     ); 
	 
	 $display("time=%10t ************** Finished Init FB and ZB *****************", $time);
      end
   endtask

   
   task write_image;
      begin
	 #10;

	 $display("time=%10t ************** Writing Final Image to File *****************", $time);
	 #10;

	 write_ppm( );
	 #10;
	 
	 $display("time=%10t ************** Finished Final Image to File *****************", $time);
	 #10;
	 
      end
   endtask //write_image


   
endmodule
