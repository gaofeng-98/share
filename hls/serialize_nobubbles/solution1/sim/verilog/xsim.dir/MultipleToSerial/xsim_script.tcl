set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {MultipleToSerial} -view {{MultipleToSerial_dataflow_ana.wcfg}} -tclbatch {MultipleToSerial.tcl} -protoinst {MultipleToSerial.protoinst}
