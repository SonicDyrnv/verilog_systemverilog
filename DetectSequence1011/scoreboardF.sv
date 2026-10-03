class scoreboard;

    mailbox #(transection) rm2sb;
    mailbox #(transection) mon2sb;
    transection transrm,transmon;
	int counterF=0;	
    int counterP=0;
  
    function new(mailbox #(transection) rm2sb, mailbox #(transection) mon2sb);
        this.rm2sb=rm2sb;
        this.mon2sb=mon2sb;
    endfunction

    task main();
        repeat(repeat_C) begin
            rm2sb.get(transrm);
            mon2sb.get(transmon);
            $display("MON : in=%0b, op = %0b", transrm.in1,transrm.op);
            $display("MON : in=%0b, op = %0b", transmon.in1,transmon.op);
            // if(transrm==transmon) $display("PASS"); // In scoreboard you never compare such objects, you need to compare values.
            if(transrm.op==transmon.op) begin $display("PASS"); counterP=counterP+1; end
          	else begin $display("FAIL"); counterF=counterF+1; end
        end

        $display("No of FAILs : %0d",counterF);
        $display("No of PASSs : %0d",counterP);
    
    endtask

endclass    