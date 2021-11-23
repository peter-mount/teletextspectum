# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all
all: disk.dsk

clean:
	$(RM) *.lst *.rom *.bas *.dsk

disk.bas: disk.z80
	$(ZASM) $< -o $@

disk.dsk: disk.bas loader.rom
	specfile -dsk $@ -format disk.bas 10 loader.rom 24000

%.rom: %.z80
	$(ZASM) $<
