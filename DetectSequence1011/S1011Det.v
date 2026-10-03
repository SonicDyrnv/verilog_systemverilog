
`timescale 1ns/1ps

parameter S0 = 4'b0;
parameter S1 = 4'b1;
parameter S10 = 4'b10;
parameter S101 = 4'b101;
parameter S1011 = 4'b1011;

module S1011Det(
    input in1,
  	input clk,
  	input rst,
    output op
);

reg [3:0]state;

assign op = (state==S1011) ? 1'b1 : 1'b0;

always @(posedge clk or posedge rst) begin
    if(!rst) begin
        case(state)
            S0 : begin 
                if(in1==1'b0)  state<=S0;
                else if(in1==1'b1)  state<=S1;
            end
            S1 : begin
                if(in1==1'b0)  state<=S10;
                else if(in1==1'b1)  state<=S1;
            end
            S10 : begin 
                if(in1==1'b0)  state<=S0;
                else if(in1==1'b1)  state<=S101;
            end
            S101 : begin
                if(in1==1'b0)  state<=S10;
                else if(in1==1'b1)  state<=S1011;
            end
            S1011 : begin
                if(in1==1'b0)  state<=S0;
                else if(in1==1'b1)  state<=S1;
            end
        endcase
    end
    else state<=S0;
end
endmodule