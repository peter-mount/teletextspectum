; ***************************************************************************
; Entry points for the teletext emulator
; ***************************************************************************

; These are the entry points to the TeleText emulator

; Initialise the screen for TeleText
;
; Exit:
;   All registers undefined
;
teletextInit        EQU 0xF400

; Write character to screen
;
; Entry:
;   A       Character to write
;
; Exit:
;   A       preserved
;
oswrch              EQU teletextInit + 3

; Write a null terminated string to screen.
;
; When a 0 is reached it will first check to see if oswrch is in the
; middle of a VDU sequence. If it is then the 0 will be treated as part
; of the string and not the string terminator.
;
; This allows for sequences like 31,30,0 where the 0 represents row 0
; and not the string terminator to be included in the string.
;
; Entry:
;   HL      Address of null terminated string
;
; Exit:
;   A       Undefined
;   HL      Points to byte after terminating null
;
writeString         EQU oswrch + 3

; Refresh the screen
;
; This is usually called if the memory under teletextScreen has been updated
; externally to the emulator, e.g. after loading from tape/disk
;
; Exit:
;   All registers undefined
;
teletextRefresh     EQU writeString + 3

; Set the text cursor
;
; This is identical to sending 31,c,b to oswrch but quicker
;
; Entry:
;   B       Text row, 0...23
;   C       Text col, 0...39
;
; Exit:
;   All registers undefined
;
teletextSetPos      EQU teletextRefresh + 3

; Get the text cursor
;
; This returns the current position. Usually used if you need temporarily
; save the current position.
;
; Exit:
;   B       Text row, 0...23
;   C       Text col, 0...39
;
teletextGetPos      EQU teletextSetPos + 3

; The location of the 40x24 byte buffer used to hold a copy of the
; screen.
;
; Code can read/write to this buffer and use teletextRefresh to perform
; a bulk update, e.g. loading/saving a screen on tape/disk
;
teletextScreen      EQU  0xFB00         ; 1K for text screen
