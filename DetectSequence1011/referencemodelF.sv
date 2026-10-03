class referenceModel;

    mailbox #(transection) drv2rm;
    mailbox #(transection) rm2sb;
    transection transback, transrm;
    logic [3:0]store;
    bit prev_op;

    function new(mailbox #(transection) drv2rm, mailbox #(transection) rm2sb);
        this.drv2rm=drv2rm;
        this.rm2sb=rm2sb;
    endfunction

    task main();
        store=4'b0;
        prev_op=1'b0;
        repeat(repeat_C) begin
            drv2rm.get(transrm);
            transback=new transrm; 
            transback.op=prev_op;
            if (transrm.rst) begin
                store=4'b0;
                prev_op=1'b0;
            end else begin
                store= (store == 4'b1011) ? transrm.in1 : {store[2:0], transrm.in1};
                prev_op= (store == 4'b1011) ? 1'b1 : 1'b0;
            end
            rm2sb.put(transback);
        end
    endtask

endclass