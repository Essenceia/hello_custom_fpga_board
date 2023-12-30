# Timing and clock information

# would like to put 8 decimal places but 3 is the maximum
set_time_format -unit ns -decimal_places 3


# External clock sources

# 50 MHz oscillator
create_clock -period 20 [get_ports OSC_50m] 

# User contrained clock uncertainty
derive_clock_uncertainty
