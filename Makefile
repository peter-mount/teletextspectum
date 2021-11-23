# ======================================================================
# Sinclair ZX Spectrum +3
#
# The +2 & 128 may be supported later, I only have a +3 physically here.
# ======================================================================
export ZASM				= zasm

.PHONY: all teletext test
all:
	@$(MAKE) -C tape all
	@$(MAKE) -C disk all
	@$(MAKE) teletext test

clean:
	@$(MAKE) -C tape clean
	@$(MAKE) -C disk clean
	$(RM) *.lst *.rom *.tap *.tzx *.dsk

teletext: teletext.rom teletext.tzx teletext-tzx.tzx teletext.dsk

teletext.rom: teletext.z80 charset1.z80

teletext-tzx.tzx: teletext-tzx.z80 teletext.z80 charset1.z80

teletext.dsk: teletext.rom disk/disk.dsk
	cp disk/disk.dsk $@
	specfile -dsk $@ teletext.rom 0xF400

manifest.rom: manifest.z80

# Test application consisting of the loader, teletext, splash screen & test page
test: test-tzx.tzx test.tzx test.dsk
test.tzx: tape/loader-tzx.tzx teletext-tzx.tzx test-tzx.tzx
	cat $^ >test.tzx

test.dsk: teletext.dsk manifest.rom splash.rom main.rom
	cp teletext.dsk $@
	specfile -dsk $@ manifest.rom 0x6200 splash.rom 0xFB00 main.rom 0x7000

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
