# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all loader teletext
all: loader teletext test

clean:
	$(RM) *.lst *.rom *.tap *.tzx

loader: loader.rom loader.tzx loader-tzx.tzx

loader.rom:	loader.z80 machinetype.z80

loader-tzx.tzx: loader-tzx.z80 loader.z80 machinetype.z80

teletext: teletext.rom teletext.tzx teletext-tzx.tzx

teletext.rom: teletext.z80 charset1.z80

teletext-tzx.tzx: teletext-tzx.z80 teletext.z80 charset1.z80

# Test application consisting of the loader, teletext, splash screen & test page
test: test-tzx.tzx test.tzx
test.tzx: loader-tzx.tzx teletext-tzx.tzx test-tzx.tzx
	cat $^ >test.tzx

test-tzx.tzx: splash.z80 main.z80

#teletext.tzx: teletext.z80 loader.z80 machinetype.z80 main.z80 screen.z80 charset1.z80 splash.z80

%.rom: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tap: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tzx: %.z80
	$(ZASM) $<
