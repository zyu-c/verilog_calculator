`define DECIMAL 0
`define OPE 1
`define HALT 2

module calc(decimal, plus, minus, equal, ce, out, sign, overflow, CLK, RST);
    input [9:0]decimal;
    input plus;
    input minus;
    input equal;
    input ce;
    output [6:0] out;
    output sign;
    output overflow;
    input CLK;
    input RST;

    reg [6:0]REGA;
    reg [8:0]REGB;
    reg [1:0]state;
    reg [1:0]count;
    reg add_or_sub;
    reg equal_l;

    wire [3:0]d;

    assign d = dectobin(decimal);
    function [3:0]dectobin;
        input [9:0]in;
        case(in)
            10'b0000000001: dectobin = 0;
            10'b0000000010: dectobin = 1;
            10'b0000000100: dectobin = 2;
            10'b0000001000: dectobin = 3;
            10'b0000010000: dectobin = 4;
            10'b0000100000: dectobin = 5;
            10'b0001000000: dectobin = 6;
            10'b0010000000: dectobin = 7;
            10'b0100000000: dectobin = 8;
            10'b1000000000: dectobin = 9;
        endcase
    endfunction

    assign out = out_func(state, REGA, REGB);
    function [6:0]out_func;
        input [1:0]s;
        input [6:0]a;
        input [8:0]b;
        case(s)
            `DECIMAL: out_func = a;
            `OPE: out_func = (b[8])?(~b+1):b;
        endcase
    endfunction

    assign sign = sign_func(state, REGB[8]);
    function sign_func;
        input [1:0]s;
        input b;
        case(s)
            `DECIMAL: sign_func = 0;
            `OPE: sign_func = b;
        endcase
    endfunction

    assign overflow = (state == `HALT)?1:0;

    always @(posedge CLK or negedge RST)begin
        if(!RST)begin
            REGA <= 0;
            REGB <= 0;
            state <= `DECIMAL;
            count <= 0;
            add_or_sub <= 0;
            equal_l <= 0;
        end else begin
            case(state)
                `DECIMAL: begin
                    if((decimal != 0) && (count < 2)) begin
                        REGA <= 10 * REGA + d;
                        count <= count + 1;
                    end else if(ce)begin
                        REGA <= 0;
                        count <= 0;
                    end else if(plus || minus || equal)begin
                        if(!add_or_sub)begin
                            REGB <= REGA + REGB;
                        end else begin
                            REGB <= REGB - REGA;
                        end
                        if(plus)begin
                            add_or_sub <= 0;
                        end else if(minus)begin
                            add_or_sub <= 1;
                        end else if(equal)begin
                            equal_l <= 1;
                        end
                        state <= `OPE;
                    end
                end

                `OPE: begin
                    if(((REGB[8] == 1) && (REGB < 412)) || ((REGB[8] == 0) && (REGB > 99)))begin
                        state <= `HALT;
                    end else if(decimal)begin
                        REGA <= d;
                        count <= 1;
                        state <= `DECIMAL;
                        if(equal_l)begin
                            REGB <= 0;
                            equal_l <= 0;
                        end
                    end
                end

                `HALT: begin
                    if(ce)begin
                        REGA <= 0;
                        REGB <= 0;
                        state <= `DECIMAL;
                        count <= 0;
                        add_or_sub <= 0;
                        equal_l <= 0;
                    end
                end
            endcase
        end
    end
endmodule
