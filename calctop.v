module calctop(push, plus, minus, equal, ce, ledh, ledl, sign, overflow, CLK, RST);
    defparam syncro0.WIDTH = 10;
    defparam syncro1.WIDTH = 1;
    defparam syncro2.WIDTH = 1;
    defparam syncro3.WIDTH = 1;
    defparam syncro4.WIDTH = 1;
    
    input [9:0]push;
    input plus;
    input minus;
    input equal;
    input ce;
    output [6:0]ledh;
    output [6:0]ledl;
    output sign;
    output overflow;
    input CLK;
    input RST;

    wire [9:0]push_out;
    wire plus_out;
    wire minus_out;
    wire equal_out;
    wire ce_out;
    wire [6:0]out;

    syncro syncro0(.in(push), .out(push_out), .CLK(CLK), .RST(RST));
    syncro syncro1(.in(plus), .out(plus_out), .CLK(CLK), .RST(RST));
    syncro syncro2(.in(minus), .out(minus_out), .CLK(CLK), .RST(RST));
    syncro syncro3(.in(equal), .out(equal_out), .CLK(CLK), .RST(RST));
    syncro syncro4(.in(ce), .out(ce_out), .CLK(CLK), .RST(RST));
    binled binled0(.in(out), .ledh(ledh), .ledl(ledl));
    calc calc0(.decimal(push_out), .plus(plus_out), .minus(minus_out), .equal(equal_out), .ce(ce_out), .out(out), .sign(sign), .overflow(overflow), .CLK(CLK), .RST(RST));
endmodule
