# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all loader
all: loader.rom tape.bas

clean:
	@$(RM) *.lst *.rom *.bas

tape.bas: tape.z80
	@$(ZASM) $< -o $@

%.rom: %.z80
	@$(ZASM) $<
