//-------------------------------------------------------------------------
//    Mouse.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  mouse ( input Reset, frame_clk,
					input [7:0] keycode,
					input [31:0] x_displacement, y_displacement,
               output [9:0]  MouseX, MouseY);
    
    logic [9:0] Mouse_X_Pos, Mouse_X_Motion, Mouse_Y_Pos, Mouse_Y_Motion;
	 
    parameter [9:0] Mouse_X_Center=320;  // Center position on the X axis
    parameter [9:0] Mouse_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Mouse_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Mouse_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Mouse_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Mouse_Y_Max=479;     // Bottommost point on the Y axis
   
    always_ff @ (posedge Reset or posedge frame_clk )
		begin
        if (Reset)  // Asynchronous Reset
        begin 
            Mouse_Y_Motion <= 10'h0;
				Mouse_X_Motion <= 10'h0;
				Mouse_Y_Pos <= Mouse_Y_Center;
				Mouse_X_Pos <= Mouse_X_Center;
        end
           
        else 
			begin
				 if ( Mouse_Y_Pos  >= Mouse_Y_Max && Mouse_Y_Pos < 900)  // Mouse is at the bottom edge, changed all of these so that the Mouse would not go out of bounds
					begin
					  Mouse_Y_Motion <= 0;  // 2's complement.
					  Mouse_Y_Pos <= Mouse_Y_Max -2;
					 end
					  
				 else if ( Mouse_Y_Pos <= Mouse_Y_Min || Mouse_Y_Pos >= 900)  // Mouse is at the top edge
					begin
					  Mouse_Y_Motion <= 0;
					  Mouse_Y_Pos <= Mouse_Y_Min + 2;
					 end
					  
				  else if ( Mouse_X_Pos >= Mouse_X_Max  && Mouse_X_Pos < 900)  // Mouse is at the Right edge
					begin
					  Mouse_X_Motion <= 0;  // 2's complement.
					  Mouse_X_Pos <= Mouse_X_Max - 2;
					end
					  
				 else if ( Mouse_X_Pos <= Mouse_X_Min || Mouse_X_Pos >= 900)  // Mouse is at the Left edge
					begin
					  Mouse_X_Motion <= 0;
					  Mouse_X_Pos <= Mouse_X_Min + 2;;
					end
					  
				 else 
				 begin
					  
					  
					  
							  
					 if(x_displacement >= 5 && x_displacement <= 127) //Made it above 5 because the mouse detection isnt that accurate
							Mouse_X_Motion <= x_displacement>>1;
							
					 else if(x_displacement >= 128 && x_displacement <= 251) //WHY IS THIS 8 BITS WTF, C says 32!
							Mouse_X_Motion <= -1*((255-x_displacement)>>1);
							
					 else
							Mouse_X_Motion <= 0; //X Displacement
						
						
						
				
					if(y_displacement >= 5 && y_displacement <= 127)
							Mouse_Y_Motion <= y_displacement>>1;
							
							
					else if(y_displacement >= 128 && y_displacement <= 251)
							Mouse_Y_Motion <= -1*((255-y_displacement)>>1);
							
							
					else
							Mouse_Y_Motion <= 0; //Y Displacement
						 
						 
						 
						 
				   case (keycode)
				  	8'h01 : begin
  
				  				Mouse_X_Motion <= -1;//A
				  				Mouse_Y_Motion<= 0;
				  			  end
				  			  
				  	8'h02 : begin
				  			
				  			  Mouse_X_Motion <= 1;//D
				  			  Mouse_Y_Motion <= 0;
				  			  end
  
				  			  
				  	8'h04 : begin
  
				  			  Mouse_Y_Motion <= 1;//S
				  			  Mouse_X_Motion <= 0;
				  			 end
				  			  
				  	8'h1A : begin
				  			  Mouse_Y_Motion <= -1;//W
				  			  Mouse_X_Motion <= 0;
				  			 end	  
				  	default: ;
				  endcase
				   
				   Mouse_Y_Pos <= (Mouse_Y_Pos + Mouse_Y_Motion);  // Update Mouse position
				   Mouse_X_Pos <= (Mouse_X_Pos + Mouse_X_Motion);
      
			end
		end  
    end
       
    assign MouseX = Mouse_X_Pos;
   
    assign MouseY = Mouse_Y_Pos;
    

endmodule
