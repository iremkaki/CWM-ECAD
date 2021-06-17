//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Irem Kaki
// Date: 16/06/2021
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module ac (
    input clk,
    input [4:0] temperature,
    output heating,
    output cooling
    );

    //define the state - 00 idle, 01 heating ON, 10 cooling ON - start from idle
    reg [1:0] state = 2'b00;
    assign heating = state[0];
    assign cooling = state[1];

    //define all possible moves between states
    always @(posedge clk) begin
        case(state)
            //state is idle
            2'b00: begin
                //if <= 18, move to heating
                if (temperature <= 18) begin
                    //heating = 1;
                    //cooling = 0;
                    state = 2'b01;
                end
                //if >= 22, move to cooling
                if (temperature >= 22) begin
                    //heating = 0;
                    //cooling = 1;
                    state = 2'b10;                
                end
                //else, stay idle
                else begin
                    //heating = 0;
                    //cooling = 0;
                    state = 2'b00;
                end
            end
            
            //state is heating
            2'b01: begin
                //if >= 20, move to idle
                if (temperature >= 20) begin
                    //heating = 0;
                    //cooling = 0;
                    state = 2'b00;
                end
                //else, stay heating
                else begin
                    //heating = 1;
                    //cooling = 0;
                    state = 2'b01;                
                end
            end

            //state is cooling
            2'b10: begin
                //if <= 20, move to idle
                if (temperature <= 20) begin
                    //heating = 0;
                    //cooling = 0;
                    state = 2'b00;
                end
                //else, stay cooling
                else begin
                    //heating = 0;
                    //cooling = 1;
                    state = 2'b10;
                end
            end
        endcase
    end
endmodule
