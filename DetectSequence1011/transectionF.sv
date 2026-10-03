class transection;

    rand bit in1;
    rand bit rst;
    bit op;
    constraint reset_C {
        rst dist {0:=99, 1:=1};
    }

endclass