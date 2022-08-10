-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MultipleToSerial is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    input_r_TDATA : IN STD_LOGIC_VECTOR (287 downto 0);
    output_r_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    input_r_TVALID : IN STD_LOGIC;
    input_r_TREADY : OUT STD_LOGIC;
    ap_start : IN STD_LOGIC;
    output_r_TVALID : OUT STD_LOGIC;
    output_r_TREADY : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC );
end;


architecture behav of MultipleToSerial is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "MultipleToSerial_MultipleToSerial,hls_ip_2022_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu15eg-ffvb1156-2-i,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=3.256000,HLS_SYN_LAT=-1,HLS_SYN_TPT=-1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=466,HLS_SYN_LUT=340,HLS_VERSION=2022_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_rst_n_inv : STD_LOGIC;
    signal tmp_elements_i_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_elements_t_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_entry4_proc2_U0_ap_start : STD_LOGIC;
    signal Block_entry4_proc2_U0_ap_done : STD_LOGIC;
    signal Block_entry4_proc2_U0_ap_continue : STD_LOGIC;
    signal Block_entry4_proc2_U0_ap_idle : STD_LOGIC;
    signal Block_entry4_proc2_U0_ap_ready : STD_LOGIC;
    signal Block_entry4_proc2_U0_input_r_TREADY : STD_LOGIC;
    signal Block_entry4_proc2_U0_tmp_elements_address0 : STD_LOGIC_VECTOR (2 downto 0);
    signal Block_entry4_proc2_U0_tmp_elements_ce0 : STD_LOGIC;
    signal Block_entry4_proc2_U0_tmp_elements_we0 : STD_LOGIC;
    signal Block_entry4_proc2_U0_tmp_elements_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_entry4_proc2_U0_tmp_elements_address1 : STD_LOGIC_VECTOR (2 downto 0);
    signal Block_entry4_proc2_U0_tmp_elements_ce1 : STD_LOGIC;
    signal Block_entry4_proc2_U0_tmp_elements_we1 : STD_LOGIC;
    signal Block_entry4_proc2_U0_tmp_elements_d1 : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_entry4_proc2_U0_ap_return : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_channel_done_tmp_elements_num_loc_channel : STD_LOGIC;
    signal tmp_elements_num_loc_channel_full_n : STD_LOGIC;
    signal ap_sync_reg_channel_write_tmp_elements_num_loc_channel : STD_LOGIC := '0';
    signal ap_sync_channel_write_tmp_elements_num_loc_channel : STD_LOGIC;
    signal ap_channel_done_tmp_elements : STD_LOGIC;
    signal Block_entry4_proc2_U0_tmp_elements_full_n : STD_LOGIC;
    signal ap_sync_reg_channel_write_tmp_elements : STD_LOGIC := '0';
    signal ap_sync_channel_write_tmp_elements : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_ap_start : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_ap_done : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_ap_continue : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_ap_idle : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_ap_ready : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_tmp_elements_address0 : STD_LOGIC_VECTOR (2 downto 0);
    signal Loop_VITIS_LOOP_16_1_proc_U0_tmp_elements_ce0 : STD_LOGIC;
    signal Loop_VITIS_LOOP_16_1_proc_U0_output_r_TDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal Loop_VITIS_LOOP_16_1_proc_U0_output_r_TVALID : STD_LOGIC;
    signal tmp_elements_i_full_n : STD_LOGIC;
    signal tmp_elements_t_empty_n : STD_LOGIC;
    signal tmp_elements_num_loc_channel_dout : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_elements_num_loc_channel_num_data_valid : STD_LOGIC_VECTOR (1 downto 0);
    signal tmp_elements_num_loc_channel_fifo_cap : STD_LOGIC_VECTOR (1 downto 0);
    signal tmp_elements_num_loc_channel_empty_n : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component MultipleToSerial_Block_entry4_proc2 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        input_r_TDATA : IN STD_LOGIC_VECTOR (287 downto 0);
        input_r_TVALID : IN STD_LOGIC;
        input_r_TREADY : OUT STD_LOGIC;
        tmp_elements_address0 : OUT STD_LOGIC_VECTOR (2 downto 0);
        tmp_elements_ce0 : OUT STD_LOGIC;
        tmp_elements_we0 : OUT STD_LOGIC;
        tmp_elements_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        tmp_elements_address1 : OUT STD_LOGIC_VECTOR (2 downto 0);
        tmp_elements_ce1 : OUT STD_LOGIC;
        tmp_elements_we1 : OUT STD_LOGIC;
        tmp_elements_d1 : OUT STD_LOGIC_VECTOR (31 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component MultipleToSerial_Loop_VITIS_LOOP_16_1_proc IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        output_r_TREADY : IN STD_LOGIC;
        p_read : IN STD_LOGIC_VECTOR (31 downto 0);
        tmp_elements_address0 : OUT STD_LOGIC_VECTOR (2 downto 0);
        tmp_elements_ce0 : OUT STD_LOGIC;
        tmp_elements_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        output_r_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        output_r_TVALID : OUT STD_LOGIC );
    end component;


    component MultipleToSerial_tmp_elements_RAM_AUTO_1R1W IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        i_address0 : IN STD_LOGIC_VECTOR (2 downto 0);
        i_ce0 : IN STD_LOGIC;
        i_we0 : IN STD_LOGIC;
        i_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        i_q0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        i_address1 : IN STD_LOGIC_VECTOR (2 downto 0);
        i_ce1 : IN STD_LOGIC;
        i_we1 : IN STD_LOGIC;
        i_d1 : IN STD_LOGIC_VECTOR (31 downto 0);
        t_address0 : IN STD_LOGIC_VECTOR (2 downto 0);
        t_ce0 : IN STD_LOGIC;
        t_we0 : IN STD_LOGIC;
        t_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        t_q0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        t_address1 : IN STD_LOGIC_VECTOR (2 downto 0);
        t_ce1 : IN STD_LOGIC;
        t_we1 : IN STD_LOGIC;
        t_d1 : IN STD_LOGIC_VECTOR (31 downto 0);
        i_ce : IN STD_LOGIC;
        t_ce : IN STD_LOGIC;
        i_full_n : OUT STD_LOGIC;
        i_write : IN STD_LOGIC;
        t_empty_n : OUT STD_LOGIC;
        t_read : IN STD_LOGIC );
    end component;


    component MultipleToSerial_fifo_w32_d2_S IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (31 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (31 downto 0);
        if_num_data_valid : OUT STD_LOGIC_VECTOR (1 downto 0);
        if_fifo_cap : OUT STD_LOGIC_VECTOR (1 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;



begin
    tmp_elements_U : component MultipleToSerial_tmp_elements_RAM_AUTO_1R1W
    generic map (
        DataWidth => 32,
        AddressRange => 8,
        AddressWidth => 3)
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        i_address0 => Block_entry4_proc2_U0_tmp_elements_address0,
        i_ce0 => Block_entry4_proc2_U0_tmp_elements_ce0,
        i_we0 => Block_entry4_proc2_U0_tmp_elements_we0,
        i_d0 => Block_entry4_proc2_U0_tmp_elements_d0,
        i_q0 => tmp_elements_i_q0,
        i_address1 => Block_entry4_proc2_U0_tmp_elements_address1,
        i_ce1 => Block_entry4_proc2_U0_tmp_elements_ce1,
        i_we1 => Block_entry4_proc2_U0_tmp_elements_we1,
        i_d1 => Block_entry4_proc2_U0_tmp_elements_d1,
        t_address0 => Loop_VITIS_LOOP_16_1_proc_U0_tmp_elements_address0,
        t_ce0 => Loop_VITIS_LOOP_16_1_proc_U0_tmp_elements_ce0,
        t_we0 => ap_const_logic_0,
        t_d0 => ap_const_lv32_0,
        t_q0 => tmp_elements_t_q0,
        t_address1 => ap_const_lv3_0,
        t_ce1 => ap_const_logic_0,
        t_we1 => ap_const_logic_0,
        t_d1 => ap_const_lv32_0,
        i_ce => ap_const_logic_1,
        t_ce => ap_const_logic_1,
        i_full_n => tmp_elements_i_full_n,
        i_write => ap_channel_done_tmp_elements,
        t_empty_n => tmp_elements_t_empty_n,
        t_read => Loop_VITIS_LOOP_16_1_proc_U0_ap_ready);

    Block_entry4_proc2_U0 : component MultipleToSerial_Block_entry4_proc2
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => Block_entry4_proc2_U0_ap_start,
        ap_done => Block_entry4_proc2_U0_ap_done,
        ap_continue => Block_entry4_proc2_U0_ap_continue,
        ap_idle => Block_entry4_proc2_U0_ap_idle,
        ap_ready => Block_entry4_proc2_U0_ap_ready,
        input_r_TDATA => input_r_TDATA,
        input_r_TVALID => input_r_TVALID,
        input_r_TREADY => Block_entry4_proc2_U0_input_r_TREADY,
        tmp_elements_address0 => Block_entry4_proc2_U0_tmp_elements_address0,
        tmp_elements_ce0 => Block_entry4_proc2_U0_tmp_elements_ce0,
        tmp_elements_we0 => Block_entry4_proc2_U0_tmp_elements_we0,
        tmp_elements_d0 => Block_entry4_proc2_U0_tmp_elements_d0,
        tmp_elements_address1 => Block_entry4_proc2_U0_tmp_elements_address1,
        tmp_elements_ce1 => Block_entry4_proc2_U0_tmp_elements_ce1,
        tmp_elements_we1 => Block_entry4_proc2_U0_tmp_elements_we1,
        tmp_elements_d1 => Block_entry4_proc2_U0_tmp_elements_d1,
        ap_return => Block_entry4_proc2_U0_ap_return);

    Loop_VITIS_LOOP_16_1_proc_U0 : component MultipleToSerial_Loop_VITIS_LOOP_16_1_proc
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => Loop_VITIS_LOOP_16_1_proc_U0_ap_start,
        ap_done => Loop_VITIS_LOOP_16_1_proc_U0_ap_done,
        ap_continue => Loop_VITIS_LOOP_16_1_proc_U0_ap_continue,
        ap_idle => Loop_VITIS_LOOP_16_1_proc_U0_ap_idle,
        ap_ready => Loop_VITIS_LOOP_16_1_proc_U0_ap_ready,
        output_r_TREADY => output_r_TREADY,
        p_read => tmp_elements_num_loc_channel_dout,
        tmp_elements_address0 => Loop_VITIS_LOOP_16_1_proc_U0_tmp_elements_address0,
        tmp_elements_ce0 => Loop_VITIS_LOOP_16_1_proc_U0_tmp_elements_ce0,
        tmp_elements_q0 => tmp_elements_t_q0,
        output_r_TDATA => Loop_VITIS_LOOP_16_1_proc_U0_output_r_TDATA,
        output_r_TVALID => Loop_VITIS_LOOP_16_1_proc_U0_output_r_TVALID);

    tmp_elements_num_loc_channel_U : component MultipleToSerial_fifo_w32_d2_S
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Block_entry4_proc2_U0_ap_return,
        if_full_n => tmp_elements_num_loc_channel_full_n,
        if_write => ap_channel_done_tmp_elements_num_loc_channel,
        if_dout => tmp_elements_num_loc_channel_dout,
        if_num_data_valid => tmp_elements_num_loc_channel_num_data_valid,
        if_fifo_cap => tmp_elements_num_loc_channel_fifo_cap,
        if_empty_n => tmp_elements_num_loc_channel_empty_n,
        if_read => Loop_VITIS_LOOP_16_1_proc_U0_ap_ready);





    ap_sync_reg_channel_write_tmp_elements_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_sync_reg_channel_write_tmp_elements <= ap_const_logic_0;
            else
                if (((Block_entry4_proc2_U0_ap_done and Block_entry4_proc2_U0_ap_continue) = ap_const_logic_1)) then 
                    ap_sync_reg_channel_write_tmp_elements <= ap_const_logic_0;
                else 
                    ap_sync_reg_channel_write_tmp_elements <= ap_sync_channel_write_tmp_elements;
                end if; 
            end if;
        end if;
    end process;


    ap_sync_reg_channel_write_tmp_elements_num_loc_channel_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_sync_reg_channel_write_tmp_elements_num_loc_channel <= ap_const_logic_0;
            else
                if (((Block_entry4_proc2_U0_ap_done and Block_entry4_proc2_U0_ap_continue) = ap_const_logic_1)) then 
                    ap_sync_reg_channel_write_tmp_elements_num_loc_channel <= ap_const_logic_0;
                else 
                    ap_sync_reg_channel_write_tmp_elements_num_loc_channel <= ap_sync_channel_write_tmp_elements_num_loc_channel;
                end if; 
            end if;
        end if;
    end process;

    Block_entry4_proc2_U0_ap_continue <= (ap_sync_channel_write_tmp_elements_num_loc_channel and ap_sync_channel_write_tmp_elements);
    Block_entry4_proc2_U0_ap_start <= ap_start;
    Block_entry4_proc2_U0_tmp_elements_full_n <= tmp_elements_i_full_n;
    Loop_VITIS_LOOP_16_1_proc_U0_ap_continue <= ap_const_logic_1;
    Loop_VITIS_LOOP_16_1_proc_U0_ap_start <= (tmp_elements_t_empty_n and tmp_elements_num_loc_channel_empty_n);
    ap_channel_done_tmp_elements <= ((ap_sync_reg_channel_write_tmp_elements xor ap_const_logic_1) and Block_entry4_proc2_U0_ap_done);
    ap_channel_done_tmp_elements_num_loc_channel <= ((ap_sync_reg_channel_write_tmp_elements_num_loc_channel xor ap_const_logic_1) and Block_entry4_proc2_U0_ap_done);
    ap_done <= Loop_VITIS_LOOP_16_1_proc_U0_ap_done;
    ap_idle <= ((tmp_elements_t_empty_n xor ap_const_logic_1) and (tmp_elements_num_loc_channel_empty_n xor ap_const_logic_1) and Loop_VITIS_LOOP_16_1_proc_U0_ap_idle and Block_entry4_proc2_U0_ap_idle);
    ap_ready <= Block_entry4_proc2_U0_ap_ready;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    ap_sync_channel_write_tmp_elements <= ((ap_channel_done_tmp_elements and Block_entry4_proc2_U0_tmp_elements_full_n) or ap_sync_reg_channel_write_tmp_elements);
    ap_sync_channel_write_tmp_elements_num_loc_channel <= ((tmp_elements_num_loc_channel_full_n and ap_channel_done_tmp_elements_num_loc_channel) or ap_sync_reg_channel_write_tmp_elements_num_loc_channel);
    input_r_TREADY <= Block_entry4_proc2_U0_input_r_TREADY;
    output_r_TDATA <= Loop_VITIS_LOOP_16_1_proc_U0_output_r_TDATA;
    output_r_TVALID <= Loop_VITIS_LOOP_16_1_proc_U0_output_r_TVALID;
end behav;
