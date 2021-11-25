# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all teletext test disk tape
all: disk tape teletext

clean:
	@$(MAKE) -C tape clean
	@$(MAKE) -C disk clean
	$(RM) *.lst *.rom *.tap *.tzx *.dsk

disk:
	@$(MAKE) -C disk all

tape:
	@$(MAKE) -C tape all

teletext: teletext.rom teletext.tzx teletext.tap teletext.dsk

teletext.rom: teletext.z80 charset1.z80

teletext.dsk: teletext.rom disk/disk.bas disk/loader.rom
	specfile -dsk $@ -format disk/disk.bas 10 disk/loader.rom 24000 teletext.rom 0xF400

teletext.tzx: teletext.rom tape/tape.bas tape/loader.rom
	specfile -tzx $@ tape/tape.bas 10 tape/loader.rom 24000 teletext.rom 0xF400

teletext.tap: teletext.rom tape/tape.bas tape/loader.rom
	specfile -tap $@ tape/tape.bas 10 tape/loader.rom 24000 teletext.rom 0xF400

manifest.rom: manifest.z80

# Test application consisting of the loader, teletext, splash screen & test page
#test: test-tzx.tzx test.tzx test.dsk
#test.tzx: tape/loader-tzx.tzx teletext-tzx.tzx test-tzx.tzx
#	cat $^ >test.tzx

#test.dsk: teletext.dsk manifest.rom splash.rom main.rom
#	cp teletext.dsk $@
#	specfile -dsk $@ manifest.rom 0x6200 splash.rom 0xFB00 main.rom 0x7000

test-tzx.tzx: splash.z80 main.z80

#teletext.tzx: teletext.z80 loader.z80 machinetype.z80 main.z80 screen.z80 charset1.z80 splash.z80

%.rom: %.z80
	$(ZASM) $<
