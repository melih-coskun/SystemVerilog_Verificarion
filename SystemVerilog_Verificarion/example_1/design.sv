// Code your design here
`timescale 1ns / 1ps
module calc(clk, rst, validIn, dataIn, dataOut);
input clk, rst, validIn;
input  [15:0] dataIn;
output reg [15:0] dataOut;

reg [1:0] state, stateNext;
reg [15:0] num1, num1Next, dataOutNext;
reg [2:0] operator, operatorNext;

always @(posedge clk) begin
    if (rst) begin
        state    <= 0;
        num1     <= 0;
        operator <= 0;
        dataOut  <= 0;
    end else begin
       state         <=  stateNext;
       num1          <=  num1Next;
       operator      <=  operatorNext;
       dataOut       <=  dataOutNext;
    end
end

always @(*) begin
    stateNext    = state;
    num1Next     = num1;
    operatorNext = operator;
    dataOutNext  = dataOut;
    case(state)
        0: begin
            if(validIn) begin
               stateNext   = 1;
               num1Next    = dataIn;
               dataOutNext = dataIn;
            end
        end
        1: begin
            if(validIn) begin
               stateNext = 0;
               case(dataIn)
                 2: dataOutNext = num1 * num1;
                 3: dataOutNext = num1 + 1;
                 default: begin
                    dataOutNext = dataIn;
                    if(dataIn < 2) begin
                       stateNext  = 2;
                       operatorNext = dataIn;
                    end else
                      stateNext  = 1;
                end
               endcase // case (dataIn)
            end
        end
        2: begin
            if(validIn) begin
               stateNext = 0;
               case(operator)
                    0: dataOutNext = num1 * dataIn;
                    1: dataOutNext = num1 + dataIn;
               endcase
            end
        end
    endcase
end

endmodule
