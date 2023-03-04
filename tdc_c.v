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


module tdc_c(
    input enable,
    input clk,
    input rst,
    input [7:0] number_in,
    input [8:0] address,
    output[7:0] number_out
    );

reg [7:0] number_all[499:0];
reg enable_state;
wire start_flag;
reg [1:0] state,next_state;
parameter IDLE = 2'b0;
parameter WORK = 2'b1;
reg [8:0] counter;
reg end_flag;
wire [7:0] number;


always @(posedge clk or negedge rst)
begin
    if(!rst)
        enable_state <= 1'b0;
    else enable_state <= enable;
end

assign  start_flag = enable & (!enable_state);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        next_state <= IDLE;
    end
    else
    case(state)
        IDLE:begin
            if(start_flag) next_state <= WORK;
        end
        WORK:begin
            if(end_flag) next_state <= IDLE;
        end
    endcase
end

always @(next_state)
begin
    state <= next_state;
end

always @(posedge clk)
begin
    case (state)
        IDLE:
        begin
            counter <= 9'h0;
            end_flag <= 1'b0;
        end
        WORK:
        begin
            number_all[counter] <= number_in;
            counter <= counter + 1;
            if(counter == 9'd500)  end_flag <= 1'b1;
            else end_flag <= 1'b0;
        end
    endcase
end

assign number_out = number_all[address];



endmodule
