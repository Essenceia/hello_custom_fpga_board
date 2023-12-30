load_package ::quartus::project

source utils.tcl

set project_name [lindex $argv 0]

set project_dir [lindex $argv 1]

set rtl_dir [lindex $argv 2]

set fpga_dir [lindex $argv 3]

# Open project
project_open $project_name.qpf 

# setup pin assignements
source $fpga_dir/bsp_lite.tcl
# setup timing constraints
set_global_assignment -name SDC_FILE timing.sdc

# Commit assignments
export_assignments
#TOP
set_global_assignment -name VERILOG_FILE $fpga_dir/top.v

# set top
set_global_assignment -name TOP_LEVEL_ENTITY top

# Singal tap
set_global_assignment -name ENABLE_SIGNALTAP ON
set_global_assignment -name USE_SIGNALTAP_FILE tap.stp

#close
project_close
