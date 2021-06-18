//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Irem Kaki
// Date: 18/06/2021
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );

    parameter CLK_PERIOD = 10;
    reg clk_n;
    reg clk_p;
    reg rst_n;
    reg [4:0] temperature;
    wire heating;
    wire cooling;
    reg err;


    // clock generation
    initial begin
        clk_n = 1'b0;
        clk_p = 1'b0;
        forever begin
            #(CLK_PERIOD/2)
            clk_n =~ clk_n;
            clk_p =~ clk_p;            
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


    // finish test, check for error
    initial begin
        #(CLK_PERIOD*50)
        if (err == 0) begin
            $display("Test passed :)");
        end
        $finish;
    end    

    // instantiate module
    top top (
        .clk_p (clk_p),
        .clk_n (clk_n),
        .rst_n (rst_n),
        .temperature_0 (temperature[0]),
        .temperature_1 (temperature[1]),
        .temperature_2 (temperature[2]),
        .temperature_3 (temperature[3]),
        .temperature_4 (temperature[4]),
        .heating (heating),
        .cooling (cooling)
        );


endmodule
