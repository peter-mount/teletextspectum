# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all loader teletext
all: loader teletext test.tzx

clean:
	$(RM) *.lst *.rom *.tap *.tzx

loader: loader.tzx loader-tzx.tzx

#loader.rom:	loader.z80 machinetype.z80

loader-tzx.tzx: loader-tzx.z80 loader.z80 machinetype.z80

teletext: teletext.tzx teletext-tzx.tzx

#teletext.rom: teletext.z80 charset1.z80

teletext-tzx.tzx: teletext-tzx.z80 teletext.z80 charset1.z80

test.tzx: loader-tzx.tzx teletext-tzx.tzx
	cat $^ >test.tzx

#teletext.tzx: teletext.z80 loader.z80 machinetype.z80 main.z80 screen.z80 charset1.z80 splash.z80

%.rom: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tap: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tzx: %.z80
	$(ZASM) $<
