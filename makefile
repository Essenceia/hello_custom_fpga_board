# TB makefile

TB_DIR=tb
RTL_DIR=cy10gx
BUILD_DIR=build
WAVE_DIR=wave

FLAGS=-Wall -g2012 -gassertions -gstrict-expr-width

top_tb: $(RTL_DIR)/top.v $(TB_DIR)/top_tb.sv
	iverilog $(FLAGS) -s $@ -o $(BUILD_DIR)/$@ $^ 
	vvp $(BUILD_DIR)/$@

clean:
	$(BUILD_DIR)/*
	$(WAVE_DIR)/*
