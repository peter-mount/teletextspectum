# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all
all: disk.bas loader.rom

clean:
	$(RM) *.lst *.rom *.bas

disk.bas: disk.z80
	$(ZASM) $< -o $@

%.rom: %.z80
	$(ZASM) $<
