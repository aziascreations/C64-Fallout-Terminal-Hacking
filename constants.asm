; Do not include any code here, you will get an E0002 error.
; If you want to do so, move the "!source" macro after the "*=$xxxx" line.

; ------------------------------------
;  Zero Page unused/unknown addresses
; ------------------------------------
ZP_TIMER = $02 ; Main loop timer
ZP_UNK1 = $2A
ZP_ALT_TIMER = $2A

ZP_TEMP1 = $52

ZP_ADR_TMP_LOW = $B0
ZP_ADR_TMP_HIGH = $B1

ZP_UNK5 = $BF

ZP_ADR_IN_LOW = $FB
ZP_ADR_IN_HIGH = $FC

ZP_ADR_OUT_LOW = $FD
ZP_ADR_OUT_HIGH = $FE

; --------------------------
;  Screen related addresses
; --------------------------
SCR_FRAME = $D020 ; Frame color
SCR_BKGND = $D021 ; Background color

;SCR_LINE1 = $0400 ; Start of first line of characters
;SCR_LINE2 = $0400 ; ...

SCR_CURSOR_X = $D3 ;Current cursor column. Values: $00-$27, 0-39.
SCR_CURSOR_Y = $D6 ;Current cursor row. Values: $00-$18, 0-24.
SCR_CURSOR_STATE = $CC ;0-Blinking 1-255-Disabled

; ---------------------------
;  Sprites related addresses
; ---------------------------
SPR_TMP0 = $D015 ; Switches for sprites (7->0)
SPR_TMP1 = $D01C ; Switches for multi-color sprites (7->0)

SPR_PTR0 = $07F8 ; Sprite location pointer #0
SPR_PTR1 = $07F9 ; Sprite location pointer #1
SPR_PTR2 = $07FA ; Sprite location pointer #2
SPR_PTR3 = $07FB ; Sprite location pointer #3
SPR_PTR4 = $07FC ; Sprite location pointer #4
SPR_PTR5 = $07FD ; Sprite location pointer #5
SPR_PTR6 = $07FE ; Sprite location pointer #6
SPR_PTR7 = $07FF ; Sprite location pointer #7

;SPR_CLR0 = $xxxx ; Sprite #0 color

; -------------
;  Controllers
; -------------
PRA  = $DC00 ; CIA#1 (Port Register A)
DDRA = $DC02 ; CIA#1 (Data Direction Register A)

PRB  = $DC01 ; CIA#1 (Port Register B)
DDRB = $DC03 ; CIA#1 (Data Direction Register B)

; -------------
;  Others/Misc
; -------------
MSC_SIDRNG = $D41B
