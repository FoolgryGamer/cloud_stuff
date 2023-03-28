module vector
#(parameter size=32)
(
    input clk,
    input [size-1:0] A,
    input [size-1:0] B,
    input [1:0] mod,
    output reg [size-1:0] out
);

always@(posedge clk) begin
    case (mod)
        2'b00: out <= A + B;
        2'b01: out <= A - B;
        2'b10: out <= B;
        2'b11: out <= A;
        default: out <= A;
    endcase
    
end

endmodule