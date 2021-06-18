//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Irem Kaki
// Date: 18/06/2021
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );

    parameter CLK_PERIOD = 10;

    reg clk;
    reg sel;
    reg rst;
    reg button;
    reg err;
    
    wire [23:0] light;
    reg [23:0] light_prev;
    

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
        // check for sel = 0 --> white
        #CLK_PERIOD
        rst = 0;
        sel = 0;
        button = 0;
        err = 0;
        if (light != 24'hffffff) begin
            $display("Test failed - sel = 0, light != white");
            err = 1;
        end

        // check for sel = 1 & button = 0 --> colour unchanged
        #CLK_PERIOD
        sel = 1;
        light_prev = light;
        #CLK_PERIOD
        if (light != light_prev) begin
            $display("Test failed - button = 0, light changed");
            err = 1;
        end

        // check for colour change
        #CLK_PERIOD
        forever begin
            light_prev = light;
            button = 1;
            #CLK_PERIOD
            if (light == light_prev) begin
                $display("Test failed - button = 1, light didn't change");
                err = 1;
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
    selector top(
        .clk (clk),
        .sel (sel),
        .rst (rst),
        .button (button),
        .light (light)
        );

endmodule
