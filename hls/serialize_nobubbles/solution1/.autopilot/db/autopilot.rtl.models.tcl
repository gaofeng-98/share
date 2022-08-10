set SynModuleInfo {
  {SRCNAME Block_entry4_proc2 MODELNAME Block_entry4_proc2 RTLNAME MultipleToSerial_Block_entry4_proc2
    SUBMODULES {
      {MODELNAME MultipleToSerial_regslice_both RTLNAME MultipleToSerial_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME MultipleToSerial_regslice_both_U}
    }
  }
  {SRCNAME Loop_VITIS_LOOP_16_1_proc MODELNAME Loop_VITIS_LOOP_16_1_proc RTLNAME MultipleToSerial_Loop_VITIS_LOOP_16_1_proc}
  {SRCNAME MultipleToSerial MODELNAME MultipleToSerial RTLNAME MultipleToSerial IS_TOP 1
    SUBMODULES {
      {MODELNAME MultipleToSerial_tmp_elements_RAM_AUTO_1R1W_memcore RTLNAME MultipleToSerial_tmp_elements_RAM_AUTO_1R1W_memcore BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME MultipleToSerial_tmp_elements_RAM_AUTO_1R1W RTLNAME MultipleToSerial_tmp_elements_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2}
      {MODELNAME MultipleToSerial_fifo_w32_d2_S RTLNAME MultipleToSerial_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME {$InstName}}
    }
  }
}
