
`include "dump_file_agent.svh"
`include "csv_file_dump.svh"
`include "sample_agent.svh"
`include "loop_sample_agent.svh"
`include "sample_manager.svh"
`include "nodf_module_interface.svh"
`include "nodf_module_monitor.svh"
`include "df_fifo_interface.svh"
`include "df_fifo_monitor.svh"
`include "df_process_interface.svh"
`include "df_process_monitor.svh"
`include "pp_loop_interface.svh"
`include "pp_loop_monitor.svh"
`timescale 1ns/1ps

// top module for dataflow related monitors
module dataflow_monitor(
input logic clock,
input logic reset,
input logic finish
);

    df_fifo_intf fifo_intf_1(clock,reset);
    assign fifo_intf_1.rd_en = AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_read & AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_empty_n;
    assign fifo_intf_1.wr_en = AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_write & AESL_inst_MultipleToSerial.tmp_elements_num_loc_channel_U.if_full_n;
    assign fifo_intf_1.fifo_rd_block = 0;
    assign fifo_intf_1.fifo_wr_block = 0;
    assign fifo_intf_1.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump fifo_csv_dumper_1;
    csv_file_dump cstatus_csv_dumper_1;
    df_fifo_monitor fifo_monitor_1;

logic region_0_idle;
logic [31:0] region_0_start_cnt;
logic [31:0] region_0_done_cnt;
assign region_0_idle = (region_0_start_cnt == region_0_done_cnt) && AESL_inst_MultipleToSerial.ap_start == 1'b0 ;
always @(posedge clock) begin
    if (reset == 1'b1)
        region_0_start_cnt <= 32'h0;
    else if (AESL_inst_MultipleToSerial.ap_start == 1'b1 && AESL_inst_MultipleToSerial.ap_ready == 1'b1)
        region_0_start_cnt <= region_0_start_cnt + 32'h1;
    else;
end
always @(posedge clock) begin
    if (reset == 1'b1)
        region_0_done_cnt <= 32'h0;
    else if (AESL_inst_MultipleToSerial.ap_done == 1'b1)
        region_0_done_cnt <= region_0_done_cnt + 32'h1;
    else;
end


    df_process_intf process_intf_1(clock,reset);
    assign process_intf_1.ap_start = AESL_inst_MultipleToSerial.Block_entry4_proc2_U0.ap_start;
    assign process_intf_1.ap_ready = AESL_inst_MultipleToSerial.Block_entry4_proc2_U0.ap_ready;
    assign process_intf_1.ap_done = AESL_inst_MultipleToSerial.Block_entry4_proc2_U0.ap_done;
    assign process_intf_1.ap_continue = AESL_inst_MultipleToSerial.Block_entry4_proc2_U0.ap_continue;
    assign process_intf_1.real_start = AESL_inst_MultipleToSerial.Block_entry4_proc2_U0.ap_start;
    assign process_intf_1.pin_stall = 1'b0;
    assign process_intf_1.pout_stall = 1'b0;
    assign process_intf_1.cin_stall = 1'b0;
    assign process_intf_1.cout_stall = 1'b0 | ~AESL_inst_MultipleToSerial.tmp_elements_U.i_full_n;
    assign process_intf_1.region_idle = region_0_idle;
    assign process_intf_1.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump pstall_csv_dumper_1;
    csv_file_dump pstatus_csv_dumper_1;
    df_process_monitor process_monitor_1;
    df_process_intf process_intf_2(clock,reset);
    assign process_intf_2.ap_start = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_start;
    assign process_intf_2.ap_ready = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_ready;
    assign process_intf_2.ap_done = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_done;
    assign process_intf_2.ap_continue = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_continue;
    assign process_intf_2.real_start = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_start;
    assign process_intf_2.pin_stall = 1'b0;
    assign process_intf_2.pout_stall = 1'b0;
    assign process_intf_2.cin_stall = 1'b0 | ~AESL_inst_MultipleToSerial.tmp_elements_U.t_empty_n;
    assign process_intf_2.cout_stall = 1'b0;
    assign process_intf_2.region_idle = region_0_idle;
    assign process_intf_2.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump pstall_csv_dumper_2;
    csv_file_dump pstatus_csv_dumper_2;
    df_process_monitor process_monitor_2;

    nodf_module_intf module_intf_1(clock,reset);
    assign module_intf_1.ap_start = AESL_inst_MultipleToSerial.ap_start;
    assign module_intf_1.ap_ready = AESL_inst_MultipleToSerial.ap_ready;
    assign module_intf_1.ap_done = AESL_inst_MultipleToSerial.ap_done;
    assign module_intf_1.ap_continue = 1'b1;
    assign module_intf_1.finish = finish;
    csv_file_dump mstatus_csv_dumper_1;
    nodf_module_monitor module_monitor_1;

    pp_loop_intf #(3) pp_loop_intf_1(clock,reset);
    assign pp_loop_intf_1.pre_loop_state0 = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_ST_fsm_state1;
    assign pp_loop_intf_1.pre_states_valid = 1'b1;
    assign pp_loop_intf_1.post_loop_state0 = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_ST_fsm_state5;
    assign pp_loop_intf_1.post_states_valid = 1'b1;
    assign pp_loop_intf_1.iter_start_state = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_ST_fsm_pp0_stage0;
    assign pp_loop_intf_1.iter_start_enable = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_enable_reg_pp0_iter0;
    assign pp_loop_intf_1.iter_start_block = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_block_pp0_stage0_subdone;
    assign pp_loop_intf_1.iter_end_state = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_ST_fsm_pp0_stage0;
    assign pp_loop_intf_1.iter_end_enable = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_enable_reg_pp0_iter2;
    assign pp_loop_intf_1.iter_end_block = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_block_pp0_stage0_subdone;
    assign pp_loop_intf_1.loop_quit_state = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_ST_fsm_pp0_stage0;
    assign pp_loop_intf_1.quit_at_end = 1'b1;
    assign pp_loop_intf_1.cur_state = AESL_inst_MultipleToSerial.Loop_VITIS_LOOP_16_1_proc_U0.ap_CS_fsm;
    assign pp_loop_intf_1.finish = finish;
    csv_file_dump pp_loop_csv_dumper_1;
    pp_loop_monitor #(3) pp_loop_monitor_1;

    sample_manager sample_manager_inst;

initial begin
    sample_manager_inst = new;

    fifo_csv_dumper_1 = new("./depth1.csv");
    cstatus_csv_dumper_1 = new("./chan_status1.csv");
    fifo_monitor_1 = new(fifo_csv_dumper_1,fifo_intf_1,cstatus_csv_dumper_1);

    pstall_csv_dumper_1 = new("./stalling1.csv");
    pstatus_csv_dumper_1 = new("./status1.csv");
    process_monitor_1 = new(pstall_csv_dumper_1,process_intf_1,pstatus_csv_dumper_1);
    pstall_csv_dumper_2 = new("./stalling2.csv");
    pstatus_csv_dumper_2 = new("./status2.csv");
    process_monitor_2 = new(pstall_csv_dumper_2,process_intf_2,pstatus_csv_dumper_2);

    mstatus_csv_dumper_1 = new("./module_status1.csv");
    module_monitor_1 = new(module_intf_1,mstatus_csv_dumper_1);

    pp_loop_csv_dumper_1 = new("./pp_loop_status1.csv");
    pp_loop_monitor_1 = new(pp_loop_intf_1,pp_loop_csv_dumper_1);




    sample_manager_inst.add_one_monitor(fifo_monitor_1);
    sample_manager_inst.add_one_monitor(process_monitor_1);
    sample_manager_inst.add_one_monitor(process_monitor_2);
    sample_manager_inst.add_one_monitor(module_monitor_1);
    sample_manager_inst.add_one_monitor(pp_loop_monitor_1);
    
    fork
        sample_manager_inst.start_monitor();
        last_transaction_done;
    join
    disable fork;

    sample_manager_inst.start_dump();
end

    task last_transaction_done();
        wait(reset == 0);
        while(1) begin
            if (finish == 1'b1 || deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock == 1'b1) begin
                @(negedge clock);
                break;
            end
            else
                @(posedge clock);
        end
    endtask


endmodule
