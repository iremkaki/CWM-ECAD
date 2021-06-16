//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Irem Kaki
// Date: 15/06/2021
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
    //Todo: Parameters
    parameter CLK_PERIOD = 10;

    //Todo: Registers and wires
    reg clk;
    reg rst;
    reg on_off;
    reg err;
    reg change;
    reg [7:0] counter_test;
    wire [7:0] counter_out;

    //Todo: Clock generation
    initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

    //Todo: User logic
    initial begin
        rst = 1;
        change = 0;
        err = 0;
        on_off = 1;
        counter_test = 0;
    
        //test to see if counter counts with these settings
        #(CLK_PERIOD);
        if (counter_out != 0) begin
            $display("Test failed - counter doesn't start from 0");
            err = 1;
        end
        
        rst = 0;
        //test to check if counter is stable (has the same result)
        counter_test = counter_out;
        #(CLK_PERIOD*2)
        if (counter_out != counter_test) begin
            $display("Test failed - counter counts when it shouldn't");
            err = 1;
        end

        //test with change = 1
        change = 1;
        forever begin
            //test count up
            on_off = 1;
            counter_test = counter_out;
            #(CLK_PERIOD * 5)
            if (counter_out != counter_test + 5) begin
                $display("Test failed - counter count up");
                err = 1;
            end
            
            //test count down
            on_off = 0;
            counter_test = counter_out;
            #(CLK_PERIOD * 5)
            if (counter_out != counter_test - 5) begin
                $display("Test failed - counter count down");
                err = 1;
            end
        end
    end

    
    
    //Todo: Finish test, check for success
    initial begin
        #(CLK_PERIOD * 50)
        if (err == 0) begin
            $display("Test passed :)");
            $finish;
        end
    end

    //Todo: Instantiate counter module
    monitor top (
        .rst (rst),
        .change (change),
        .clk (clk),
        .on_off (on_off),
        .counter_out (counter_out)
    );

 
endmodule 
