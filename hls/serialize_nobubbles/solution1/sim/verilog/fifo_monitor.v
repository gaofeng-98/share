///////////////////////////////////////////////////////////////////////////
// This module is used to monitor fifo max depth and I/O block states
// it will dump these infomation into a json file after simualtion finished
// it will also record the total latency of all transactions in the same file
///////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module fifo_monitor(
input wire clk,
input wire rst,
input wire [31:0] lat_total,
input wire finish
);

function [3:0] fifo_scenario;
    input [63:0] pair_mem[65535:0];
    input [15:0] pair_cnt;
    input is_single_chan;
    reg [15:0] pair_idx;
    reg [1:0] pair_tmp;
    reg [15:0] p00_cnt;
    reg [15:0] p01_cnt;
    reg [15:0] p10_cnt;
    reg [15:0] p11_cnt;
    real p00_percent;
    real p01_percent;
    real p10_percent;
    real p11_percent;
begin
    pair_idx = 16'h0;
    p00_cnt = 16'h0;
    p01_cnt = 16'h0;
    p10_cnt = 16'h0;
    p11_cnt = 16'h0;
    while (pair_idx < pair_cnt) begin
        pair_tmp = {pair_mem[pair_idx][63],pair_mem[pair_idx][31]};
        case(pair_tmp)
            2'b00 : p00_cnt = p00_cnt + 16'h1;
            2'b01 : p01_cnt = p01_cnt + 16'h1;
            2'b10 : p10_cnt = p10_cnt + 16'h1;
            2'b11 : p11_cnt = p11_cnt + 16'h1;
            default: $display("fifo pair has unknown value.");
        endcase
        pair_idx = pair_idx + 16'h1;
    end
    p00_percent = p00_cnt * 1.0 / pair_cnt;
    p01_percent = p01_cnt * 1.0 / pair_cnt;
    p10_percent = p10_cnt * 1.0 / pair_cnt;
    p11_percent = p11_cnt * 1.0 / pair_cnt;
    if (p00_percent == 1.0)
        fifo_scenario = 5;
    else if (p10_percent + p00_percent == 1.0 && is_single_chan == 1'b1) 
        fifo_scenario = 6;
    else if (p10_percent + p00_percent == 1.0)
        fifo_scenario = 4;
    else if (p01_percent > 0.5)
        fifo_scenario = 3;
    else if (p11_percent > 0.5)
        fifo_scenario = 1;
    else if (p10_percent + p01_percent > 0.5)
        fifo_scenario = 2;
    else
        fifo_scenario = 0;
end
endfunction

reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_rd_blocked;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_wr_blocked;
reg [31:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth;
reg [31:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_max_depth;
always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_wr_blocked <= 1'b0;
    else ;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_rd_blocked <= 1'b0;
    else ;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth <= 32'h0;
    else if (AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_write == 1'b1 && AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_read == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth;
    else if (AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_write == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth + 32'h1;
    else if (AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_read == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth - 32'h1;
    else ;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_max_depth <= 32'h0;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_max_depth)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_max_depth <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth;
    else ;
end

reg [31:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d;
always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d <= 32'h0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth;
end
reg [31:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_2d;
always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_2d <= 32'h0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_2d <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d;
end

reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process;

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process <= 1'b0;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process <= 1'b1;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process <= 1'b0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process <= 1'b0;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d == AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth) || 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth && AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process == 1'b1) || 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth && AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process == 1'b1)) 
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process <= 1'b1;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process <= 1'b0;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process <= 1'b0;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process <= 1'b1;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process <= 1'b0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process;
end

reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding;

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding <= 1'b1;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding <= 1'b1;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding <= 1'b0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding <= 1'b0;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding <= 1'b1;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding <= 1'b0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding;
end

reg [63:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[65535:0];
reg [16:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt;
reg [30:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_block_status_candidate;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid;
reg [30:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid;
reg [3:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_scr;
reg AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_process_done;

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid <= 1'b0;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding == 1'b1))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid <= 1'b1;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid <= 1'b0;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate <= 31'h0;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth) && 
             (((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding == 1'b1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process == 1'b1)) || 
              ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding == 1'b1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process == 1'b1)))) 
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate <= 31'h0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_block_status_candidate <= 1'b0;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_block_status_candidate <= 1'b0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_block_status_candidate <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_block_status_candidate;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid <= 1'b0;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_raising_process == 1'b1) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth) && 
             (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding == 1'b1))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid <= 1'b1;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid <= 1'b0;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate <= 31'h0;
    else if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_depth_1d > AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth) && 
             (((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_finding == 1'b1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process == 1'b1)) ||
              ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_finding == 1'b1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_shaking_process == 1'b1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_falling_process == 1'b1))))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_runtime_depth;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate <= 31'h0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate;
end

always @(posedge clk)
begin
    if (rst == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate <= 1'b0;
    else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid == 1'b1)
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate <= 1'b0;
    else
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate <= AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate;
end

initial begin : AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_scenario_judge
reg [15:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_idx = 0;
reg [63:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_tmp = 64'h0;
reg [1:0] AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_info = 2'h0;
    AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt = 16'h0;
    AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_process_done = 1'b0;
    wait(rst == 1'b0);
    @(posedge clk);
    while(finish == 1'b0) begin
        if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_valid == 1'b1)
            AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt] = {AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_block_status_candidate,
                                                              AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_peak_depth_candidate,
                                                              32'h0};
        else if (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_valid == 1'b1) begin
            AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_tmp = AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt];
            AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt] = {AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_tmp[63:32],
                                                              AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate,
                                                              AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate};
            AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt = AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt + 16'h1;
        end
        @(posedge clk);
    end
    
    if ((AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_max_depth == 32'h1) && (AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt == 16'h0))
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt] = {AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_wr_blocked,
                                                          31'h1,
                                                          AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_rd_blocked,
                                                          31'h0};
    else begin
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_tmp = AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt];
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem[AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt] = {AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_tmp[63:32],
                                                          AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_block_status_candidate,
                                                          AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_valley_depth_candidate};
    end
    AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt = AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt + 16'h1;
    while(AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_idx < AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt) begin
        AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_idx = AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_idx + 16'h1;
    end
    AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_scr = fifo_scenario(AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_mem,AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_pair_cnt,1'b1);
    AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_process_done = 1'b1;
end


wire all_fifo_process_done;
assign all_fifo_process_done = 1'b1 && AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_process_done;
initial begin : profile_dump
    integer fp;
    wait(finish == 1'b1);
    wait(all_fifo_process_done == 1'b1);
    fp = $fopen("fifo_sizing_current.json","w");
    $fdisplay(fp,"{");
    $fdisplay(fp,"\"fifo_info\" : [");
    $fdisplay(fp,"{\"inst\" : \"AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U\", \"depth\" : %0d, \"input_block\" : %0d, \"output_block\" : %0d, \"work_scenario\" : %0d, \"chan_type\" : %0d},",AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_max_depth,AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_wr_blocked,AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_rd_blocked,AESL_inst_MultipleToSerial_tmp_elements_num_loc_channel_U_scr,1);
    $fdisplay(fp,"],");
    $fdisplay(fp,"\"lat_total\" : %0d",lat_total);
    $fdisplay(fp,"}");
    $fclose(fp);
end
endmodule
