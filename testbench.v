`timescale 1ns / 1ns
module testbench;
    reg CLK;
    reg RST;
    reg [9:0]push;
    reg plus;
    reg minus;
    reg equal;
    reg ce;
    wire [6:0]ledh;
    wire [6:0]ledl;
    wire sign;
    wire overflow;

    calctop calctop(.push(push), .plus(plus), .minus(minus), .equal(equal), .ce(ce), .ledh(ledh), .ledl(ledl), .overflow(overflow), .sign(sign), .CLK(CLK), .RST(RST));
    
    always begin
        CLK = 1;
        #50	CLK = 0;
        #50;
	end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
        RST = 0;
        push = 10'b1111111111;
        plus = 1;
        minus = 1;
        equal=1;
        ce = 1;
        #50 RST = 1;
        #50
        #500 push = 10'b1111111101;     //1
        #500 push = 10'b1111111111;
        #500 plus = 0;                  //+
        #500 plus = 1;
        #500 push = 10'b1111111101;     //1
        #500 push = 10'b1111111111;
        #500 equal = 0;                 //=
        #500 equal = 1;
        #(2e4) $finish;
    end
endmodule
