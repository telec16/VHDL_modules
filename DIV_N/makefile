# VHDL files
FILES = sources/*
VHDLEX = .vhd

# Testbench
TESTBENCHFILE = $(TESTBENCH)_tb
TESTBENCHPATH = testbenches/$(TESTBENCHFILE)$(VHDLEX)

# GHDL
GHDL = ghdl
GHDLFLAGS= -v --work=work --workdir=simulation
GHDLRUNFLAGS= --ieee=standard 

# Simulation
SIMDIR = simulation
STOP_TIME = 200us
#GHDL_SIM_OPT = --assert-level=note
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)

WAVEFORM_VIEWER = gtkwave


.PHONY: clean

all: clean init elab make run view


# Remove simulation files
clean:
	@echo ""
	@echo "Cleaning..."
	@echo ""
	"rm" -rf $(SIMDIR)

# Targets to analyze libraries
init: clean
	@echo ""
	@echo "Importing and analysis..."
	@echo ""
ifeq ($(strip $(TESTBENCH)),)
	echo "TESTBENCH not set. Use TESTBENCH=<value> to set it."
	exit 1
endif
	"mkdir" $(SIMDIR)

	$(GHDL) -i $(GHDLFLAGS) $(TESTBENCHPATH) $(FILES)
	
	$(GHDL) -a $(GHDLFLAGS) testbenches/DIV_N_tb.vhd
	$(GHDL) -a $(GHDLFLAGS) sources/DIV_N.vhd
	$(GHDL) -a $(GHDLFLAGS) sources/DIV2N.vhd
	$(GHDL) -a $(GHDLFLAGS) sources/DIVevenN.vhd
	$(GHDL) -a $(GHDLFLAGS) sources/DIVoddN.vhd

# Elaborate target.  Almost useless
elab: init
	@echo ""
	@echo "Elaboration..."
	@echo ""
	$(GHDL) -e $(GHDLFLAGS) $(GHDLRUNFLAGS) $(TESTBENCHFILE)
	
# Make target.
make: elab
	@echo ""
	@echo "Making..."
	@echo ""
	$(GHDL) -m $(GHDLFLAGS) $(GHDLRUNFLAGS) $(TESTBENCHFILE)

# Run target
run: make
	@echo ""
	@echo "Running..."
	@echo ""
	$(GHDL) -r $(GHDLFLAGS) $(GHDLRUNFLAGS) $(TESTBENCHFILE) $(GHDL_SIM_OPT) --vcd=$(SIMDIR)/$(TESTBENCHFILE).vcd

# View wave
view:
	$(WAVEFORM_VIEWER) $(SIMDIR)/$(TESTBENCHFILE).vcd


