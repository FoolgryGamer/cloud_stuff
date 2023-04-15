`timescale  1ns / 1ps

module tb_sdp_ram_top;

// sdp_ram_top Parameters
parameter PERIOD      = 10               ;
parameter DATA_WIDTH  = 72               ;
parameter DATA_DEPTH  = 4096             ;

// sdp_ram_top Inputs
reg   rst_n                                = 0 ;
reg   clk                                  = 0 ;

// sdp_ram_top Outputs
wire  [DATA_WIDTH - 1 : 0]  doutb          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

sdp_ram_top #(
    .DATA_WIDTH ( DATA_WIDTH ),
    .DATA_DEPTH ( DATA_DEPTH )
)
u_sdp_ram_top (
    .rst_n                   ( rst_n ),
    .clk                     ( clk   ),

    .doutb                   ( doutb )
);

endmodule

