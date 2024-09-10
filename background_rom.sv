module background_rom( input [9:0] addressX, addressY, MouseX, MouseY,
								output data, data_mouse
								);
								

logic [4:0] X_shifted, Y_shifted;
logic [19:0] data_array;
logic [4:0] MouseX_shifted, MouseY_shifted;
logic [19:0] Mousedata_array;

assign X_shifted = addressX >> 5;
assign Y_shifted = addressY >> 5;
assign MouseX_shifted = MouseX >> 5;
assign MouseY_shifted = MouseY >> 5;	 
					 
				
	// ROM definition				
	logic [0:14][0:19] ROM = {
       20'b00000000100000000000, // 0 
       20'b00000000111111000000, // 1
       20'b00000000000001000000, // 2
       20'b00111110000001000000, // 3
       20'b00100010000001000000, // 4
       20'b00100010000001000000, // 5
       20'b00100010011111000000, // 6
       20'b11100010010000000000, // 7
       20'b00000010010000000000, // 8
       20'b00000010011111000000, // 9
       20'b01111110000001000000, // 10
       20'b01000000000001000000, // 11
       20'b01000000000001000000, // 12
       20'b01111111111111000000, // 13
       20'b00000000000000000000, // 14
//         0123456789abcdefghij
        };


	assign data_array = ROM[Y_shifted];
	assign data = data_array[19-X_shifted];
	

        assign Mousedata_array = ROM[MouseY_shifted];
	assign data_mouse = Mousedata_array[19-MouseX_shifted];

endmodule  