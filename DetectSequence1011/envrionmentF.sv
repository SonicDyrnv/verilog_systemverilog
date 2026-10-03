`include "transectionF.sv" 
`include "interfaceF.sv"
`include "generatorF.sv"
`include "driverF.sv"
`include "monitorF.sv"
`include "referencemodelF.sv"
`include "scoreboardF.sv"
// Note that `include you can assume like you copied and pasted whole code so you can work with defining parameter one time only.
// Context=> How many time I want to randomize?
// Yes, remember you need to include this one also otherwise how will computor know what is transection?

class environment;

    mailbox #(transection) gen2drv,drv2rm,mon2sb,rm2sb;
    virtual intf vif;
    driver drv;
    monitor mon;
    referenceModel rm;
    scoreboard sb;
    generator gen;

    function new(virtual intf vif);
        this.vif=vif;
        gen2drv=new();
        drv2rm=new();
        mon2sb=new();
        rm2sb=new();
        gen=new(gen2drv);
        drv=new(vif.mp_drv, gen2drv, drv2rm);
        mon=new(vif.mp_mon, mon2sb);
        rm=new(drv2rm,rm2sb);
        // rm=new(vif,drv2rm,rm2sb);
        sb=new(rm2sb,mon2sb);
    endfunction

    task main();
        fork
            gen.main();
            drv.main();
            mon.main();
            rm.main();
            sb.main();
        join
    endtask

endclass