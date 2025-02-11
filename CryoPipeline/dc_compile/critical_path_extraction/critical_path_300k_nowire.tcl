define_design_lib WORK -path ./WORK

set TOP_MODULE PSU
set src_path "./src_vlg"
set PDK_path "./freepdk-45nm/stdview"
set SYN_path "/home/synopsys/dc_compiler_2019/syn/P-2019.03/libraries/syn"

set search_path "$src_path \ $PDK_path \ $SYN_path"

set target_library "$PDK_path/NangateOpenCellLibrary.db"
set synthetic_library "$SYN_path/dw_foundation.sldb"
set link_library "* $target_library $synthetic_library"
set mw_reference_library "./milky-45nm-ideal"
set mw_design_library "./mw_design_lib_ideal"
set technology_file "$PDK_path/rtk-tech-ideal.tf"

open_mw_lib $mw_design_library
check_library

read_ddc $src_path/../${TOP_MODULE}_300k_nowire.ddc

set REPORT_DIR "./latency_result"

redirect ${REPORT_DIR}/${TOP_MODULE}_critical_path_300k_nowire {report_timing -through [get_pins -of_objects {  genblk1.vcr/ips[7].ipc/chi/genblk2.genblk1.flit_ctrlq*}] -through [get_pins -of_objects {  genblk1.vcr/ips[7].ipc/fb/genblk2.samqc/queues[1].fc/genblk1.pop_addrq*}]}
redirect ${REPORT_DIR}/${TOP_MODULE}_power_300k_nowire                   {report_power -hierarchy -levels 10}

exit
