//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name: Irem Kaki
// Date: 16/06/2021
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb (
    );
    
    parameter CLK_PERIOD = 10;

    reg clk;
    reg rst;
    reg button;
    wire [2:0] colour;
    reg err;
    reg [2:0] colour_prev;

    // clock
    initial begin
        clk = 1'b0;
        forever
        #(CLK_PERIOD/2) clk=~clk;
    end

    // tests
    initial begin
        // reset test
        err = 0;
        button = 0;
        rst = 1;
        #CLK_PERIOD
        if (colour != 3'b001) begin
            $display("Test failed - reset");
            err = 1;
        end
        
        // button unpressed test
        rst = 0;
        colour_prev = colour;
        #(CLK_PERIOD*2)
        if (colour != colour_prev) begin
            $display("Test failed - colour changed while button = 0");
            err = 1;
        end

        // button pressed tests
        button = 1;
	    forever begin
	        colour_prev = colour;
            #CLK_PERIOD
            // check if it goes from 110 back to 001
            if (colour_prev == 3'b110 && colour != 3'b001) begin
                $display("Test failed - didn't go from 110 to 001");
                err = 1;
            end
            // check if others work
            if (colour_prev < 3'b110 && colour != colour_prev + 3'b001) begin
                $display("Test failed - colour change");
                err = 1;
            end
	    end
    

    end

    // finish test and check for success
    initial begin
        #(CLK_PERIOD*100)
        if (err==0) begin
            $display("Test passed :)");
            $finish;
        end
    end
        

    // instantiate led module
    led top(
        .clk (clk),
        .rst (rst),
        .button (button),
        .colour (colour)
    );

endmodule

