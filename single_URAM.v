module vector_U(
    input [Size-1:0]        data_in,
    input                   clk,
    input [1:0]             mod,
    input                   en_read,
    input                   rst,
    input [5:0]             host_write_addr,
    input [5:0]             host_read_addr,
    output [Size-1:0]   out_number
);
// addr 0 is empty, please not insert data into this address
parameter Size = 256;

parameter IDLE = 4'b0000, READ_A = 4'b0001,READ_B = 4'b0010,WAIT = 4'b0011,DATA_A = 4'b0100,DATA_B = 4'b0101,FINISH = 4'b0110,WAIT_WRITE = 4'b0111,WRITE_BACK = 4'b1000;

reg [3:0]       state,next_state;
reg [5:0]       addrb;
wire [Size-1:0] data;

assign out_number = data;

always @(posedge clk or negedge rst)
begin
    if(!rst)  state <= IDLE;
    else state <= next_state;
end

always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        next_state <= IDLE;
    end
    else begin
        case (next_state)
            IDLE: begin 
                if (en_read) next_state <= READ_A;
            end 
            READ_A: next_state <= READ_B;
            READ_B: next_state <= WAIT;
            WAIT: next_state <= DATA_A;
            DATA_A: next_state <= DATA_B;
            DATA_B: next_state <= FINISH;
            FINISH: next_state <= WAIT_WRITE;
            WAIT_WRITE: next_state <= IDLE;    
            // WRITE_BACK: next_state <= IDLE;
            default: next_state <= IDLE;    
        endcase
    end
end

reg [Size-1:0] data_A,data_B;

always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        data_A <= 0;
        data_B <= 0;
    end
    else begin
        case(next_state)
            DATA_A: data_A <= data;
            DATA_B: data_B <= data;
            default: ;
        endcase
    end
end

always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        addrb <= 0;
        finish <= 0;
    end
    case(next_state)
        IDLE: begin
            addrb <= addrb;
            addr_read <= host_read_addr;
            finish <= 1'b0;
        end
        READ_A: begin 
            addr_read <= addrb + 1;
            addrb <= addrb + 1;
        end
        READ_B: begin
            addr_read <= addrb + 1;
            addrb <= addrb + 1;
        end
        FINISH: begin
            finish <= 1'b1;
            addr_read <= host_read_addr;
        end
        WAIT_WRITE: finish <= 1'b0;
    endcase
end

reg [5:0]       addr_write;
reg [5:0]       addr_read;
reg [Size-1:0]  data_input;
reg             finish;
reg [Size-1:0]  out;

always @(posedge clk)
begin
    if (finish) begin
        addr_write <= 6'b100000 + addrb;
        data_input <= out;
    end
    else begin
        addr_write <= host_write_addr;
        data_input <= data_in;
    end
end

//URAM instance
xpm_memory_sdpram #(
      .ADDR_WIDTH_A(6),               // DECIMAL
      .ADDR_WIDTH_B(6),               // DECIMAL
      .AUTO_SLEEP_TIME(0),            // DECIMAL
      .BYTE_WRITE_WIDTH_A(Size),        // DECIMAL
      .CASCADE_HEIGHT(0),             // DECIMAL
      .CLOCKING_MODE("common_clock"), // String
      .ECC_MODE("no_ecc"),            // String
      .MEMORY_INIT_FILE("none"),      // String
      .MEMORY_INIT_PARAM("0"),        // String
      .MEMORY_OPTIMIZATION("true"),   // String
      .MEMORY_PRIMITIVE("ultra"),      // String
      .MEMORY_SIZE(16384),             // DECIMAL
      .MESSAGE_CONTROL(0),            // DECIMAL
      .READ_DATA_WIDTH_B(Size),         // DECIMAL
      .READ_LATENCY_B(2),             // DECIMAL
      .READ_RESET_VALUE_B("0"),       // String
      .RST_MODE_A("SYNC"),            // String
      .RST_MODE_B("SYNC"),            // String
      .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
      .USE_MEM_INIT(1),               // DECIMAL
      .USE_MEM_INIT_MMI(0),           // DECIMAL
      .WAKEUP_TIME("disable_sleep"),  // String
      .WRITE_DATA_WIDTH_A(Size),        // DECIMAL
      .WRITE_MODE_B("read_first"),     // String
      .WRITE_PROTECT(1)               // DECIMAL
   )
   xpm_memory_sdpram_inst (
      .dbiterrb(),             // 1-bit output: Status signal to indicate double bit error occurrence
                                       // on the data output of port B.

      .doutb(data),                   // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
      .sbiterrb(),             // 1-bit output: Status signal to indicate single bit error occurrence
                                       // on the data output of port B.

      .addra(addr_write),                   // ADDR_WIDTH_A-bit input: Address for port A write operations.
      .addrb(addr_read),                   // ADDR_WIDTH_B-bit input: Address for port B read operations.
      .clka(clk),                     // 1-bit input: Clock signal for port A. Also clocks port B when
                                       // parameter CLOCKING_MODE is "common_clock".

      .clkb(clk),                     // 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                       // "independent_clock". Unused when parameter CLOCKING_MODE is
                                       // "common_clock".

      .dina(data_input),                     // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
      .ena(1'b1),                       // 1-bit input: Memory enable signal for port A. Must be high on clock
                                       // cycles when write operations are initiated. Pipelined internally.

      .enb(1'b1),                       // 1-bit input: Memory enable signal for port B. Must be high on clock
                                       // cycles when read operations are initiated. Pipelined internally.

      .injectdbiterra(1'b0), // 1-bit input: Controls double bit error injection on input data when
                                       // ECC enabled (Error injection capability is not available in
                                       // "decode_only" mode).

      .injectsbiterra(1'b0), // 1-bit input: Controls single bit error injection on input data when
                                       // ECC enabled (Error injection capability is not available in
                                       // "decode_only" mode).

      .regceb(1'b1),                 // 1-bit input: Clock Enable for the last register stage on the output
                                       // data path.

      .rstb(1'b0),                     // 1-bit input: Reset signal for the final port B output register stage.
                                       // Synchronously resets output port doutb to the value specified by
                                       // parameter READ_RESET_VALUE_B.

      .sleep(1'b0),                   // 1-bit input: sleep signal to enable the dynamic power saving feature.
      .wea(1'b1)                        // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                                       // for port A input data port dina. 1 bit wide when word-wide writes are
                                       // used. In byte-wide write configurations, each bit controls the
                                       // writing one byte of dina to address addra. For example, to
                                       // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                                       // is 32, wea would be 4'b0010.

   );

//statement of data, output of URAM

// out signal assignment
always@(posedge clk or negedge rst) begin
    if(!rst) begin
        out <= 0;
    end
    else begin
        case (mod)
            2'b00: out <= data_A + data_B;
            2'b01: out <= data_A - data_B;
            2'b10: out <= data_B;
            2'b11: out <= data_A;
            default: out <= data_A;
        endcase  
    end
end

endmodule