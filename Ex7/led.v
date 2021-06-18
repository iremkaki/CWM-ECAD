//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name: Irem Kaki
// Date: 16/06/2021
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module led (
    // define ports
    input clk, rst, button,
    output reg [2:0] colour
    );

    // logic
    always @(posedge clk) begin
        if (rst) begin
            colour = 3'b001;
        end
        if (button) begin
            case (colour)
                3'b000: colour = 3'b001;
                3'b001: colour = 3'b010;
                3'b010: colour = 3'b011;
                3'b011: colour = 3'b100;
                3'b100: colour = 3'b101;
                3'b101: colour = 3'b110;
                3'b110: colour = 3'b001;
                3'b111: colour = 3'b001;
            endcase
        end
        else begin
            colour = colour;
        end
    end
endmodule
