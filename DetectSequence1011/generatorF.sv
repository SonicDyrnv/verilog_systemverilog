parameter repeat_C=10+1; // How many testcases? That +1 is for initial reset.

class generator;
    
    mailbox #(transection) gen2drv;
    transection trans;

    function new(mailbox #(transection) gen2drv);
        this.gen2drv=gen2drv;
    endfunction

    function disp(transection trans);
        $display("in1 : %0b, rst : %0b", trans.in1,trans.rst);
    endfunction

    task main();
    trans=new();
        trans.rst=1;
        trans.in1=0;
        gen2drv.put(trans);
        repeat(repeat_C-1) begin
            trans=new();
            trans.randomize();
            this.disp(trans);
            gen2drv.put(trans);
        end
    endtask

endclass
