set_property SRC_FILE_INFO {cfile:Z:/Documents/Projects/Fall2023/CPE487/Lab4/Lab4.srcs/constrs_1/new/hexcalc.xdc rfile:../../../../../Lab4.srcs/constrs_1/new/hexcalc.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:3 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_50MHz]
