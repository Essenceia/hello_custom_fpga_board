# TCL makefile, used to automatise clean as overwrite functionality
# fails on quartus projects that have been build with an error

PROJECT=led_blink
PROJECT_DIR=$(PROJECT)
PROJECT_FILE=$(PROJECT).qpf

LANG=VERILOG
QUARTUS_TCL=quartus_sh -t


RTL_DIR=..
FPGA_DIR=../cy10gx

# makefile paramters: timing report, details report of number worst paths
ifndef nworst
nworst := 100
endif
ifndef npaths
npaths := 10
endif

# Compatibility mode : rework ip generation tcl files
ifndef compat
compat:=
endif

.PHONY: build setup lint synth place
########
# Init #
########
# init project
init:quartus_init.tcl
	$(QUARTUS_TCL) $< "$(PROJECT)"

###########
# Project #
###########

bsp_deps:= $(FPGA_DIR)/bsp_lite.tcl timing.sdc
 
# setup project files and IP
setup:quartus_setup.tcl $(bsp_deps) $(PROJECT_FILE) $(ip_list)
	$(QUARTUS_TCL) $< "$(PROJECT)" "$(PROJECT_DIR)" "$(RTL_DIR)" "$(FPGA_DIR)"

# lint
# call lint when ip files are modified or when
# verilog files are modified
rtl_deps = $(shell ls $(RTL_DIR)/*.v) $(FPGA_DIR)/top.v 


lint:quartus_lint.tcl setup $(rtl_deps) 
	$(QUARTUS_TCL) $< "$(PROJECT)"

# synth
synth:
	quartus_syn $(PROJECT)

# place and route
fit:
	quartus_fit $(PROJECT)

timing: quartus_timing.tcl
	quartus_sta -t $< "$(PROJECT)" "$(nworst)" "$(npaths)"

# by default assemble will produce a SRAM object file ( .sof )
# programmed using passive serial
SOF_OBJ := $(PROJECT_DIR)/$(PROJECT).sof
PROG := "USB-Blaster [1-3]"

$(SOF_OBJ):
	quartus_asm $(PROJECT)

prog_sof: $(SOF_OBJ)
	quartus_pgm -c $(PROG) -m JTAG -o "p;$(SOF_OBJ)@1"

tap:
	quartus_stp $(PROJECT) 	

build:
	$(MAKE) init	
	$(MAKE) setup
	$(MAKE) rebuild_timing
	$(MAKE) assemble

rebuild:
	$(MAKE) lint
	$(MAKE) synth
	$(MAKE) fit

rebuild_timing:
	$(MAKE) rebuild
	$(MAKE) timing

# clean
clean:
	rm -rf db
	rm -rf dni
	rm -rf DNI
	rm -rf .qsys_edit
	rm -rf tmp-clearbox
	$(foreach x,$(ip_list),$(call IP_CLEAN,$x))
	rm -rf qdb
	rm -f $(PROJECT).*
	rm -rf $(PROJECT)
	rm -rf pcs
	rm -f serv_req_info.txt
