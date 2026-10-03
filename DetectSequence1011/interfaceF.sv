interface intf(input clk);

    logic in1,rst,op;

    clocking cb_drv@(posedge clk);
        default input #2 output #1;
        output in1; // Asynchronous with rst
    endclocking

    clocking cb_mon@(posedge clk);
        default input #2 output #1;
        input in1,rst,op;
    endclocking

    modport mp_drv(clocking cb_drv,output rst);
    modport mp_mon(clocking cb_mon);

endinterface