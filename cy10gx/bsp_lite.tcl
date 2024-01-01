# Custom board pin assignement
# Lite version : only strictly needed pins

set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
set_global_assignment -name DEVICE_FILTER_PIN_COUNT 780
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1

#[3.0V I/O]
set_location_assignment PIN_A24 -to OSC_50m
set_instance_assignment -name IO_STANDARD "1.8 V" -to OSC_50m -entity top

set_location_assignment PIN_E22 -to FPGA_RSTn
set_instance_assignment -name IO_STANDARD "3.0-V LVCMOS" -to FPGA_RSTn -entity top

# Led
set_location_assignment PIN_B8 -to USER_LED[0]
set_location_assignment PIN_A8 -to USER_LED[1]
set_location_assignment PIN_B9 -to USER_LED[2]
set_location_assignment PIN_A9 -to USER_LED[3]
set_location_assignment PIN_B10 -to USER_LED[4]
set_location_assignment PIN_B11 -to USER_LED[5]
set_location_assignment PIN_A11 -to USER_LED[6]
set_location_assignment PIN_A12 -to USER_LED[7]
set_location_assignment PIN_A13 -to USER_LED[8]
set_instance_assignment -name IO_STANDARD "1.8 V" -to "USER_LED[*]"

# Thermal
set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL

export_assignments
