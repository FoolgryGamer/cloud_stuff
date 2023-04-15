`timescale 1ns / 1ps

module ram_ctrl
#(
   parameter DATA_WIDTH = 72    ,
   parameter DATA_DEPTH = 4096
)
(
    output  reg  [DATA_WIDTH         - 1 : 0]  dina    ,
    output  reg  [$clog2(DATA_DEPTH) - 1 : 0]  addra   ,
    output  reg  [$clog2(DATA_DEPTH) - 1 : 0]  addrb   ,
    output                                     wea     ,
    input                                      rst_n   ,
    input                                      clk
    );

    assign wea = 1'b1;

    //输入地址
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            addra <= 'd0;
        end
        else begin
            addra <= addra + 'd1;
        end
    end

    //输入数据
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            dina <= 'd0;
        end
        else begin
            dina <= dina +'b1;
        end
    end

    //输出地址
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            addrb <= 'd0;
        end
        else begin
            addrb <= addra;
        end
    end

endmodule