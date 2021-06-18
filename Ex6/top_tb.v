//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Irem Kaki
// Date: 17/06/2021
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb (
	);

    parameter CLK_PERIOD = 10;

    reg clk;
    reg [2:0] colour;
    reg enable;
    wire [23:0] rgb;
    reg err;
    reg [23:0] rgb_prev;

    // clock generation
    initial begin
        clk = 1'b0;
        forever begin
            #(CLK_PERIOD/2)
            clk =~ clk;
	    end    
    end

    // tests
    initial begin
        err = 0;
        colour = 0;
        rgb_prev = rgb;
        enable = 1;
        #(CLK_PERIOD*2)
        
        forever begin
            #(CLK_PERIOD*2)
            rgb_prev = rgb;
            colour = colour + 1;
        end

        #(CLK_PERIOD*4)
        forever begin
            if (enable == 1) begin
                #(CLK_PERIOD)
                if (rgb_prev == rgb) begin
                    $display("Test failed - colour change");
                    err = 1;
                end
            end
        end
    end

    // finish test, check for error
    initial begin
        #(CLK_PERIOD*100)
        if (err == 0) begin
            $display("Test passed :)");
        end
        $finish;
    end
    

    // instantiate module
    rgb top(
        .clk (clk),
        .colour (colour),
        .enable (enable),
        .rgb (rgb)
        );


endmodule


