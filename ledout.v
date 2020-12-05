module ledout(in, out);
    input [3:0]in;
    output [6:0]out;

    assign out = convert(in);
    function [6:0]convert;
        input [3:0]in;
        case(in)
            0: convert = 7'b1111110;
            1: convert = 7'b0110000;
            2: convert = 7'b1101101;
            3: convert = 7'b1111001;
            4: convert = 7'b0110011;
            5: convert = 7'b1011011;
            6: convert = 7'b1011111;
            7: convert = 7'b1110000;
            8: convert = 7'b1111111;
            9: convert = 7'b1111011;
            10: convert = 7'b1110111;
            11: convert = 7'b0011111;
            12: convert = 7'b0001101;
            13: convert = 7'b0111101;
            14: convert = 7'b1001111;
            15: convert = 7'b1000111;
        endcase
    endfunction
endmodule
