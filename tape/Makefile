# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all loader
all: loader

clean:
	$(RM) *.lst *.rom *.tap *.tzx *.dsk

loader: loader.rom loader.tzx loader-tzx.tzx

loader-tzx.tzx: loader-tzx.z80 basloader.z80 loader.z80 machinetype.z80

%.rom: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tap: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tzx: %.z80
	$(ZASM) $<

disk.dsk: basloader.rom loader.rom teletext.rom
	cp basloader.rom disk.bas
	specfile -dsk $@ -format disk.bas 10 loader.rom 24000 teletext.rom 0xF400
