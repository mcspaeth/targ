
				;; Variables from asm
				;; $0008-0009		= PRNG

				;; $0034				= Validated control inputs
				;; $00a0				= Half coins
				;; $00a1				= Credits
				;; $00a7				= Status?
				;; $00ae-00af		= High score
				;; $00b0				= shots at special
				;; $00b1				= # active arrows
				;; $00b2				= Smart move code?
				;; $00b3				= Flash counter
				;; $00b4-00b5		= Flash screen location
				;; $00b6				= Car base timer
				;; $00b7				= Car "calender"?
				;; $00b8				= Special object counter
				;; $00b9-00ba		= Flashing image
				;; $00bc				= Type of points to award
				;; $00bd-00be		= Player score
				;; $00bf				= Player #
				;; $00c0				= # players
				;; $00c1				= Lives left
				;; $00c2				= Bullet "calendar"?
				;; $00c3				= Points per arrow
				;; $00d0-00d1		= P1/2 Score lo
				;; $00d2-00d3		= P1/2 Score hi
				;; $00d4-00d5		= P1/2 Active arrows
				;; $00d6-00d7		= P1/2 Lives left
				;; $00d8-00d9		= P1/2 shots at special target
				;; $00da-00db		= P1/2 Points per arrow
				;; $00dc-00dd		= ???
				;; $00de-00df		= P1/2 ??
				;; $00e0-00ff		= Apparently unused

				;; $0300				= Counter to validate coins
				;; $0301				= Valid coin
				
1800: 20 0C 2F jsr $2f0c								; Copy player data to PX 
1803: 4C 0F 18 jmp $180f
				
1806: 20 0A 2F jsr $2f0a								; Copy player data to P2 
1809: 4C 0F 18 jmp $180f
				
180C: 20 05 2F jsr $2f05								; Copy player data to P1 
180F: A5 28    lda $28									; ??
1811: 95 DE    sta $de, x
1813: 60       rts
				
1814: 20 EC 2E jsr $2eec								; Copy PX store to player data
1817: 4C 23 18 jmp $1823
				
181A: 20 EA 2E jsr $2eea								; Copy P2 store to player data
181D: 4C 23 18 jmp $1823
				
1820: 20 E5 2E jsr $2ee5								; Copy P1 store to player data
1823: B5 DE    lda $de, x
1825: 85 28    sta $28									; ??
1827: 60       rts
				
1828: 20 32 18 jsr $1832
182B: 20 47 18 jsr $1847
182E: 20 71 23 jsr $2371
1831: 60       rts
1832: C6 A4    dec $a4
1834: 30 07    bmi $183d
1836: EA       nop
1837: A9 02    lda #$02
1839: 20 CF 23 jsr $23cf
183C: 60       rts
183D: A9 FD    lda #$fd
183F: 20 CA 23 jsr $23ca
1842: A9 00    lda #$00
1844: 85 A4    sta $a4
1846: 60       rts
1847: C6 A5    dec $a5
1849: 30 02    bmi $184d
184B: EA       nop
184C: 60       rts
184D: 38       sec
184E: A9 14    lda #$14
1850: E5 B7    sbc $b7
1852: 85 A5    sta $a5
1854: A5 A6    lda $a6
1856: 29 01    and #$01
1858: C9 01    cmp #$01
185A: D0 19    bne $1875
185C: EA       nop
185D: A9 00    lda #$00
185F: 85 A6    sta $a6
1861: A5 B1    lda $b1
1863: C9 03    cmp #$03
1865: F0 13    beq $187a
1867: EA       nop
1868: C9 01    cmp #$01
186A: F0 0E    beq $187a
186C: EA       nop
186D: A5 A6    lda $a6
186F: 09 02    ora #$02
1871: 8D 01 52 sta $5201
1874: 60       rts
1875: A9 01    lda #$01
1877: 4C 5F 18 jmp $185f
187A: A5 A6    lda $a6
187C: 8D 01 52 sta $5201
187F: 60       rts
				
1880: A9 3D    lda #$3d
1882: 85 03    sta $03

				;; ($10-11) = $4048
1884: A9 48    lda #$48
1886: 85 10    sta $10
1888: A9 40    lda #$40
188A: 85 11    sta $11
				
188C: A5 BF    lda $bf													; Player # 
188E: 4A       lsr a														;  
188F: AA       tax															; x = 0 (P1), 2 (P2) 
1890: B5 DC    lda $dc, x
1892: AA       tax
1893: BD DE 1F lda $1fde, x
1896: AA       tax
1897: 20 A2 18 jsr $18a2
189A: 20 A0 18 jsr $18a0
189D: 20 A0 18 jsr $18a0
				
18A0: A2 00    ldx #$00
18A2: BC 52 1F ldy $1f52, x							; Table 
18A5: C0 FF    cpy #$ff
18A7: F0 09    beq $18b2								; Exit loop 
18A9: EA       nop
				
18AA: A5 03    lda $03
18AC: 91 10    sta ($10), y
18AE: E8       inx
18AF: 4C A2 18 jmp $18a2								; Loop 
				
18B2: 18       clc
18B3: A5 10    lda $10
18B5: 69 05    adc #$05
18B7: 85 10    sta $10
18B9: 60       rts
18BA: 2C 00 51 bit $5100								; DIPs 
18BD: 30 07    bmi $18c6
18BF: EA       nop
18C0: 20 CF 1D jsr $1dcf
18C3: 4C C9 18 jmp $18c9
				
18C6: 20 7C 2B jsr $2b7c								; Quarters (Make this freeplay?)  
18C9: 20 E2 18 jsr $18e2
18CC: 20 F9 18 jsr $18f9
18CF: 20 4F 2B jsr $2b4f								; Draw DEPOSIT_COIN 
18D2: 20 EA 2B jsr $2bea								; Draw CREDITS_##
18D5: 20 37 2B jsr $2b37
18D8: 20 08 24 jsr $2408
18DB: 20 3B 2A jsr $2a3b								; Draw player scores
18DE: 20 EA 23 jsr $23ea
18E1: 60       rts
				
18E2: A0 05    ldy #$05
18E4: B9 3E 1F lda $1f3e, y							; HI_SCR 
18E7: 99 2B 40 sta $402b, y							; Screen loc 
18EA: 88       dey
18EB: 10 F7    bpl $18e4
				
18ED: A5 AE    lda $ae									; High score lo 
18EF: 85 03    sta $03
18F1: A5 AF    lda $af									; High score hi 
18F3: A2 10    ldx #$10
18F5: 20 60 2A jsr $2a60								; Draw 2 byte score from a, $03
18F8: 60       rts

				
18F9: A5 A7    lda $a7
18FB: 09 10    ora #$10									; Set bit 5 
18FD: 85 A7    sta $a7

				;; Set ($10-11) to $40c2
18FF: A9 C2    lda #$c2
1901: 85 10    sta $10
1903: A9 40    lda #$40
1905: 85 11    sta $11

				;; Set ($14-15) to $1e54
1907: A0 00    ldy #$00
1909: B9 46 1F lda $1f46, y
190C: 85 14    sta $14
190E: C8       iny
190F: B9 46 1F lda $1f46, y
1912: 85 15    sta $15
				
1914: 20 FE 22 jsr $22fe								; Draw string
				
1917: 60       rts

				
1918: 20 40 23 jsr $2340								; Clear screen

				;; Set ($10-11) to $420c
191B: A9 0C    lda #$0c
191D: 85 10    sta $10
191F: A9 42    lda #$42
1921: 85 11    sta $11

				;; Set ($14-15) to $27c7 = END_OF_GAME
1923: A0 00    ldy #$00
1925: B9 44 1F lda $1f44, y
1928: 85 14    sta $14
192A: C8       iny
192B: B9 44 1F lda $1f44, y
192E: 85 15    sta $15
				
1930: 20 FE 22 jsr $22fe								; Draw string
				
1933: 20 86 23 jsr $2386
1936: 20 86 23 jsr $2386
1939: 60       rts

				;; Decrement credits
193A: A5 A1    lda $a1									; Credits 
193C: D0 03    bne $1941
193E: EA       nop
193F: 38       sec											; Carry = no credits 
1940: 60       rts
				
1941: F8       sed											; Decimal mode 
1942: 38       sec											; Clear borrow
1943: E9 01    sbc #$01									;
1945: 85 A1    sta $a1									; Credits 
1947: D8       cld											; Clear decimal 
1948: 20 EA 2B jsr $2bea								; Draw CREDITS_##
194B: 18       clc											; No carry = credits 
194C: 60       rts

				
194D: 20 71 19 jsr $1971
				
1950: A2 00    ldx #$00									; P1 offset 
1952: A5 BF    lda $bf									; Current player 
1954: C9 01    cmp #$01
1956: F0 03    beq $195b								; Is P1 
1958: EA       nop
				
1959: A2 18    ldx #$18									; P2 offset 
195B: A9 00    lda #$00
				
195D: 20 52 2A jsr $2a52								; Add a to current player score
1960: A5 2F    lda $2f
1962: 85 B1    sta $b1
1964: 20 2B 2C jsr $2c2b
1967: C6 28    dec $28
1969: 10 05    bpl $1970
196B: EA       nop
196C: A9 00    lda #$00
196E: 85 28    sta $28
1970: 60       rts
1971: 20 7B 19 jsr $197b
1974: 20 3B 2A jsr $2a3b								; Draw player scores
1977: 20 7D 2A jsr $2a7d
197A: 60       rts
				
197B: 20 2B 2C jsr $2c2b
197E: A9 00    lda #$00
1980: 85 1D    sta $1d
1982: 85 30    sta $30
1984: 85 3E    sta $3e
1986: 85 1F    sta $1f
1988: 85 31    sta $31
198A: 85 B3    sta $b3
198C: 85 B8    sta $b8
198E: 85 BC    sta $bc
1990: A9 08    lda #$08
1992: 85 1C    sta $1c
1994: A9 F3    lda #$f3
1996: 85 1A    sta $1a
1998: 20 6D 24 jsr $246d
199B: A9 01    lda #$01
199D: 85 1E    sta $1e
199F: 20 AA 2E jsr $2eaa
19A2: A9 06    lda #$06
19A4: 85 B6    sta $b6
19A6: 85 B7    sta $b7
19A8: A9 03    lda #$03
19AA: 85 20    sta $20
19AC: 85 21    sta $21
19AE: A9 80    lda #$80
19B0: 85 B9    sta $b9
19B2: 20 40 23 jsr $2340								; Clear screen
19B5: 20 EA 2B jsr $2bea								; Draw CREDITS_##
19B8: 20 C8 26 jsr $26c8
19BB: A9 0A    lda #$0a
19BD: 85 2F    sta $2f
19BF: A9 04    lda #$04
19C1: 85 B0    sta $b0
19C3: 60       rts
19C4: A5 BC    lda $bc
19C6: D0 02    bne $19ca
19C8: EA       nop
19C9: 60       rts
19CA: A6 BF    ldx $bf
19CC: F0 3F    beq $1a0d
19CE: EA       nop
19CF: E0 01    cpx #$01
19D1: F0 06    beq $19d9
19D3: EA       nop
19D4: A2 18    ldx #$18
19D6: 4C DB 19 jmp $19db
19D9: A2 00    ldx #$00
19DB: A5 BC    lda $bc
19DD: 30 06    bmi $19e5
19DF: EA       nop
19E0: A5 C3    lda $c3
19E2: 4C EF 19 jmp $19ef
19E5: A9 60    lda #$60
19E7: 20 CF 23 jsr $23cf
19EA: E6 A8    inc $a8
19EC: 20 12 1A jsr $1a12
19EF: 20 52 2A jsr $2a52								; Add a to current player score
19F2: E0 18    cpx #$18
19F4: B0 08    bcs $19fe
19F6: EA       nop
				
19F7: A2 18    ldx #$18									; Offset +$18 
19F9: A0 01    ldy #$01									; Player 2 
19FB: 4C 02 1A jmp $1a02
				
19FE: A0 00    ldy #$00									; Player 1 
1A00: A2 00    ldx #$00									; Location +00 
1A02: B9 D0 00 lda $00d0, y							; Score lo
1A05: 85 03    sta $03
1A07: B9 D2 00 lda $00d2, y							; Score hi 
1A0A: 20 60 2A jsr $2a60								; Draw 2 byte score from a, $03
				
1A0D: A9 00    lda #$00
1A0F: 85 BC    sta $bc
1A11: 60       rts
				
1A12: 86 01    stx $01
1A14: A5 B1    lda $b1									; # active arrows 
1A16: D0 07    bne $1a1f
1A18: EA       nop
				
1A19: A5 A7    lda $a7
1A1B: 09 10    ora #$10									; Set bit 5 
1A1D: 85 A7    sta $a7
				
1A1F: A9 00    lda #$00
1A21: 8D 01 52 sta $5201
1A24: 20 A4 23 jsr $23a4								; Kick PRNG
1A27: 29 03    and #$03
1A29: AA       tax
1A2A: BD EC 1F lda $1fec, x							; Table (01 02 03 05) 
1A2D: AA       tax
1A2E: A0 00    ldy #$00
1A30: 85 00    sta $00
1A32: B1 9B    lda ($9b), y
1A34: 99 41 00 sta $0041, y
1A37: A5 00    lda $00
1A39: 09 30    ora #$30
1A3B: 91 9B    sta ($9b), y
1A3D: C8       iny
1A3E: B1 9B    lda ($9b), y
1A40: 99 41 00 sta $0041, y
1A43: C8       iny
1A44: B1 9B    lda ($9b), y
1A46: 99 41 00 sta $0041, y
1A49: 88       dey
1A4A: A9 30    lda #$30
1A4C: 91 9B    sta ($9b), y
1A4E: C8       iny
1A4F: 91 9B    sta ($9b), y
1A51: 8A       txa
1A52: 0A       asl a
1A53: 0A       asl a
1A54: 0A       asl a
1A55: 0A       asl a
1A56: 85 00    sta $00
1A58: A6 01    ldx $01
1A5A: 20 89 23 jsr $2389
1A5D: 20 8C 23 jsr $238c
1A60: A0 00    ldy #$00
1A62: 20 6E 1A jsr $1a6e
1A65: 20 6E 1A jsr $1a6e
1A68: 20 6E 1A jsr $1a6e
1A6B: A5 00    lda $00
1A6D: 60       rts
				
1A6E: B9 41 00 lda $0041, y
1A71: 91 9B    sta ($9b), y
1A73: C8       iny
1A74: 60       rts
				
1A75: C6 B6    dec $b6
1A77: D0 3F    bne $1ab8
1A79: EA       nop
				
1A7A: A9 05    lda #$05
1A7C: 85 B6    sta $b6
1A7E: A5 20    lda $20
1A80: 10 22    bpl $1aa4
1A82: EA       nop
				
1A83: E6 B7    inc $b7
1A85: A5 B7    lda $b7
1A87: C9 0F    cmp #$0f
1A89: 90 08    bcc $1a93
1A8B: EA       nop
				
1A8C: A9 0E    lda #$0e
1A8E: 85 B7    sta $b7
1A90: 4C B8 1A jmp $1ab8
				
1A93: AA       tax
1A94: BD F0 1F lda $1ff0, x
1A97: 85 00    sta $00
1A99: A5 20    lda $20
1A9B: 29 C0    and #$c0
1A9D: 05 00    ora $00
1A9F: 85 20    sta $20
1AA1: 4C B8 1A jmp $1ab8
				
1AA4: A5 20    lda $20
1AA6: 29 40    and #$40
1AA8: F0 0E    beq $1ab8
1AAA: EA       nop
				
1AAB: C6 B7    dec $b7
1AAD: A5 B7    lda $b7
1AAF: 10 E2    bpl $1a93
				
1AB1: A9 00    lda #$00
1AB3: 85 B7    sta $b7
1AB5: 4C 93 1A jmp $1a93
				
1AB8: C6 21    dec $21
1ABA: D0 18    bne $1ad4
1ABC: EA       nop
				
1ABD: 20 6A 22 jsr $226a
1AC0: A0 00    ldy #$00
1AC2: B1 2A    lda ($2a), y
1AC4: C9 20    cmp #$20
1AC6: F0 09    beq $1ad1
1AC8: EA       nop
				
1AC9: C9 21    cmp #$21
1ACB: F0 04    beq $1ad1
1ACD: EA       nop
				
1ACE: 4C 69 3F jmp $3f69
				
1AD1: 4C 94 2D jmp $2d94
				
1AD4: 4C 9D 2D jmp $2d9d
				
1AD7: A9 91    lda #$91
1AD9: 20 02 1B jsr $1b02
				
1ADC: AE 16 03 ldx $0316
1ADF: CA       dex
1AE0: EA       nop
1AE1: EA       nop
1AE2: D0 FB    bne $1adf				; Delay loop?
1AE4: EA       nop
				
1AE5: A9 9E    lda #$9e
1AE7: 20 07 1B jsr $1b07
				
1AEA: AE 16 03 ldx $0316
1AED: CA       dex
1AEE: EA       nop
1AEF: EA       nop
1AF0: D0 FB    bne $1aed				; Delay loop?
				
1AF2: C6 A9    dec $a9
1AF4: D0 06    bne $1afc
1AF6: EA       nop
				
1AF7: C6 AA    dec $aa
1AF9: D0 DC    bne $1ad7				; Loop
1AFB: 60       rts
				
1AFC: F0 00    beq $1afe
1AFE: F0 00    beq $1b00
1B00: D0 D5    bne $1ad7
1B02: 05 AB    ora $ab
1B04: D0 03    bne $1b09
1B06: EA       nop
				
1B07: 25 AB    and $ab
1B09: 85 AB    sta $ab
1B0B: 09 90    ora #$90
1B0D: 29 F1    and #$f1
1B0F: 8D 00 52 sta $5200
1B12: 60       rts

				;; y = $00 or $12
1B13: B9 D9 1B lda $1bd9, y
1B16: 8D 10 03 sta $0310
1B19: C8       iny
1B1A: A9 00    lda #$00
1B1C: 8D 01 52 sta $5201
1B1F: B9 D9 1B lda $1bd9, y
1B22: 29 E0    and #$e0									; Mask high 3 bits
1B24: 4A       lsr a										; a>>1
1B25: 4A       lsr a										; a>>2
1B26: 4A       lsr a										; a>>3
1B27: 4A       lsr a										; a>>4
1B28: 4A       lsr a										; a>>5
1B29: 85 AC    sta $ac
1B2B: B9 D9 1B lda $1bd9, y
1B2E: F0 3B    beq $1b6b
1B30: EA       nop
				
1B31: C9 01    cmp #$01
1B33: F0 31    beq $1b66
1B35: EA       nop
				
1B36: C9 FF    cmp #$ff
1B38: F0 57    beq $1b91
1B3A: EA       nop
				
1B3B: 29 1F    and #$1f									; Mask low 5 bits 
1B3D: AA       tax
1B3E: BD 97 1B lda $1b97, x
1B41: 8D 16 03 sta $0316
1B44: AD 10 03 lda $0310
1B47: F0 08    beq $1b51
1B49: EA       nop
				
1B4A: BD B8 1B lda $1bb8, x
1B4D: 4A       lsr a
1B4E: 4C 54 1B jmp $1b54
1B51: BD B8 1B lda $1bb8, x
1B54: 4A       lsr a
1B55: 85 A9    sta $a9
1B57: A9 01    lda #$01
1B59: 85 AA    sta $aa
1B5B: 20 D7 1A jsr $1ad7
1B5E: C6 AC    dec $ac
1B60: D0 C9    bne $1b2b
1B62: C8       iny
1B63: 4C 1F 1B jmp $1b1f								; Loop back 
				
1B66: A9 30    lda #$30
1B68: 4C 6D 1B jmp $1b6d
1B6B: A9 03    lda #$03
1B6D: 8D 17 03 sta $0317
1B70: A9 00    lda #$00
1B72: 8D 12 03 sta $0312
1B75: 8D 13 03 sta $0313
1B78: EE 12 03 inc $0312
1B7B: EE 13 03 inc $0313
1B7E: A9 80    lda #$80
1B80: CD 13 03 cmp $0313
1B83: D0 F6    bne $1b7b
1B85: AD 12 03 lda $0312
1B88: CD 17 03 cmp $0317
1B8B: D0 EB    bne $1b78
1B8D: C8       iny
1B8E: 4C 1F 1B jmp $1b1f
1B91: A9 10    lda #$10
1B93: 20 02 1B jsr $1b02
1B96: 60       rts

				;; Table $20 long
1B97: F6 E8 DC CE C2 B9 AD A4						; DATA 
1B9F: 9B 91 89 81 7A 73 6C 66						; DATA 
1BA7: 60 5B 55 50 4C 48 43 3F						; DATA 
1BAF: 3C 38 34 31 2E 2C 29 26						; DATA 
1BB7: 24																; DATA ? 

				;; Table $20 long
1BB8: 1F 21 23 25 27 29 2C 2E						; DATA 
1BB0: 31 34 37 3A 3E 42 46 4A						; DATA 
1BC8: 4E 53 58 5D 63 69 6F 75						; DATA 
1BD0: 7C 83 8B 94 9D A6 B0 BA						; DATA 
1BD8: C6																; DATA ? 
				
1BD9: FF 32 35 3D 32 35 3D 32						; DATA 
1BE1: 35 3D 32 35 3D 32 35 3D						; DATA 
1BE9: FF FF
				
1BEB: 32 35 3D FF FF 32 35 3D						; DATA 
1BF3: 32 35 3D FF												; DATA 


				;; Clear to end?
				;; Alt IRQ code?
1BF7: 08       php
1BF8: 48       pha
1BF9: 8A       txa
1BFA: 48       pha
1BFB: 98       tya
1BFC: 48       pha
1BFD: AD 03 51 lda $5103								; IRQ source
1C00: A8       tay
1C01: 29 60    and #$60									; Mask coins
1C03: D0 0F    bne $1c14
1C05: EA       nop
1C06: 98       tya
1C07: 10 08    bpl $1c11
1C09: EA       nop
				
1C0A: 68       pla
1C0B: A8       tay
1C0C: 68       pla
1C0D: AA       tax
1C0E: 68       pla
1C0F: 28       plp
1C10: 40       rti
				
1C11: 4C 4D 3F jmp $3f4d
				
1C14: A5 A2    lda $a2
1C16: C9 06    cmp #$06
1C18: 90 F0    bcc $1c0a								; Exit NMI

				;; Push y, $10, $11, $14, $15 to stack
1C1A: 98       tya
1C1B: 48       pha
1C1C: A5 14    lda $14
1C1E: 48       pha
1C1F: A5 15    lda $15
1C21: 48       pha
1C22: A5 10    lda $10
1C24: 48       pha
1C25: A5 11    lda $11
1C27: 48       pha
				
1C28: 98       tya
1C29: 29 60    and #$60
1C2B: 8D 01 03 sta $0301								; Coin condition
				 
1C2E: A9 00    lda #$00
1C30: 85 A2    sta $a2
1C32: 2C 00 51 bit $5100								; DIPs 
1C35: 30 43    bmi $1c7a
1C37: EA       nop
				
1C38: 98       tya
1C39: 29 20    and #$20
1C3B: D0 1E    bne $1c5b
1C3D: EA       nop
				
1C3E: AD 00 51 lda $5100								; DIPs 
1C41: 49 FF    eor #$ff
1C43: 29 02    and #$02
1C45: D0 11    bne $1c58
1C47: EA       nop
				
1C48: E6 A0    inc $a0
1C4A: A5 A0    lda $a0
1C4C: C9 02    cmp #$02
1C4E: 90 3D    bcc $1c8d
1C50: EA       nop
1C51: A9 00    lda #$00
1C53: 85 A0    sta $a0
1C55: 4C 80 1C jmp $1c80
1C58: 4C 80 1C jmp $1c80
1C5B: AD 00 51 lda $5100												; DIPs 
1C5E: 49 FF    eor #$ff
1C60: 29 02    and #$02
1C62: D0 0A    bne $1c6e
1C64: EA       nop
1C65: 20 DB 1C jsr $1cdb
1C68: 20 DB 1C jsr $1cdb
1C6B: 4C 80 1C jmp $1c80
1C6E: 20 DB 1C jsr $1cdb
1C71: 20 DB 1C jsr $1cdb
1C74: 20 DB 1C jsr $1cdb
1C77: 4C 65 1C jmp $1c65
1C7A: 98       tya
1C7B: 29 40    and #$40
1C7D: F0 0E    beq $1c8d
1C7F: EA       nop
1C80: 20 9E 1C jsr $1c9e
1C83: 24 A7    bit $a7
1C85: 30 06    bmi $1c8d
1C87: EA       nop
1C88: A0 12    ldy #$12
1C8A: 20 13 1B jsr $1b13
1C8D: 68       pla
1C8E: 85 11    sta $11
1C90: 68       pla
1C91: 85 10    sta $10
1C93: 68       pla
1C94: 85 15    sta $15
1C96: 68       pla
1C97: 85 14    sta $14
1C99: 68       pla
1C9A: A8       tay
1C9B: 4C 0A 1C jmp $1c0a
				
1C9E: AD 03 51 lda $5103				; IRQ source
1CA1: 29 60    and #$60					; Mask coins
1CA3: D0 02    bne $1ca7
1CA5: EA       nop
1CA6: 60       rts
				
1CA7: A9 FF    lda #$ff
1CA9: 8D 00 03 sta $0300
				
1CAC: AD 03 51 lda $5103				; IRQ source
1CAF: 29 60    and #$60					; Mask coins
1CB1: 4D 01 03 eor $0301
1CB4: D0 E8    bne $1c9e				; Jump if different
				
1CB6: CE 00 03 dec $0300
1CB9: D0 F1    bne $1cac
				
1CBB: AD 03 51 lda $5103				; IRQ source
1CBE: 29 60    and #$60					; Mask coins
1CC0: 4D 01 03 eor $0301
1CC3: D0 F6    bne $1cbb				; Loop if different
				
1CC5: CE 00 03 dec $0300
1CC8: AD 03 51 lda $5103				; IRQ source
1CCB: 29 60    and #$60					; Mask coins
1CCD: 4D 01 03 eor $0301
1CD0: D0 E9    bne $1cbb				; Loop if different
				
1CD2: CE 00 03 dec $0300
1CD5: D0 F1    bne $1cc8				; Loop
				
1CD7: 20 DB 1C jsr $1cdb
1CDA: 60       rts

1CDB: AD 00 51 lda $5100												; DIPs 
1CDE: 29 18    and #$18
1CE0: C9 10    cmp #$10
1CE2: D0 0B    bne $1cef
1CE4: EA       nop
1CE5: E6 A0    inc $a0
1CE7: A5 A0    lda $a0
1CE9: C9 02    cmp #$02
1CEB: B0 02    bcs $1cef
1CED: EA       nop
1CEE: 60       rts
				
1CEF: 4C D7 2B jmp $2bd7
				;; End of alt IRQ

				
1CF2: 20 40 23 jsr $2340								; Clear screen
1CF5: 20 80 1D jsr $1d80
1CF8: A5 BF    lda $bf
1CFA: 4A       lsr a
1CFB: AA       tax
1CFC: F8       sed
1CFD: 18       clc
1CFE: B5 DC    lda $dc, x
1D00: C9 09    cmp #$09
1D02: B0 05    bcs $1d09
1D04: EA       nop
1D05: 69 01    adc #$01
1D07: 95 DC    sta $dc, x
1D09: 18       clc
1D0A: 65 BE    adc $be
1D0C: 85 BE    sta $be
1D0E: A5 C3    lda $c3
1D10: C9 09    cmp #$09
1D12: B0 05    bcs $1d19
1D14: EA       nop
1D15: 69 01    adc #$01
1D17: 85 C3    sta $c3
1D19: D8       cld
1D1A: 20 80 18 jsr $1880

				;; ($10-11) = $414b
1D1D: A9 4B    lda #$4b
1D1F: 85 10    sta $10
1D21: A9 41    lda #$41
1D23: 85 11    sta $11

				;; ($14-15) = $1e72
1D25: A0 00    ldy #$00
1D27: B9 48 1F lda $1f48, y
1D2A: 85 14    sta $14
1D2C: C8       iny
1D2D: B9 48 1F lda $1f48, y
1D30: 85 15    sta $15
				
1D32: 20 FE 22 jsr $22fe								; Draw string

				;; ($14-15) = $2f9b
1D35: A0 00    ldy #$00
1D37: B9 F2 2F lda $2ff2, y
1D3A: 85 14    sta $14
1D3C: C8       iny
1D3D: B9 F2 2F lda $2ff2, y
1D40: 85 15    sta $15

				;; ($10-11) = $420e
1D42: A9 0E    lda #$0e
1D44: 85 10    sta $10
1D46: A9 42    lda #$42
1D48: 85 11    sta $11
				
1D4A: 20 FE 22 jsr $22fe								; Draw string
				
1D4D: 20 EA 23 jsr $23ea
1D50: A5 C3    lda $c3
1D52: 09 30    ora #$30
1D54: 8D 6D 42 sta $426d
1D57: A9 10    lda #$10
1D59: 8D 00 52 sta $5200
1D5C: A0 00    ldy #$00
1D5E: 20 13 1B jsr $1b13
1D61: 20 8E 1D jsr $1d8e
1D64: A2 2F    ldx #$2f
1D66: 20 6D 1D jsr $1d6d
1D69: CA       dex
1D6A: 10 FA    bpl $1d66
1D6C: 60       rts
1D6D: C6 16    dec $16
1D6F: D0 FC    bne $1d6d
1D71: A0 07    ldy #$07
1D73: 20 A4 23 jsr $23a4								; Kick PRNG
1D76: 99 E8 49 sta $49e8, y
1D79: 99 F0 4D sta $4df0, y
1D7C: 88       dey
1D7D: 10 F4    bpl $1d73
1D7F: 60       rts
1D80: A9 FF    lda #$ff
1D82: A0 07    ldy #$07
1D84: 99 E8 49 sta $49e8, y
1D87: 99 F0 4D sta $4df0, y
1D8A: 88       dey
1D8B: 10 F7    bpl $1d84
1D8D: 60       rts
1D8E: A9 09    lda #$09
1D90: 85 3F    sta $3f
1D92: A9 12    lda #$12
1D94: 85 B7    sta $b7
1D96: 20 A0 1D jsr $1da0
1D99: C6 B7    dec $b7
1D9B: C6 3F    dec $3f
1D9D: D0 F7    bne $1d96
1D9F: 60       rts
1DA0: A5 03    lda $03
1DA2: C9 BE    cmp #$be
1DA4: F0 22    beq $1dc8
1DA6: EA       nop
1DA7: A9 BE    lda #$be
1DA9: 85 03    sta $03
1DAB: 20 84 18 jsr $1884
1DAE: A9 12    lda #$12
1DB0: 85 17    sta $17
1DB2: C6 16    dec $16
1DB4: D0 FC    bne $1db2
1DB6: A5 17    lda $17
1DB8: 29 03    and #$03
1DBA: 85 B1    sta $b1
1DBC: A5 17    lda $17
1DBE: 29 06    and #$06
1DC0: D0 01    bne $1dc3
1DC2: EA       nop
1DC3: C6 17    dec $17
1DC5: D0 EB    bne $1db2
1DC7: 60       rts
1DC8: 20 80 18 jsr $1880
1DCB: 20 AE 1D jsr $1dae
1DCE: 60       rts

				;; Set up pence coinage
1DCF: AD 00 51 lda $5100								; DIPs 
1DD2: A0 00    ldy #$00
1DD4: 49 FF    eor #$ff									; Invert 
1DD6: 29 02    and #$02									; Mask coinage 
1DD8: D0 0F    bne $1de9
1DDA: EA       nop

				;; ($14-15) = $1f09
1DDB: B9 50 1F lda $1f50, y
1DDE: 85 14    sta $14
1DE0: C8       iny
1DE1: B9 50 1F lda $1f50, y
1DE4: 85 15    sta $15
1DE6: 4C F4 1D jmp $1df4

				;; ($14-15) = $1ed4
1DE9: B9 4E 1F lda $1f4e, y
1DEC: 85 14    sta $14
1DEE: C8       iny
1DEF: B9 4E 1F lda $1f4e, y
1DF2: 85 15    sta $15

				;; ($10-11) = $4164
1DF4: A9 64    lda #$64
1DF6: 85 10    sta $10
1DF8: A9 41    lda #$41
1DFA: 85 11    sta $11
				
1DFC: 20 FE 22 jsr $22fe								; Draw string
				
1DFF: C8       iny
1E00: A9 69    lda #$69
1E02: 85 10    sta $10
1E04: 20 00 23 jsr $2300								; Draw next string 
1E07: 60       rts
				
1E08: A5 BE    lda $be
1E0A: C5 AF    cmp $af
1E0C: F0 05    beq $1e13
1E0E: EA       nop
1E0F: B0 0A    bcs $1e1b
1E11: EA       nop
1E12: 60       rts
1E13: A5 BD    lda $bd
1E15: C5 AE    cmp $ae
1E17: B0 02    bcs $1e1b
1E19: EA       nop
1E1A: 60       rts
1E1B: A5 BD    lda $bd
1E1D: 85 AE    sta $ae
1E1F: A5 BE    lda $be
1E21: 85 AF    sta $af
1E23: A5 A7    lda $a7
1E25: 29 FC    and #$fc
1E27: 85 A7    sta $a7
1E29: A5 BF    lda $bf
1E2B: 29 03    and #$03
1E2D: 05 A7    ora $a7
1E2F: 85 A7    sta $a7
1E31: 60       rts
1E32: A9 01    lda #$01
1E34: 85 29    sta $29
1E36: 85 28    sta $28
1E38: A9 0B    lda #$0b
1E3A: 85 2F    sta $2f
1E3C: A9 0A    lda #$0a
1E3E: 85 B1    sta $b1
1E40: 20 7B 19 jsr $197b
1E43: 20 3B 2A jsr $2a3b								; Draw player scores
1E46: 20 E2 18 jsr $18e2
1E49: A9 02    lda #$02
1E4B: 85 20    sta $20
1E4D: 85 21    sta $21
1E4F: A9 00    lda #$00
1E51: 85 A7    sta $a7
1E53: 60       rts

1e54: 54 4f 50 20 48 49 47 48						; DATA TOP_HIGH
1e5c: 20 53 43 4f 52 45 20 46						; DATA _SCORE_F
1e64: 4f 52 20 45 58 54 52 41						; DATA OR_EXTRA
1e6c: 20 50 4c 41 59 00									; DATA _PLAY

1e72: 45 58 54 52 41 20 50 4f						; DATA EXTRA_PO
1e7a: 49 4e 54 53 00										; DATA INTS

1e7f: 45 58 54 45 4e 44 45 44						; DATA EXTENDED
1e87: 20 50 4c 41 59 20 46 4f						; DATA _PLAY_FO
1e8f: 52 20 50 4c 41 59 45 52						; DATA R_PLAYER
1e97: 20 20 20 00												; DATA ___

1e9b: 54 4f 50 50 49 4e 47 20						; DATA TOPPING_
1ea3: 48 49 47 48 20 53 43 4f						; DATA HIGH_SCO
1eab: 52 45 20 00												; DATA RE_

1eaf: 45 58 54 52 41 20 43 52						; DATA EXTRA_CR
1eb7: 45 44 49 54 20 00									; DATA EDIT_

1ebd: 46 4f 52 20 54 4f 50 50						; DATA FOR_TOPP
1ec5: 49 4e 47 20 48 49 47 48						; DATA ING_HIGH
1ecd: 20 53 43 4f 52 45 00							; DATA _SCORE

1ed4: 31 20 47 41 4d 45 20 20						; DATA 1_GAME__
1edc: 4f 4e 45 20 31 30 20 50						; DATA ONE_10_P
1ee4: 45 4e 43 45 20 43 4f 49						; DATA ENCE_COI
1eec: 4e 20 00													; DATA N_

1eef: 36 20 47 41 4d 45 53 20						 ; DATA 6_GAMES_
1ef7: 4f 4e 45 20 35 30 20 50						; DATA ONE_50_P
1eff: 45 4e 43 45 20 43 4f 49						; DATA ENCE_COI
1f07: 4e 00															; DATA N

1f09: 31 20 47 41 4d 45 20 20						; DATA 1_GAME__
1f11: 54 57 4f 20 31 30 20 50						; DATA TWO_10_P
1f19: 45 4e 43 45 20 43 4f 49						; DATA ENCE_COI
1f21: 4e 53 00													; DATA NS

1f24: 33 20 47 41 4d 45 53 20						; DATA 3_GAMES_
1f2c: 4f 4e 45 20 35 30 20 50						; DATA ONE_50_P
1f34: 45 4e 43 45 20 43 4f 49						; DATA ENCE_COI
1f3c: 4e 00															; DATA N

1f3e: 48 49 20 53 43 52 c7 27						; DATA HI_SCR

				;; Text pointers Could be hard coded
1F44: C7 27															; ADDR $27c7 = END_OF_GAME
1F46: 54 1E															; ADDR $1e54 = TOP_HIGH_SCORE...
1F48: 72 1E															; ADDR $1e72 = EXTRA_POINTS
1F4A: 7F 1E															; ADDR $1e7f = EXTENDED_PLAY...
1F4C: AF 1E															; ADDR $1eaf = EXTRA_CREDIT_
				
				;; Coinage table pointers
1F4F: D4 1E															; ADDR $1ed4 = 1G_10P
1F50: 09 1F															; ADDR $1f09 = 1G_2x20P

				;; Table ($FF terminated)
1F52: 01 02 20 23 40 43 60 63						; DATA 
1F5A: 80 83 A1 A2 FF										; DATA 
				
1F5F: 00 01 21 41 61 81 A0 A1						; DATA 
1F67: A2 FF															; DATA 
				
1F69: 00 01 02 20 22 42 60 61						; DATA 
1F71: 62 80 A0 A1 A2 FF									; DATA 
				
1F77: 00 01 02 22 41 42 62 82						; DATA 
1F7F: A0 A1 A2 FF												; DATA 
				 
1F83: 02 20 22 40 42 60 61 62						; DATA 
1F8B: 63 82 A1 A2 A3 FF									; DATA 
				
1F91: 00 01 02 20 40 41 42 43						; DATA 
1F99: 63 83 A0 A1 A2 A3 FF							; DATA 
				 
1FA0: 00 01 02 20 40 60 61 62						; DATA 
1FA8: 63 80 83 A0 A1 A2 A3 FF						; DATA 
				
1FB0: 00 01 02 03 23 42 43 61						; DATA 
1FB8: 62 81 A1 FF												; DATA 
				
1FBC: 01 02 03 21 23 40 41 42						; DATA 
1FC4: 43 60 63 80 83 A0 A1 A2						; DATA 
1FCC: A3 FF															; DATA 
				 
1FCE: 00 01 02 03 20 23 40 41						; DATA 
1FD6: 42 43 63 83 A1 A2 A3 FF						; DATA 
				 
1FDE: 00 0D															; DATA  
1FE0: 17 25															; DATA  
1FE2: 31 3F															; DATA  
1FE4: 4E 5E															; DATA  
1FE6: 6A 7C															; DATA  
				
1FE8: 20 40 04 08												; DATA (4 entries)
1FEC: 01 02 03 05												; DATA (4 entries)
				
				;; Table
1FF0: 0A 09 08 06												; DATA 
1FF4: 05 04 04 03												; DATA 
1FF8: 03 03 02 02												; DATA 
1FFC: 02 02 02 02												; DATA 

				;; Check fire button
2000: AD 05 51 lda $5105								; Control inputs 
2003: C9 FF    cmp #$ff
2005: D0 06    bne $200d								; Something pressed 
2007: EA       nop
				
2008: A9 00    lda #$00									; No controls 
200A: 85 34    sta $34									; IN0 store
200C: 60       rts

				;; Validate inputs
200D: 85 34    sta $34									; IN0 store
200F: A2 04    ldx #$04									; Loop counter 
2011: AD 05 51 lda $5105								; Control inputs 
2014: 05 34    ora $34									; IN0 store
2016: 85 34    sta $34									; IN0 store
2018: CA       dex
2019: D0 F6    bne $2011								; Loop
				
201B: 49 FF    eor #$ff
201D: 85 34    sta $34									; IN0 store
				
201F: 29 10    and #$10									; Button 
2021: F0 0B    beq $202e								;  
2023: EA       nop
				
2024: A5 35    lda $35									; Old IN0 store 
2026: 85 36    sta $36									; Old Old IN0 store 
2028: A5 34    lda $34									; IN0 Store 
202A: 29 EF    and #$ef									; Clear Button 
202C: 85 35    sta $35									; Old IN0 store 
202E: 60       rts


202F: A5 30    lda $30
2031: 29 60    and #$60
2033: D0 06    bne $203b
2035: EA       nop
2036: A9 16    lda #$16
2038: 85 38    sta $38
203A: 60       rts
203B: C6 38    dec $38
203D: 30 02    bmi $2041
203F: EA       nop
2040: 60       rts
2041: A5 30    lda $30
2043: 29 20    and #$20
2045: D0 0D    bne $2054
2047: EA       nop
2048: A5 3A    lda $3a
204A: 20 93 20 jsr $2093
204D: A5 30    lda $30
204F: 29 BF    and #$bf
2051: 85 30    sta $30
2053: 60       rts
				
2054: 20 A4 23 jsr $23a4								; Kick PRNG
2057: 29 01    and #$01
2059: AA       tax
205A: A5 1C    lda $1c
205C: F0 12    beq $2070
205E: EA       nop
205F: A5 1D    lda $1d
2061: F0 07    beq $206a
2063: EA       nop
2064: BD AD 27 lda $27ad, x
2067: 4C 7E 20 jmp $207e
				
206A: BD AB 27 lda $27ab, x
206D: 4C 7E 20 jmp $207e
2070: A5 1D    lda $1d
2072: F0 07    beq $207b
2074: EA       nop
2075: BD AF 27 lda $27af, x
2078: 4C 7E 20 jmp $207e
207B: BD B1 27 lda $27b1, x
207E: 20 93 20 jsr $2093
2081: A5 30    lda $30
2083: 29 9F    and #$9f
2085: 85 30    sta $30
2087: 60       rts
2088: A5 34    lda $34
208A: 29 EF    and #$ef
208C: D0 05    bne $2093
208E: EA       nop
208F: 20 25 22 jsr $2225
2092: 60       rts
2093: C9 20    cmp #$20
2095: F0 53    beq $20ea
2097: EA       nop
2098: C9 40    cmp #$40
209A: F0 77    beq $2113
209C: EA       nop
209D: C9 04    cmp #$04
209F: D0 04    bne $20a5
20A1: EA       nop
20A2: 4C 3E 21 jmp $213e
20A5: C9 08    cmp #$08
20A7: D0 04    bne $20ad
20A9: EA       nop
20AA: 4C 69 21 jmp $2169
20AD: 60       rts
20AE: A5 31    lda $31
20B0: F0 02    beq $20b4
20B2: EA       nop
20B3: 60       rts
20B4: A5 34    lda $34
20B6: 29 10    and #$10
20B8: D0 02    bne $20bc
20BA: EA       nop
20BB: 60       rts
20BC: A9 0C    lda #$0c
20BE: 85 A4    sta $a4
20C0: A9 01    lda #$01
20C2: 85 31    sta $31
20C4: A9 02    lda #$02
20C6: 85 26    sta $26
20C8: 85 27    sta $27
20CA: A5 1A    lda $1a
20CC: 0A       asl a
20CD: 0A       asl a
20CE: 0A       asl a
20CF: 0A       asl a
20D0: 09 40    ora #$40
20D2: 85 00    sta $00
20D4: A5 1A    lda $1a
20D6: 29 0F    and #$0f
20D8: 05 00    ora $00
20DA: 85 1A    sta $1a
20DC: A5 1C    lda $1c
20DE: 85 22    sta $22
20E0: A5 1D    lda $1d
20E2: 85 23    sta $23
20E4: 20 D9 21 jsr $21d9
20E7: 4C 6D 24 jmp $246d
20EA: A5 1F    lda $1f
20EC: F0 13    beq $2101
20EE: EA       nop
20EF: 30 04    bmi $20f5
20F1: EA       nop
20F2: 4C F4 21 jmp $21f4
20F5: A5 20    lda $20
20F7: 29 3F    and #$3f
20F9: C9 0A    cmp #$0a
20FB: B0 0B    bcs $2108
20FD: EA       nop
20FE: 4C 0A 22 jmp $220a
2101: 20 A1 21 jsr $21a1
2104: B0 02    bcs $2108
2106: EA       nop
2107: 60       rts
2108: A9 01    lda #$01
210A: 85 1F    sta $1f
210C: A9 00    lda #$00
210E: 85 1E    sta $1e
2110: 4C 91 21 jmp $2191
2113: A5 1F    lda $1f
2115: F0 13    beq $212a
2117: EA       nop
2118: 10 04    bpl $211e
211A: EA       nop
211B: 4C F4 21 jmp $21f4
211E: A5 20    lda $20
2120: 29 3F    and #$3f
2122: C9 0A    cmp #$0a
2124: B0 0B    bcs $2131
2126: EA       nop
2127: 4C 0A 22 jmp $220a
212A: 20 A1 21 jsr $21a1
212D: B0 02    bcs $2131
212F: EA       nop
2130: 60       rts
2131: A9 FE    lda #$fe
2133: 85 1F    sta $1f
2135: A9 00    lda #$00
2137: 85 1E    sta $1e
2139: A9 01    lda #$01
213B: 4C 91 21 jmp $2191
213E: A5 1E    lda $1e
2140: F0 13    beq $2155
2142: EA       nop
2143: 10 04    bpl $2149
2145: EA       nop
2146: 4C F4 21 jmp $21f4
2149: A5 20    lda $20
214B: 29 3F    and #$3f
214D: C9 0A    cmp #$0a
214F: B0 0B    bcs $215c
2151: EA       nop
2152: 4C 0A 22 jmp $220a
2155: 20 A9 21 jsr $21a9
2158: B0 02    bcs $215c
215A: EA       nop
215B: 60       rts
215C: A9 FE    lda #$fe
215E: 85 1E    sta $1e
2160: A9 00    lda #$00
2162: 85 1F    sta $1f
2164: A9 02    lda #$02
2166: 4C 91 21 jmp $2191
2169: A5 1E    lda $1e
216B: F0 13    beq $2180
216D: EA       nop
216E: 30 04    bmi $2174
2170: EA       nop
2171: 4C F4 21 jmp $21f4
2174: A5 20    lda $20
2176: 29 3F    and #$3f
2178: C9 0A    cmp #$0a
217A: B0 0B    bcs $2187
217C: EA       nop
217D: 4C 0A 22 jmp $220a
2180: 20 A9 21 jsr $21a9
2183: B0 02    bcs $2187
2185: EA       nop
2186: 60       rts
2187: A9 01    lda #$01
2189: 85 1E    sta $1e
218B: A9 00    lda #$00
218D: 85 1F    sta $1f
218F: A9 03    lda #$03
2191: 48       pha
2192: A5 1A    lda $1a
2194: 29 F0    and #$f0
2196: 85 1A    sta $1a
2198: 68       pla
2199: 05 1A    ora $1a
219B: 85 1A    sta $1a
219D: 20 6D 24 jsr $246d
21A0: 60       rts
21A1: A5 1C    lda $1c
21A3: F0 22    beq $21c7
21A5: EA       nop
21A6: 4C AE 21 jmp $21ae
21A9: A5 1D    lda $1d
21AB: F0 1A    beq $21c7
21AD: EA       nop
21AE: 85 01    sta $01
21B0: A2 0A    ldx #$0a
21B2: A9 00    lda #$00
21B4: 85 00    sta $00
21B6: C5 01    cmp $01
21B8: F0 0D    beq $21c7
21BA: EA       nop
21BB: A9 18    lda #$18
21BD: 18       clc
21BE: 65 00    adc $00
21C0: 85 00    sta $00
21C2: CA       dex
21C3: D0 F1    bne $21b6
21C5: 18       clc
21C6: 60       rts
21C7: A5 39    lda $39
21C9: 85 3A    sta $3a
21CB: A5 34    lda $34
21CD: 29 EF    and #$ef
21CF: 85 39    sta $39
21D1: A5 30    lda $30
21D3: 29 BF    and #$bf
21D5: 85 30    sta $30
21D7: 38       sec
21D8: 60       rts
21D9: A5 1E    lda $1e
21DB: 20 E8 21 jsr $21e8
21DE: 85 24    sta $24
21E0: A5 1F    lda $1f
21E2: 20 E8 21 jsr $21e8
21E5: 85 25    sta $25
21E7: 60       rts
21E8: F0 06    beq $21f0
21EA: EA       nop
21EB: 30 04    bmi $21f1
21ED: EA       nop
21EE: A9 02    lda #$02
21F0: 60       rts
21F1: A9 FD    lda #$fd
21F3: 60       rts
21F4: A5 20    lda $20
21F6: 10 02    bpl $21fa
21F8: EA       nop
21F9: 60       rts
21FA: A5 36    lda $36
21FC: C5 35    cmp $35
21FE: D0 09    bne $2209
2200: EA       nop
2201: A5 20    lda $20
2203: 29 BF    and #$bf
2205: 09 80    ora #$80
2207: 85 20    sta $20
2209: 60       rts
220A: A5 20    lda $20
220C: 29 40    and #$40
220E: F0 02    beq $2212
2210: EA       nop
2211: 60       rts
2212: A5 36    lda $36
2214: C5 35    cmp $35
2216: D0 F1    bne $2209
2218: A5 20    lda $20
221A: 29 7F    and #$7f
221C: 09 40    ora #$40
221E: 85 20    sta $20
2220: A5 3C    lda $3c
2222: 85 2E    sta $2e
2224: 60       rts
2225: A5 20    lda $20
2227: 29 3F    and #$3f
2229: 85 20    sta $20
222B: 60       rts
222C: 20 6A 22 jsr $226a
222F: A5 10    lda $10
2231: 29 1F    and #$1f
2233: 85 00    sta $00
2235: A5 2A    lda $2a
2237: 29 1F    and #$1f
2239: 38       sec
223A: E5 00    sbc $00
223C: 85 2D    sta $2d
223E: A5 11    lda $11
2240: 85 19    sta $19
2242: A5 10    lda $10
2244: 85 18    sta $18
2246: 20 5C 22 jsr $225c
2249: 85 00    sta $00
224B: A5 2B    lda $2b
224D: 85 19    sta $19
224F: A5 2A    lda $2a
2251: 85 18    sta $18
2253: 20 5C 22 jsr $225c
2256: 38       sec
2257: E5 00    sbc $00
2259: 85 2C    sta $2c
225B: 60       rts
225C: A2 05    ldx #$05
225E: 66 19    ror $19
2260: 66 18    ror $18
2262: CA       dex
2263: D0 F9    bne $225e
2265: A5 18    lda $18
2267: 29 1F    and #$1f
2269: 60       rts
226A: A5 1D    lda $1d
226C: 85 18    sta $18
226E: A5 1C    lda $1c
2270: 85 19    sta $19
2272: 4C 7D 22 jmp $227d
2275: A5 23    lda $23
2277: 85 18    sta $18
2279: A5 22    lda $22
227B: 85 19    sta $19
227D: A9 00    lda #$00
227F: 85 2B    sta $2b
2281: A5 18    lda $18
2283: 49 FF    eor #$ff
2285: 4A       lsr a
2286: 4A       lsr a
2287: 4A       lsr a
2288: 18       clc
2289: 69 01    adc #$01
228B: E9 04    sbc #$04
228D: 85 2A    sta $2a
228F: 18       clc
2290: 65 2A    adc $2a
2292: 85 2A    sta $2a
2294: A2 04    ldx #$04
2296: 06 2A    asl $2a
2298: 26 2B    rol $2b
229A: CA       dex
229B: D0 F9    bne $2296
229D: A5 2A    lda $2a
229F: 69 60    adc #$60
22A1: 85 2A    sta $2a
22A3: A5 2B    lda $2b
22A5: 69 40    adc #$40
22A7: 85 2B    sta $2b
22A9: A5 19    lda $19
22AB: 49 FF    eor #$ff
22AD: 4A       lsr a
22AE: 4A       lsr a
22AF: 4A       lsr a
22B0: 18       clc
22B1: 69 01    adc #$01
22B3: 38       sec
22B4: E9 03    sbc #$03
22B6: 18       clc
22B7: 65 2A    adc $2a
22B9: 85 2A    sta $2a
22BB: 60       rts

				;; Set ($14-15) to $4800 (char RAM)
22BC: A9 00    lda #$00
22BE: 85 14    sta $14
22C0: A9 48    lda #$48
22C2: 85 15    sta $15

				;; 
22C4: A0 00    ldy #$00
22C6: B9 FC 27 lda $27fc, y
22C9: 85 18    sta $18
22CB: C8       iny
22CC: B9 FC 27 lda $27fc, y
22CF: 85 19    sta $19
22D1: A2 08    ldx #$08
22D3: 20 E9 22 jsr $22e9
22D6: 60       rts
22D7: 20 E0 22 jsr $22e0
22DA: E6 19    inc $19
22DC: CA       dex
22DD: D0 F8    bne $22d7
22DF: 60       rts
22E0: A0 00    ldy #$00
22E2: 98       tya
22E3: 91 18    sta ($18), y
22E5: C8       iny
22E6: D0 FB    bne $22e3
22E8: 60       rts

				;; Copy x pages from ($18-19) to ($14-15)
22E9: 20 F4 22 jsr $22f4
22EC: E6 15    inc $15
22EE: E6 19    inc $19
22F0: CA       dex
22F1: D0 F6    bne $22e9								; Loop 
22F3: 60       rts

				;; Copy $0100 bytes from ($18-19) to ($14-15)
22F4: A0 00    ldy #$00
22F6: B1 18    lda ($18), y
22F8: 91 14    sta ($14), y
22FA: C8       iny
22FB: D0 F9    bne $22f6								; Loop 
22FD: 60       rts
			
				;; Draw string from ($14-15) at ($10-11)
22FE: A0 00    ldy #$00
2300: B1 14    lda ($14), y							; Get char 
2302: D0 02    bne $2306								; 0 terminated 
2304: EA       nop
				
2305: 60       rts
				
2306: 91 10    sta ($10), y							; Store char 
2308: C8       iny
2309: 4C 00 23 jmp $2300								; Loop 
				
230C: A9 60    lda #$60
230E: 4C 18 23 jmp $2318
2311: A9 40    lda #$40
2313: 4C 18 23 jmp $2318
2316: A9 20    lda #$20
2318: 18       clc
2319: 65 10    adc $10
231B: 85 10    sta $10
231D: A5 11    lda $11
231F: 69 00    adc #$00
2321: 85 11    sta $11
2323: 60       rts
				
2324: A9 60    lda #$60
2326: 4C 30 23 jmp $2330
2329: A9 40    lda #$40
232B: 4C 30 23 jmp $2330
232E: A9 20    lda #$20
2330: 85 00    sta $00
2332: 38       sec
2333: A5 10    lda $10
2335: E5 00    sbc $00
2337: 85 10    sta $10
2339: A5 11    lda $11
233B: E9 00    sbc #$00
233D: 85 11    sta $11
233F: 60       rts

				
				;; Clear screen
2340: 20 59 23 jsr $2359								; ($10-11) = $4000
				
2343: A8       tay											; y=a=0 
2344: A2 04    ldx #$04									; Loop counter 
2346: 20 51 23 jsr $2351								; Clear y chars at ($10-11)
				
2349: E6 11    inc $11
234B: CA       dex
234C: D0 F8    bne $2346								; Loop 
234E: 60       rts

				;; Clear $20 chars at ($10-11)
234F: A0 20    ldy #$20

				;; Clear y chars at ($10-11)
2351: A9 20    lda #$20									; (space char) 
2353: 88       dey
2354: 91 10    sta ($10), y
2356: D0 FB    bne $2353								; Loop 
2358: 60       rts

				;; ($10-11) = $4000
2359: A9 40    lda #$40
235B: D0 0D    bne $236a
235D: EA       nop
				
				;; ($10-11) = $4100
235E: A9 41    lda #$41
2360: D0 08    bne $236a
2362: EA       nop
				
				;; ($10-11) = $4200
2363: A9 42    lda #$42
2365: D0 03    bne $236a
2367: EA       nop
				
				;; ($10-11) = $4300
2368: A9 43    lda #$43
236A: 85 11    sta $11
236C: A9 00    lda #$00
236E: 85 10    sta $10
2370: 60       rts


2371: A5 B1    lda $b1
2373: C5 A8    cmp $a8
2375: D0 07    bne $237e
2377: EA       nop
2378: A9 9F    lda #$9f
237A: 20 CA 23 jsr $23ca
237D: 60       rts
237E: 85 A8    sta $a8
2380: A9 60    lda #$60
2382: 20 CF 23 jsr $23cf
2385: 60       rts
2386: 20 89 23 jsr $2389
2389: 20 8C 23 jsr $238c
238C: 20 8F 23 jsr $238f
238F: A9 00    lda #$00
2391: 85 16    sta $16
2393: 85 17    sta $17
2395: E6 16    inc $16
2397: E6 17    inc $17
2399: A9 26    lda #$26
239B: C5 17    cmp $17
239D: D0 F8    bne $2397
239F: C5 16    cmp $16
23A1: D0 F2    bne $2395
23A3: 60       rts

				;; Kick PRNG
23A4: 98       tya
23A5: 48       pha											; Push y
				
23A6: A0 23    ldy #$23
23A8: A5 09    lda $09
23AA: F0 11    beq $23bd								; ==0 
23AC: EA       nop
				
23AD: 29 60    and #$60
23AF: C9 20    cmp #$20
23B1: F0 0A    beq $23bd								; == 20/60/a0/e0 
23B3: EA       nop
				
23B4: C9 40    cmp #$40
23B6: F0 05    beq $23bd								; == 40/c0 
23B8: EA       nop
				
23B9: 18       clc											; Clear carry 
23BA: 90 02    bcc $23be								; (Always) 
23BC: EA       nop
				
23BD: 38       sec											; Set carry 
23BE: 26 08    rol $08
23C0: 26 09    rol $09
23C2: 88       dey
23C3: D0 E3    bne $23a8
23C5: 68       pla
23C6: A8       tay
23C7: A5 08    lda $08
23C9: 60       rts


23CA: 25 A3    and $a3
23CC: 4C D1 23 jmp $23d1
23CF: 05 A3    ora $a3
23D1: 85 A3    sta $a3
23D3: 8D 00 52 sta $5200
23D6: 60       rts
23D7: AD 00 51 lda $5100												; DIPs 
23DA: 49 FF    eor #$ff
23DC: 29 60    and #$60
23DE: 4A       lsr a
23DF: 4A       lsr a
23E0: 4A       lsr a
23E1: 4A       lsr a
23E2: 4A       lsr a
23E3: AA       tax
23E4: BD C3 27 lda $27c3, x
23E7: 85 C1    sta $c1
23E9: 60       rts
23EA: A9 01    lda #$01
23EC: 8D 6B 42 sta $426b

				;; ($10-11) = $426d
23EF: A9 6D    lda #$6d
23F1: 85 10    sta $10
23F3: A9 42    lda #$42
23F5: 85 11    sta $11

				;; ($14-15) = $27ec
23F7: A0 00    ldy #$00
23F9: B9 FA 27 lda $27fa, y
23FC: 85 14    sta $14
23FE: C8       iny
23FF: B9 FA 27 lda $27fa, y
2402: 85 15    sta $15
				
2404: 20 FE 22 jsr $22fe								; Draw string
2407: 60       rts

				;; ($10-11) = $42ef
2408: A9 EF    lda #$ef
240A: 85 10    sta $10
240C: A9 42    lda #$42
240E: 85 11    sta $11

				;; ($14-15) = $27de
2410: A0 00    ldy #$00
2412: B9 F6 27 lda $27f6, y
2415: 85 14    sta $14
2417: C8       iny
2418: B9 F6 27 lda $27f6, y
241B: 85 15    sta $15
				
241D: 20 FE 22 jsr $22fe								; Draw string
2420: 60       rts
				
2421: A0 00    ldy #$00
2423: A9 10    lda #$10
2425: 8D 00 52 sta $5200
2428: A9 EE    lda #$ee
242A: 8D 00 51 sta $5100								; Sprite latch

				;; ($10-11) = $420d
242D: A9 0D    lda #$0d
242F: 85 10    sta $10
2431: A9 42    lda #$42
2433: 85 11    sta $11

				;; ($14-15) = $27d8
2435: B9 F8 27 lda $27f8, y
2438: 85 14    sta $14
243A: C8       iny
243B: B9 F8 27 lda $27f8, y
243E: 85 15    sta $15
2440: 20 FE 22 jsr $22fe								; Draw string

				;; ($10-11) = $430d
2443: A9 43    lda #$43
2445: 85 10    sta $10
2447: C8       iny
2448: 20 00 23 jsr $2300								; Draw next string
				
244B: A5 BF    lda $bf
244D: 09 30    ora #$30
244F: 8D 55 42 sta $4255
2452: 20 86 23 jsr $2386
2455: 20 86 23 jsr $2386
2458: 60       rts
2459: A5 1C    lda $1c
245B: 8D 00 50 sta $5000
245E: A5 1D    lda $1d
2460: 8D 40 50 sta $5040
2463: A5 22    lda $22
2465: 8D 80 50 sta $5080
2468: A5 23    lda $23
246A: 8D C0 50 sta $50c0
246D: A5 1A    lda $1a
246F: 8D 00 51 sta $5100								; Sprite latch 
2472: 60       rts
2473: A5 1E    lda $1e
2475: F0 24    beq $249b
2477: EA       nop
2478: 18       clc
2479: 65 1C    adc $1c
247B: 69 00    adc #$00
247D: 20 CE 24 jsr $24ce
2480: 85 1C    sta $1c
2482: B0 02    bcs $2486
2484: EA       nop
2485: 60       rts
2486: A5 30    lda $30
2488: 29 40    and #$40
248A: D0 08    bne $2494
248C: EA       nop
248D: A5 30    lda $30
248F: 09 40    ora #$40
2491: 85 30    sta $30
2493: 60       rts
2494: A5 30    lda $30
2496: 09 20    ora #$20
2498: 85 30    sta $30
249A: 60       rts
249B: A5 1F    lda $1f
249D: D0 02    bne $24a1
249F: EA       nop
24A0: 60       rts
24A1: 18       clc
24A2: 65 1D    adc $1d
24A4: 69 00    adc #$00
24A6: 20 CE 24 jsr $24ce
24A9: 85 1D    sta $1d
24AB: B0 D9    bcs $2486
24AD: 60       rts
24AE: A5 24    lda $24
24B0: F0 0B    beq $24bd
24B2: EA       nop
24B3: 18       clc
24B4: 65 22    adc $22
24B6: 69 00    adc #$00
24B8: 20 DF 24 jsr $24df
24BB: 85 22    sta $22
24BD: A5 25    lda $25
24BF: D0 02    bne $24c3
24C1: EA       nop
24C2: 60       rts
24C3: 18       clc
24C4: 65 23    adc $23
24C6: 69 00    adc #$00
24C8: 20 DF 24 jsr $24df
24CB: 85 23    sta $23
24CD: 60       rts
24CE: C9 FC    cmp #$fc
24D0: B0 07    bcs $24d9
24D2: EA       nop
24D3: C9 D8    cmp #$d8
24D5: B0 05    bcs $24dc
24D7: EA       nop
24D8: 60       rts
24D9: A9 00    lda #$00
24DB: 60       rts
24DC: A9 D8    lda #$d8
24DE: 60       rts
24DF: C9 FC    cmp #$fc
24E1: B0 07    bcs $24ea
24E3: EA       nop
24E4: C9 DA    cmp #$da
24E6: B0 02    bcs $24ea
24E8: EA       nop
24E9: 60       rts
24EA: 85 00    sta $00
24EC: A5 1A    lda $1a
24EE: 09 F0    ora #$f0
24F0: 85 1A    sta $1a
24F2: A9 00    lda #$00
24F4: 85 31    sta $31
24F6: A5 00    lda $00
24F8: 60       rts
24F9: A5 0C    lda $0c
24FB: 29 18    and #$18
24FD: 49 08    eor #$08
24FF: 85 0C    sta $0c
2501: 60       rts
2502: A5 10    lda $10
2504: 85 06    sta $06
2506: A5 11    lda $11
2508: 85 07    sta $07
250A: 60       rts
250B: A5 06    lda $06
250D: 85 10    sta $10
250F: A5 07    lda $07
2511: 85 11    sta $11
2513: 60       rts
2514: 20 02 25 jsr $2502
2517: A5 0C    lda $0c
2519: 29 18    and #$18
251B: AA       tax
251C: C9 08    cmp #$08
251E: F0 09    beq $2529
2520: EA       nop
2521: C9 10    cmp #$10
2523: F0 0C    beq $2531
2525: EA       nop
2526: 20 24 23 jsr $2324
2529: A9 03    lda #$03
252B: 20 30 23 jsr $2330
252E: 4C 34 25 jmp $2534
2531: 20 24 23 jsr $2324
2534: 8A       txa
2535: 0A       asl a
2536: AA       tax
2537: A9 00    lda #$00
2539: 85 00    sta $00
253B: BC 57 27 ldy $2757, x
253E: F0 14    beq $2554
2540: EA       nop
2541: B1 10    lda ($10), y
2543: 86 01    stx $01
2545: A6 00    ldx $00
2547: 29 7F    and #$7f
2549: 95 41    sta $41, x
254B: E8       inx
254C: 86 00    stx $00
254E: A6 01    ldx $01
2550: E8       inx
2551: 4C 3B 25 jmp $253b
2554: 20 0B 25 jsr $250b
2557: 60       rts
2558: A5 41    lda $41
255A: C9 60    cmp #$60
255C: B0 02    bcs $2560
255E: EA       nop
255F: 60       rts
2560: A5 4B    lda $4b
2562: C9 60    cmp #$60
2564: B0 13    bcs $2579
2566: EA       nop
2567: A5 4A    lda $4a
2569: C9 60    cmp #$60
256B: B0 02    bcs $256f
256D: EA       nop
256E: 60       rts
256F: C9 20    cmp #$20
2571: 90 19    bcc $258c
2573: EA       nop
2574: A9 04    lda #$04
2576: 4C 80 25 jmp $2580
2579: C9 20    cmp #$20
257B: 90 0F    bcc $258c
257D: EA       nop
257E: A9 02    lda #$02
2580: 05 05    ora $05
2582: 85 05    sta $05
2584: 60       rts
2585: A5 41    lda $41
2587: C9 20    cmp #$20
2589: F0 08    beq $2593
258B: EA       nop
258C: A5 05    lda $05
258E: 09 01    ora #$01
2590: 85 05    sta $05
2592: 60       rts
2593: A5 05    lda $05
2595: 09 80    ora #$80
2597: 85 05    sta $05
2599: 60       rts
259A: A5 4A    lda $4a
259C: C9 20    cmp #$20
259E: D0 07    bne $25a7
25A0: EA       nop
25A1: A5 05    lda $05
25A3: 09 10    ora #$10
25A5: 85 05    sta $05
25A7: A5 4B    lda $4b
25A9: C9 20    cmp #$20
25AB: D0 07    bne $25b4
25AD: EA       nop
25AE: A5 05    lda $05
25B0: 09 08    ora #$08
25B2: 85 05    sta $05
25B4: 60       rts
25B5: A5 4A    lda $4a
25B7: C9 20    cmp #$20
25B9: 90 25    bcc $25e0
25BB: EA       nop
25BC: A5 4B    lda $4b
25BE: C9 20    cmp #$20
25C0: 90 1E    bcc $25e0
25C2: EA       nop
25C3: A5 4C    lda $4c
25C5: C9 20    cmp #$20
25C7: 90 17    bcc $25e0
25C9: EA       nop
25CA: A5 4D    lda $4d
25CC: C9 20    cmp #$20
25CE: 90 10    bcc $25e0
25D0: EA       nop
25D1: A5 45    lda $45
25D3: C9 20    cmp #$20
25D5: 90 09    bcc $25e0
25D7: EA       nop
25D8: A5 49    lda $49
25DA: C9 20    cmp #$20
25DC: 90 02    bcc $25e0
25DE: EA       nop
25DF: 60       rts
25E0: A5 05    lda $05
25E2: 09 40    ora #$40
25E4: 85 05    sta $05
25E6: 60       rts
25E7: A5 41    lda $41
25E9: C9 20    cmp #$20
25EB: D0 02    bne $25ef
25ED: EA       nop
25EE: 60       rts
25EF: A5 43    lda $43
25F1: C9 20    cmp #$20
25F3: D0 09    bne $25fe
25F5: EA       nop
25F6: A5 47    lda $47
25F8: C9 20    cmp #$20
25FA: D0 02    bne $25fe
25FC: EA       nop
25FD: 60       rts
25FE: A5 05    lda $05
2600: 09 20    ora #$20
2602: 85 05    sta $05
2604: 60       rts
2605: 20 64 26 jsr $2664
2608: A6 3D    ldx $3d
260A: BD 97 27 lda $2797, x
260D: 85 0C    sta $0c
260F: BC 9F 27 ldy $279f, x
2612: 20 9E 26 jsr $269e
2615: BD A7 27 lda $27a7, x
2618: 20 18 23 jsr $2318
261B: A5 3D    lda $3d
261D: C9 03    cmp #$03
261F: F0 02    beq $2623
2621: EA       nop
2622: 60       rts
2623: 20 2E 23 jsr $232e
2626: 60       rts
2627: 20 64 26 jsr $2664
262A: A6 3D    ldx $3d
262C: BD 9B 27 lda $279b, x
262F: 85 0C    sta $0c
2631: BC A3 27 ldy $27a3, x
2634: 20 9E 26 jsr $269e
2637: A5 3D    lda $3d
2639: C9 03    cmp #$03
263B: F0 17    beq $2654
263D: EA       nop
263E: C9 01    cmp #$01
2640: F0 09    beq $264b
2642: EA       nop
2643: C9 02    cmp #$02
2645: F0 08    beq $264f
2647: EA       nop
2648: C6 10    dec $10
264A: 60       rts
264B: 20 16 23 jsr $2316
264E: 60       rts
264F: E6 10    inc $10
2651: 20 2E 23 jsr $232e
2654: 60       rts
2655: C6 0B    dec $0b
2657: 30 03    bmi $265c
2659: EA       nop
265A: 18       clc
265B: 60       rts
265C: 20 64 26 jsr $2664
265F: 20 A4 23 jsr $23a4								; Kick PRNG
2662: 38       sec
2663: 60       rts
2664: A9 04    lda #$04
2666: 85 0B    sta $0b
2668: 60       rts
2669: A5 0C    lda $0c
266B: 29 18    and #$18
266D: 85 0C    sta $0c
266F: F0 1C    beq $268d
2671: EA       nop
2672: C9 08    cmp #$08
2674: F0 0E    beq $2684
2676: EA       nop
2677: C9 10    cmp #$10
2679: F0 1B    beq $2696
267B: EA       nop
267C: A0 01    ldy #$01
267E: 20 9E 26 jsr $269e
2681: C6 10    dec $10
2683: 60       rts
2684: A0 00    ldy #$00
2686: 20 9E 26 jsr $269e
2689: 20 16 23 jsr $2316
268C: 60       rts
268D: A0 20    ldy #$20
268F: 20 9E 26 jsr $269e
2692: 20 2E 23 jsr $232e
2695: 60       rts
2696: A0 00    ldy #$00
2698: 20 9E 26 jsr $269e
269B: E6 10    inc $10
269D: 60       rts
269E: A9 20    lda #$20
26A0: 91 10    sta ($10), y
26A2: 60       rts
26A3: A5 0C    lda $0c
26A5: 29 1F    and #$1f
26A7: A0 00    ldy #$00
26A9: 91 10    sta ($10), y
26AB: E6 0C    inc $0c
26AD: A5 0C    lda $0c
26AF: 29 1F    and #$1f
26B1: A4 04    ldy $04
26B3: 91 10    sta ($10), y
26B5: A5 0C    lda $0c
26B7: 29 07    and #$07
26B9: C9 07    cmp #$07
26BB: F0 04    beq $26c1
26BD: EA       nop
26BE: E6 0C    inc $0c
26C0: 60       rts
26C1: A5 0C    lda $0c
26C3: 09 40    ora #$40
26C5: 85 0C    sta $0c
26C7: 60       rts
26C8: 20 00 27 jsr $2700
26CB: 20 59 23 jsr $2359								; ($10-11) = $4000
26CE: A9 80    lda #$80
26D0: 85 10    sta $10
26D2: A2 09    ldx #$09
26D4: A9 BA    lda #$ba
26D6: 20 E8 26 jsr $26e8
26D9: 20 16 23 jsr $2316
26DC: A9 BC    lda #$bc
26DE: 20 E8 26 jsr $26e8
26E1: 20 11 23 jsr $2311
26E4: CA       dex
26E5: D0 ED    bne $26d4
26E7: 60       rts
				
26E8: A0 03    ldy #$03
26EA: 85 03    sta $03
26EC: 85 04    sta $04
26EE: E6 04    inc $04
26F0: A5 03    lda $03
26F2: 91 10    sta ($10), y
26F4: C8       iny
26F5: A5 04    lda $04
26F7: 91 10    sta ($10), y
26F9: C8       iny
26FA: C8       iny
26FB: C0 1D    cpy #$1d
26FD: 90 F1    bcc $26f0
26FF: 60       rts
2700: 20 59 23 jsr $2359								; ($10-11) = $4000
2703: A9 42    lda #$42
2705: 85 10    sta $10
2707: A9 60    lda #$60
2709: 20 3D 27 jsr $273d
270C: 20 68 23 jsr $2368								; ($10-11) = $4300
270F: A9 E2    lda #$e2
2711: 85 10    sta $10
2713: A9 61    lda #$61
2715: 20 3D 27 jsr $273d
2718: 20 59 23 jsr $2359								; ($10-11) = $4000
271B: A9 60    lda #$60
271D: 85 10    sta $10
271F: A9 63    lda #$63
2721: 20 43 27 jsr $2743
2724: 20 59 23 jsr $2359								; ($10-11) = $4000
2727: A9 61    lda #$61
2729: 85 10    sta $10
272B: A9 62    lda #$62
272D: 20 48 27 jsr $2748
2730: 20 59 23 jsr $2359								; ($10-11) = $4000
2733: A9 61    lda #$61
2735: 85 10    sta $10
2737: A9 62    lda #$62
2739: 20 43 27 jsr $2743
273C: 60       rts
273D: A0 1C    ldy #$1c
273F: 20 53 23 jsr $2353
2742: 60       rts
2743: A0 1E    ldy #$1e
2745: 4C 4A 27 jmp $274a
2748: A0 00    ldy #$00
274A: A2 1C    ldx #$1c
274C: 91 10    sta ($10), y
274E: 48       pha
274F: 20 16 23 jsr $2316
2752: 68       pla
2753: CA       dex
2754: D0 F6    bne $274c
2756: 60       rts
				
2757: 43 42															; DATA 
2759: 23 44															; DATA 
275B: 41 22															; DATA 
275D: 03 24															; DATA 
275F: 45 62															; DATA 
2761: 64 61															; DATA 
2763: 65 60															; DATA 
2765: 66 00															; DATA 
2767: 43 44															; DATA 
2769: 63 42															; DATA 
276B: 45 64															; DATA 
276D: 83 62															; DATA 
276F: 41 24															; DATA 
2771: 22 25															; DATA 
2773: 21 26															; DATA 
2775: 20 00															; DATA 
2777: 62 42															; DATA 
2779: 63 82															; DATA 
277B: 22 43															; DATA 
277D: 64 83															; DATA 
277E: A2 41															; DATA 
2781: 81 21															; DATA 
2783: A1 01															; DATA 
2785: 61 00															; DATA 
2787: 62 82															; DATA 
2789: 61 42															; DATA 
278B: A2 81															; DATA 
278D: 60 41															; DATA 
278F: 22 83															; DATA 
2791: 43 A3															; DATA 
2793: 23 C3															; DATA 
2795: 03   															; DATA 

2797: 10 18 08 00												; DATA 
279B: 18 10 00 08												; DATA 
279F: 20 00 00 01												; DATA 
27A3: 20 00 00 01												; DATA 
27A7: 00 1F 01 00												; DATA 
27AB: 04 20 40 04												; DATA 
27AF: 08 40 20 08												; DATA 
27B3: 00 02 01 80												; DATA 
27B7: 02 00 80 01												; DATA 
27BB: 01 80 02 00												; DATA 
27BF: 80 01 00 02												; DATA 
27C3: 02 03 04 05												; DATA 
				

27c7: 45 4e 44 20 4f 46 20 47						; DATA END_OF_G
27cf: 41 4d 45 00												; DATA AME

27d3: 54 41 52 47 00										; DATA TARG

27d8: 47 45 54 20 52 45 41 44						; DATA GET_READ
27e0: 59 00															; DATA Y

27e2: 50 4c 41 59 45 52 20 20						; DATA PLAYER__
27ea: 20 00															; DATA _

27ec: 31 30 20 50 4f 49 4e 54						; DATA 10_POINT
27f4: 53 00															; DATA S
				
27F6: D3 27															; ADDR  
27F8: D8 27															; ADDR  
27FA: EC 27															; ADDR  
				
27FC: 00 38															; ADDR  (Char data source)
				
27FE: 20 20 A5 jsr $a520
2801: 3E 10 07 rol $0710, x
2804: EA       nop
2805: 20 F3 29 jsr $29f3
2808: 4C 20 28 jmp $2820
280B: A5 B1    lda $b1
280D: C9 03    cmp #$03
280F: 90 0F    bcc $2820
2811: EA       nop
2812: C6 0E    dec $0e
2814: F0 06    beq $281c
2816: EA       nop
2817: A9 FF    lda #$ff
2819: 85 B2    sta $b2
281B: 60       rts
281C: A5 B1    lda $b1
281E: 85 0E    sta $0e
2820: A6 3D    ldx $3d
2822: A5 2D    lda $2d
2824: 10 03    bpl $2829
2826: EA       nop
2827: 49 FF    eor #$ff
2829: 85 00    sta $00
282B: A5 2C    lda $2c
282D: 10 03    bpl $2832
282F: EA       nop
2830: 49 FF    eor #$ff
2832: C5 00    cmp $00
2834: B0 12    bcs $2848
2836: EA       nop
2837: A5 2D    lda $2d
2839: 10 07    bpl $2842
283B: EA       nop
283C: BD BB 27 lda $27bb, x
283F: 4C 56 28 jmp $2856
2842: BD BF 27 lda $27bf, x
2845: 4C 56 28 jmp $2856
2848: A5 2C    lda $2c
284A: 10 07    bpl $2853
284C: EA       nop
284D: BD B3 27 lda $27b3, x
2850: 4C 56 28 jmp $2856
2853: BD B7 27 lda $27b7, x
2856: F0 04    beq $285c
2858: EA       nop
2859: 85 B2    sta $b2
285B: 60       rts
285C: A5 3E    lda $3e
285E: 10 2B    bpl $288b
2860: EA       nop
2861: A5 1A    lda $1a
2863: 29 03    and #$03
2865: 18       clc
2866: 65 3D    adc $3d
2868: C9 01    cmp #$01
286A: F0 09    beq $2875
286C: EA       nop
286D: C9 05    cmp #$05
286F: F0 0E    beq $287f
2871: EA       nop
2872: 4C 8B 28 jmp $288b
2875: A5 30    lda $30
2877: 29 10    and #$10
2879: D0 0B    bne $2886
287B: EA       nop
287C: 4C 8B 28 jmp $288b
287F: A5 30    lda $30
2881: 29 08    and #$08
2883: F0 06    beq $288b
2885: EA       nop
2886: A9 03    lda #$03
2888: 85 B2    sta $b2
288A: 60       rts
288B: A9 00    lda #$00
288D: 85 B2    sta $b2
288F: 60       rts
2890: A9 80    lda #$80
2892: 85 B2    sta $b2
2894: 60       rts
2895: A9 01    lda #$01
2897: 85 B2    sta $b2
2899: 60       rts
289A: 20 14 25 jsr $2514
289D: 20 9A 29 jsr $299a
28A0: A5 0C    lda $0c
28A2: 29 18    and #$18
28A4: 4A       lsr a
28A5: 4A       lsr a
28A6: 4A       lsr a
28A7: 85 3D    sta $3d
28A9: A9 00    lda #$00
28AB: 85 05    sta $05
28AD: 20 00 28 jsr $2800
28B0: 20 85 25 jsr $2585
28B3: A5 05    lda $05
28B5: 29 01    and #$01
28B7: F0 0B    beq $28c4
28B9: EA       nop
28BA: A5 41    lda $41
28BC: C9 3A    cmp #$3a
28BE: B0 19    bcs $28d9
28C0: EA       nop
28C1: 4C F9 24 jmp $24f9
28C4: 20 58 25 jsr $2558
28C7: A5 05    lda $05
28C9: 29 06    and #$06
28CB: F0 0C    beq $28d9
28CD: EA       nop
28CE: C9 02    cmp #$02
28D0: F0 04    beq $28d6
28D2: EA       nop
28D3: 4C 05 26 jmp $2605
28D6: 4C 27 26 jmp $2627
28D9: 20 9A 25 jsr $259a
28DC: A5 05    lda $05
28DE: 30 1F    bmi $28ff
28E0: EA       nop
28E1: 29 18    and #$18
28E3: F0 17    beq $28fc
28E5: EA       nop
28E6: C9 08    cmp #$08
28E8: F0 0F    beq $28f9
28EA: EA       nop
28EB: C9 10    cmp #$10
28ED: F0 07    beq $28f6
28EF: EA       nop
28F0: 20 A4 23 jsr $23a4								; Kick PRNG
28F3: 30 04    bmi $28f9
28F5: EA       nop
28F6: 4C 27 26 jmp $2627
28F9: 4C 05 26 jmp $2605
28FC: 4C F9 24 jmp $24f9
28FF: A5 05    lda $05
2901: 29 18    and #$18
2903: F0 22    beq $2927
2905: EA       nop
2906: C9 18    cmp #$18
2908: F0 26    beq $2930
290A: EA       nop
290B: A5 3E    lda $3e
290D: 30 40    bmi $294f
290F: EA       nop
2910: 20 55 26 jsr $2655
2913: 90 12    bcc $2927
2915: EA       nop
2916: 30 0F    bmi $2927
2918: EA       nop
2919: A5 05    lda $05
291B: 29 18    and #$18
291D: C9 08    cmp #$08
291F: F0 0C    beq $292d
2921: EA       nop
2922: C9 10    cmp #$10
2924: F0 04    beq $292a
2926: EA       nop
2927: 4C 74 29 jmp $2974
292A: 4C 27 26 jmp $2627
292D: 4C 05 26 jmp $2605
2930: A5 B2    lda $b2
2932: F0 F3    beq $2927
2934: C9 03    cmp #$03
2936: F0 0D    beq $2945
2938: EA       nop
2939: C9 01    cmp #$01
293B: F0 ED    beq $292a
293D: C9 80    cmp #$80
293F: F0 EC    beq $292d
2941: C9 02    cmp #$02
2943: F0 B7    beq $28fc
2945: 20 55 26 jsr $2655
2948: 90 DD    bcc $2927
294A: 30 DE    bmi $292a
294C: 4C 2D 29 jmp $292d
294F: A5 B2    lda $b2
2951: F0 D4    beq $2927
2953: 30 0D    bmi $2962
2955: EA       nop
2956: C9 01    cmp #$01
2958: F0 11    beq $296b
295A: EA       nop
295B: C9 02    cmp #$02
295D: F0 9D    beq $28fc
295F: 4C 19 29 jmp $2919
2962: A5 05    lda $05
2964: 29 10    and #$10
2966: D0 C5    bne $292d
2968: 4C 27 29 jmp $2927
296B: A5 05    lda $05
296D: 29 08    and #$08
296F: D0 B9    bne $292a
2971: 4C 27 29 jmp $2927
2974: 20 69 26 jsr $2669
2977: 60       rts
2978: A0 00    ldy #$00
297A: B1 10    lda ($10), y
297C: C9 21    cmp #$21
297E: F0 18    beq $2998
2980: EA       nop
2981: A5 0C    lda $0c
2983: 29 10    and #$10
2985: D0 06    bne $298d
2987: EA       nop
2988: A0 20    ldy #$20
298A: 4C 8F 29 jmp $298f
298D: A0 01    ldy #$01
298F: B1 10    lda ($10), y
2991: C9 21    cmp #$21
2993: F0 03    beq $2998
2995: EA       nop
2996: 18       clc
2997: 60       rts
2998: 38       sec
2999: 60       rts
299A: 20 2C 22 jsr $222c
299D: A5 2D    lda $2d
299F: 10 03    bpl $29a4
29A1: EA       nop
29A2: 49 FF    eor #$ff
29A4: C9 07    cmp #$07
29A6: B0 2F    bcs $29d7
29A8: EA       nop
29A9: C9 02    cmp #$02
29AB: B0 07    bcs $29b4
29AD: EA       nop
29AE: A5 30    lda $30
29B0: 09 10    ora #$10
29B2: 85 30    sta $30
29B4: A5 2C    lda $2c
29B6: 10 03    bpl $29bb
29B8: EA       nop
29B9: 49 FF    eor #$ff
29BB: C9 07    cmp #$07
29BD: B0 18    bcs $29d7
29BF: EA       nop
29C0: C9 02    cmp #$02
29C2: B0 07    bcs $29cb
29C4: EA       nop
29C5: A5 30    lda $30
29C7: 09 08    ora #$08
29C9: 85 30    sta $30
29CB: A5 3E    lda $3e
29CD: 09 80    ora #$80
29CF: 85 3E    sta $3e
29D1: A9 01    lda #$01
29D3: 85 0F    sta $0f
29D5: 18       clc
29D6: 60       rts
29D7: A5 B1    lda $b1
29D9: C9 04    cmp #$04
29DB: B0 08    bcs $29e5
29DD: EA       nop
29DE: A5 3E    lda $3e
29E0: 09 80    ora #$80
29E2: 85 3E    sta $3e
29E4: 60       rts
29E5: A5 30    lda $30
29E7: 29 E7    and #$e7
29E9: 85 30    sta $30
29EB: A5 3E    lda $3e
29ED: 29 7F    and #$7f
29EF: 85 3E    sta $3e
29F1: 38       sec
29F2: 60       rts
29F3: A5 1A    lda $1a
29F5: 29 03    and #$03
29F7: F0 10    beq $2a09
29F9: EA       nop
29FA: C9 01    cmp #$01
29FC: F0 1B    beq $2a19
29FE: EA       nop
29FF: C9 02    cmp #$02
2A01: F0 26    beq $2a29
2A03: EA       nop
2A04: E6 2A    inc $2a
2A06: 4C 2B 2A jmp $2a2b
2A09: A9 20    lda #$20
2A0B: 18       clc
2A0C: 65 2A    adc $2a
2A0E: 85 2A    sta $2a
2A10: A5 2B    lda $2b
2A12: 69 00    adc #$00
2A14: 85 2B    sta $2b
2A16: 4C 2B 2A jmp $2a2b
2A19: A5 2A    lda $2a
2A1B: 38       sec
2A1C: E9 20    sbc #$20
2A1E: 85 2A    sta $2a
2A20: A5 2B    lda $2b
2A22: E9 00    sbc #$00
2A24: 85 2B    sta $2b
2A26: 4C 2B 2A jmp $2a2b
2A29: C6 2A    dec $2a
2A2B: 20 2F 22 jsr $222f
2A2E: 60       rts

				;; Split nybbles
2A2F: A8       tay											; Stash a
2A30: 4A       lsr a										; a>>1
2A31: 4A       lsr a										; a>>2
2A32: 4A       lsr a										; a>>3
2A33: 4A       lsr a										; a>>4
2A34: 48       pha											; Hi nybble 
2A35: 98       tya
2A36: 29 0F    and #$0f									; Low nybble 
2A38: A8       tay											; Stash in y 
2A39: 68       pla											; Hi nybble
2A3A: 60       rts

				;; Draw player scores
2A3B: A0 00    ldy #$00									; P1  
2A3D: A2 00    ldx #$00									; P1 offset 
2A3F: 20 46 2A jsr $2a46
				 
2A42: A0 01    ldy #$01									; P2 
2A44: A2 18    ldx #$18									; P2 offset 
2A46: B9 D0 00 lda $00d0, y							; Score lo 
2A49: 85 03    sta $03
2A4B: B9 D2 00 lda $00d2, y							; Score hi 
2A4E: 20 60 2A jsr $2a60								; Draw 2 byte score from a, $03
2A51: 60       rts

				;; Add a to current player score & redraw
				;; (X = offset)
2A52: F8       sed
2A53: 18       clc
2A54: 65 BD    adc $bd
2A56: 85 BD    sta $bd
2A58: 85 03    sta $03
2A5A: A5 BE    lda $be
2A5C: 69 00    adc #$00
2A5E: 85 BE    sta $be

				;; Draw 2 byte score from a, $03 + 0
2A60: 20 6A 2A jsr $2a6a
2A63: A9 30    lda #$30
2A65: 9D 22 40 sta $4022, x							; Append 0 
2A68: D8       cld
2A69: 60       rts

				;; Draw 2-byte score from a, $03
2A6A: 20 6F 2A jsr $2a6f								; Do hi byte 
2A6D: A5 03    lda $03									; Get lo byte 
				
2A6F: 20 2F 2A jsr $2a2f								; Split nybbles
2A72: 20 76 2A jsr $2a76								; Do hi nubble 
2A75: 98       tya											; Get lo nybble 
2A76: 09 30    ora #$30									; BCD to char 
2A78: 9D 22 40 sta $4022, x							; Store to screen 
2A7B: E8       inx
2A7C: 60       rts
				
2A7D: A5 BF    lda $bf
2A7F: C9 01    cmp #$01
2A81: F0 06    beq $2a89
2A83: EA       nop
2A84: A2 09    ldx #$09
2A86: 4C 8B 2A jmp $2a8b
2A89: A2 00    ldx #$00
2A8B: A9 64    lda #$64
2A8D: A4 C1    ldy $c1
2A8F: 9D 2A 40 sta $402a, x
2A92: E8       inx
2A93: 88       dey
2A94: D0 F9    bne $2a8f
2A96: 60       rts
2A97: A5 3E    lda $3e
2A99: 29 02    and #$02
2A9B: D0 1D    bne $2aba
2A9D: EA       nop
2A9E: E6 16    inc $16
2AA0: 30 02    bmi $2aa4
2AA2: EA       nop
2AA3: 60       rts
2AA4: 20 A4 23 jsr $23a4								; Kick PRNG
2AA7: 29 47    and #$47
2AA9: C9 40    cmp #$40
2AAB: F0 06    beq $2ab3
2AAD: EA       nop
2AAE: A9 00    lda #$00
2AB0: 85 16    sta $16
2AB2: 60       rts
2AB3: A5 3E    lda $3e
2AB5: 09 02    ora #$02
2AB7: 85 3E    sta $3e
2AB9: 60       rts
2ABA: 20 76 2E jsr $2e76
2ABD: 60       rts
2ABE: A2 07    ldx #$07
2AC0: B5 96    lda $96, x
2AC2: 95 0B    sta $0b, x
2AC4: CA       dex
2AC5: 10 F9    bpl $2ac0
2AC7: C6 0F    dec $0f
2AC9: 10 17    bpl $2ae2
2ACB: EA       nop
2ACC: A5 B0    lda $b0
2ACE: C9 08    cmp #$08
2AD0: 90 06    bcc $2ad8
2AD2: EA       nop
2AD3: A9 02    lda #$02
2AD5: 4C DF 2A jmp $2adf
2AD8: 49 FF    eor #$ff
2ADA: 29 07    and #$07
2ADC: 18       clc
2ADD: 69 02    adc #$02
2ADF: 20 07 2D jsr $2d07
2AE2: A2 07    ldx #$07
2AE4: B5 0B    lda $0b, x
2AE6: 95 96    sta $96, x
2AE8: CA       dex
2AE9: 10 F9    bpl $2ae4
2AEB: 24 A7    bit $a7
2AED: 10 31    bpl $2b20
2AEF: EA       nop
2AF0: 24 0C    bit $0c
2AF2: 30 2C    bmi $2b20
2AF4: EA       nop
2AF5: 24 0D    bit $0d
2AF7: 30 27    bmi $2b20
2AF9: EA       nop
2AFA: A9 EF    lda #$ef
2AFC: 20 CA 23 jsr $23ca
2AFF: 24 3E    bit $3e
2B01: 30 29    bmi $2b2c
2B03: EA       nop
2B04: A5 2D    lda $2d
2B06: F0 24    beq $2b2c
2B08: EA       nop
2B09: A5 2C    lda $2c
2B0B: F0 1F    beq $2b2c
2B0D: EA       nop
2B0E: A5 30    lda $30
2B10: 29 18    and #$18
2B12: D0 18    bne $2b2c
2B14: EA       nop
2B15: A9 FE    lda #$fe
2B17: 20 CA 23 jsr $23ca
2B1A: A9 08    lda #$08
2B1C: 20 CF 23 jsr $23cf
2B1F: 60       rts
2B20: A5 A3    lda $a3
2B22: 29 F0    and #$f0
2B24: 09 10    ora #$10
2B26: 85 A3    sta $a3
2B28: 8D 00 52 sta $5200
2B2B: 60       rts
2B2C: A9 F7    lda #$f7
2B2E: 20 CA 23 jsr $23ca
2B31: A9 01    lda #$01
2B33: 20 CF 23 jsr $23cf
2B36: 60       rts

				;; ($10-11) = $4343
2B37: A0 00    ldy #$00
2B39: A9 43    lda #$43
2B3B: 85 10    sta $10
2B3D: 85 11    sta $11

				;; ($14-15) = $2fc8
2B3F: B9 F8 2F lda $2ff8, y
2B42: 85 14    sta $14
2B44: C8       iny
2B45: B9 F8 2F lda $2ff8, y
2B48: 99 14 00 sta $0014, y
2B4B: 20 FE 22 jsr $22fe								; Draw string
2B4E: 60       rts

				;; Draw DEPOSIT COIN
2B4F: 20 63 2B jsr $2b63
2B52: A5 A1    lda $a1									; Credits
2B54: D0 02    bne $2b58
2B56: EA       nop
2B57: 60       rts

				;; Draw OR_PRESS_START
2B58: A0 02    ldy #$02									; Next string

				;; ($11-10) = $420a
2B5A: A9 0A    lda #$0a
2B5C: 85 10    sta $10
2B5E: A9 42    lda #$42
2B60: 4C 6B 2B jmp $2b6b

				;; ($10-11) = $41eb
2B63: A0 00    ldy #$00
2B65: A9 EB    lda #$eb
2B67: 85 10    sta $10
2B69: A9 41    lda #$41
2B6B: 85 11    sta $11

				;; ($14-15) = $2f7f = DEPOSIT_COIN
2B6D: B9 EE 2F lda $2fee, y 
2B70: 85 14    sta $14
2B72: C8       iny
2B73: B9 EE 2F lda $2fee, y
2B76: 85 15    sta $15
2B78: 20 FE 22 jsr $22fe								; Draw string
				
2B7B: 60       rts

				;; Set up quarter coinage

				;; ($10-11) = $4169 (screen location)
2B7C: A9 69    lda #$69
2B7E: 85 10    sta $10
2B80: A9 41    lda #$41
2B82: 85 11    sta $11
2B84: AD 00 51 lda $5100												; DIPs 
2B87: 29 18    and #$18													; Mask coinage 
2B89: D0 02    bne $2b8d												; Non 1C_1P setting 
2B8B: EA       nop
2B8C: 60       rts															; No display for 1C/1P 
				
2B8D: C9 18    cmp #$18
2B8F: F0 0B    beq $2b9c												; == $18  
2B91: EA       nop
				
2B92: C9 08    cmp #$08
2B94: F0 0B    beq $2ba1												; == $08 
2B96: EA       nop

				;; $10 = 2C/1P
2B97: A0 06    ldy #$06
2B99: 4C A3 2B jmp $2ba3

				;; $18 = 1C/2P
2B9C: A0 00    ldy #$00
2B9E: 4C A3 2B jmp $2ba3

				;; $08 = 1C/1C (with display)
				;; ($14-15) = $2f37
2BA1: A0 02    ldy #$02
2BA3: B9 E4 2F lda $2fe4, y
2BA6: 85 14    sta $14
2BA8: C8       iny
2BA9: B9 E4 2F lda $2fe4, y
2BAC: 85 15    sta $15
2BAE: 20 FE 22 jsr $22fe								; Draw string
				
2BB1: AD 00 51 lda $5100								; DIPs 
2BB4: 29 18    and #$18
2BB6: C9 18    cmp #$18
2BB8: D0 02    bne $2bbc
2BBA: EA       nop
2BBB: 60       rts
				
2BBC: A9 77    lda #$77
2BBE: 85 10    sta $10
2BC0: C8       iny
2BC1: 20 00 23 jsr $2300								; Draw next string
				
2BC4: 60       rts

				
				;; Garbage code
2BC5: AD 05 51 lda $5105								; Control inputs 
2BC8: 29 18    and #$18									; Mask B1, Left
2BCA: C9 10    cmp #$10									; Left only?
2BCC: D0 09    bne $2bd7
2BCE: EA       nop
				
2BCF: A5 A0    lda $a0									; Half coins 
2BD1: C9 02    cmp #$02
2BD3: B0 02    bcs $2bd7								; <2 
2BD5: EA       nop
2BD6: 60       rts
				;; Until here

				
				;; Add credit
2BD7: A5 A1    lda $a1									; Credits 
2BD9: C9 99    cmp #$99
2BDB: D0 02    bne $2bdf								; <99 
2BDD: EA       nop
2BDE: 60       rts

				;; Increment credits BCD
2BDF: F8       sed 
2BE0: 18       clc
2BE1: 69 01    adc #$01
2BE3: 85 A1    sta $a1
2BE5: D8       cld
2BE6: A9 00    lda #$00
2BE8: 85 A0    sta $a0									; Clear half coins 


				;; Draw CREDITS_##
				;; ($10-11) = $400c
2BEA: A0 00    ldy #$00
2BEC: A9 0C    lda #$0c
2BEE: 85 10    sta $10
2BF0: A9 40    lda #$40
2BF2: 85 11    sta $11

				;; ($14-15) = $2fa1	= CREDITS
2BF4: B9 F4 2F lda $2ff4, y
2BF7: 85 14    sta $14
2BF9: C8       iny
2BFA: B9 F4 2F lda $2ff4, y
2BFD: 85 15    sta $15
2BFF: 20 FE 22 jsr $22fe								; Draw string 

				;; (Duplicate of above)
				;; ($14-15) = $2fa1 = CREDITS
2C02: A0 00    ldy #$00
2C04: B9 F4 2F lda $2ff4, y
2C07: 85 14    sta $14
2C09: C8       iny
2C0A: B9 F4 2F lda $2ff4, y
2C0D: 85 15    sta $15

				;; ($10-11) = $400c
2C0F: A9 40    lda #$40
2C11: 85 11    sta $11
2C13: A9 0C    lda #$0c
2C15: 85 10    sta $10
				
2C17: 20 FE 22 jsr $22fe								; Draw string

2C1A: A5 A1    lda $a1
2C1C: 20 2F 2A jsr $2a2f								; Split nybbles
2C1F: 09 30    ora #$30
2C21: 8D 14 40 sta $4014
2C24: 98       tya
2C25: 09 30    ora #$30
2C27: 8D 15 40 sta $4015
2C2A: 60       rts
2C2B: A9 71    lda #$71
2C2D: 85 10    sta $10
2C2F: A9 6E    lda #$6e
2C31: 85 11    sta $11
2C33: A4 B1    ldy $b1
2C35: A2 00    ldx #$00
2C37: 20 A4 23 jsr $23a4								; Kick PRNG
2C3A: 29 0F    and #$0f
2C3C: 95 50    sta $50, x
2C3E: E8       inx
2C3F: A9 08    lda #$08
2C41: 95 50    sta $50, x
2C43: E8       inx
2C44: 98       tya
2C45: F0 0A    beq $2c51
2C47: EA       nop
2C48: 30 07    bmi $2c51
2C4A: EA       nop
2C4B: A9 00    lda #$00
2C4D: 88       dey
2C4E: 4C 53 2C jmp $2c53
2C51: A9 A0    lda #$a0
2C53: 95 50    sta $50, x
2C55: E8       inx
2C56: A5 B1    lda $b1
2C58: 95 50    sta $50, x
2C5A: E8       inx
2C5B: A9 1F    lda #$1f
2C5D: 95 50    sta $50, x
2C5F: E8       inx
2C60: 8A       txa
2C61: 29 01    and #$01
2C63: F0 0C    beq $2c71
2C65: EA       nop
2C66: A5 10    lda $10
2C68: E6 10    inc $10
2C6A: E6 10    inc $10
2C6C: E6 10    inc $10
2C6E: 4C 79 2C jmp $2c79
2C71: A5 11    lda $11
2C73: C6 11    dec $11
2C75: C6 11    dec $11
2C77: C6 11    dec $11
2C79: 95 50    sta $50, x
2C7B: E8       inx
2C7C: A9 40    lda #$40
2C7E: 95 50    sta $50, x
2C80: E8       inx
2C81: E0 45    cpx #$45
2C83: 90 B2    bcc $2c37
2C85: A5 B1    lda $b1
2C87: C9 03    cmp #$03
2C89: B0 0D    bcs $2c98
2C8B: EA       nop
2C8C: A9 18    lda #$18
2C8E: A2 01    ldx #$01
2C90: 95 50    sta $50, x
2C92: A9 10    lda #$10
2C94: A2 08    ldx #$08
2C96: 95 50    sta $50, x
2C98: 60       rts
				
2C99: A5 30    lda $30
2C9B: 29 7F    and #$7f
2C9D: 85 30    sta $30
2C9F: 24 30    bit $30
2CA1: 30 F6    bmi $2c99
				
2CA3: A6 2F    ldx $2f
2CA5: A0 00    ldy #$00
2CA7: B9 FA 2F lda $2ffa, y
2CAA: 85 32    sta $32
2CAC: C8       iny
2CAD: B9 FA 2F lda $2ffa, y
2CB0: 85 33    sta $33
2CB2: 8A       txa
2CB3: 48       pha
2CB4: 20 BD 2C jsr $2cbd
2CB7: 68       pla
2CB8: AA       tax
2CB9: CA       dex
2CBA: D0 F6    bne $2cb2
2CBC: 60       rts

				;; Copy bytes from ($32-33) == $0050 to $000b
2CBD: A0 00    ldy #$00
2CBF: B1 32    lda ($32), y
2CC1: 99 0B 00 sta $000b, y
2CC4: C8       iny
2CC5: C0 07    cpy #$07
2CC7: D0 F6    bne $2cbf								; Loop 
				
2CC9: 20 E6 2C jsr $2ce6
				
				;; Copy bytes from $000b to ($32-33) == $0050
2CCC: A0 00    ldy #$00
2CCE: B9 0B 00 lda $000b, y
2CD1: 91 32    sta ($32), y
2CD3: C8       iny
2CD4: C0 07    cpy #$07
2CD6: D0 F6    bne $2cce								; Loop 

				;; $32-33 += 7
2CD8: A5 32    lda $32
2CDA: 18       clc
2CDB: 69 07    adc #$07
2CDD: 85 32    sta $32
2CDF: A5 33    lda $33
2CE1: 69 00    adc #$00
2CE3: 85 33    sta $33
2CE5: 60       rts

				
2CE6: C6 0F    dec $0f
2CE8: 30 02    bmi $2cec								; $0f was 0 
2CEA: EA       nop
				
2CEB: 60       rts
				
2CEC: A5 0D    lda $0d
2CEE: 29 20    and #$20									; Mask bit 5 
2CF0: F0 02    beq $2cf4								; Clear
2CF2: EA       nop
				
2CF3: 60       rts
				
2CF4: A5 B1    lda $b1
2CF6: C9 04    cmp #$04
2CF8: 90 0A    bcc $2d04
2CFA: EA       nop
				
2CFB: A9 00    lda #$00
2CFD: 85 0E    sta $0e
2CFF: A9 04    lda #$04
2D01: 4C 07 2D jmp $2d07
				
2D04: 18       clc
2D05: 65 28    adc $28
				
2D07: 85 0F    sta $0f
2D09: 20 78 29 jsr $2978
2D0C: B0 43    bcs $2d51
2D0E: EA       nop
				
2D0F: A5 0C    lda $0c
2D11: 30 3E    bmi $2d51
2D13: EA       nop
				
2D14: 29 40    and #$40
2D16: F0 04    beq $2d1c
2D18: EA       nop
				
2D19: 20 9A 28 jsr $289a
2D1C: A5 0C    lda $0c
2D1E: 29 10    and #$10
2D20: D0 06    bne $2d28
2D22: EA       nop
				
2D23: A9 20    lda #$20
2D25: 4C 2A 2D jmp $2d2a
				
2D28: A9 01    lda #$01
2D2A: 85 04    sta $04
2D2C: A5 0D    lda $0d
2D2E: 29 40    and #$40
2D30: D0 05    bne $2d37
2D32: EA       nop
				
2D33: 20 A3 26 jsr $26a3
2D36: 60       rts
				
2D37: A5 0C    lda $0c
2D39: 29 1F    and #$1f
2D3B: 09 C0    ora #$c0
2D3D: 85 03    sta $03
2D3F: A0 00    ldy #$00
2D41: 91 10    sta ($10), y
2D43: E6 03    inc $03
2D45: A5 03    lda $03
2D47: A4 04    ldy $04
2D49: 91 10    sta ($10), y
2D4B: E6 0C    inc $0c
2D4D: 20 B3 26 jsr $26b3
2D50: 60       rts
2D51: A5 0C    lda $0c
2D53: 30 13    bmi $2d68
2D55: EA       nop
2D56: A9 21    lda #$21
2D58: 20 7B 2D jsr $2d7b
2D5B: A5 0C    lda $0c
2D5D: 09 80    ora #$80
2D5F: 85 0C    sta $0c
2D61: A9 01    lda #$01
2D63: 85 BC    sta $bc
2D65: C6 B1    dec $b1
2D67: 60       rts
2D68: A5 0D    lda $0d
2D6A: 30 0E    bmi $2d7a
2D6C: EA       nop
2D6D: A5 0D    lda $0d
2D6F: 09 80    ora #$80
2D71: 85 0D    sta $0d
2D73: A0 00    ldy #$00
2D75: A9 20    lda #$20
2D77: 20 7B 2D jsr $2d7b
2D7A: 60       rts
2D7B: 85 03    sta $03
2D7D: A0 00    ldy #$00
2D7F: 91 10    sta ($10), y
2D81: A5 0C    lda $0c
2D83: 29 10    and #$10
2D85: D0 06    bne $2d8d
2D87: EA       nop
2D88: A0 20    ldy #$20
2D8A: 4C 8F 2D jmp $2d8f
2D8D: A0 01    ldy #$01
2D8F: A5 03    lda $03
2D91: 91 10    sta ($10), y
2D93: 60       rts
2D94: 20 73 24 jsr $2473
2D97: A5 20    lda $20
2D99: 29 3F    and #$3f
2D9B: 85 21    sta $21
2D9D: A5 31    lda $31
2D9F: D0 0C    bne $2dad
2DA1: EA       nop
2DA2: A9 00    lda #$00
2DA4: 85 C2    sta $c2
2DA6: A5 1A    lda $1a
2DA8: 09 F0    ora #$f0
2DAA: 85 1A    sta $1a
2DAC: 60       rts
2DAD: C6 27    dec $27
2DAF: D0 16    bne $2dc7
2DB1: EA       nop
2DB2: E6 C2    inc $c2
2DB4: 20 75 22 jsr $2275
2DB7: A0 00    ldy #$00
2DB9: B1 2A    lda ($2a), y
2DBB: C9 20    cmp #$20
2DBD: D0 09    bne $2dc8
2DBF: EA       nop
2DC0: 20 AE 24 jsr $24ae
2DC3: A5 26    lda $26
2DC5: 85 27    sta $27
2DC7: 60       rts
2DC8: 85 03    sta $03
2DCA: A5 C2    lda $c2
2DCC: C9 06    cmp #$06
2DCE: 90 F0    bcc $2dc0
2DD0: A9 21    lda #$21
2DD2: 91 2A    sta ($2a), y
2DD4: A5 1A    lda $1a
2DD6: 09 F0    ora #$f0
2DD8: 85 1A    sta $1a
2DDA: A5 30    lda $30
2DDC: 09 04    ora #$04
2DDE: 85 30    sta $30
2DE0: A9 00    lda #$00
2DE2: 85 31    sta $31
2DE4: A5 03    lda $03
2DE6: C9 C0    cmp #$c0
2DE8: B0 02    bcs $2dec
2DEA: EA       nop
2DEB: 60       rts
2DEC: A5 3E    lda $3e
2DEE: 29 9F    and #$9f
2DF0: 85 3E    sta $3e
2DF2: A9 00    lda #$00
2DF4: 85 B8    sta $b8
2DF6: A9 80    lda #$80
2DF8: 85 B9    sta $b9
2DFA: 20 A4 23 jsr $23a4								; Kick PRNG
2DFD: 09 C0    ora #$c0
2DFF: 85 B3    sta $b3
2E01: 20 AA 2E jsr $2eaa
2E04: A9 80    lda #$80
2E06: 85 BC    sta $bc
2E08: A5 3E    lda $3e
2E0A: 29 FD    and #$fd
2E0C: 85 3E    sta $3e
2E0E: E6 B0    inc $b0
2E10: 60       rts
2E11: A5 B8    lda $b8
2E13: C9 08    cmp #$08
2E15: B0 08    bcs $2e1f
2E17: EA       nop
2E18: A5 97    lda $97
2E1A: 09 80    ora #$80
2E1C: 85 97    sta $97
2E1E: 60       rts
2E1F: A5 3E    lda $3e
2E21: 29 20    and #$20
2E23: F0 02    beq $2e27
2E25: EA       nop
2E26: 60       rts
2E27: A5 B4    lda $b4
2E29: 38       sec
2E2A: E9 20    sbc #$20
2E2C: 85 9B    sta $9b
2E2E: A5 B5    lda $b5
2E30: E9 00    sbc #$00
2E32: 85 9C    sta $9c
2E34: A0 00    ldy #$00
2E36: B1 9B    lda ($9b), y
2E38: C9 20    cmp #$20
2E3A: F0 02    beq $2e3e
2E3C: EA       nop
2E3D: 60       rts
2E3E: C6 9B    dec $9b
2E40: B1 9B    lda ($9b), y
2E42: E6 9B    inc $9b
2E44: C9 20    cmp #$20
2E46: F0 02    beq $2e4a
2E48: EA       nop
2E49: 60       rts
2E4A: C8       iny
2E4B: B1 9B    lda ($9b), y
2E4D: C9 20    cmp #$20
2E4F: F0 02    beq $2e53
2E51: EA       nop
2E52: 60       rts
2E53: 20 A4 23 jsr $23a4								; Kick PRNG
2E56: 29 08    and #$08
2E58: 09 12    ora #$12
2E5A: 85 97    sta $97
2E5C: A9 43    lda #$43
2E5E: 85 98    sta $98
2E60: A9 04    lda #$04
2E62: 85 96    sta $96
2E64: A9 01    lda #$01
2E66: 85 9A    sta $9a
2E68: A5 3E    lda $3e
2E6A: 09 20    ora #$20
2E6C: 85 3E    sta $3e
2E6E: A9 8C    lda #$8c
2E70: 85 B9    sta $b9
2E72: 20 95 2E jsr $2e95
2E75: 60       rts
2E76: A5 3E    lda $3e
2E78: 29 20    and #$20
2E7A: F0 02    beq $2e7e
2E7C: EA       nop
2E7D: 60       rts
2E7E: C6 B3    dec $b3
2E80: F0 02    beq $2e84
2E82: EA       nop
2E83: 60       rts
2E84: A9 2F    lda #$2f
2E86: 85 B3    sta $b3
2E88: E6 B8    inc $b8
2E8A: A5 B9    lda $b9
2E8C: C9 90    cmp #$90
2E8E: 90 05    bcc $2e95
2E90: EA       nop
2E91: A9 80    lda #$80
2E93: 85 B9    sta $b9
2E95: A0 00    ldy #$00
2E97: 20 9C 2E jsr $2e9c
2E9A: A0 20    ldy #$20
2E9C: A5 B9    lda $b9
2E9E: 91 B4    sta ($b4), y
2EA0: C8       iny
2EA1: E6 B9    inc $b9
2EA3: A5 B9    lda $b9
2EA5: 91 B4    sta ($b4), y
2EA7: E6 B9    inc $b9
2EA9: 60       rts
2EAA: A9 40    lda #$40
2EAC: 85 B5    sta $b5
2EAE: A9 20    lda #$20
2EB0: 85 B4    sta $b4
2EB2: 20 D9 2E jsr $2ed9
2EB5: AA       tax
2EB6: A9 60    lda #$60
2EB8: 18       clc
2EB9: 65 B4    adc $b4
2EBB: 85 B4    sta $b4
2EBD: A5 B5    lda $b5
2EBF: 69 00    adc #$00
2EC1: 85 B5    sta $b5
2EC3: CA       dex
2EC4: 10 F0    bpl $2eb6
2EC6: 20 D9 2E jsr $2ed9
2EC9: AA       tax
2ECA: A0 00    ldy #$00
2ECC: C8       iny
2ECD: C8       iny
2ECE: C8       iny
2ECF: CA       dex
2ED0: 10 FA    bpl $2ecc
2ED2: 98       tya
2ED3: 18       clc
2ED4: 65 B4    adc $b4
2ED6: 85 B4    sta $b4
2ED8: 60       rts
2ED9: 20 A4 23 jsr $23a4								; Kick PRNG
2EDC: 29 0F    and #$0f
2EDE: C9 09    cmp #$09
2EE0: 90 02    bcc $2ee4
2EE2: EA       nop
2EE3: 4A       lsr a
2EE4: 60       rts

				;; Copy P1 store to player data
2EE5: A2 00    ldx #$00									; For P1 
2EE7: 4C EC 2E jmp $2eec

				;; Copy P2 store to player data
2EEA: A2 01    ldx #$01									; For P2 
2EEC: B5 D0    lda $d0, x
2EEE: 85 BD    sta $bd									; Score lo 
2EF0: B5 D2    lda $d2, x
2EF2: 85 BE    sta $be									; Score hi
2EF4: B5 D4    lda $d4, x
2EF6: 85 B1    sta $b1									; Active arrows
2EF8: B5 D6    lda $d6, x
2EFA: 85 C1    sta $c1									; Lives left
2EFC: B5 D8    lda $d8, x
2EFE: 85 B0    sta $b0									; Shots at special 
2F00: B5 DA    lda $da, x
2F02: 85 C3    sta $c3									; Points/arrow 
2F04: 60       rts

				;; Copy player data to P1 store
2F05: A2 00    ldx #$00									; For P1 
2F07: 4C 0C 2F jmp $2f0c

				;; Copy player data to P2 store
2F0A: A2 01    ldx #$01									; For P2 
2F0C: A5 BD    lda $bd									; Score lo 
2F0E: 95 D0    sta $d0, x
2F10: A5 BE    lda $be									; Score hi 
2F12: 95 D2    sta $d2, x
2F14: A5 B1    lda $b1									; Active arrows
2F16: 95 D4    sta $d4, x
2F18: A5 C1    lda $c1									; Lives left
2F1A: 95 D6    sta $d6, x
2F1C: A5 B0    lda $b0									; Shots at special 
2F1E: 95 D8    sta $d8, x							 
2F20: A5 C3    lda $c3									; Points/arrow 
2F22: 95 DA    sta $da, x
2F24: 60       rts

				
2F25: 32 20 50 4C 41 59 45 52						; DATA 2_PLAYER 
2F2D: 53 20 31 20 43 4F 49 4E						; DATA S_1_COIN
2F35: 20 00															; DATA _ 
				
2F37: 31 20 50 4C 41 59 45 52						; DATA 1_PLAYER 
2F3F: 20 20 31 20 43 4F 49 4E						; DATA __1_COIN 
2F47: 20 00															; DATA _ 
				
2F49: 32 20 50 4C 41 59 45 52						; DATA 2_PLAYER 
2F51: 53 20 32 20 43 4F 49 4E						; DATA S_2_COIN 
2F59: 53 00															; DATA S 
				
2F5B: 31 20 50 4C 41 59 45 52						; DATA 1_PLAYER
2F63: 20 20 32 20 43 4F 49 4E						; DATA __2_COIN
2F6B: 53 00															; DATA S
				 
2F6D: 32 20 50 4C 41 59 45 52						; DATA 2_PLAYER 
2F75: 53 20 34 20 43 4F 49 4E						; DATA S_4_COIN 
2F7D: 53 00															; DATA S
				
2F7F: 44 45 50 4F 53 49 54 20						; DATA DEPOSIT_ 
2F87: 43 4F 49 4E 00										; DATA COIN
				
2F8C: 4F 52 20 50 52 45 53 53						; DATA OR_PRESS 
2F94: 20 53 54 41 52 54 00							; DATA _START
				
2F9B: 42 4F 4E 55 53 00									; DATA BONUS
				
2FA1: 43 52 45 44 49 54 53 00						; DATA CREDITS
				 
2FA9: 54 4F 50 20 54 48 49 53						; DATA TOP_THIS 
2FB1: 20 53 43 4F 52 45 20 46						; DATA _SCORE_F 
2FB9: 4F 52 20 45 58 54 52 41						; DATA OR_EXTRA 
2FC1: 20 42 4F 4E 55 53 00							; DATA _BONUS
				 
2FC8: 43 4F 50 59 52 49 47 48						; DATA COPYRIGH 
2FD0: 54 20 31 39 38 30 20 42						; DATA T_1980_B 
2FD8: 59 20 45 58 49 44 59 20						; DATA Y_EXIDY_ 
2FE0: 49 4E 43 00												; DATA INC 


				;; Text pointers
2FE4: 25 2F															; ADDR $2f25		2P_1C
2FE6: 37 2F															; ADDR $2f37		1P_1C
2FE8: 49 2F															; ADDR $2f49		2P_2C
2FEA: 5B 2F															; ADDR $2f5b		1P_2C
2FEC: 6D 2F															; ADDR $2f6d		2P_4C
2FEE:	7F 2F															; ADDR $2f7f		DEPOSIT_COIN
2FF0: 8C 2F															; ADDR $2f8c		OR PRESS START
2FF2: 9B 2F															; ADDR $2f9b		BONUS
2FF4: A1 2F															; ADDR $2fa1		CREDITS
2FF6: A9 2F															; ADDR $2fa9		TOP_THIS...
2FF8: C8 2F															; ADDR $2fc8		COPYRIHT
				
2FFA: 50 00															; ADDR $0050 
2FFC: 0D 11 80 ora $8011
2FFF: 20
				
3000: 78       sei											; Disable interrupts
3001:	A2 FF    ldx #$ff									; Stack pointer, loop counter
3003: 9A       txs											; Set stack pointer
				
3004: AD 03 51 lda $5103								; IRQ source
3007: CA       dex
3008: 30 FA    bmi $3004								; Loop
				
300A: D8       cld
300B: A9 00    lda #$00
300D: 85 A0    sta $a0
300F: 85 A1    sta $a1
3011: 85 A2    sta $a2
3013: 58       cli											; Enable interrupts
				
3014: 20 BC 22 jsr $22bc
				
3017: A9 00    lda #$00
3019: 85 AB    sta $ab
301B: 85 A3    sta $a3
301D: 85 BD    sta $bd
301F: 85 BE    sta $be

				;; Set default high score
3021: 85 AE    sta $ae									; HS lo
3023: A9 10    lda #$10
3025: 85 AF    sta $af									; HS hi
				
3027: 20 0C 18 jsr $180c								; Copy player data to P1
302A: 20 06 18 jsr $1806								; Copy player data to P2 
302D: 4C 83 33 jmp $3383
				
3030: 78       sei
3031: A2 FF    ldx #$ff
3033: 9A       txs
3034: 58       cli
3035: A9 00    lda #$00
3037: 85 BD    sta $bd
3039: 85 BE    sta $be
303B: 85 DC    sta $dc
303D: 85 DD    sta $dd
303F: A9 01    lda #$01
3041: 85 BF    sta $bf
3043: 85 C3    sta $c3
3045: 20 D7 23 jsr $23d7
3048: 20 0C 18 jsr $180c
304B: 20 06 18 jsr $1806
304E: 20 71 19 jsr $1971
3051: 20 3B 2A jsr $2a3b								; Draw player scores
3054: 20 06 18 jsr $1806
3057: A5 B1    lda $b1
3059: 85 A8    sta $a8
305B: A9 00    lda #$00
305D: 85 A4    sta $a4
305F: A9 90    lda #$90
3061: 85 A3    sta $a3
3063: 8D 00 52 sta $5200
3066: A9 20    lda #$20
3068: 85 35    sta $35
306A: 85 36    sta $36
306C: 20 99 2C jsr $2c99
306F: 20 07 33 jsr $3307
3072: 20 00 20 jsr $2000								; Check fire button
3075: 20 88 20 jsr $2088
3078: 20 AE 20 jsr $20ae
307B: 20 75 1A jsr $1a75
307E: 20 C4 19 jsr $19c4
3081: 20 2F 20 jsr $202f
3084: 20 97 2A jsr $2a97
3087: 20 11 2E jsr $2e11
308A: 20 28 18 jsr $1828
308D: A5 B1    lda $b1
308F: F0 0D    beq $309e
3091: EA       nop
3092: A5 30    lda $30
3094: 29 02    and #$02
3096: F0 D4    beq $306c
3098: 20 6E 31 jsr $316e
309B: 4C 6C 30 jmp $306c
309E: A9 EE    lda #$ee
30A0: 8D 00 51 sta $5100								; Sprite latch 
30A3: 20 8C 23 jsr $238c
30A6: A9 10    lda #$10
30A8: 8D 00 52 sta $5200
30AB: A6 BF    ldx $bf
30AD: CA       dex
30AE: 20 00 18 jsr $1800								; Copy player data to PX 
30B1: 20 8C 23 jsr $238c
30B4: A9 EE    lda #$ee
30B6: 8D 00 51 sta $5100								; Sprite latch 
30B9: 85 1A    sta $1a
30BB: 20 F2 1C jsr $1cf2
30BE: 20 4D 19 jsr $194d
30C1: 4C 6C 30 jmp $306c
30C4: A9 10    lda #$10
30C6: 8D 00 52 sta $5200
30C9: A9 EE    lda #$ee
30CB: 8D 00 51 sta $5100								; Sprite latch 
30CE: 20 8C 23 jsr $238c
30D1: A5 A7    lda $a7
30D3: 29 03    and #$03
30D5: D0 07    bne $30de
30D7: EA       nop
30D8: 20 18 19 jsr $1918
30DB: 4C 83 33 jmp $3383
30DE: AD 00 51 lda $5100								; DIPs 
30E1: 49 FF    eor #$ff
30E3: 29 04    and #$04
30E5: D0 53    bne $313a
30E7: EA       nop
30E8: 24 A7    bit $a7
30EA: 70 EC    bvs $30d8
30EC: 20 40 23 jsr $2340								; Clear screen
30EF: A5 A7    lda $a7
30F1: 29 03    and #$03
30F3: 85 BF    sta $bf
30F5: F0 E1    beq $30d8
30F7: 4A       lsr a
30F8: AA       tax
30F9: A9 01    lda #$01
30FB: 95 D6    sta $d6, x

				;; Set ($10-11) to $4204
30FD: A0 00    ldy #$00
30FF: A9 04    lda #$04
3101: 85 10    sta $10
3103: A9 42    lda #$42
3105: 85 11    sta $11

				;; Set ($14-15) to $1e7f
3107: B9 4A 1F lda $1f4a, y
310A: 85 14    sta $14
310C: C8       iny
310D: B9 4A 1F lda $1f4a, y
3110: 85 15    sta $15
				
3112: 20 FE 22 jsr $22fe								; Draw string
				
3115: A9 2C    lda #$2c
3117: 85 10    sta $10
3119: C8       iny
311A: 20 00 23 jsr $2300								; Draw next string
				
311D: A5 BF    lda $bf
311F: 09 30    ora #$30
3121: 8D 1D 42 sta $421d
3124: 20 86 23 jsr $2386
3127: 20 86 23 jsr $2386
312A: A5 A7    lda $a7
312C: 09 40    ora #$40
312E: 85 A7    sta $a7
3130: A5 BF    lda $bf
3132: 4A       lsr a
3133: AA       tax
3134: 20 14 18 jsr $1814								; Copy PX store to player data
3137: 4C 9E 30 jmp $309e
				
313A: 20 40 23 jsr $2340								; Clear screen
313D: 20 EA 2B jsr $2bea								; Draw CREDITS_##
3140: E6 A1    inc $a1									; Credits 
				
				;; Set ($10-11) to $420b
3142: A9 0B    lda #$0b
3144: 85 10    sta $10
3146: A9 42    lda #$42
3148: 85 11    sta $11

				;; Set ($14-15) to $1eaf
314A: A0 00    ldy #$00
314C: B9 4C 1F lda $1f4c, y
314F: 85 14    sta $14
3151: C8       iny
3152: B9 4C 1F lda $1f4c, y
3155: 85 15    sta $15
				
3157: 20 FE 22 jsr $22fe								; Draw string
				
315A: C8       iny
315B: A9 38    lda #$38
315D: 85 10    sta $10
315F: 20 00 23 jsr $2300								; Draw next string
				
3162: 20 86 23 jsr $2386
3165: 20 EA 2B jsr $2bea								; Draw CREDITS_##
3168: 20 86 23 jsr $2386
316B: 4C D8 30 jmp $30d8
316E: A9 10    lda #$10
3170: 20 CF 23 jsr $23cf
3173: A9 EE    lda #$ee
3175: 8D 00 51 sta $5100								; Sprite latch 
3178: 20 08 1E jsr $1e08
				
317B: A5 2F    lda $2f									; ?? Not new level? 
317D: D0 07    bne $3186
317F: EA       nop
				
3180: A9 0A    lda #$0a
3182: 85 2F    sta $2f
3184: 85 B1    sta $b1									; # Active arrows
				
3186: C6 C1    dec $c1									; Lives left 
3188: 10 05    bpl $318f								; >= 0 
318A: EA       nop

				;; Reset to 0 if negative
318B: A9 00    lda #$00
318D: 85 C1    sta $c1									; Lives left 
				
318F: A5 C0    lda $c0									; # Players 
3191: C9 02    cmp #$02
3193: D0 24    bne $31b9								; 1P only -- no swap 
3195: EA       nop

				;; Swap players
3196: A5 BF    lda $bf									; Player # 
3198: C9 01    cmp #$01
319A: F0 10    beq $31ac								; Currently P1 
319C: EA       nop

				;; Swap data to P1
319D: A9 01    lda #$01 
319F: 85 BF    sta $bf
31A1: 20 06 18 jsr $1806								; Copy player data to P2 
31A4: 20 20 18 jsr $1820								; Copy P1 store to player data
31A7: A5 C1    lda $c1									; Lives left 
31A9: D0 16    bne $31c1
31AB: EA       nop

				;; Swap data to P2
31AC: A9 02    lda #$02
31AE: 85 BF    sta $bf
31B0: 20 0C 18 jsr $180c								; Copy player data to P1 
31B3: 20 1A 18 jsr $181a								; Copy P2 store to player data
31B6: 4C BC 31 jmp $31bc
				
31B9: 20 0C 18 jsr $180c
31BC: A5 C1    lda $c1
31BE: F0 0E    beq $31ce
31C0: EA       nop
31C1: 20 40 23 jsr $2340								; Clear screen
31C4: 20 21 24 jsr $2421
31C7: 20 71 19 jsr $1971
31CA: 20 3B 2A jsr $2a3b								; Draw player scores
31CD: 60       rts
31CE: 4C C4 30 jmp $30c4


				;; IRQ vector
31D1: 08       php
31D2: 48       pha
31D3: 8A       txa
31D4: 48       pha
31D5: 98       tya
31D6: 48       pha
				
31D7: AD 03 51 lda $5103								; IRQ source
31DA: A8       tay
31DB: 29 60    and #$60
31DD: D0 0F    bne $31ee								; Coin 1 or 2 pressed
				
31DF: EA       nop
31E0: 98       tya
31E1: 10 08    bpl $31eb								; VBlank?
31E3: EA       nop
				
31E4: 68       pla
31E5: A8       tay
31E6: 68       pla
31E7: AA       tax
31E8: 68       pla
31E9: 28       plp
31EA: 40       rti
				
31EB: 4C 4D 3F jmp $3f4d								;  Change this for new irq

				;; Coin pressed
31EE: A5 A2    lda $a2
31F0: C9 06    cmp #$06
31F2: 90 F0    bcc $31e4								; Exit NMI if $a2 <= 6
				 
31F4: 20 79 32 jsr $3279
31F7: B0 EB    bcs $31e4								; No valid coin 

				;; Push y, $10, $11, $14, $15 to stack
31F9: 98       tya
31FA: 48       pha
31FB: A5 14    lda $14
31FD: 48       pha
31FE: A5 15    lda $15
3200: 48       pha
3201: A5 10    lda $10
3203: 48       pha
3204: A5 11    lda $11
3206: 48       pha
				
3207: A9 00    lda #$00
3209: 85 A2    sta $a2
320B: 2C 00 51 bit $5100								; DIPs 
320E: 30 42    bmi $3252								; Quarters! 
3210: EA       nop

				;; Handle Pence
3211: AD 01 03 lda $0301
3214: C9 40    cmp #$40									; Was coin 1 
3216: D0 1B    bne $3233
3218: EA       nop
				
3219: AD 00 51 lda $5100								; DIPs 
321C: 49 FF    eor #$ff
321E: 29 02    and #$02									; Mask 1/2 C_C 
3220: D0 0E    bne $3230								; 1 Coin/credit 
3222: EA       nop

				;; 2 coin per
3223: E6 A0    inc $a0									; Inc half coin
3225: A5 A0    lda $a0									; Half coin
3227: C9 02    cmp #$02
3229: 90 3D    bcc $3268
322B: EA       nop

				;; 1 coin per
322C: A9 00    lda #$00
322E: 85 A0    sta $a0									; Half coin
3230: 4C 58 32 jmp $3258								;  
				
3233: AD 00 51 lda $5100								; DIPs 
3236: 49 FF    eor #$ff
3238: 29 02    and #$02
323A: D0 0A    bne $3246								; Add 5 coins 
323C: EA       nop

				;; Add 2 coins
323D: 20 EE 32 jsr $32ee								; Add coin

				;; Add 1 coin
3240: 20 EE 32 jsr $32ee								; Add coin
3243: 4C 58 32 jmp $3258
				
				;; Add 5 coins total
3246: 20 EE 32 jsr $32ee								; Add coin
3249: 20 EE 32 jsr $32ee								; Add coin
324C: 20 EE 32 jsr $32ee								; Add coin
324F: 4C 3D 32 jmp $323d

				;; Handle quarters
3252: 2C 01 03 bit $0301
3255: 30 11    bmi $3268								; Skip to end 
3257: EA       nop
				
3258: 20 EE 32 jsr $32ee								; Add credit 
325B: 90 0B    bcc $3268
325D: EA       nop
				
325E: 24 A7    bit $a7
3260: 30 06    bmi $3268
3262: EA       nop
				
3263: A0 12    ldy #$12
3265: 20 13 1B jsr $1b13

				;; End of coin routine
3268: 68       pla
3269: 85 11    sta $11
326B: 68       pla
326C: 85 10    sta $10
326E: 68       pla
326F: 85 15    sta $15
3271: 68       pla
3272: 85 14    sta $14
3274: 68       pla
3275: A8       tay
3276: 4C E4 31 jmp $31e4								; End of ISR 

		
				;; IRQ Coin handler
3279: A9 05    lda #$05									; 5 tries to catch coin 
327B: 8D 00 03 sta $0300								; Loop counter 
327E: 2C 01 51 bit $5101								; Control inputs 
3281: 10 15    bpl $3298								; Coin 1
3283: EA       nop
				
3284: AD 00 51 lda $5100								; DIPs 
3287: 29 01    and #$01									; Mask Coin 2 
3289: D0 35    bne $32c0								; Coin 2
328B: EA       nop
				
328C: CE 00 03 dec $0300
328F: D0 E8    bne $3279								; Loop
				
3291: A9 00    lda #$00									; No coin?
3293: 8D 01 03 sta $0301
3296: 38       sec											; Invalid coin 
3297: 60       rts

				;; Validate Coin 1
3298: A9 FF    lda #$ff									; Loop counter  
329A: 8D 00 03 sta $0300
329D: 2C 01 51 bit $5101								; Control inputs 
32A0: 30 D7    bmi $3279								; No Coin 1 
32A2: CE 00 03 dec $0300
32A5: D0 F6    bne $329d								; Loop
				
32A7: 2C 01 51 bit $5101								; Control inputs 
32AA: 10 FB    bpl $32a7								; Coin 1 
				 
32AC: CE 00 03 dec $0300								; Loop counter (#ff) 
32AF: 2C 01 51 bit $5101								; Control inputs 
32B2: 10 F3    bpl $32a7								; Coin 1 
32B4: CE 00 03 dec $0300
32B7: D0 F6    bne $32af								; Loop
				
32B9: A9 40    lda #$40									; Coin 1 
32BB: 8D 01 03 sta $0301
32BE: 18       clc											; Valid Coin 1 
32BF: 60       rts

				;; Validate Coin 2
32C0: A9 FF    lda #$ff									; Loop counter 
32C2: 8D 00 03 sta $0300
32C5: AD 00 51 lda $5100								; DIPs 
32C8: 29 01    and #$01
32CA: F0 AD    beq $3279								; No coin 2 
				
32CC: CE 00 03 dec $0300
32CF: D0 F4    bne $32c5								; Loop
				 
32D1: AD 00 51 lda $5100								; DIPs 
32D4: 29 01    and #$01
32D6: D0 F9    bne $32d1								; Coin 2
				
32D8: CE 00 03 dec $0300
32DB: AD 00 51 lda $5100								; DIPs 
32DE: 29 01    and #$01
32E0: D0 EF    bne $32d1								; Coin 2
				 
32E2: CE 00 03 dec $0300
32E5: D0 F4    bne $32db								; Loop 
32E7: A9 80    lda #$80									; Coin 2 
32E9: 8D 01 03 sta $0301
32EC: 18       clc											; Valid Coin 2
32ED: 60       rts

				
32EE: AD 00 51 lda $5100								; DIPs 
32F1: 29 18    and #$18									; Mask coinage
				  
32F3: C9 10    cmp #$10
32F5: D0 0B    bne $3302								; Not 2C_1C 
32F7: EA       nop
				
32F8: E6 A0    inc $a0									; Half coins 
32FA: A5 A0    lda $a0
32FC: C9 02    cmp #$02
32FE: B0 02    bcs $3302								; <2 
3300: EA       nop
3301: 60       rts
				
3302: 20 D7 2B jsr $2bd7								; Add credit 
3305: 38       sec
3306: 60       rts
				
3307: A2 07    ldx #$07
3309: B5 96    lda $96, x
330B: 95 0B    sta $0b, x
330D: CA       dex
330E: 10 F9    bpl $3309
3310: C6 0F    dec $0f
3312: 10 17    bpl $332b
3314: EA       nop
3315: A5 B0    lda $b0
3317: C9 08    cmp #$08
3319: 90 06    bcc $3321
331B: EA       nop
331C: A9 02    lda #$02
331E: 4C 28 33 jmp $3328
3321: 49 FF    eor #$ff
3323: 29 07    and #$07
3325: 18       clc
3326: 69 02    adc #$02
3328: 20 07 2D jsr $2d07
332B: A2 07    ldx #$07
332D: B5 0B    lda $0b, x
332F: 95 96    sta $96, x
3331: CA       dex
3332: 10 F9    bpl $332d
3334: 24 A7    bit $a7
3336: 10 31    bpl $3369
3338: EA       nop
3339: 24 0C    bit $0c
333B: 30 2C    bmi $3369
333D: EA       nop
333E: 24 0D    bit $0d
3340: 30 27    bmi $3369
3342: EA       nop
3343: A5 97    lda $97
3345: 29 40    and #$40
3347: D0 02    bne $334b
3349: EA       nop
334A: 60       rts
334B: A9 EF    lda #$ef
334D: 20 CA 23 jsr $23ca
3350: EE 0F 03 inc $030f
3353: AD 0F 03 lda $030f
3356: 29 40    and #$40
3358: D0 1B    bne $3375
335A: EA       nop
335B: A5 A3    lda $a3
335D: 29 08    and #$08
335F: F0 02    beq $3363
3361: EA       nop
3362: 60       rts
3363: A9 08    lda #$08
3365: 20 CF 23 jsr $23cf
3368: 60       rts
3369: A5 A3    lda $a3
336B: 29 F0    and #$f0
336D: 09 10    ora #$10
336F: 85 A3    sta $a3
3371: 8D 00 52 sta $5200
3374: 60       rts
3375: A5 A3    lda $a3
3377: 29 08    and #$08
3379: D0 02    bne $337d
337B: EA       nop
337C: 60       rts
337D: A9 F7    lda #$f7
337F: 20 CA 23 jsr $23ca
3382: 60       rts
				
3383: A9 EE    lda #$ee
3385: 8D 00 51 sta $5100								; Sprite latch 
3388: 85 1A    sta $1a
338A: 20 6D 24 jsr $246d
338D: A9 10    lda #$10
338F: 85 A3    sta $a3
3391: 8D 00 52 sta $5200
3394: A9 00    lda #$00
3396: 85 A7    sta $a7
3398: 20 40 23 jsr $2340								; Clear screen
339B: 20 BA 18 jsr $18ba
339E: A9 1F    lda #$1f
33A0: 85 17    sta $17									 ;Loop Counter 
				
33A2: 20 4F 2B jsr $2b4f								; Draw DEPOSIT_COIN 
33A5: A9 2A    lda #$2a
33A7: 85 41    sta $41									; Loop counter 
33A9: 85 42    sta $42									; Loop counter 
				
33AB: A5 A1    lda $a1									; Credits 
33AD: D0 40    bne $33ef								; Credits -- check starts 
33AF: EA       nop

				;; No credits
33B0: E6 3F    inc $3f
33B2: D0 EE    bne $33a2								; Loop 
				
33B4: C6 17    dec $17
33B6: D0 EA    bne $33a2								; Loop
				 
33B8: 20 32 1E jsr $1e32
				
33BB: A9 0D    lda #$0d
33BD: 85 17    sta $17
				
33BF: 20 99 2C jsr $2c99
33C2: 20 07 33 jsr $3307
33C5: 20 6E 34 jsr $346e
33C8: 20 88 20 jsr $2088
33CB: 20 AE 20 jsr $20ae
33CE: 20 B8 1A jsr $1ab8
33D1: 20 2F 20 jsr $202f
33D4: 20 76 2E jsr $2e76
33D7: 20 11 2E jsr $2e11
33DA: A5 A1    lda $a1
33DC: D0 A5    bne $3383
33DE: A5 30    lda $30
33E0: 29 02    and #$02
33E2: D0 9F    bne $3383
33E4: C6 3F    dec $3f
33E6: D0 D7    bne $33bf
33E8: C6 17    dec $17
33EA: D0 D3    bne $33bf
33EC: 4C 83 33 jmp $3383
				
33EF: AD 05 51 lda $5105								; Control inputs 
33F2: 49 FF    eor #$ff									; Invert 
33F4: 29 03    and #$03									; Mask Start buttons 
33F6: C9 01    cmp #$01									; 1P Start 
33F8: F0 44    beq $343e
33FA: EA       nop
				
33FB: C9 02    cmp #$02									; 2P Start 
33FD: F0 26    beq $3425
33FF: EA       nop
				
3400: C6 16    dec $16
3402: D0 A7    bne $33ab								; Loop 
3404: C6 41    dec $41
3406: D0 A3    bne $33ab								; Loop 
3408: A9 01    lda #$01
340A: 85 41    sta $41
340C: A2 0A    ldx #$0a
340E: AD 0D 42 lda $420d
3411: C9 20    cmp #$20
3413: F0 09    beq $341e
3415: EA       nop
				
3416: A9 20    lda #$20
3418: 9D 0D 42 sta $420d, x
341B: CA       dex
341C: 10 FA    bpl $3418
				
341E: C6 42    dec $42
3420: D0 89    bne $33ab								; Loop
				 
3422: 4C A2 33 jmp $33a2								; Loop 
				
				;; 2P Start pressed
3425: AD 00 51 lda $5100								; DIPs 
3428: 29 18    and #$18
342A: C9 18    cmp #$18
342C: F0 0E    beq $343c								; 2P per credit? 
342E: EA       nop
				
342F: A5 A1    lda $a1									; Credits 
3431: C9 02    cmp #$02
3433: B0 04    bcs $3439
3435: EA       nop
3436: 4C A2 33 jmp $33a2								; Not enough credits
				 
3439: 20 3A 19 jsr $193a								; Decrement credits
				
343C: A9 02    lda #$02

				;; 1P Start 
343E: 85 C0    sta $c0									; # Players 
3440: 20 3A 19 jsr $193a								; Decrement credits
				
3443: A9 0B    lda #$0b
3445: 85 2F    sta $2f
3447: A9 0A    lda #$0a
3449: 85 B1    sta $b1
344B: A9 03    lda #$03
344D: 85 28    sta $28
344F: 20 40 23 jsr $2340								; Clear screen
3452: A9 01    lda #$01
3454: 85 BF    sta $bf
3456: A9 80    lda #$80									; D7 = game mode 
3458: 85 A7    sta $a7									; Status 
345A: A0 16    ldy #$16
345C: A5 C0    lda $c0
345E: C9 02    cmp #$02
3460: F0 03    beq $3465
3462: EA       nop
				
3463: A0 12    ldy #$12
3465: 20 13 1B jsr $1b13
3468: 20 21 24 jsr $2421
346B: 4C 30 30 jmp $3030


346E: A5 3F    lda $3f									; ?? 
3470: 29 1F    and #$1f
3472: C9 0F    cmp #$0f
3474: D0 0B    bne $3481
3476: EA       nop
				
3477: 20 A4 23 jsr $23a4								; Kick PRNG
347A: 85 00    sta $00									; Store PRN 
347C: 29 49    and #$49									; 0100_1001 
347E: D0 06    bne $3486
3480: EA       nop
				
3481: A9 00    lda #$00
3483: 85 34    sta $34
3485: 60       rts
				
3486: A5 00    lda $00
3488: 29 03    and #$03									; Clear high 6 bits 
348A: AA       tax
348B: BD E8 1F lda $1fe8, x							; Table (20 40 04 08)
348E: 85 34    sta $34
				
3490: A5 00    lda $00
3492: 29 10    and #$10
3494: 05 34    ora $34									; May set bit 4 
3496: 85 34    sta $34									; 04 08 20 40 / 14 1 
3498: 29 EF    and #$ef									; D0 never set anyway? 
349A: 85 35    sta $35									; Store
349C: 60       rts

				
				;; Assembly text here to $37FF
349D: 54 0D    nop $0d, x
349F: 10 30    bpl $34d1
34A1: 20 41 43 jsr $4341
34A4: 54 49    nop $49, x
34A6: 56 45    lsr $45, x
34A8: 3D 24 30 and $3024, x
34AB: 30 42    bmi $34ef
34AD: 31 20    and ($20), y
34AF: 3B 4E 55 rla $554e, y
34B2: 4D 42 45 eor $4542
34B5: 52       kil
34B6: 20 4F 46 jsr $464f
34B9: 20 41 43 jsr $4341
34BC: 54 49    nop $49, x
34BE: 56 45    lsr $45, x
34C0: 20 41 52 jsr $5241
34C3: 52       kil
34C4: 4F 57 53 sre $5357
34C7: 0D 10 40 ora $4010
34CA: 20 53 4D jsr $4d53
34CD: 4F 56 45 sre $4556
34D0: 3D 24 30 and $3024, x
34D3: 30 42    bmi $3517
34D5: 32       kil
34D6: 20 3B 53 jsr $533b
34D9: 4D 41 52 eor $5241
34DC: 54 20    nop $20, x
34DE: 4D 4F 56 eor $564f
34E1: 45 20    eor $20
34E3: 43 4F    sre ($4f, x)
34E5: 44 45    nop $45
34E7: 0D 10 50 ora $5010
34EA: 20 46 53 jsr $5346
34ED: 48       pha
34EE: 43 4E    sre ($4e, x)
34F0: 54 3D    nop $3d, x
34F2: 24 30    bit $30
34F4: 30 42    bmi $3538
34F6: 33 20    rla ($20), y
34F8: 3B 46 4C rla $4c46, y
34FB: 41 53    eor ($53, x)
34FD: 48       pha
34FE: 20 43 4F jsr $4f43
3501: 55 4E    eor $4e, x
3503: 54 45    nop $45, x
3505: 52       kil
3506: 0D 10 60 ora $6010
3509: 20 46 53 jsr $5346
350C: 43 52    sre ($52, x)
350E: 4E 3D 24 lsr $243d
3511: 30 30    bmi $3543
3513: 42       kil
3514: 34 20    nop $20, x
3516: 3B 46 4C rla $4c46, y
3519: 41 53    eor ($53, x)
351B: 48       pha
351C: 20 53 43 jsr $4353
351F: 52       kil
3520: 45 45    eor $45
3522: 4E 20 4C lsr $4c20
3525: 4F 43 41 sre $4143
3528: 54 49    nop $49, x
352A: 4F 4E 0D sre $0d4e
352D: 10 70    bpl $359f
352F: 20 43 41 jsr $4143
3532: 42       kil
3533: 54 4D    nop $4d, x
3535: 3D 24 30 and $3024, x
3538: 30 42    bmi $357c
353A: 36 20    rol $20, x
353C: 3B 43 41 rla $4143, y
353F: 52       kil
3540: 20 42 41 jsr $4142
3543: 53 45    sre ($45), y
3545: 20 54 49 jsr $4954
3548: 4D 45 52 eor $5245
354B: 0D 10 80 ora $8010
354E: 20 43 41 jsr $4143
3551: 52       kil
3552: 43 41    sre ($41, x)
3554: 4C 3D 24 jmp $243d
3557: 30 30    bmi $3589
3559: 42       kil
355A: 37 20    rla $20, x
355C: 3B 43 41 rla $4143, y
355F: 52       kil
3560: 20 43 41 jsr $4143
3563: 4C 45 4E jmp $4e45
3566: 44 41    nop $41
3568: 52       kil
3569: 0D 10 90 ora $9010
356C: 20 4F 42 jsr $424f
356F: 4A       lsr a
3570: 43 54    sre ($54, x)
3572: 52       kil
3573: 3D 24 30 and $3024, x
3576: 30 42    bmi $35ba
3578: 38       sec
3579: 20 3B 53 jsr $533b
357C: 50 45    bvc $35c3
357E: 43 49    sre ($49, x)
3580: 41 4C    eor ($4c, x)
3582: 20 4F 42 jsr $424f
3585: 4A       lsr a
3586: 45 43    eor $43
3588: 54 20    nop $20, x
358A: 43 4F    sre ($4f, x)
358C: 55 4E    eor $4e, x
358E: 54 45    nop $45, x
3590: 52       kil
3591: 0D 11 00 ora $0011
3594: 20 46 49 jsr $4946
3597: 4D 41 47 eor $4741
359A: 3D 24 30 and $3024, x
359D: 30 42    bmi $35e1
359F: 39 20 3B and $3b20, y
35A2: 46 4C    lsr $4c
35A4: 41 53    eor ($53, x)
35A6: 48       pha
35A7: 49 4E    eor #$4e
35A9: 47 20    sre $20
35AB: 49 4D    eor #$4d
35AD: 41 47    eor ($47, x)
35AF: 45 0D    eor $0d
35B1: 11 10    ora ($10), y
35B3: 20 54 50 jsr $5054
35B6: 4F 49 4E sre $4e49
35B9: 54 3D    nop $3d, x
35BB: 24 30    bit $30
35BD: 30 42    bmi $3601
35BF: 43 20    sre ($20, x)
35C1: 3B 54 59 rla $5954, y
35C4: 50 45    bvc $360b
35C6: 20 4F 46 jsr $464f
35C9: 20 50 4F jsr $4f50
35CC: 49 4E    eor #$4e
35CE: 54 20    nop $20, x
35D0: 54 4F    nop $4f, x
35D2: 20 42 45 jsr $4542
35D5: 20 41 57 jsr $5741
35D8: 41 52    eor ($52, x)
35DA: 44 45    nop $45
35DC: 44 20    nop $20
35DE: 28       plp
35DF: 41 52    eor ($52, x)
35E1: 52       kil
35E2: 4F 57 2D sre $2d57
35E5: 53 50    sre ($50), y
35E7: 45 43    eor $43
35E9: 20 54 41 jsr $4154
35EC: 52       kil
35ED: 47 29    sre $29
35EF: 0D 11 20 ora $2011
35F2: 20 50 4C jsr $4c50
35F5: 59 52 53 eor $5352, y
35F8: 43 3D    sre ($3d, x)
35FA: 24 30    bit $30
35FC: 30 42    bmi $3640
35FE: 44 20    nop $20
3600: 3B 50 4C rla $4c50, y
3603: 41 59    eor ($59, x)
3605: 45 52    eor $52
3607: 20 53 43 jsr $4353
360A: 4F 52 45 sre $4552
360D: 20 28 32 jsr $3228
3610: 20 42 59 jsr $5942
3613: 54 45    nop $45, x
3615: 53 29    sre ($29), y
3617: 0D 11 30 ora $3011
361A: 20 50 4C jsr $4c50
361D: 59 4E 3D eor $3d4e, y
3620: 24 30    bit $30
3622: 30 42    bmi $3666
3624: 46 20    lsr $20
3626: 3B 50 4C rla $4c50, y
3629: 41 59    eor ($59, x)
362B: 45 52    eor $52
362D: 20 4E 55 jsr $554e
3630: 4D 42 45 eor $4542
3633: 52       kil
3634: 0D 11 40 ora $4011
3637: 20 4E 50 jsr $504e
363A: 4C 59 52 jmp $5259
363D: 53 3D    sre ($3d), y
363F: 24 30    bit $30
3641: 30 43    bmi $3686
3643: 30 20    bmi $3665
3645: 3B 4E 55 rla $554e, y
3648: 4D 42 45 eor $4542
364B: 52       kil
364C: 20 4F 46 jsr $464f
364F: 20 50 4C jsr $4c50
3652: 41 59    eor ($59, x)
3654: 45 52    eor $52
3656: 53 20    sre ($20), y
3658: 28       plp
3659: 31 20    and ($20), y
365B: 4F 52 20 sre $2052
365E: 32       kil
365F: 29 0D    and #$0d
3661: 11 50    ora ($50), y
3663: 20 4E 43 jsr $434e
3666: 41 52    eor ($52, x)
3668: 53 3D    sre ($3d), y
366A: 24 30    bit $30
366C: 30 43    bmi $36b1
366E: 31 20    and ($20), y
3670: 3B 4E 55 rla $554e, y
3673: 4D 42 45 eor $4542
3676: 52       kil
3677: 20 4F 46 jsr $464f
367A: 20 43 41 jsr $4143
367D: 52       kil
367E: 53 20    sre ($20), y
3680: 50 45    bvc $36c7
3682: 52       kil
3683: 20 47 41 jsr $4147
3686: 4D 45 0D eor $0d45
3689: 11 60    ora ($60), y
368B: 20 42 43 jsr $4342
368E: 41 4C    eor ($4c, x)
3690: 4E 3D 24 lsr $243d
3693: 30 30    bmi $36c5
3695: 43 32    sre ($32, x)
3697: 20 3B 42 jsr $423b
369A: 55 4C    eor $4c, x
369C: 4C 45 54 jmp $5445
369F: 20 43 41 jsr $4143
36A2: 4C 45 4E jmp $4e45
36A5: 44 41    nop $41
36A7: 52       kil
36A8: 0D 11 70 ora $7011
36AB: 20 4E 50 jsr $504e
36AE: 4F 49 4E sre $4e49
36B1: 54 3D    nop $3d, x
36B3: 24 30    bit $30
36B5: 30 43    bmi $36fa
36B7: 33 20    rla ($20), y
36B9: 3B 4E 55 rla $554e, y
36BC: 4D 42 45 eor $4542
36BF: 52       kil
36C0: 20 4F 46 jsr $464f
36C3: 20 50 4F jsr $4f50
36C6: 49 4E    eor #$4e
36C8: 54 53    nop $53, x
36CA: 20 50 45 jsr $4550
36CD: 52       kil
36CE: 20 41 52 jsr $5241
36D1: 52       kil
36D2: 4F 57 0D sre $0d57
36D5: 11 80    ora ($80), y
36D7: 20 53 43 jsr $4353
36DA: 4F 52 45 sre $4552
36DD: 31 3D    and ($3d), y
36DF: 24 30    bit $30
36E1: 30 44    bmi $3727
36E3: 30 20    bmi $3705
36E5: 3B 53 43 rla $4353, y
36E8: 4F 52 45 sre $4552
36EB: 20 53 54 jsr $5453
36EE: 4F 52 41 sre $4152
36F1: 47 45    sre $45
36F3: 0D 11 90 ora $9011
36F6: 20 53 43 jsr $4353
36F9: 4F 52 31 sre $3152
36FC: 31 3D    and ($3d), y
36FE: 24 30    bit $30
3700: 30 44    bmi $3746
3702: 32       kil
3703: 20 3B 48 jsr $483b
3706: 2E 4F 2E rol $2e4f
3709: 20 53 43 jsr $4353
370C: 4F 52 45 sre $4552
370F: 20 53 54 jsr $5453
3712: 4F 52 41 sre $4152
3715: 47 45    sre $45
3717: 0D 12 00 ora $0012
371A: 20 41 43 jsr $4341
371D: 54 49    nop $49, x
371F: 56 31    lsr $31, x
3721: 3D 24 30 and $3024, x
3724: 30 44    bmi $376a
3726: 34 20    nop $20, x
3728: 3B 4E 55 rla $554e, y
372B: 4D 42 45 eor $4542
372E: 52       kil
372F: 20 4F 46 jsr $464f
3732: 20 41 43 jsr $4341
3735: 54 49    nop $49, x
3737: 56 45    lsr $45, x
3739: 20 41 52 jsr $5241
373C: 52       kil
373D: 4F 57 53 sre $5357
3740: 20 53 54 jsr $5453
3743: 4F 52 41 sre $4152
3746: 47 45    sre $45
3748: 0D 12 10 ora $1012
374B: 20 4E 43 jsr $434e
374E: 41 52    eor ($52, x)
3750: 53 31    sre ($31), y
3752: 3D 24 30 and $3024, x
3755: 30 44    bmi $379b
3757: 36 20    rol $20, x
3759: 3B 4E 55 rla $554e, y
375C: 4D 42 45 eor $4542
375F: 52       kil
3760: 20 4F 46 jsr $464f
3763: 20 43 41 jsr $4143
3766: 52       kil
3767: 53 20    sre ($20), y
3769: 4C 45 46 jmp $4645
376C: 54 20    nop $20, x
376E: 53 54    sre ($54), y
3770: 4F 52 41 sre $4152
3773: 47 45    sre $45
3775: 0D 12 20 ora $2012
3778: 20 4E 53 jsr $534e
377B: 46 49    lsr $49
377D: 52       kil
377E: 53 3D    sre ($3d), y
3780: 24 30    bit $30
3782: 30 44    bmi $37c8
3784: 38       sec
3785: 20 3B 4E jsr $4e3b
3788: 55 4D    eor $4d, x
378A: 42       kil
378B: 45 52    eor $52
378D: 20 4F 46 jsr $464f
3790: 20 54 49 jsr $4954
3793: 4D 45 53 eor $5345
3796: 20 46 49 jsr $4946
3799: 52       kil
379A: 45 44    eor $44
379C: 20 41 54 jsr $5441
379F: 20 53 50 jsr $5053
37A2: 45 43    eor $43
37A4: 49 41    eor #$41
37A6: 4C 20 54 jmp $5420
37A9: 41 52    eor ($52, x)
37AB: 47 45    sre $45
37AD: 54 0D    nop $0d, x
37AF: 12       kil
37B0: 30 20    bmi $37d2
37B2: 4E 50 4F lsr $4f50
37B5: 49 54    eor #$54
37B7: 53 3D    sre ($3d), y
37B9: 24 30    bit $30
37BB: 30 44    bmi $3801
37BD: 41 20    eor ($20, x)
37BF: 3B 4E 55 rla $554e, y
37C2: 4D 42 45 eor $4542
37C5: 52       kil
37C6: 20 4F 46 jsr $464f
37C9: 20 50 4F jsr $4f50
37CC: 49 4E    eor #$4e
37CE: 54 53    nop $53, x
37D0: 20 50 45 jsr $4550
37D3: 52       kil
37D4: 20 41 52 jsr $5241
37D7: 52       kil
37D8: 4F 57 0D sre $0d57
37DB: 12       kil
37DC: 40       rti
37DD: 20 48 53 jsr $5348
37E0: 43 4F    sre ($4f, x)
37E2: 52       kil
37E3: 4E 3D 24 lsr $243d
37E6: 30 30    bmi $3818
37E8: 44 43    nop $43
37EA: 20 3B 48 jsr $483b
37ED: 49 47    eor #$47
37EF: 48       pha
37F0: 20 53 43 jsr $4353
37F3: 4F 52 45 sre $4552
37F6: 20 4E 55 jsr $554e
37F9: 4D 42 45 eor $4542
37FC: 52       kil
37FD: 0D 12 50 ora $5012


3800: 00												; DATA ................  $00
3801: 00												; DATA ................ 
3802: 00												; DATA ................ 
3803: 00												; DATA ................ 
3804: 00												; DATA ................ 
3805: 00												; DATA ................ 
3806: 00												; DATA ................ 
3807: 00												; DATA ................ 

3808: 18												; DATA ......####......  $01
3809: 18												; DATA ......####...... 
380a: 3c												; DATA ....########.... 
380b: 3c												; DATA ....########.... 
380c: 7e												; DATA ..############.. 
380d: 7e												; DATA ..############.. 
380e: e7												; DATA ######....###### 
380f: c3												; DATA ####........#### 

3810: 00												; DATA ................  $02
3811: 00												; DATA ................ 
3812: 00												; DATA ................ 
3813: 00												; DATA ................ 
3814: 00												; DATA ................ 
3815: 00												; DATA ................ 
3816: 18												; DATA ......####...... 
3817: 18												; DATA ......####...... 

3818: 3c												; DATA ....########....  $03
3819: 3c												; DATA ....########.... 
381a: 7e												; DATA ..############.. 
381b: 7e												; DATA ..############.. 
381c: e7												; DATA ######....###### 
381d: c3												; DATA ####........#### 
381e: 00												; DATA ................ 
381f: 00												; DATA ................ 

3820: 00												; DATA ................  $04
3821: 00												; DATA ................ 
3822: 00												; DATA ................ 
3823: 00												; DATA ................ 
3824: 18												; DATA ......####...... 
3825: 18												; DATA ......####...... 
3826: 3c												; DATA ....########.... 
3827: 3c												; DATA ....########.... 

3828: 7e												; DATA ..############..  $05
3829: 7e												; DATA ..############.. 
382a: e7												; DATA ######....###### 
382b: c3												; DATA ####........#### 
382c: 00												; DATA ................ 
382d: 00												; DATA ................ 
382e: 00												; DATA ................ 
382f: 00												; DATA ................ 

3830: 00												; DATA ................  $06
3831: 00												; DATA ................ 
3832: 18												; DATA ......####...... 
3833: 18												; DATA ......####...... 
3834: 3c												; DATA ....########.... 
3835: 3c												; DATA ....########.... 
3836: 7e												; DATA ..############.. 
3837: 7e												; DATA ..############.. 

3838: e7												; DATA ######....######  $07
3839: c3												; DATA ####........#### 
383a: 00												; DATA ................ 
383b: 00												; DATA ................ 
383c: 00												; DATA ................ 
383d: 00												; DATA ................ 
383e: 00												; DATA ................ 
383f: 00												; DATA ................ 

3840: c3												; DATA ####........####  $08
3841: e7												; DATA ######....###### 
3842: 7e												; DATA ..############.. 
3843: 7e												; DATA ..############.. 
3844: 3c												; DATA ....########.... 
3845: 3c												; DATA ....########.... 
3846: 18												; DATA ......####...... 
3847: 18												; DATA ......####...... 

3848: 00												; DATA ................  $09
3849: 00												; DATA ................ 
384a: 00												; DATA ................ 
384b: 00												; DATA ................ 
384c: 00												; DATA ................ 
384d: 00												; DATA ................ 
384e: 00												; DATA ................ 
384f: 00												; DATA ................ 

3850: 00												; DATA ................  $0a
3851: 00												; DATA ................ 
3852: c3												; DATA ####........#### 
3853: e7												; DATA ######....###### 
3854: 7e												; DATA ..############.. 
3855: 7e												; DATA ..############.. 
3856: 3c												; DATA ....########.... 
3857: 3c												; DATA ....########.... 

3858: 18												; DATA ......####......  $0b
3859: 18												; DATA ......####...... 
385a: 00												; DATA ................ 
385b: 00												; DATA ................ 
385c: 00												; DATA ................ 
385d: 00												; DATA ................ 
385e: 00												; DATA ................ 
385f: 00												; DATA ................ 

3860: 00												; DATA ................  $0c
3861: 00												; DATA ................ 
3862: 00												; DATA ................ 
3863: 00												; DATA ................ 
3864: c3												; DATA ####........#### 
3865: e7												; DATA ######....###### 
3866: 7e												; DATA ..############.. 
3867: 7e												; DATA ..############.. 

3868: 3c												; DATA ....########....  $0d
3869: 3c												; DATA ....########.... 
386a: 18												; DATA ......####...... 
386b: 18												; DATA ......####...... 
386c: 00												; DATA ................ 
386d: 00												; DATA ................ 
386e: 00												; DATA ................ 
386f: 00												; DATA ................ 

3870: 00												; DATA ................  $0e
3871: 00												; DATA ................ 
3872: 00												; DATA ................ 
3873: 00												; DATA ................ 
3874: 00												; DATA ................ 
3875: 00												; DATA ................ 
3876: c3												; DATA ####........#### 
3877: e7												; DATA ######....###### 

3878: 7e												; DATA ..############..  $0f
3879: 7e												; DATA ..############.. 
387a: 3c												; DATA ....########.... 
387b: 3c												; DATA ....########.... 
387c: 18												; DATA ......####...... 
387d: 18												; DATA ......####...... 
387e: 00												; DATA ................ 
387f: 00												; DATA ................ 

3880: c0												; DATA ####............  $10
3881: f0												; DATA ########........ 
3882: 7c												; DATA ..##########.... 
3883: 3f												; DATA ....############ 
3884: 3f												; DATA ....############ 
3885: 7c												; DATA ..##########.... 
3886: f0												; DATA ########........ 
3887: c0												; DATA ####............ 

3888: 00												; DATA ................  $11
3889: 00												; DATA ................ 
388a: 00												; DATA ................ 
388b: 00												; DATA ................ 
388c: 00												; DATA ................ 
388d: 00												; DATA ................ 
388e: 00												; DATA ................ 
388f: 00												; DATA ................ 

3890: 30												; DATA ....####........  $12
3891: 3c												; DATA ....########.... 
3892: 1f												; DATA ......########## 
3893: 0f												; DATA ........######## 
3894: 0f												; DATA ........######## 
3895: 1f												; DATA ......########## 
3896: 3c												; DATA ....########.... 
3897: 30												; DATA ....####........ 

3898: 00												; DATA ................  $13
3899: 00												; DATA ................ 
389a: 00												; DATA ................ 
389b: c0												; DATA ####............ 
389c: c0												; DATA ####............ 
389d: 00												; DATA ................ 
389e: 00												; DATA ................ 
389f: 00												; DATA ................ 

38a0: 0c												; DATA ........####....  $14
38a1: 0f												; DATA ........######## 
38a2: 07												; DATA ..........###### 
38a3: 03												; DATA ............#### 
38a4: 03												; DATA ............#### 
38a5: 07												; DATA ..........###### 
38a6: 0f												; DATA ........######## 
38a7: 0c												; DATA ........####.... 

38a8: 00												; DATA ................  $15
38a9: 00												; DATA ................ 
38aa: c0												; DATA ####............ 
38ab: f0												; DATA ########........ 
38ac: f0												; DATA ########........ 
38ad: c0												; DATA ####............ 
38ae: 00												; DATA ................ 
38af: 00												; DATA ................ 

38b0: 03												; DATA ............####  $16
38b1: 03												; DATA ............#### 
38b2: 01												; DATA ..............## 
38b3: 00												; DATA ................ 
38b4: 00												; DATA ................ 
38b5: 01												; DATA ..............## 
38b6: 03												; DATA ............#### 
38b7: 03												; DATA ............#### 

38b8: 00												; DATA ................  $17
38b9: c0												; DATA ####............ 
38ba: f0												; DATA ########........ 
38bb: fc												; DATA ############.... 
38bc: fc												; DATA ############.... 
38bd: f0												; DATA ########........ 
38be: c0												; DATA ####............ 
38bf: 00												; DATA ................ 

38c0: 00												; DATA ................  $18
38c1: 00												; DATA ................ 
38c2: 00												; DATA ................ 
38c3: 00												; DATA ................ 
38c4: 00												; DATA ................ 
38c5: 00												; DATA ................ 
38c6: 00												; DATA ................ 
38c7: 00												; DATA ................ 

38c8: 03												; DATA ............####  $19
38c9: 0f												; DATA ........######## 
38ca: 3e												; DATA ....##########.. 
38cb: fc												; DATA ############.... 
38cc: fc												; DATA ############.... 
38cd: 3e												; DATA ....##########.. 
38ce: 0f												; DATA ........######## 
38cf: 03												; DATA ............#### 

38d0: 00												; DATA ................  $1a 
38d1: 00												; DATA ................ 
38d2: 00												; DATA ................ 
38d3: 03												; DATA ............#### 
38d4: 03												; DATA ............#### 
38d5: 00												; DATA ................ 
38d6: 00												; DATA ................ 
38d7: 00												; DATA ................ 

38d8: 0c												; DATA ........####....  $1b
38d9: 3c												; DATA ....########.... 
38da: f8												; DATA ##########...... 
38db: f0												; DATA ########........ 
38dc: f0												; DATA ########........ 
38dd: f8												; DATA ##########...... 
38de: 3c												; DATA ....########.... 
38df: 0c												; DATA ........####.... 

38e0: 00												; DATA ................  $1c
38e1: 00												; DATA ................ 
38e2: 03												; DATA ............#### 
38e3: 0f												; DATA ........######## 
38e4: 0f												; DATA ........######## 
38e5: 03												; DATA ............#### 
38e6: 00												; DATA ................ 
38e7: 00												; DATA ................ 

38e8: 30												; DATA ....####........  $1d
38e9: f0												; DATA ########........ 
38ea: e0												; DATA ######.......... 
38eb: c0												; DATA ####............ 
38ec: c0												; DATA ####............ 
38ed: e0												; DATA ######.......... 
38ee: f0												; DATA ########........ 
38ef: 30												; DATA ....####........ 

38f0: 00												; DATA ................  $1e
38f1: 03												; DATA ............#### 
38f2: 0f												; DATA ........######## 
38f3: 3f												; DATA ....############ 
38f4: 3f												; DATA ....############ 
38f5: 0f												; DATA ........######## 
38f6: 03												; DATA ............#### 
38f7: 00												; DATA ................ 

38f8: c0												; DATA ####............  $1f
38f9: c0												; DATA ####............ 
38fa: 80												; DATA ##.............. 
38fb: 00												; DATA ................ 
38fc: 00												; DATA ................ 
38fd: 80												; DATA ##.............. 
38fe: c0												; DATA ####............ 
38ff: c0												; DATA ####............ 

3900: 00												; DATA ................  $20
3901: 00												; DATA ................ 
3902: 00												; DATA ................ 
3903: 00												; DATA ................ 
3904: 00												; DATA ................ 
3905: 00												; DATA ................ 
3906: 00												; DATA ................ 
3907: 00												; DATA ................ 

3908: 14												; DATA ......##..##....  $21
3909: 8a												; DATA ##......##..##.. 
390a: a1												; DATA ##..##........## 
390b: 29												; DATA ....##..##....## 
390c: d3												; DATA ####..##....#### 
390d: 52												; DATA ..##..##....##.. 
390e: 61												; DATA ..####........## 
390f: 3a												; DATA ....######..##.. 

3910: 31												; DATA ....####......##  $22
3911: 55												; DATA ..##..##..##..## 
3912: 61												; DATA ..####........## 
3913: a1												; DATA ##..##........## 
3914: 22												; DATA ....##......##.. 
3915: 44												; DATA ..##......##.... 
3916: 91												; DATA ##....##......## 
3917: ca												; DATA ####....##..##.. 

3918: 00												; DATA ................  $23
3919: 00												; DATA ................ 
391a: 00												; DATA ................ 
391b: 00												; DATA ................ 
391c: 00												; DATA ................ 
391d: 00												; DATA ................ 
391e: 00												; DATA ................ 
391f: 00												; DATA ................ 

3920: 00												; DATA ................  $24
3921: 00												; DATA ................ 
3922: 00												; DATA ................ 
3923: 00												; DATA ................ 
3924: 00												; DATA ................ 
3925: 00												; DATA ................ 
3926: 00												; DATA ................ 
3927: 00												; DATA ................ 

3928: 00												; DATA ................  $25
3929: 00												; DATA ................ 
392a: 00												; DATA ................ 
392b: 00												; DATA ................ 
392c: 00												; DATA ................ 
392d: 00												; DATA ................ 
392e: 00												; DATA ................ 
392f: 00												; DATA ................ 

3930: 00												; DATA ................  $26
3931: 00												; DATA ................ 
3932: 00												; DATA ................ 
3933: 00												; DATA ................ 
3934: 00												; DATA ................ 
3935: 00												; DATA ................ 
3936: 00												; DATA ................ 
3937: 00												; DATA ................ 

3938: 00												; DATA ................  $27
3939: 00												; DATA ................ 
393a: 00												; DATA ................ 
393b: 00												; DATA ................ 
393c: 00												; DATA ................ 
393d: 00												; DATA ................ 
393e: 00												; DATA ................ 
393f: 00												; DATA ................ 

3940: 00												; DATA ................  $28
3941: 00												; DATA ................ 
3942: 00												; DATA ................ 
3943: 00												; DATA ................ 
3944: 00												; DATA ................ 
3945: 00												; DATA ................ 
3946: 00												; DATA ................ 
3947: 00												; DATA ................ 

3948: 00												; DATA ................  $29
3949: 00												; DATA ................ 
394a: 00												; DATA ................ 
394b: 00												; DATA ................ 
394c: 00												; DATA ................ 
394d: 00												; DATA ................ 
394e: 00												; DATA ................ 
394f: 00												; DATA ................ 

3950: 00												; DATA ................  $2a
3951: 00												; DATA ................ 
3952: 00												; DATA ................ 
3953: 00												; DATA ................ 
3954: 00												; DATA ................ 
3955: 00												; DATA ................ 
3956: 00												; DATA ................ 
3957: 00												; DATA ................ 

3958: 00												; DATA ................  $2b
3959: 00												; DATA ................ 
395a: 00												; DATA ................ 
395b: 00												; DATA ................ 
395c: 00												; DATA ................ 
395d: 00												; DATA ................ 
395e: 00												; DATA ................ 
395f: 00												; DATA ................ 

3960: 00												; DATA ................  $2c
3961: 00												; DATA ................ 
3962: 00												; DATA ................ 
3963: 00												; DATA ................ 
3964: 00												; DATA ................ 
3965: 00												; DATA ................ 
3966: 00												; DATA ................ 
3967: 00												; DATA ................ 

3968: 00												; DATA ................  $2d
3969: 00												; DATA ................ 
396a: 00												; DATA ................ 
396b: 00												; DATA ................ 
396c: 00												; DATA ................ 
396d: 00												; DATA ................ 
396e: 00												; DATA ................ 
396f: 00												; DATA ................ 

3970: 00												; DATA ................  $2e
3971: 00												; DATA ................ 
3972: 00												; DATA ................ 
3973: 00												; DATA ................ 
3974: 00												; DATA ................ 
3975: 00												; DATA ................ 
3976: 00												; DATA ................ 
3977: 00												; DATA ................ 

3978: 00												; DATA ................  $2f
3979: 00												; DATA ................ 
397a: 00												; DATA ................ 
397b: 00												; DATA ................ 
397c: 00												; DATA ................ 
397d: 00												; DATA ................ 
397e: 00												; DATA ................ 
397f: 00												; DATA ................ 

3980: 00												; DATA ................  $30
3981: 38												; DATA ....######...... 
3982: 44												; DATA ..##......##.... 
3983: 44												; DATA ..##......##.... 
3984: 44												; DATA ..##......##.... 
3985: 44												; DATA ..##......##.... 
3986: 44												; DATA ..##......##.... 
3987: 38												; DATA ....######...... 

3988: 00												; DATA ................  $31
3989: 10												; DATA ......##........ 
398a: 30												; DATA ....####........ 
398b: 10												; DATA ......##........ 
398c: 10												; DATA ......##........ 
398d: 10												; DATA ......##........ 
398e: 10												; DATA ......##........ 
398f: 38												; DATA ....######...... 

3990: 00												; DATA ................  $32
3991: 38												; DATA ....######...... 
3992: 44												; DATA ..##......##.... 
3993: 04												; DATA ..........##.... 
3994: 18												; DATA ......####...... 
3995: 20												; DATA ....##.......... 
3996: 40												; DATA ..##............ 
3997: 7c												; DATA ..##########.... 

3998: 00												; DATA ................  $33
3999: 7c												; DATA ..##########.... 
399a: 04												; DATA ..........##.... 
399b: 08												; DATA ........##...... 
399c: 18												; DATA ......####...... 
399d: 04												; DATA ..........##.... 
399e: 44												; DATA ..##......##.... 
399f: 38												; DATA ....######...... 

39a0: 00												; DATA ................  $34
39a1: 08												; DATA ........##...... 
39a2: 18												; DATA ......####...... 
39a3: 28												; DATA ....##..##...... 
39a4: 48												; DATA ..##....##...... 
39a5: 7c												; DATA ..##########.... 
39a6: 08												; DATA ........##...... 
39a7: 08												; DATA ........##...... 

39a8: 00												; DATA ................  $35
39a9: 7c												; DATA ..##########.... 
39aa: 40												; DATA ..##............ 
39ab: 78												; DATA ..########...... 
39ac: 04												; DATA ..........##.... 
39ad: 04												; DATA ..........##.... 
39ae: 44												; DATA ..##......##.... 
39af: 38												; DATA ....######...... 

39b0: 00												; DATA ................  $36
39b1: 1c												; DATA ......######.... 
39b2: 20												; DATA ....##.......... 
39b3: 40												; DATA ..##............ 
39b4: 78												; DATA ..########...... 
39b5: 44												; DATA ..##......##.... 
39b6: 44												; DATA ..##......##.... 
39b7: 38												; DATA ....######...... 

39b8: 00												; DATA ................  $37
39b9: 7c												; DATA ..##########.... 
39ba: 04												; DATA ..........##.... 
39bb: 08												; DATA ........##...... 
39bc: 10												; DATA ......##........ 
39bd: 20												; DATA ....##.......... 
39be: 20												; DATA ....##.......... 
39bf: 20												; DATA ....##.......... 

39c0: 00												; DATA ................  $38
39c1: 38												; DATA ....######...... 
39c2: 44												; DATA ..##......##.... 
39c3: 44												; DATA ..##......##.... 
39c4: 38												; DATA ....######...... 
39c5: 44												; DATA ..##......##.... 
39c6: 44												; DATA ..##......##.... 
39c7: 38												; DATA ....######...... 

39c8: 00												; DATA ................  $39
39c9: 38												; DATA ....######...... 
39ca: 44												; DATA ..##......##.... 
39cb: 44												; DATA ..##......##.... 
39cc: 3c												; DATA ....########.... 
39cd: 04												; DATA ..........##.... 
39ce: 08												; DATA ........##...... 
39cf: 70												; DATA ..######........ 

39d0: 00												; DATA ................  $3a
39d1: 00												; DATA ................ 
39d2: 00												; DATA ................ 
39d3: 00												; DATA ................ 
39d4: 00												; DATA ................ 
39d5: 00												; DATA ................ 
39d6: 00												; DATA ................ 
39d7: 00												; DATA ................ 

39d8: 00												; DATA ................  $3b
39d9: 00												; DATA ................ 
39da: 00												; DATA ................ 
39db: 00												; DATA ................ 
39dc: 00												; DATA ................ 
39dd: 00												; DATA ................ 
39de: 00												; DATA ................ 
39df: 00												; DATA ................ 

39e0: 00												; DATA ................  $3c
39e1: 00												; DATA ................ 
39e2: 00												; DATA ................ 
39e3: 00												; DATA ................ 
39e4: 00												; DATA ................ 
39e5: 00												; DATA ................ 
39e6: 00												; DATA ................ 
39e7: 00												; DATA ................ 

39e8: ff												; DATA ################  $3d
39e9: ff												; DATA ################ 
39ea: ff												; DATA ################ 
39eb: ff												; DATA ################ 
39ec: ff												; DATA ################ 
39ed: ff												; DATA ################ 
39ee: ff												; DATA ################ 
39ef: ff												; DATA ################ 

39f0: 00												; DATA ................  $3e
39f1: 00												; DATA ................ 
39f2: 00												; DATA ................ 
39f3: 00												; DATA ................ 
39f4: 00												; DATA ................ 
39f5: 00												; DATA ................ 
39f6: 00												; DATA ................ 
39f7: 00												; DATA ................ 

39f8: 00												; DATA ................  $3f
39f9: 00												; DATA ................ 
39fa: 00												; DATA ................ 
39fb: 00												; DATA ................ 
39fc: 00												; DATA ................ 
39fd: 00												; DATA ................ 
39fe: 00												; DATA ................ 
39ff: 00												; DATA ................ 

3a00: 00												; DATA ................  $40
3a01: 00												; DATA ................ 
3a02: 00												; DATA ................ 
3a03: 00												; DATA ................ 
3a04: 00												; DATA ................ 
3a05: 00												; DATA ................ 
3a06: 00												; DATA ................ 
3a07: 00												; DATA ................ 

3a08: 00												; DATA ................  $41
3a09: 10												; DATA ......##........ 
3a0a: 28												; DATA ....##..##...... 
3a0b: 44												; DATA ..##......##.... 
3a0c: 44												; DATA ..##......##.... 
3a0d: 7c												; DATA ..##########.... 
3a0e: 44												; DATA ..##......##.... 
3a0f: 44												; DATA ..##......##.... 

3a10: 00												; DATA ................  $42
3a11: 78												; DATA ..########...... 
3a12: 44												; DATA ..##......##.... 
3a13: 44												; DATA ..##......##.... 
3a14: 78												; DATA ..########...... 
3a15: 44												; DATA ..##......##.... 
3a16: 44												; DATA ..##......##.... 
3a17: 78												; DATA ..########...... 

3a18: 00												; DATA ................  $43
3a19: 38												; DATA ....######...... 
3a1a: 44												; DATA ..##......##.... 
3a1b: 40												; DATA ..##............ 
3a1c: 40												; DATA ..##............ 
3a1d: 40												; DATA ..##............ 
3a1e: 44												; DATA ..##......##.... 
3a1f: 38												; DATA ....######...... 

3a20: 00												; DATA ................  $44
3a21: 78												; DATA ..########...... 
3a22: 44												; DATA ..##......##.... 
3a23: 44												; DATA ..##......##.... 
3a24: 44												; DATA ..##......##.... 
3a25: 44												; DATA ..##......##.... 
3a26: 44												; DATA ..##......##.... 
3a27: 78												; DATA ..########...... 

3a28: 00												; DATA ................  $45
3a29: 7c												; DATA ..##########.... 
3a2a: 40												; DATA ..##............ 
3a2b: 40												; DATA ..##............ 
3a2c: 78												; DATA ..########...... 
3a2d: 40												; DATA ..##............ 
3a2e: 40												; DATA ..##............ 
3a2f: 7c												; DATA ..##########.... 

3a30: 00												; DATA ................  $46
3a31: 7c												; DATA ..##########.... 
3a32: 40												; DATA ..##............ 
3a33: 40												; DATA ..##............ 
3a34: 78												; DATA ..########...... 
3a35: 40												; DATA ..##............ 
3a36: 40												; DATA ..##............ 
3a37: 40												; DATA ..##............ 

3a38: 00												; DATA ................  $47
3a39: 3c												; DATA ....########.... 
3a3a: 40												; DATA ..##............ 
3a3b: 40												; DATA ..##............ 
3a3c: 40												; DATA ..##............ 
3a3d: 4c												; DATA ..##....####.... 
3a3e: 44												; DATA ..##......##.... 
3a3f: 3c												; DATA ....########.... 

3a40: 00												; DATA ................  $48
3a41: 44												; DATA ..##......##.... 
3a42: 44												; DATA ..##......##.... 
3a43: 44												; DATA ..##......##.... 
3a44: 7c												; DATA ..##########.... 
3a45: 44												; DATA ..##......##.... 
3a46: 44												; DATA ..##......##.... 
3a47: 44												; DATA ..##......##.... 

3a48: 00												; DATA ................  $49
3a49: 38												; DATA ....######...... 
3a4a: 10												; DATA ......##........ 
3a4b: 10												; DATA ......##........ 
3a4c: 10												; DATA ......##........ 
3a4d: 10												; DATA ......##........ 
3a4e: 10												; DATA ......##........ 
3a4f: 38												; DATA ....######...... 

3a50: 00												; DATA ................  $4a
3a51: 04												; DATA ..........##.... 
3a52: 04												; DATA ..........##.... 
3a53: 04												; DATA ..........##.... 
3a54: 04												; DATA ..........##.... 
3a55: 04												; DATA ..........##.... 
3a56: 44												; DATA ..##......##.... 
3a57: 38												; DATA ....######...... 

3a58: 00												; DATA ................  $4b
3a59: 44												; DATA ..##......##.... 
3a5a: 48												; DATA ..##....##...... 
3a5b: 50												; DATA ..##..##........ 
3a5c: 70												; DATA ..######........ 
3a5d: 50												; DATA ..##..##........ 
3a5e: 48												; DATA ..##....##...... 
3a5f: 44												; DATA ..##......##.... 

3a60: 00												; DATA ................  $4c
3a61: 40												; DATA ..##............ 
3a62: 40												; DATA ..##............ 
3a63: 40												; DATA ..##............ 
3a64: 40												; DATA ..##............ 
3a65: 40												; DATA ..##............ 
3a66: 40												; DATA ..##............ 
3a67: 7c												; DATA ..##########.... 

3a68: 00												; DATA ................  $4d
3a69: 44												; DATA ..##......##.... 
3a6a: 6c												; DATA ..####..####.... 
3a6b: 54												; DATA ..##..##..##.... 
3a6c: 54												; DATA ..##..##..##.... 
3a6d: 44												; DATA ..##......##.... 
3a6e: 44												; DATA ..##......##.... 
3a6f: 44												; DATA ..##......##.... 

3a70: 00												; DATA ................  $4e
3a71: 44												; DATA ..##......##.... 
3a72: 44												; DATA ..##......##.... 
3a73: 64												; DATA ..####....##.... 
3a74: 54												; DATA ..##..##..##.... 
3a75: 4c												; DATA ..##....####.... 
3a76: 44												; DATA ..##......##.... 
3a77: 44												; DATA ..##......##.... 

3a78: 00												; DATA ................  $4f
3a79: 38												; DATA ....######...... 
3a7a: 44												; DATA ..##......##.... 
3a7b: 44												; DATA ..##......##.... 
3a7c: 44												; DATA ..##......##.... 
3a7d: 44												; DATA ..##......##.... 
3a7e: 44												; DATA ..##......##.... 
3a7f: 38												; DATA ....######...... 

3a80: 00												; DATA ................  $50
3a81: 78												; DATA ..########...... 
3a82: 44												; DATA ..##......##.... 
3a83: 44												; DATA ..##......##.... 
3a84: 78												; DATA ..########...... 
3a85: 40												; DATA ..##............ 
3a86: 40												; DATA ..##............ 
3a87: 40												; DATA ..##............ 

3a88: 00												; DATA ................  $51
3a89: 38												; DATA ....######...... 
3a8a: 44												; DATA ..##......##.... 
3a8b: 44												; DATA ..##......##.... 
3a8c: 44												; DATA ..##......##.... 
3a8d: 54												; DATA ..##..##..##.... 
3a8e: 48												; DATA ..##....##...... 
3a8f: 34												; DATA ....####..##.... 

3a90: 00												; DATA ................  $52
3a91: 78												; DATA ..########...... 
3a92: 44												; DATA ..##......##.... 
3a93: 44												; DATA ..##......##.... 
3a94: 78												; DATA ..########...... 
3a95: 50												; DATA ..##..##........ 
3a96: 48												; DATA ..##....##...... 
3a97: 44												; DATA ..##......##.... 

3a98: 00												; DATA ................  $53
3a99: 38												; DATA ....######...... 
3a9a: 44												; DATA ..##......##.... 
3a9b: 40												; DATA ..##............ 
3a9c: 38												; DATA ....######...... 
3a9d: 04												; DATA ..........##.... 
3a9e: 44												; DATA ..##......##.... 
3a9f: 38												; DATA ....######...... 

3aa0: 00												; DATA ................  $54
3aa1: 7c												; DATA ..##########.... 
3aa2: 10												; DATA ......##........ 
3aa3: 10												; DATA ......##........ 
3aa4: 10												; DATA ......##........ 
3aa5: 10												; DATA ......##........ 
3aa6: 10												; DATA ......##........ 
3aa7: 10												; DATA ......##........ 

3aa8: 00												; DATA ................  $55
3aa9: 44												; DATA ..##......##.... 
3aaa: 44												; DATA ..##......##.... 
3aab: 44												; DATA ..##......##.... 
3aac: 44												; DATA ..##......##.... 
3aad: 44												; DATA ..##......##.... 
3aae: 44												; DATA ..##......##.... 
3aaf: 38												; DATA ....######...... 

3ab0: 00												; DATA ................  $56
3ab1: 44												; DATA ..##......##.... 
3ab2: 44												; DATA ..##......##.... 
3ab3: 44												; DATA ..##......##.... 
3ab4: 44												; DATA ..##......##.... 
3ab5: 44												; DATA ..##......##.... 
3ab6: 28												; DATA ....##..##...... 
3ab7: 10												; DATA ......##........ 

3ab8: 00												; DATA ................  $57
3ab9: 44												; DATA ..##......##.... 
3aba: 44												; DATA ..##......##.... 
3abb: 44												; DATA ..##......##.... 
3abc: 54												; DATA ..##..##..##.... 
3abd: 54												; DATA ..##..##..##.... 
3abe: 6c												; DATA ..####..####.... 
3abf: 44												; DATA ..##......##.... 

3ac0: 00												; DATA ................  $58
3ac1: 44												; DATA ..##......##.... 
3ac2: 44												; DATA ..##......##.... 
3ac3: 28												; DATA ....##..##...... 
3ac4: 10												; DATA ......##........ 
3ac5: 28												; DATA ....##..##...... 
3ac6: 44												; DATA ..##......##.... 
3ac7: 44												; DATA ..##......##.... 

3ac8: 00												; DATA ................  $59
3ac9: 44												; DATA ..##......##.... 
3aca: 44												; DATA ..##......##.... 
3acb: 28												; DATA ....##..##...... 
3acc: 10												; DATA ......##........ 
3acd: 10												; DATA ......##........ 
3ace: 10												; DATA ......##........ 
3acf: 10												; DATA ......##........ 

3ad0: 00												; DATA ................  $5a
3ad1: 7c												; DATA ..##########.... 
3ad2: 04												; DATA ..........##.... 
3ad3: 08												; DATA ........##...... 
3ad4: 10												; DATA ......##........ 
3ad5: 20												; DATA ....##.......... 
3ad6: 40												; DATA ..##............ 
3ad7: 7c												; DATA ..##########.... 

3ad8: 80												; DATA ##..............  $5b
3ad9: 80												; DATA ##.............. 
3ada: 80												; DATA ##.............. 
3adb: 80												; DATA ##.............. 
3adc: 80												; DATA ##.............. 
3add: 80												; DATA ##.............. 
3ade: 80												; DATA ##.............. 
3adf: 80												; DATA ##..............
				
3ae0: ff												; DATA ################  $5c
3ae1: df												; DATA ####..########## 
3ae2: 4e												; DATA ..##....######.. 
3ae3: ff												; DATA ################ 
3ae4: ff												; DATA ################ 
3ae5: ff												; DATA ################ 
3ae6: df												; DATA ####..########## 
3ae7: df												; DATA ####..########## 

3ae8: ff												; DATA ################  $5d
3ae9: ff												; DATA ################ 
3aea: ff												; DATA ################ 
3aeb: ff												; DATA ################ 
3aec: df												; DATA ####..########## 
3aed: ff												; DATA ################ 
3aee: df												; DATA ####..########## 
3aef: ff												; DATA ################ 

3af0: ff												; DATA ################  $5e
3af1: ff												; DATA ################ 
3af2: ff												; DATA ################ 
3af3: ff												; DATA ################ 
3af4: ff												; DATA ################ 
3af5: ff												; DATA ################ 
3af6: df												; DATA ####..########## 
3af7: ff												; DATA ################ 

3af8: ff												; DATA ################  $5f
3af9: df												; DATA ####..########## 
3afa: df												; DATA ####..########## 
3afb: af												; DATA ##..##..######## 
3afc: ff												; DATA ################ 
3afd: df												; DATA ####..########## 
3afe: ff												; DATA ################ 
3aff: ff												; DATA ################ 
				
3b00: 00												; DATA ................  $60
3b01: 00												; DATA ................ 
3b02: 00												; DATA ................ 
3b03: 00												; DATA ................ 
3b04: 00												; DATA ................ 
3b05: 00												; DATA ................ 
3b06: 00												; DATA ................ 
3b07: ff												; DATA ################ 

3b08: ff												; DATA ################  $61
3b09: 00												; DATA ................ 
3b0a: 00												; DATA ................ 
3b0b: 00												; DATA ................ 
3b0c: 00												; DATA ................ 
3b0d: 00												; DATA ................ 
3b0e: 00												; DATA ................ 
3b0f: 00												; DATA ................ 

3b10: 01												; DATA ..............##  $62
3b11: 01												; DATA ..............## 
3b12: 01												; DATA ..............## 
3b13: 01												; DATA ..............## 
3b14: 01												; DATA ..............## 
3b15: 01												; DATA ..............## 
3b16: 01												; DATA ..............## 
3b17: 01												; DATA ..............## 

3b18: 80												; DATA ##..............  $63
3b19: 80												; DATA ##.............. 
3b1a: 80												; DATA ##.............. 
3b1b: 80												; DATA ##.............. 
3b1c: 80												; DATA ##.............. 
3b1d: 80												; DATA ##.............. 
3b1e: 80												; DATA ##.............. 
3b1f: 80												; DATA ##.............. 

3b20: 3c												; DATA ....########....  $64
3b21: a5												; DATA ##..##....##..## 
3b22: ff												; DATA ################ 
3b23: bd												; DATA ##..########..## 
3b24: 3c												; DATA ....########.... 
3b25: bd												; DATA ##..########..## 
3b26: ff												; DATA ################ 
3b27: bd												; DATA ##..########..## 

3b28: bd												; DATA ##..########..##  $65
3b29: ff												; DATA ################ 
3b2a: bd												; DATA ##..########..## 
3b2b: 3c												; DATA ....########.... 
3b2c: bd												; DATA ##..########..## 
3b2d: ff												; DATA ################ 
3b2e: a5												; DATA ##..##....##..## 
3b2f: 3c												; DATA ....########.... 

3b30: ee												; DATA ######..######..  $66
3b31: 44												; DATA ..##......##.... 
3b32: ff												; DATA ################ 
3b33: fd												; DATA ############..## 
3b34: fd												; DATA ############..## 
3b35: ff												; DATA ################ 
3b36: 44												; DATA ..##......##.... 
3b37: ee												; DATA ######..######.. 

3b38: 77												; DATA ..######..######  $67
3b39: 22												; DATA ....##......##.. 
3b3a: ff												; DATA ################ 
3b3b: bf												; DATA ##..############ 
3b3c: bf												; DATA ##..############ 
3b3d: ff												; DATA ################ 
3b3e: 22												; DATA ....##......##.. 
3b3f: 77												; DATA ..######..###### 

3b40: 00												; DATA ................  $68
3b41: 00												; DATA ................ 
3b42: 00												; DATA ................ 
3b43: 00												; DATA ................ 
3b44: 00												; DATA ................ 
3b45: 00												; DATA ................ 
3b46: 00												; DATA ................ 
3b47: 00												; DATA ................ 

3b48: 00												; DATA ................  $69
3b49: 00												; DATA ................ 
3b4a: 00												; DATA ................ 
3b4b: 00												; DATA ................ 
3b4c: 00												; DATA ................ 
3b4d: 00												; DATA ................ 
3b4e: 00												; DATA ................ 
3b4f: 00												; DATA ................ 

3b50: 00												; DATA ................  $6a
3b51: 00												; DATA ................ 
3b52: 00												; DATA ................ 
3b53: 00												; DATA ................ 
3b54: 00												; DATA ................ 
3b55: 00												; DATA ................ 
3b56: 00												; DATA ................ 
3b57: 00												; DATA ................ 

3b58: 00												; DATA ................  $6b
3b59: 00												; DATA ................ 
3b5a: 00												; DATA ................ 
3b5b: 00												; DATA ................ 
3b5c: 00												; DATA ................ 
3b5d: 00												; DATA ................ 
3b5e: 00												; DATA ................ 
3b5f: 00												; DATA ................ 

3b60: 00												; DATA ................  $6c
3b61: 00												; DATA ................ 
3b62: 00												; DATA ................ 
3b63: 00												; DATA ................ 
3b64: 00												; DATA ................ 
3b65: 00												; DATA ................ 
3b66: 00												; DATA ................ 
3b67: 00												; DATA ................ 

3b68: 00												; DATA ................  $6d
3b69: 00												; DATA ................ 
3b6a: 00												; DATA ................ 
3b6b: 00												; DATA ................ 
3b6c: 00												; DATA ................ 
3b6d: 00												; DATA ................ 
3b6e: 00												; DATA ................ 
3b6f: 00												; DATA ................ 

3b70: 00												; DATA ................  $6e
3b71: 00												; DATA ................ 
3b72: 00												; DATA ................ 
3b73: 00												; DATA ................ 
3b74: 00												; DATA ................ 
3b75: 00												; DATA ................ 
3b76: 00												; DATA ................ 
3b77: 00												; DATA ................ 

3b78: 00												; DATA ................  $6f
3b79: 00												; DATA ................ 
3b7a: 00												; DATA ................ 
3b7b: 00												; DATA ................ 
3b7c: 00												; DATA ................ 
3b7d: 00												; DATA ................ 
3b7e: 00												; DATA ................ 
3b7f: 00												; DATA ................ 

3b80: 00												; DATA ................  $70
3b81: 00												; DATA ................ 
3b82: 00												; DATA ................ 
3b83: 00												; DATA ................ 
3b84: 00												; DATA ................ 
3b85: 00												; DATA ................ 
3b86: 00												; DATA ................ 
3b87: 00												; DATA ................ 

3b88: 00												; DATA ................  $71
3b89: 00												; DATA ................ 
3b8a: 00												; DATA ................ 
3b8b: 00												; DATA ................ 
3b8c: 00												; DATA ................ 
3b8d: 00												; DATA ................ 
3b8e: 00												; DATA ................ 
3b8f: 00												; DATA ................ 

3b90: 00												; DATA ................  $72
3b91: 00												; DATA ................ 
3b92: 00												; DATA ................ 
3b93: 00												; DATA ................ 
3b94: 00												; DATA ................ 
3b95: 00												; DATA ................ 
3b96: 00												; DATA ................ 
3b97: 00												; DATA ................ 

3b98: 00												; DATA ................  $73
3b99: 00												; DATA ................ 
3b9a: 00												; DATA ................ 
3b9b: 00												; DATA ................ 
3b9c: 00												; DATA ................ 
3b9d: 00												; DATA ................ 
3b9e: 00												; DATA ................ 
3b9f: 00												; DATA ................ 

3ba0: 00												; DATA ................  $74
3ba1: 00												; DATA ................ 
3ba2: 00												; DATA ................ 
3ba3: 00												; DATA ................ 
3ba4: 00												; DATA ................ 
3ba5: 00												; DATA ................ 
3ba6: 00												; DATA ................ 
3ba7: 00												; DATA ................ 

3ba8: 00												; DATA ................  $75
3ba9: 00												; DATA ................ 
3baa: 00												; DATA ................ 
3bab: 00												; DATA ................ 
3bac: 00												; DATA ................ 
3bad: 00												; DATA ................ 
3bae: 00												; DATA ................ 
3baf: 00												; DATA ................ 

3bb0: 00												; DATA ................  $76
3bb1: 00												; DATA ................ 
3bb2: 00												; DATA ................ 
3bb3: 00												; DATA ................ 
3bb4: 00												; DATA ................ 
3bb5: 00												; DATA ................ 
3bb6: 00												; DATA ................ 
3bb7: 00												; DATA ................ 

3bb8: 00												; DATA ................  $77
3bb9: 00												; DATA ................ 
3bba: 00												; DATA ................ 
3bbb: 00												; DATA ................ 
3bbc: 00												; DATA ................ 
3bbd: 00												; DATA ................ 
3bbe: 00												; DATA ................ 
3bbf: 00												; DATA ................ 

3bc0: 00												; DATA ................  $78
3bc1: 00												; DATA ................ 
3bc2: 00												; DATA ................ 
3bc3: 00												; DATA ................ 
3bc4: 00												; DATA ................ 
3bc5: 00												; DATA ................ 
3bc6: 00												; DATA ................ 
3bc7: 00												; DATA ................ 

3bc8: 00												; DATA ................  $79
3bc9: 00												; DATA ................ 
3bca: 00												; DATA ................ 
3bcb: 00												; DATA ................ 
3bcc: 00												; DATA ................ 
3bcd: 00												; DATA ................ 
3bce: 00												; DATA ................ 
3bcf: 00												; DATA ................ 

3bd0: 00												; DATA ................  $7a
3bd1: 00												; DATA ................ 
3bd2: 00												; DATA ................ 
3bd3: 00												; DATA ................ 
3bd4: 00												; DATA ................ 
3bd5: 00												; DATA ................ 
3bd6: 00												; DATA ................ 
3bd7: 00												; DATA ................ 

3bd8: 00												; DATA ................  $7b
3bd9: 00												; DATA ................ 
3bda: 00												; DATA ................ 
3bdb: 00												; DATA ................ 
3bdc: 00												; DATA ................ 
3bdd: 00												; DATA ................ 
3bde: 00												; DATA ................ 
3bdf: 00												; DATA ................ 

3be0: 00												; DATA ................  $7c
3be1: 00												; DATA ................ 
3be2: 00												; DATA ................ 
3be3: 00												; DATA ................ 
3be4: 00												; DATA ................ 
3be5: 00												; DATA ................ 
3be6: 00												; DATA ................ 
3be7: 00												; DATA ................ 

3be8: 00												; DATA ................  $7d
3be9: 00												; DATA ................ 
3bea: 00												; DATA ................ 
3beb: 00												; DATA ................ 
3bec: 00												; DATA ................ 
3bed: 00												; DATA ................ 
3bee: 00												; DATA ................ 
3bef: 00												; DATA ................ 

3bf0: 00												; DATA ................  $7e
3bf1: 00												; DATA ................ 
3bf2: 00												; DATA ................ 
3bf3: 00												; DATA ................ 
3bf4: 00												; DATA ................ 
3bf5: 00												; DATA ................ 
3bf6: 00												; DATA ................ 
3bf7: 00												; DATA ................ 

3bf8: 00												; DATA ................  $7f
3bf9: 00												; DATA ................ 
3bfa: 00												; DATA ................ 
3bfb: 00												; DATA ................ 
3bfc: 00												; DATA ................ 
3bfd: 00												; DATA ................ 
3bfe: 00												; DATA ................ 
3bff: 00												; DATA ................ 

3c00: 00												; DATA ................  $80
3c01: 7f												; DATA ..############## 
3c02: 7f												; DATA ..############## 
3c03: 7f												; DATA ..############## 
3c04: 7f												; DATA ..############## 
3c05: 7f												; DATA ..############## 
3c06: 7f												; DATA ..############## 
3c07: 7e												; DATA ..############.. 

3c08: 00												; DATA ................  $81
3c09: fe												; DATA ##############.. 
3c0a: fe												; DATA ##############.. 
3c0b: fe												; DATA ##############.. 
3c0c: fe												; DATA ##############.. 
3c0d: fe												; DATA ##############.. 
3c0e: fe												; DATA ##############.. 
3c0f: 7e												; DATA ..############.. 

3c10: 7e												; DATA ..############..  $82
3c11: 7f												; DATA ..############## 
3c12: 7f												; DATA ..############## 
3c13: 7f												; DATA ..############## 
3c14: 7f												; DATA ..############## 
3c15: 7f												; DATA ..############## 
3c16: 7f												; DATA ..############## 
3c17: 00												; DATA ................ 

3c18: 7e												; DATA ..############..  $83
3c19: fe												; DATA ##############.. 
3c1a: fe												; DATA ##############.. 
3c1b: fe												; DATA ##############.. 
3c1c: fe												; DATA ##############.. 
3c1d: fe												; DATA ##############.. 
3c1e: fe												; DATA ##############.. 
3c1f: 00												; DATA ................ 

3c20: 00												; DATA ................  $84
3c21: 7f												; DATA ..############## 
3c22: 7f												; DATA ..############## 
3c23: 7f												; DATA ..############## 
3c24: 7f												; DATA ..############## 
3c25: 78												; DATA ..########...... 
3c26: 78												; DATA ..########...... 
3c27: 78												; DATA ..########...... 

3c28: 00												; DATA ................  $85
3c29: fe												; DATA ##############.. 
3c2a: fe												; DATA ##############.. 
3c2b: fe												; DATA ##############.. 
3c2c: fe												; DATA ##############.. 
3c2d: 1e												; DATA ......########.. 
3c2e: 1e												; DATA ......########.. 
3c2f: 1e												; DATA ......########.. 

3c30: 78												; DATA ..########......  $86
3c31: 78												; DATA ..########...... 
3c32: 78												; DATA ..########...... 
3c33: 7f												; DATA ..############## 
3c34: 7f												; DATA ..############## 
3c35: 7f												; DATA ..############## 
3c36: 7f												; DATA ..############## 
3c37: 00												; DATA ................ 

3c38: 1e												; DATA ......########..  $87
3c39: 1e												; DATA ......########.. 
3c3a: 1e												; DATA ......########.. 
3c3b: fe												; DATA ##############.. 
3c3c: fe												; DATA ##############.. 
3c3d: fe												; DATA ##############.. 
3c3e: fe												; DATA ##############.. 
3c3f: 00												; DATA ................ 

3c40: 00												; DATA ................  $88
3c41: 7f												; DATA ..############## 
3c42: 7f												; DATA ..############## 
3c43: 60												; DATA ..####.......... 
3c44: 60												; DATA ..####.......... 
3c45: 60												; DATA ..####.......... 
3c46: 60												; DATA ..####.......... 
3c47: 60												; DATA ..####.......... 

3c48: 00												; DATA ................  $89
3c49: fe												; DATA ##############.. 
3c4a: fe												; DATA ##############.. 
3c4b: 06												; DATA ..........####.. 
3c4c: 06												; DATA ..........####.. 
3c4d: 06												; DATA ..........####.. 
3c4e: 06												; DATA ..........####.. 
3c4f: 06												; DATA ..........####.. 

3c50: 60												; DATA ..####..........  $8a
3c51: 60												; DATA ..####.......... 
3c52: 60												; DATA ..####.......... 
3c53: 60												; DATA ..####.......... 
3c54: 60												; DATA ..####.......... 
3c55: 7f												; DATA ..############## 
3c56: 7f												; DATA ..############## 
3c57: 00												; DATA ................ 

3c58: 06												; DATA ..........####..  $8b
3c59: 06												; DATA ..........####.. 
3c5a: 06												; DATA ..........####.. 
3c5b: 06												; DATA ..........####.. 
3c5c: 06												; DATA ..........####.. 
3c5d: fe												; DATA ##############.. 
3c5e: fe												; DATA ##############.. 
3c5f: 00												; DATA ................ 

3c60: 00												; DATA ................  $8c
3c61: 7f												; DATA ..############## 
3c62: 7f												; DATA ..############## 
3c63: 7f												; DATA ..############## 
3c64: 7f												; DATA ..############## 
3c65: 7f												; DATA ..############## 
3c66: 7f												; DATA ..############## 
3c67: 7f												; DATA ..############## 

3c68: 00												; DATA ................  $8d
3c69: fe												; DATA ##############.. 
3c6a: fe												; DATA ##############.. 
3c6b: fe												; DATA ##############.. 
3c6c: fe												; DATA ##############.. 
3c6d: fe												; DATA ##############.. 
3c6e: fe												; DATA ##############.. 
3c6f: fe												; DATA ##############.. 

3c70: 7f												; DATA ..##############  $8e
3c71: 7f												; DATA ..############## 
3c72: 7f												; DATA ..############## 
3c73: 7f												; DATA ..############## 
3c74: 7f												; DATA ..############## 
3c75: 7f												; DATA ..############## 
3c76: 7f												; DATA ..############## 
3c77: 00												; DATA ................ 

3c78: fe												; DATA ##############..  $8f
3c79: fe												; DATA ##############.. 
3c7a: fe												; DATA ##############.. 
3c7b: fe												; DATA ##############.. 
3c7c: fe												; DATA ##############.. 
3c7d: fe												; DATA ##############.. 
3c7e: fe												; DATA ##############.. 
3c7f: 00												; DATA ................ 

3c80: 00												; DATA ................  $90
3c81: 00												; DATA ................ 
3c82: 00												; DATA ................ 
3c83: 00												; DATA ................ 
3c84: 00												; DATA ................ 
3c85: 00												; DATA ................ 
3c86: 00												; DATA ................ 
3c87: 00												; DATA ................ 

3c88: 18												; DATA ......####......  $91
3c89: 24												; DATA ....##....##.... 
3c8a: 24												; DATA ....##....##.... 
3c8b: 18												; DATA ......####...... 
3c8c: 2c												; DATA ....##..####.... 
3c8d: 76												; DATA ..######..####.. 
3c8e: bd												; DATA ##..########..## 
3c8f: 81												; DATA ##............## 

3c90: 00												; DATA ................  $92
3c91: 00												; DATA ................ 
3c92: 00												; DATA ................ 
3c93: 00												; DATA ................ 
3c94: 00												; DATA ................ 
3c95: 00												; DATA ................ 
3c96: 00												; DATA ................ 
3c97: 00												; DATA ................ 

3c98: 00												; DATA ................  $93
3c99: 00												; DATA ................ 
3c9a: 00												; DATA ................ 
3c9b: 00												; DATA ................ 
3c9c: 00												; DATA ................ 
3c9d: 00												; DATA ................ 
3c9e: 00												; DATA ................ 
3c9f: 00												; DATA ................ 

3ca0: 00												; DATA ................  $94
3ca1: 00												; DATA ................ 
3ca2: 00												; DATA ................ 
3ca3: 00												; DATA ................ 
3ca4: 00												; DATA ................ 
3ca5: 00												; DATA ................ 
3ca6: 00												; DATA ................ 
3ca7: 00												; DATA ................ 

3ca8: 00												; DATA ................  $95
3ca9: 00												; DATA ................ 
3caa: 00												; DATA ................ 
3cab: 00												; DATA ................ 
3cac: 00												; DATA ................ 
3cad: 00												; DATA ................ 
3cae: 00												; DATA ................ 
3caf: 00												; DATA ................ 

3cb0: 00												; DATA ................  $96
3cb1: 00												; DATA ................ 
3cb2: 00												; DATA ................ 
3cb3: 00												; DATA ................ 
3cb4: 00												; DATA ................ 
3cb5: 00												; DATA ................ 
3cb6: 00												; DATA ................ 
3cb7: 00												; DATA ................ 

3cb8: 00												; DATA ................  $97
3cb9: 00												; DATA ................ 
3cba: 00												; DATA ................ 
3cbb: 00												; DATA ................ 
3cbc: 00												; DATA ................ 
3cbd: 00												; DATA ................ 
3cbe: 00												; DATA ................ 
3cbf: 00												; DATA ................ 

3cc0: 00												; DATA ................  $98
3cc1: 00												; DATA ................ 
3cc2: 00												; DATA ................ 
3cc3: 00												; DATA ................ 
3cc4: 00												; DATA ................ 
3cc5: 00												; DATA ................ 
3cc6: 00												; DATA ................ 
3cc7: 00												; DATA ................ 

3cc8: 00												; DATA ................  $99
3cc9: 00												; DATA ................ 
3cca: 00												; DATA ................ 
3ccb: 00												; DATA ................ 
3ccc: 00												; DATA ................ 
3ccd: 00												; DATA ................ 
3cce: 00												; DATA ................ 
3ccf: 00												; DATA ................ 

3cd0: 00												; DATA ................  $9a
3cd1: 00												; DATA ................ 
3cd2: 00												; DATA ................ 
3cd3: 00												; DATA ................ 
3cd4: 00												; DATA ................ 
3cd5: 00												; DATA ................ 
3cd6: 00												; DATA ................ 
3cd7: 00												; DATA ................ 

3cd8: 00												; DATA ................  $9b
3cd9: 00												; DATA ................ 
3cda: 00												; DATA ................ 
3cdb: 00												; DATA ................ 
3cdc: 00												; DATA ................ 
3cdd: 00												; DATA ................ 
3cde: 00												; DATA ................ 
3cdf: 00												; DATA ................ 

3ce0: 00												; DATA ................  $9c
3ce1: 00												; DATA ................ 
3ce2: 00												; DATA ................ 
3ce3: 00												; DATA ................ 
3ce4: 00												; DATA ................ 
3ce5: 00												; DATA ................ 
3ce6: 00												; DATA ................ 
3ce7: 00												; DATA ................ 

3ce8: 00												; DATA ................  $9d
3ce9: 00												; DATA ................ 
3cea: 00												; DATA ................ 
3ceb: 00												; DATA ................ 
3cec: 00												; DATA ................ 
3ced: 00												; DATA ................ 
3cee: 00												; DATA ................ 
3cef: 00												; DATA ................ 

3cf0: 00												; DATA ................  $9e
3cf1: 00												; DATA ................ 
3cf2: 00												; DATA ................ 
3cf3: 00												; DATA ................ 
3cf4: 00												; DATA ................ 
3cf5: 00												; DATA ................ 
3cf6: 00												; DATA ................ 
3cf7: 00												; DATA ................ 

3cf8: 00												; DATA ................  $9f
3cf9: 00												; DATA ................ 
3cfa: 00												; DATA ................ 
3cfb: 00												; DATA ................ 
3cfc: 00												; DATA ................ 
3cfd: 00												; DATA ................ 
3cfe: 00												; DATA ................ 
3cff: 00												; DATA ................ 

3d00: 00												; DATA ................  $a0
3d01: 00												; DATA ................ 
3d02: 00												; DATA ................ 
3d03: 00												; DATA ................ 
3d04: 00												; DATA ................ 
3d05: 00												; DATA ................ 
3d06: 00												; DATA ................ 
3d07: 00												; DATA ................ 

3d08: 00												; DATA ................  $a1
3d09: 00												; DATA ................ 
3d0a: 00												; DATA ................ 
3d0b: 00												; DATA ................ 
3d0c: 00												; DATA ................ 
3d0d: 00												; DATA ................ 
3d0e: 00												; DATA ................ 
3d0f: 00												; DATA ................ 

3d10: 00												; DATA ................  $a2
3d11: 00												; DATA ................ 
3d12: 00												; DATA ................ 
3d13: 00												; DATA ................ 
3d14: 00												; DATA ................ 
3d15: 00												; DATA ................ 
3d16: 00												; DATA ................ 
3d17: 00												; DATA ................ 

3d18: 00												; DATA ................  $a3
3d19: 00												; DATA ................ 
3d1a: 00												; DATA ................ 
3d1b: 00												; DATA ................ 
3d1c: 00												; DATA ................ 
3d1d: 00												; DATA ................ 
3d1e: 00												; DATA ................ 
3d1f: 00												; DATA ................ 

3d20: 00												; DATA ................  $a4
3d21: 00												; DATA ................ 
3d22: 00												; DATA ................ 
3d23: 00												; DATA ................ 
3d24: 00												; DATA ................ 
3d25: 00												; DATA ................ 
3d26: 00												; DATA ................ 
3d27: 00												; DATA ................ 

3d28: 00												; DATA ................  $a5
3d29: 00												; DATA ................ 
3d2a: 00												; DATA ................ 
3d2b: 00												; DATA ................ 
3d2c: 00												; DATA ................ 
3d2d: 00												; DATA ................ 
3d2e: 00												; DATA ................ 
3d2f: 00												; DATA ................ 

3d30: 00												; DATA ................  $a6
3d31: 00												; DATA ................ 
3d32: 00												; DATA ................ 
3d33: 00												; DATA ................ 
3d34: 00												; DATA ................ 
3d35: 00												; DATA ................ 
3d36: 00												; DATA ................ 
3d37: 00												; DATA ................ 

3d38: 00												; DATA ................  $a7
3d39: 00												; DATA ................ 
3d3a: 00												; DATA ................ 
3d3b: 00												; DATA ................ 
3d3c: 00												; DATA ................ 
3d3d: 00												; DATA ................ 
3d3e: 00												; DATA ................ 
3d3f: 00												; DATA ................ 

3d40: 00												; DATA ................  $a8
3d41: 00												; DATA ................ 
3d42: 00												; DATA ................ 
3d43: 00												; DATA ................ 
3d44: 00												; DATA ................ 
3d45: 00												; DATA ................ 
3d46: 00												; DATA ................ 
3d47: 00												; DATA ................ 

3d48: 00												; DATA ................  $a9
3d49: 00												; DATA ................ 
3d4a: 00												; DATA ................ 
3d4b: 00												; DATA ................ 
3d4c: 00												; DATA ................ 
3d4d: 00												; DATA ................ 
3d4e: 00												; DATA ................ 
3d4f: 00												; DATA ................ 

3d50: 00												; DATA ................  $aa
3d51: 00												; DATA ................ 
3d52: 00												; DATA ................ 
3d53: 00												; DATA ................ 
3d54: 00												; DATA ................ 
3d55: 00												; DATA ................ 
3d56: 00												; DATA ................ 
3d57: 00												; DATA ................ 

3d58: 00												; DATA ................  $ab
3d59: 00												; DATA ................ 
3d5a: 00												; DATA ................ 
3d5b: 00												; DATA ................ 
3d5c: 00												; DATA ................ 
3d5d: 00												; DATA ................ 
3d5e: 00												; DATA ................ 
3d5f: 00												; DATA ................ 

3d60: 00												; DATA ................  $ac
3d61: 00												; DATA ................ 
3d62: 00												; DATA ................ 
3d63: 00												; DATA ................ 
3d64: 00												; DATA ................ 
3d65: 00												; DATA ................ 
3d66: 00												; DATA ................ 
3d67: 00												; DATA ................ 

3d68: 00												; DATA ................  $ad
3d69: 00												; DATA ................ 
3d6a: 00												; DATA ................ 
3d6b: 00												; DATA ................ 
3d6c: 00												; DATA ................ 
3d6d: 00												; DATA ................ 
3d6e: 00												; DATA ................ 
3d6f: 00												; DATA ................ 

3d70: 00												; DATA ................  $ae
3d71: 00												; DATA ................ 
3d72: 00												; DATA ................ 
3d73: 00												; DATA ................ 
3d74: 00												; DATA ................ 
3d75: 00												; DATA ................ 
3d76: 00												; DATA ................ 
3d77: 00												; DATA ................ 

3d78: 00												; DATA ................  $af
3d79: 00												; DATA ................ 
3d7a: 00												; DATA ................ 
3d7b: 00												; DATA ................ 
3d7c: 00												; DATA ................ 
3d7d: 00												; DATA ................ 
3d7e: 00												; DATA ................ 
3d7f: 00												; DATA ................ 

3d80: 00												; DATA ................  $b0
3d81: 00												; DATA ................ 
3d82: 00												; DATA ................ 
3d83: 00												; DATA ................ 
3d84: 00												; DATA ................ 
3d85: 00												; DATA ................ 
3d86: 00												; DATA ................ 
3d87: 00												; DATA ................ 

3d88: 00												; DATA ................  $b1
3d89: 00												; DATA ................ 
3d8a: 00												; DATA ................ 
3d8b: 00												; DATA ................ 
3d8c: 00												; DATA ................ 
3d8d: 00												; DATA ................ 
3d8e: 00												; DATA ................ 
3d8f: 00												; DATA ................ 

3d90: 00												; DATA ................  $b2
3d91: 00												; DATA ................ 
3d92: 00												; DATA ................ 
3d93: 00												; DATA ................ 
3d94: 00												; DATA ................ 
3d95: 00												; DATA ................ 
3d96: 00												; DATA ................ 
3d97: 00												; DATA ................ 

3d98: 00												; DATA ................  $b3
3d99: 00												; DATA ................ 
3d9a: 00												; DATA ................ 
3d9b: 00												; DATA ................ 
3d9c: 00												; DATA ................ 
3d9d: 00												; DATA ................ 
3d9e: 00												; DATA ................ 
3d9f: 00												; DATA ................ 

3da0: 00												; DATA ................  $b4
3da1: 00												; DATA ................ 
3da2: 00												; DATA ................ 
3da3: 00												; DATA ................ 
3da4: 00												; DATA ................ 
3da5: 00												; DATA ................ 
3da6: 00												; DATA ................ 
3da7: 00												; DATA ................ 

3da8: 00												; DATA ................  $b5
3da9: 00												; DATA ................ 
3daa: 00												; DATA ................ 
3dab: 00												; DATA ................ 
3dac: 00												; DATA ................ 
3dad: 00												; DATA ................ 
3dae: 00												; DATA ................ 
3daf: 00												; DATA ................ 

3db0: 00												; DATA ................  $b6
3db1: 00												; DATA ................ 
3db2: 00												; DATA ................ 
3db3: 00												; DATA ................ 
3db4: 00												; DATA ................ 
3db5: 00												; DATA ................ 
3db6: 00												; DATA ................ 
3db7: 00												; DATA ................ 

3db8: 00												; DATA ................  $b7
3db9: 00												; DATA ................ 
3dba: 00												; DATA ................ 
3dbb: 00												; DATA ................ 
3dbc: 00												; DATA ................ 
3dbd: 00												; DATA ................ 
3dbe: 00												; DATA ................ 
3dbf: 00												; DATA ................ 

3dc0: 00												; DATA ................  $b8
3dc1: 00												; DATA ................ 
3dc2: 00												; DATA ................ 
3dc3: 00												; DATA ................ 
3dc4: 00												; DATA ................ 
3dc5: 00												; DATA ................ 
3dc6: 00												; DATA ................ 
3dc7: 00												; DATA ................ 

3dc8: 00												; DATA ................  $b9
3dc9: 00												; DATA ................ 
3dca: 00												; DATA ................ 
3dcb: 00												; DATA ................ 
3dcc: 00												; DATA ................ 
3dcd: 00												; DATA ................ 
3dce: 00												; DATA ................ 
3dcf: 00												; DATA ................ 

3dd0: 00												; DATA ................  $ba
3dd1: 7f												; DATA ..############## 
3dd2: 7f												; DATA ..############## 
3dd3: 7f												; DATA ..############## 
3dd4: 7f												; DATA ..############## 
3dd5: 7f												; DATA ..############## 
3dd6: 7f												; DATA ..############## 
3dd7: 7f												; DATA ..############## 

3dd8: 00												; DATA ................  $bb
3dd9: fe												; DATA ##############.. 
3dda: fe												; DATA ##############.. 
3ddb: fe												; DATA ##############.. 
3ddc: fe												; DATA ##############.. 
3ddd: fe												; DATA ##############.. 
3dde: fe												; DATA ##############.. 
3ddf: fe												; DATA ##############.. 

3de0: 7f												; DATA ..##############  $bc
3de1: 7f												; DATA ..############## 
3de2: 7f												; DATA ..############## 
3de3: 7f												; DATA ..############## 
3de4: 7f												; DATA ..############## 
3de5: 7f												; DATA ..############## 
3de6: 7f												; DATA ..############## 
3de7: 00												; DATA ................ 

3de8: fe												; DATA ##############..  $bd
3de9: fe												; DATA ##############.. 
3dea: fe												; DATA ##############.. 
3deb: fe												; DATA ##############.. 
3dec: fe												; DATA ##############.. 
3ded: fe												; DATA ##############.. 
3dee: fe												; DATA ##############.. 
3def: 00												; DATA ................ 

3df0: 00												; DATA ................  $be
3df1: 00												; DATA ................ 
3df2: 00												; DATA ................ 
3df3: 00												; DATA ................ 
3df4: 00												; DATA ................ 
3df5: 00												; DATA ................ 
3df6: 00												; DATA ................ 
3df7: 00												; DATA ................ 

3df8: 00												; DATA ................  $bf
3df9: 00												; DATA ................ 
3dfa: 00												; DATA ................ 
3dfb: 00												; DATA ................ 
3dfc: 00												; DATA ................ 
3dfd: 00												; DATA ................ 
3dfe: 00												; DATA ................ 
3dff: 00												; DATA ................ 

3e00: 00												; DATA ................  $c0
3e01: 00												; DATA ................ 
3e02: 00												; DATA ................ 
3e03: 00												; DATA ................ 
3e04: 00												; DATA ................ 
3e05: 00												; DATA ................ 
3e06: 00												; DATA ................ 
3e07: 00												; DATA ................ 

3e08: 18												; DATA ......####......  $c1
3e09: 24												; DATA ....##....##.... 
3e0a: 24												; DATA ....##....##.... 
3e0b: 18												; DATA ......####...... 
3e0c: 2c												; DATA ....##..####.... 
3e0d: 76												; DATA ..######..####.. 
3e0e: bd												; DATA ##..########..## 
3e0f: 81												; DATA ##............## 

3e10: 00												; DATA ................  $c2
3e11: 00												; DATA ................ 
3e12: 00												; DATA ................ 
3e13: 00												; DATA ................ 
3e14: 00												; DATA ................ 
3e15: 00												; DATA ................ 
3e16: 18												; DATA ......####...... 
3e17: 24												; DATA ....##....##.... 

3e18: 24												; DATA ....##....##....  $c3
3e19: 18												; DATA ......####...... 
3e1a: 2c												; DATA ....##..####.... 
3e1b: 76												; DATA ..######..####.. 
3e1c: bd												; DATA ##..########..## 
3e1d: 81												; DATA ##............## 
3e1e: 00												; DATA ................ 
3e1f: 00												; DATA ................ 

3e20: 00												; DATA ................  $c4
3e21: 00												; DATA ................ 
3e22: 00												; DATA ................ 
3e23: 00												; DATA ................ 
3e24: 18												; DATA ......####...... 
3e25: 24												; DATA ....##....##.... 
3e26: 24												; DATA ....##....##.... 
3e27: 18												; DATA ......####...... 

3e28: 2c												; DATA ....##..####....  $c5
3e29: 76												; DATA ..######..####.. 
3e2a: bd												; DATA ##..########..## 
3e2b: 81												; DATA ##............## 
3e2c: 00												; DATA ................ 
3e2d: 00												; DATA ................ 
3e2e: 00												; DATA ................ 
3e2f: 00												; DATA ................ 

3e30: 00												; DATA ................  $c6
3e31: 00												; DATA ................ 
3e32: 18												; DATA ......####...... 
3e33: 24												; DATA ....##....##.... 
3e34: 24												; DATA ....##....##.... 
3e35: 18												; DATA ......####...... 
3e36: 2c												; DATA ....##..####.... 
3e37: 76												; DATA ..######..####.. 

3e38: bd												; DATA ##..########..##  $c7
3e39: 81												; DATA ##............## 
3e3a: 00												; DATA ................ 
3e3b: 00												; DATA ................ 
3e3c: 00												; DATA ................ 
3e3d: 00												; DATA ................ 
3e3e: 00												; DATA ................ 
3e3f: 00												; DATA ................ 

3e40: 81												; DATA ##............##  $c8
3e41: bd												; DATA ##..########..## 
3e42: 6e												; DATA ..####..######.. 
3e43: 34												; DATA ....####..##.... 
3e44: 18												; DATA ......####...... 
3e45: 24												; DATA ....##....##.... 
3e46: 24												; DATA ....##....##.... 
3e47: 18												; DATA ......####...... 

3e48: 00												; DATA ................  $c9
3e49: 00												; DATA ................ 
3e4a: 00												; DATA ................ 
3e4b: 00												; DATA ................ 
3e4c: 00												; DATA ................ 
3e4d: 00												; DATA ................ 
3e4e: 00												; DATA ................ 
3e4f: 00												; DATA ................ 

3e50: 00												; DATA ................  $ca
3e51: 00												; DATA ................ 
3e52: 81												; DATA ##............## 
3e53: bd												; DATA ##..########..## 
3e54: 6e												; DATA ..####..######.. 
3e55: 34												; DATA ....####..##.... 
3e56: 18												; DATA ......####...... 
3e57: 24												; DATA ....##....##.... 

3e58: 24												; DATA ....##....##....  $cb
3e59: 18												; DATA ......####...... 
3e5a: 00												; DATA ................ 
3e5b: 00												; DATA ................ 
3e5c: 00												; DATA ................ 
3e5d: 00												; DATA ................ 
3e5e: 00												; DATA ................ 
3e5f: 00												; DATA ................ 

3e60: 00												; DATA ................  $cc
3e61: 00												; DATA ................ 
3e62: 00												; DATA ................ 
3e63: 00												; DATA ................ 
3e64: 81												; DATA ##............## 
3e65: bd												; DATA ##..########..## 
3e66: 6e												; DATA ..####..######.. 
3e67: 34												; DATA ....####..##.... 

3e68: 18												; DATA ......####......  $cd
3e69: 24												; DATA ....##....##.... 
3e6a: 24												; DATA ....##....##.... 
3e6b: 18												; DATA ......####...... 
3e6c: 00												; DATA ................ 
3e6d: 00												; DATA ................ 
3e6e: 00												; DATA ................ 
3e6f: 00												; DATA ................ 

3e70: 00												; DATA ................  $ce
3e71: 00												; DATA ................ 
3e72: 00												; DATA ................ 
3e73: 00												; DATA ................ 
3e74: 00												; DATA ................ 
3e75: 00												; DATA ................ 
3e76: 81												; DATA ##............## 
3e77: bd												; DATA ##..########..## 

3e78: 6e												; DATA ..####..######..  $cf
3e79: 34												; DATA ....####..##.... 
3e7a: 18												; DATA ......####...... 
3e7b: 24												; DATA ....##....##.... 
3e7c: 24												; DATA ....##....##.... 
3e7d: 18												; DATA ......####...... 
3e7e: 00												; DATA ................ 
3e7f: 00												; DATA ................ 

3e80: c0												; DATA ####............  $d0
3e81: 20												; DATA ....##.......... 
3e82: 76												; DATA ..######..####.. 
3e83: 69												; DATA ..####..##....## 
3e84: 59												; DATA ..##..####....## 
3e85: 76												; DATA ..######..####.. 
3e86: 20												; DATA ....##.......... 
3e87: c0												; DATA ####............ 

3e88: 00												; DATA ................  $d1
3e89: 00												; DATA ................ 
3e8a: 00												; DATA ................ 
3e8b: 00												; DATA ................ 
3e8c: 00												; DATA ................ 
3e8d: 00												; DATA ................ 
3e8e: 00												; DATA ................ 
3e8f: 00												; DATA ................ 

3e90: 30												; DATA ....####........  $d2
3e91: 08												; DATA ........##...... 
3e92: 1d												; DATA ......######..## 
3e93: 1a												; DATA ......####..##.. 
3e94: 16												; DATA ......##..####.. 
3e95: 1d												; DATA ......######..## 
3e96: 08												; DATA ........##...... 
3e97: 30												; DATA ....####........ 

3e98: 00												; DATA ................  $d3
3e99: 00												; DATA ................ 
3e9a: 80												; DATA ##.............. 
3e9b: 40												; DATA ..##............ 
3e9c: 40												; DATA ..##............ 
3e9d: 80												; DATA ##.............. 
3e9e: 00												; DATA ................ 
3e9f: 00												; DATA ................ 

3ea0: 0c												; DATA ........####....  $d4
3ea1: 02												; DATA ............##.. 
3ea2: 07												; DATA ..........###### 
3ea3: 06												; DATA ..........####.. 
3ea4: 05												; DATA ..........##..## 
3ea5: 07												; DATA ..........###### 
3ea6: 02												; DATA ............##.. 
3ea7: 0c												; DATA ........####.... 

3ea8: 00												; DATA ................  $d5
3ea9: 00												; DATA ................ 
3eaa: 60												; DATA ..####.......... 
3eab: 90												; DATA ##....##........ 
3eac: 90												; DATA ##....##........ 
3ead: 60												; DATA ..####.......... 
3eae: 00												; DATA ................ 
3eaf: 00												; DATA ................ 

3eb0: 03												; DATA ............####  $d6
3eb1: 00												; DATA ................ 
3eb2: 01												; DATA ..............## 
3eb3: 01												; DATA ..............## 
3eb4: 01												; DATA ..............## 
3eb5: 01												; DATA ..............## 
3eb6: 00												; DATA ................ 
3eb7: 03												; DATA ............#### 

3eb8: 00												; DATA ................  $d7
3eb9: 80												; DATA ##.............. 
3eba: d8												; DATA ####..####...... 
3ebb: a4												; DATA ##..##....##.... 
3ebc: 64												; DATA ..####....##.... 
3ebd: d8												; DATA ####..####...... 
3ebe: 80												; DATA ##.............. 
3ebf: 00												; DATA ................ 

3ec0: 00												; DATA ................  $d8
3ec1: 00												; DATA ................ 
3ec2: 00												; DATA ................ 
3ec3: 00												; DATA ................ 
3ec4: 00												; DATA ................ 
3ec5: 00												; DATA ................ 
3ec6: 00												; DATA ................ 
3ec7: 00												; DATA ................ 

3ec8: 03												; DATA ............####  $d9
3ec9: 04												; DATA ..........##.... 
3eca: 6e												; DATA ..####..######.. 
3ecb: 9a												; DATA ##....####..##.. 
3ecc: 96												; DATA ##....##..####.. 
3ecd: 6e												; DATA ..####..######.. 
3ece: 04												; DATA ..........##.... 
3ecf: 03												; DATA ............#### 

3ed0: 00												; DATA ................  $da
3ed1: 00												; DATA ................ 
3ed2: 01												; DATA ..............## 
3ed3: 02												; DATA ............##.. 
3ed4: 02												; DATA ............##.. 
3ed5: 01												; DATA ..............## 
3ed6: 00												; DATA ................ 
3ed7: 00												; DATA ................ 

3ed8: 0c												; DATA ........####....  $db
3ed9: 10												; DATA ......##........ 
3eda: b8												; DATA ##..######...... 
3edb: 68												; DATA ..####..##...... 
3edc: 58												; DATA ..##..####...... 
3edd: b8												; DATA ##..######...... 
3ede: 10												; DATA ......##........ 
3edf: 0c												; DATA ........####.... 

3ee0: 00												; DATA ................  $dc
3ee1: 00												; DATA ................ 
3ee2: 06												; DATA ..........####.. 
3ee3: 09												; DATA ........##....## 
3ee4: 09												; DATA ........##....## 
3ee5: 06												; DATA ..........####.. 
3ee6: 00												; DATA ................ 
3ee7: 00												; DATA ................ 

3ee8: 30												; DATA ....####........  $dd
3ee9: 40												; DATA ..##............ 
3eea: e0												; DATA ######.......... 
3eeb: a0												; DATA ##..##.......... 
3eec: 60												; DATA ..####.......... 
3eed: e0												; DATA ######.......... 
3eee: 40												; DATA ..##............ 
3eef: 30												; DATA ....####........ 

3ef0: 00												; DATA ................  $de
3ef1: 01												; DATA ..............## 
3ef2: 1b												; DATA ......####..#### 
3ef3: 26												; DATA ....##....####.. 
3ef4: 25												; DATA ....##....##..## 
3ef5: 1b												; DATA ......####..#### 
3ef6: 01												; DATA ..............## 
3ef7: 00												; DATA ................ 

3ef8: c0												; DATA ####............  $df
3ef9: 00												; DATA ................ 
3efa: 80												; DATA ##.............. 
3efb: 80												; DATA ##.............. 
3efc: 80												; DATA ##.............. 
3efd: 80												; DATA ##.............. 
3efe: 00												; DATA ................ 
3eff: c0												; DATA ####............


				;; Copy of $1842-1846
3F00: A9 00    lda #$00
3F02: 85 A4    sta $a4
3F04: 60       rts

				;; Alt IRQ vector?
3F05: 08       php
3F06: 48       pha
3F07: 8A       txa
3F08: 48       pha
3F09: 98       tya
3F0A: 48       pha
				
3F0B: AD 03 51 lda $5103								; IRQ source
3F0E: A8       tay
3F0F: 29 40    and #$40									; Coin 1
3F11: D0 0E    bne $3f21
3F13: EA       nop
3F14: 98       tya
3F15: 29 80    and #$80
3F17: F0 34    beq $3f4d
3F19: EA       nop
				
3F1A: 68       pla
3F1B: A8       tay
3F1C: 68       pla
3F1D: AA       tax
3F1E: 68       pla
3F1F: 28       plp
3F20: 40       rti
				
3F21: A5 A2    lda $a2
3F23: C9 06    cmp #$06
3F25: 90 F3    bcc $3f1a
3F27: A5 14    lda $14
3F29: 48       pha
3F2A: A5 15    lda $15
3F2C: 48       pha
3F2D: A5 10    lda $10
3F2F: 48       pha
3F30: A5 11    lda $11
3F32: 48       pha
3F33: A9 00    lda #$00
3F35: 85 A2    sta $a2
3F37: 20 C5 2B jsr $2bc5
3F3A: 68       pla
3F3B: 85 11    sta $11
3F3D: 68       pla
3F3E: 85 10    sta $10
3F40: 68       pla
3F41: 85 15    sta $15
3F43: 68       pla
3F44: 85 14    sta $14
3F46: 4C 1A 3F jmp $3f1a
3F49: EA       nop
3F4A: 4C 1A 3F jmp $3f1a


				;; VBlank IRQ jumps to here
3F4D: A5 A7    lda $a7
3F4F: 29 20    and #$20
3F51: D0 04    bne $3f57
3F53: EA       nop
				
3F54: 20 59 24 jsr $2459
				
3F57: E6 A2    inc $a2
3F59: 10 05    bpl $3f60
3F5B: EA       nop
				
3F5C: A9 80    lda #$80
3F5E: 85 A2    sta $a2
				
3F60: A5 30    lda $30
3F62: 09 80    ora #$80									; Set D7 
3F64: 85 30    sta $30
				
;3F66: 4C 1A 3F jmp $3f1a								; Change this
3F66: 4C E4 31 jmp $31e4
3F69: A9 50    lda #$50
3F6B: 20 CF 23 jsr $23cf
3F6E: A9 00    lda #$00
3F70: 8D 01 52 sta $5201
3F73: 20 E2 3F jsr $3fe2
3F76: A9 EE    lda #$ee
3F78: 8D 00 51 sta $5100								; Sprite latch
3F7B: A5 1A    lda $1a
3F7D: 29 02    and #$02
3F7F: D0 0B    bne $3f8c
3F81: EA       nop
				
3F82: A5 1C    lda $1c
3F84: 18       clc
3F85: 69 08    adc #$08
3F87: 85 1C    sta $1c
3F89: 4C 93 3F jmp $3f93
				
3F8C: A5 1D    lda $1d
3F8E: 18       clc
3F8F: 69 08    adc #$08
3F91: 85 1D    sta $1d
3F93: A5 1A    lda $1a
3F95: 09 0F    ora #$0f
3F97: 85 1A    sta $1a
3F99: A5 A7    lda $a7
3F9B: 09 20    ora #$20
3F9D: 85 A7    sta $a7
3F9F: A9 F8    lda #$f8
3FA1: 85 0A    sta $0a
3FA3: 8D 00 51 sta $5100								; Sprite latch

				;; Delay
3FA6: A9 30    lda #$30
3FA8: 85 40    sta $40
3FAA: C6 3F    dec $3f
3FAC: D0 FC    bne $3faa
				
3FAE: C6 40    dec $40
3FB0: D0 F8    bne $3faa
				
3FB2: E6 0A    inc $0a
3FB4: A5 0A    lda $0a
3FB6: C9 FA    cmp #$fa
3FB8: B0 03    bcs $3fbd
3FBA: EA       nop
				
3FBB: A5 0A    lda $0a
3FBD: C9 FE    cmp #$fe
3FBF: D0 E2    bne $3fa3
				
3FC1: 20 8C 23 jsr $238c
3FC4: A9 10    lda #$10
3FC6: 20 CF 23 jsr $23cf
3FC9: A5 30    lda $30
3FCB: 09 02    ora #$02
3FCD: 85 30    sta $30
3FCF: A5 1A    lda $1a
3FD1: 09 F0    ora #$f0
3FD3: 85 1A    sta $1a
3FD5: 8D 00 51 sta $5100								; Sprite latch 
3FD8: 20 89 23 jsr $2389
3FDB: A5 A7    lda $a7
3FDD: 29 DF    and #$df
3FDF: 85 A7    sta $a7
3FE1: 60       rts
3FE2: 24 A7    bit $a7
3FE4: 10 06    bpl $3fec
3FE6: EA       nop
				
3FE7: A9 70    lda #$70
3FE9: 8D 00 52 sta $5200
3FEC: 60       rts
				
3FED: 4E 45 0D lsr $0d45
3FF0: 17 50    slo $50, x
3FF2: 20 3B 53 jsr $533b
3FF5: 54 4D    nop $4d, x
3FF7: 4F
				
3FF8: 00 30											; ADDR ???   vector
3FFA: 00 30											; ADDR BRK   vector 
3FFC: 00 30											; ADDR Reset vector 
3FFE: D1 31											; ADDR IRQ		vector
