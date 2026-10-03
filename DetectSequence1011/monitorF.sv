class monitor;

    virtual intf.mp_mon vif;
    mailbox #(transection) mon2sb;
    transection transback;

    function new(virtual intf.mp_mon vif,mailbox #(transection) mon2sb);
        this.vif=vif;
        this.mon2sb=mon2sb;
    endfunction

    function disp(transection transback);
        $display("MONITOR : in1=%0b, rst=%0b, op=%0b", transback.in1,transback.rst,transback.op);
    endfunction

    task main();
        @(vif.cb_mon) // This one extra delay is bcz I want to give one delay otherwise it will sample even before 1st input.
        repeat(repeat_C) begin
            @(vif.cb_mon);
            transback=new();
            transback.in1=vif.cb_mon.in1; // Similarly as driver here also you need to use clocking block to access through
            transback.rst=vif.cb_mon.rst; // Similarly as driver here also you need to use clocking block to access through
            transback.op=vif.cb_mon.op; // Similarly as driver here also you need to use clocking block to access through
            mon2sb.put(transback);
            this.disp(transback);
        end
    endtask

endclass