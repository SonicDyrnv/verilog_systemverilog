class driver;

    virtual intf.mp_drv vif;
    mailbox #(transection) gen2drv;
    mailbox #(transection) drv2rm;
    transection trans;

    function new(virtual intf.mp_drv vif, mailbox #(transection) gen2drv, mailbox #(transection) drv2rm);
        this.vif=vif;
        this.gen2drv=gen2drv;
        this.drv2rm=drv2rm;
    endfunction

    function disp(transection trans);
        $display("DRIVER : in1 = %0b, rst = %0b", trans.in1,trans.rst);
    endfunction

    task main();
        repeat(repeat_C) begin
            trans=new();
            gen2drv.get(trans);
            @(vif.cb_drv);
            drv2rm.put(trans);
            vif.cb_drv.in1<=trans.in1; // Note that wherever you want to use cb you still need to use name.
            vif.rst<=trans.rst;
            this.disp(trans);
        end
    endtask

endclass    