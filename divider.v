module divider(
	input clk,
	input rst,
	input clk_in0,
	input clk_in1,
	input clk_in2,
	input clk_in3,
	input clk_in4,
	input clk_in5,
	input enable,
	input [2:0] sel,
	input [7:0] counter,
	output reg out_clk);

reg [7:0] counter_inside;
reg sysclk;

always @(*)
begin
    if(enable == 1)
    begin
    	case(sel) 
	    	3'b000: sysclk = clk;
	    	3'b001: sysclk = clk_in0;
	    	3'b010: sysclk = clk_in1;
	    	3'b011: sysclk = clk_in2;
	    	3'b100: sysclk = clk_in3;
	    	3'b101: sysclk = clk_in4;
	    	3'b110: sysclk = clk_in5;
			default: sysclk = clk;
		endcase
    end
    else sysclk = clk;
end

always @(posedge sysclk or negedge rst)
begin
	if(!rst) 
	begin
		counter_inside <= 8'h0;
		out_clk <= 1'b0;
	end
	else if(counter_inside == counter)
	begin
		out_clk <= !out_clk;
		counter_inside <= 1'b0;
	end	
	else begin
		counter_inside <= counter_inside + 1'b1;
	end
end

endmodule