# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

all: teletext.tzx

clean:
	$(RM) *.lst *.tap

teletext.tap: teletext.z80 main.z80 screen.z80 charset1.z80

teletext.tzx: teletext.z80 loader.z80 main.z80 screen.z80 charset1.z80 splash.z80

# Spectrum TAP tape format
%.tap: %.z80
	$(ZASM) $<

# Spectrum TAP tape format
%.tzx: %.z80
	$(ZASM) $<
