module vector
#(parameter size=3072)
(
    input clk,
    input rst,
    input [size-1:0] A,
    input [size-1:0] B,
    input [1:0] mod,
    output reg [size-1:0] out
);

parameter ADDRWIDTH = 6; //
parameter DATAWIDTH = 72;
parameter NUMBER_URAM = 86;

wire [ADDRWIDTH-1:0] addra;
wire [ADDRWIDTH-1:0] addrb;
wire [DATAWIDTH-1:0] doutb[NUMBER_URAM-1:0];

genvar URAM_i;
generate for(URAM_i=0;S_i<NUMBER_URAM;URAM_i=URAM_i+1)
begin:URAM_generate
    if (URAM_i == 42) begin
        xpm_memory_sdpram #(
        .ADDR_WIDTH_A(ADDRWIDTH),       // DECIMAL
        .ADDR_WIDTH_B(ADDRWIDTH),       // DECIMAL
        .AUTO_SLEEP_TIME(0),            // DECIMAL
        .BYTE_WRITE_WIDTH_A(DATAWIDTH), // DECIMAL
        .CASCADE_HEIGHT(0),             // DECIMAL
        .CLOCKING_MODE("common_clock"), // String
        .ECC_MODE("no_ecc"),            // String
        .MEMORY_INIT_FILE("none"),      // String
        .MEMORY_INIT_PARAM("0"),        // String
        .MEMORY_OPTIMIZATION("true"),   // String
        .MEMORY_PRIMITIVE("ultra"),     // String
        .MEMORY_SIZE(4608),             // DECIMAL
        .MESSAGE_CONTROL(0),            // DECIMAL
        .READ_DATA_WIDTH_B(DATAWIDTH),  // DECIMAL
        .READ_LATENCY_B(2),             // DECIMAL
        .READ_RESET_VALUE_B("0"),       // String
        .RST_MODE_A("SYNC"),            // String
        .RST_MODE_B("SYNC"),            // String
        .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
        .USE_MEM_INIT(1),               // DECIMAL
        .WAKEUP_TIME("disable_sleep"),  // String
        .WRITE_DATA_WIDTH_A(DATAWIDTH), // DECIMAL
        .WRITE_MODE_B("no_change")      // String
        )
        xpm_memory_sdpram_inst (
            .dbiterrb(),             // 1-bit output: Status signal to indicate double bit error occurrence
                                            // on the data output of port B.

            .doutb(doutb[URAM_i]),                   // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
            .sbiterrb(),             // 1-bit output: Status signal to indicate single bit error occurrence
                                            // on the data output of port B.

            .addra(addra),                   // ADDR_WIDTH_A-bit input: Address for port A write operations.
            .addrb(addrb),                   // ADDR_WIDTH_B-bit input: Address for port B read operations.
            .clka(clk),                     // 1-bit input: Clock signal for port A. Also clocks port B when
                                            // parameter CLOCKING_MODE is "common_clock".

            .clkb(clk),                     // 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                            // "independent_clock". Unused when parameter CLOCKING_MODE is
                                            // "common_clock".

            .dina({24'b0,A[3024:3071]}),           // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
            .ena(1'b1),                      // 1-bit input: Memory enable signal for port A. Must be high on clock
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
            .wea()                        // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                                            // for port A input data port dina. 1 bit wide when word-wide writes are
                                            // used. In byte-wide write configurations, each bit controls the
                                            // writing one byte of dina to address addra. For example, to
                                            // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                                            // is 32, wea would be 4'b0010.
        );
    end
    else if(URAM_i == 85) begin
    xpm_memory_sdpram #(
        .ADDR_WIDTH_A(ADDRWIDTH),       // DECIMAL
        .ADDR_WIDTH_B(ADDRWIDTH),       // DECIMAL
        .AUTO_SLEEP_TIME(0),            // DECIMAL
        .BYTE_WRITE_WIDTH_A(DATAWIDTH), // DECIMAL
        .CASCADE_HEIGHT(0),             // DECIMAL
        .CLOCKING_MODE("common_clock"), // String
        .ECC_MODE("no_ecc"),            // String
        .MEMORY_INIT_FILE("none"),      // String
        .MEMORY_INIT_PARAM("0"),        // String
        .MEMORY_OPTIMIZATION("true"),   // String
        .MEMORY_PRIMITIVE("ultra"),     // String
        .MEMORY_SIZE(4608),            // DECIMAL
        .MESSAGE_CONTROL(0),            // DECIMAL
        .READ_DATA_WIDTH_B(DATAWIDTH),  // DECIMAL
        .READ_LATENCY_B(2),             // DECIMAL
        .READ_RESET_VALUE_B("0"),       // String
        .RST_MODE_A("SYNC"),            // String
        .RST_MODE_B("SYNC"),            // String
        .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
        .USE_MEM_INIT(1),               // DECIMAL
        .WAKEUP_TIME("disable_sleep"),  // String
        .WRITE_DATA_WIDTH_A(DATAWIDTH), // DECIMAL
        .WRITE_MODE_B("no_change")      // String
    )
    xpm_memory_sdpram_inst (
        .dbiterrb(),             // 1-bit output: Status signal to indicate double bit error occurrence
                                        // on the data output of port B.

        .doutb(doutb[URAM_i]),                   // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
        .sbiterrb(),             // 1-bit output: Status signal to indicate single bit error occurrence
                                        // on the data output of port B.

        .addra(addra),                   // ADDR_WIDTH_A-bit input: Address for port A write operations.
        .addrb(addrb),                   // ADDR_WIDTH_B-bit input: Address for port B read operations.
        .clka(clk),                     // 1-bit input: Clock signal for port A. Also clocks port B when
                                        // parameter CLOCKING_MODE is "common_clock".

        .clkb(clk),                     // 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                        // "independent_clock". Unused when parameter CLOCKING_MODE is
                                        // "common_clock".

        .dina({24'b0,B[3024:3071]}),           // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
        .ena(1'b1),                      // 1-bit input: Memory enable signal for port A. Must be high on clock
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
        .wea()                        // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                                        // for port A input data port dina. 1 bit wide when word-wide writes are
                                        // used. In byte-wide write configurations, each bit controls the
                                        // writing one byte of dina to address addra. For example, to
                                        // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                                        // is 32, wea would be 4'b0010.

    );
    end
    else if(URAM_i < 42)begin
    xpm_memory_sdpram #(
        .ADDR_WIDTH_A(ADDRWIDTH),       // DECIMAL
        .ADDR_WIDTH_B(ADDRWIDTH),       // DECIMAL
        .AUTO_SLEEP_TIME(0),            // DECIMAL
        .BYTE_WRITE_WIDTH_A(DATAWIDTH), // DECIMAL
        .CASCADE_HEIGHT(0),             // DECIMAL
        .CLOCKING_MODE("common_clock"), // String
        .ECC_MODE("no_ecc"),            // String
        .MEMORY_INIT_FILE("none"),      // String
        .MEMORY_INIT_PARAM("0"),        // String
        .MEMORY_OPTIMIZATION("true"),   // String
        .MEMORY_PRIMITIVE("ultra"),     // String
        .MEMORY_SIZE(4608),            // DECIMAL
        .MESSAGE_CONTROL(0),            // DECIMAL
        .READ_DATA_WIDTH_B(DATAWIDTH),  // DECIMAL
        .READ_LATENCY_B(2),             // DECIMAL
        .READ_RESET_VALUE_B("0"),       // String
        .RST_MODE_A("SYNC"),            // String
        .RST_MODE_B("SYNC"),            // String
        .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
        .USE_MEM_INIT(1),               // DECIMAL
        .WAKEUP_TIME("disable_sleep"),  // String
        .WRITE_DATA_WIDTH_A(DATAWIDTH), // DECIMAL
        .WRITE_MODE_B("no_change")      // String
    )
    xpm_memory_sdpram_inst (
        .dbiterrb(),             // 1-bit output: Status signal to indicate double bit error occurrence
                                        // on the data output of port B.

        .doutb(doutb[URAM_i]),                   // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
        .sbiterrb(),             // 1-bit output: Status signal to indicate single bit error occurrence
                                        // on the data output of port B.

        .addra(addra),                   // ADDR_WIDTH_A-bit input: Address for port A write operations.
        .addrb(addrb),                   // ADDR_WIDTH_B-bit input: Address for port B read operations.
        .clka(clk),                     // 1-bit input: Clock signal for port A. Also clocks port B when
                                        // parameter CLOCKING_MODE is "common_clock".

        .clkb(clk),                     // 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                        // "independent_clock". Unused when parameter CLOCKING_MODE is
                                        // "common_clock".

        .dina(A[(URAM_i*DATAWIDTH)+:DATAWIDTH]),           // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
        .ena(1'b1),                      // 1-bit input: Memory enable signal for port A. Must be high on clock
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
        .wea()                        // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                                        // for port A input data port dina. 1 bit wide when word-wide writes are
                                        // used. In byte-wide write configurations, each bit controls the
                                        // writing one byte of dina to address addra. For example, to
                                        // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                                        // is 32, wea would be 4'b0010.

    );
    end
    else begin
    xpm_memory_sdpram #(
        .ADDR_WIDTH_A(ADDRWIDTH),       // DECIMAL
        .ADDR_WIDTH_B(ADDRWIDTH),       // DECIMAL
        .AUTO_SLEEP_TIME(0),            // DECIMAL
        .BYTE_WRITE_WIDTH_A(DATAWIDTH), // DECIMAL
        .CASCADE_HEIGHT(0),             // DECIMAL
        .CLOCKING_MODE("common_clock"), // String
        .ECC_MODE("no_ecc"),            // String
        .MEMORY_INIT_FILE("none"),      // String
        .MEMORY_INIT_PARAM("0"),        // String
        .MEMORY_OPTIMIZATION("true"),   // String
        .MEMORY_PRIMITIVE("ultra"),     // String
        .MEMORY_SIZE(4608),            // DECIMAL
        .MESSAGE_CONTROL(0),            // DECIMAL
        .READ_DATA_WIDTH_B(DATAWIDTH),  // DECIMAL
        .READ_LATENCY_B(2),             // DECIMAL
        .READ_RESET_VALUE_B("0"),       // String
        .RST_MODE_A("SYNC"),            // String
        .RST_MODE_B("SYNC"),            // String
        .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
        .USE_MEM_INIT(1),               // DECIMAL
        .WAKEUP_TIME("disable_sleep"),  // String
        .WRITE_DATA_WIDTH_A(DATAWIDTH), // DECIMAL
        .WRITE_MODE_B("no_change")      // String
    )
    xpm_memory_sdpram_inst (
        .dbiterrb(),             // 1-bit output: Status signal to indicate double bit error occurrence
                                        // on the data output of port B.

        .doutb(doutb[URAM_i]),                   // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
        .sbiterrb(),             // 1-bit output: Status signal to indicate single bit error occurrence
                                        // on the data output of port B.

        .addra(addra),                   // ADDR_WIDTH_A-bit input: Address for port A write operations.
        .addrb(addrb),                   // ADDR_WIDTH_B-bit input: Address for port B read operations.
        .clka(clk),                     // 1-bit input: Clock signal for port A. Also clocks port B when
                                        // parameter CLOCKING_MODE is "common_clock".

        .clkb(clk),                     // 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                        // "independent_clock". Unused when parameter CLOCKING_MODE is
                                        // "common_clock".

        .dina(A[((URAM_i-43)*DATAWIDTH)+:DATAWIDTH]),           // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
        .ena(1'b1),                      // 1-bit input: Memory enable signal for port A. Must be high on clock
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
        .wea()                        // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                                        // for port A input data port dina. 1 bit wide when word-wide writes are
                                        // used. In byte-wide write configurations, each bit controls the
                                        // writing one byte of dina to address addra. For example, to
                                        // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                                        // is 32, wea would be 4'b0010.
    );
    end
end
endgenerate
wire [3:0] counter;
always@(posedge clk) begin
    if(!rst) counter <= 0;
    else if (counter == 12) begin
        counter <= 0;
    end
    else begin
        counter <= counter + 1;
    end
end

always@(posedge clk) begin
    if(!rst) begin
        addra <= 0;
        addrb <= 0;
    end
    if(counter == 10) begin
        addra <= 6'b100000;
        addrb <= 6'b100000;
    end
    else if (counter == 12) begin
        addra <= 0;
        addrb <= 0;
    end
end


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