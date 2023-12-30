load_package ::quartus::project
load_package ::quartus::sdc_ext

source utils.tcl

set project_name [lindex $argv 0]

set nworst [lindex $argv 1]
set npaths [lindex $argv 2]

set fname $project_name/sta_report.txt

source utils.tcl

setup_timing $project_name

check_timing -file $fname
 
report_timing -npaths $npaths -nworst $nworst -show_routing -append -file $fname

#report_timing -nworst $npaths -delay_type max -sort_by group -file $fname                 

# delete timing netlist
delete_timing_netlist

# Close project
project_close
