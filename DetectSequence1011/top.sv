`timescale 1ns/1ps
`include "envrionmentF.sv" // Never miss this one, from personal experience

module tb;
logic clk;
initial clk=0;
always #10 clk=~clk;

intf vif(clk);

S1011Det dut(vif.in1,vif.clk,vif.rst,vif.op);

environment env;
initial begin
env=new(vif);
env.main();
$finish;
end

endmodule