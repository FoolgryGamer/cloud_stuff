`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/09 14:47:30
// Design Name: 
// Module Name: tdc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tdc(
    input hit,
    input clk,
    input [7:0] seed,
    output[7:0] number,
    output outclk0,
    output outclk1,
    output outclk2,
    output outclk3,
    output outclk4,
    output outclk5
    );

(* dont_touch = "TRUE" *) wire [255:0] ff_d;
(* dont_touch = "TRUE" *) wire [255:0] carry_chain_out;
reg [2:0] inter_value;
genvar i;
generate for(i = 0;i <= 255;i=i+1)
    begin :generate_carry_chain
        if(i == 0)
        begin
        (* dont_touch = "TRUE" *) CARRY4  u1( .CO({carry_chain_out[i],3'b000}),
                    .CI(hit),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S(4'b1111));
        end
        else
        begin
        (* dont_touch = "TRUE" *) CARRY4  u1( .CO({carry_chain_out[i],3'b000}),
                    .CI(carry_chain_out[i-1]),
                    .CYINIT(1'b0),
                    .DI(4'b0000),
                    .S(4'b1111));
        end
    end
endgenerate

generate for(i = 0;i < 255;i = i+1)
    begin :generate_ff
        (* dont_touch = "TRUE" *) DFF dff0(.CLK(clk),.D(carry_chain_out[i]),.Q(ff_d[i]));
    end
endgenerate

Decoder inst_decode(.data_in(ff_d),.data_out(number));

always @(posedge clk)
begin
    inter_value <= number[2:0] ^ number[5:3] ^ {1'b0,number[7:6]};
end

assign outclk0 = carry_chain_out[{5'b0,inter_value}];
assign outclk1 = carry_chain_out[{4'b0,inter_value,1'b0}];
assign outclk2 = carry_chain_out[{3'b0,inter_value,2'b0}];
assign outclk3 = carry_chain_out[{2'b0,inter_value,3'b0}];
assign outclk4 = carry_chain_out[{1'b0,inter_value,4'b0}];
assign outclk5 = carry_chain_out[seed];
endmodule
