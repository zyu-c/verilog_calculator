module binled(in, ledh, ledl);
    input [6:0]in;
    output [6:0]ledh;
    output [6:0]ledl;

    wire [3:0]h;
    wire [3:0]l;

    bintobcd bintobcd0(.in(in), .outh(h), .outl(l));
    ledout ledout0(.in(h), .out(ledh));
    ledout ledout1(.in(l), .out(ledl));
endmodule
