module DFF(CLK,D,Q);
    input CLK,D;
    output reg Q;
    always@(posedge CLK)
        Q <= D;
endmodule
