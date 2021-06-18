//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Irem Kaki
// Date: 16/06/2021
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );

    parameter CLK_PERIOD = 10;
    reg clk;
    reg [4:0] temperature;
    wire heating;
    wire cooling;
    reg err;

    // clock generation
    initial begin
        clk = 1'b0;
        forever begin
            #(CLK_PERIOD/2)
            clk =~ clk;
	    end    
    end


    // set regular tests
    initial begin
        err = 0;
        temperature = 16;
        forever begin
            #CLK_PERIOD
            // cannot be cooling and heating at the same time
            if ((cooling == 1) && (heating == 1)) begin
                $display("Test failed - illegal state, heating and cooling at once");
                err = 1;
            end

            // check idle state
            if ((temperature > 18) && (temperature < 22) && (cooling != 0) && (heating != 0)) begin
                $display("Test failed - error in idle state");
                err = 1;
            end 

            // check heating state
            if ((temperature <= 18) && (cooling != 0) && (heating != 1)) begin
                $display("Test failed - error in heating state");
                err = 1;
            end

            // check cooling state
            if ((temperature >= 22) && (cooling != 1) && (heating != 0)) begin
                $display("Test failed - error in cooling state");
                err = 1;
            end
            #(CLK_PERIOD*3)
            temperature = temperature + 1;
        end
    end


    // finish test, check for success
    initial begin
        #(CLK_PERIOD*100)
        if (err == 0) begin
            $display("Test passed :)");   
        end
	$finish;
    end

    // instantiate module
    ac top(
        .clk (clk),
        .temperature (temperature),
        .heating (heating),
        .cooling (cooling)
        );

endmodule
