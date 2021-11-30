# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

SPECFILE		= specfile
TELETEXT_TAP	= teletext.tap
TELETEXT_TZX	= teletext.tzx
TELETEXT_DSK	= teletext.dsk

.PHONY: all disk tape
all: $(TELETEXT_DSK) $(TELETEXT_TAP) $(TELETEXT_TZX)

clean:
	@$(MAKE) -C tape clean
	@$(MAKE) -C disk clean
	@$(RM) *.lst *.rom *.tap *.tzx *.dsk

disk:
	@$(MAKE) -C disk all

tape:
	@$(MAKE) -C tape all

teletext.rom: teletext.z80 charset1.z80

$(TELETEXT_DSK): teletext.rom disk
	@$(SPECFILE) -dsk $@ -format disk/disk.bas 10 disk/loader.rom 24000 teletext.rom 0xF400

$(TELETEXT_TZX): teletext.rom tape
	@$(SPECFILE) -tzx $@ tape/tape.bas 10 tape/loader.rom 24000 teletext.rom 0xF400

$(TELETEXT_TAP): teletext.rom tape
	@$(SPECFILE) -tap $@ tape/tape.bas 10 tape/loader.rom 24000 teletext.rom 0xF400

%.rom: %.z80
	@$(ZASM) $<
