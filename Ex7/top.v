//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name: Irem Kaki
// Date: 18/06/2021
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

module selector (
    input clk, sel, rst, button,
    output [23:0] light
    );

    // registers and wires
    wire [2:0] colour;
    wire [23:0] light_out;
    wire [23:0] rgb;

    // instantiate other modules
    led led(
        .clk (clk),
        .rst (rst),
        .button (button),
        .colour (colour)
        );

    rgb_converter rgb_converter(
        .clk (clk),
        .enable (1'b1),
        .colour (colour),
        .rgb (rgb)
        );

    mux mux(
        .a (24'hffffff),
        .b (rgb),
        .sel (sel),
        .out (light_out)
        );

endmodule
