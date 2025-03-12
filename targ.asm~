				;; Variables from asm
				;; $0008-0009		= PRNG
				
				;; Constants
HSEC		= $1e										; 1/2 second = 30 IRQs

				;; Memory loc
SCRLOCT	= $06										; (2 bytes) Temp store for SCRLOC
PRNG		= $08										; (2 bytes) PRNG
PRNGN		= $0b										; Spare PRNG @ L2655
SCRLOC	= $10										;	(2 bytes) Screen loc to draw string
STRLOC	= $14										; (2 bytes) String source data
DELAY		= $16										; (2 bytes) Delay counter
SPRVAL	= $1a										; Local MOBLAT st
SPR1H		= $1c										; Written to MOB1H during IRQ
SPR1V		= $1d										; Written to MOB1V during IRQ
SPR2H		= $22										; Written to MOB2H during IRQ
SPR2V		= $23										; Written to MOB2V during IRQ

CURIN0	= $34										; Validated control inputs
OLDIN0	= $35										; Last $34 (not really used)
OOLDIN0	= $36										; Last $35 (not really used)
				
HCOIN		= $a0										; Half coins
CREDIT	= $a1										; Credits
VAUD1		= $a3										; AUDIO1 value store
				;; $00a7				= Status?
SCOREH	= $ae										; (2 bytes) High score
				;; $00b0				= shots at special
ARROWS	= $b1
				;; $00b2				= Smart move code?
				;; $00b3				= Flash counter
				;; $00b4-00b5		= Flash screen location
				;; $00b6				= Car base timer
				;; $00b7				= Car "calender"?7
				;; $00b8				= Special object counter
				;; $00b9-00ba		= Flashing image
				;; $00bc				= Type of points to award
SCOREP	= $bd										; (2 bytes) Player score
PNUM		= $bf										; 1=P1, 2=P2
NUMP		= $c0										; # Players
LIVES		= $c1										; LIves left
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

MOB1H		= $5000
MOB1V		= $5040
MOB2H		= $5080
MOB2V		= $50c0
MOBLAT	= $5100

DSW			= $5100													; DIP switches
IN0			= $5101													; Inputs
IN0B		= $5105													; Mirror of above 
AUDIO1	= $5200
AUDIO2	= $5201

				.org		$0000
				.db			$ff

				.org		$1800
L1800:
				jsr			L2f0c								; Copy player data to PX
				jmp			L180f

L1806:
				jsr			L2f0a								; Copy player data to P2
				jmp			L180f

L180c:
				jsr			L2f05								; Copy player data to P1
L180f:
				lda			$28									; ??
				sta			$de, x
				rts

L1814:
				jsr			L2eec								; Copy PX store to player data
				jmp			L1823

L181a:
				jsr			L2eea								; Copy P2 store to player data
				jmp			L1823

L1820:
				jsr			L2ee5								; Copy P1 store to player data
L1823:
				lda			$de, x
				sta			$28									; ??
				rts

L1828:
				jsr			L1832
				jsr			L1847
				jsr			L2371
				rts
L1832:
				dec			$a4
				bmi			L183d
				nop
				lda			#$02
				jsr			L23cf
				rts
L183d:
				lda			#$fd
				jsr			L23ca
				lda			#$00
				sta			$a4
				rts
L1847:
				dec			$a5
				bmi			L184d
				nop
				rts
L184d:
				sec
				lda			#$14
				sbc			$b7
				sta			$a5
				lda			$a6
				and			#$01
				cmp			#$01
				bne			L1875
				nop
				lda			#$00
L185f:
				sta			$a6
				lda			ARROWS
				cmp			#$03
				beq			L187a
				nop
				cmp			#$01
				beq			L187a
				nop
				lda			$a6
				ora			#$02
				sta			AUDIO2
				rts
L1875:
				lda			#$01
				jmp			L185f
L187a:
				lda			$a6
				sta			AUDIO2
				rts

L1880:
				lda			#$3d
				sta			$03

				;; ($10-11) = $4048
L1884:
				lda			#$48
				sta			SCRLOC
				lda			#$40
				sta		SCRLOC+1

				lda			PNUM													; Player #
				lsr			a														;
				tax																	; x = 0 (P1), 2 (P2)
				lda			$dc, x
				tax
				lda			L1fde, x
				tax
				jsr			L18a2
				jsr			L18a0
				jsr			L18a0

L18a0:
				ldx			#$00
L18a2:
				ldy			L1f52, x								; Table
				cpy			#$ff
				beq			L18b2										; Exit loop
				nop

				lda			$03
				sta			($10), y
				inx
				jmp			L18a2										; Loop

L18b2:
				clc
				lda			SCRLOC
				adc			#$05
				sta			SCRLOC
				rts


				;; Draw coinage
L18ba:
				bit			$5100										; DIPs
				bmi			L18c6										; (Quarters) 
				nop

				jsr			L1dcf										; Pence 
				jmp			L18c9

L18c6:
				jsr			L2b7c										; Quarters (Make this freeplay?)
L18c9:
				jsr			L18e2
				jsr			L18f9
				jsr			L2b4f										; Draw DEPOSIT_COIN
				jsr			L2bea										; Draw CREDITS_##
				jsr			L2b37
				jsr			L2408
				jsr			L2a3b										; Draw player scores
				jsr			L23ea
				rts

L18e2:
				ldy			#$05
L18e4:
				lda			L1f3e, y							; HI_SCR
				sta			$402b, y							; Screen loc
				dey
				bpl			L18e4

				lda			SCOREH									; High score lo
				sta			$03
				lda			SCOREH+1									; High score hi
				ldx			#$10
				jsr			L2a60								; Draw 2 byte score from a, $03
				rts


L18f9:
				lda			$a7
				ora			#$10									; Set bit 5
				sta			$a7

				;; Set ($10-11) to $40c2
				lda			#$c2
				sta			SCRLOC
				lda			#$40
				sta		SCRLOC+1

				;; Set ($14-15) to $1e54
				ldy			#$00
				lda			L1f46, y
				sta			STRLOC
				iny
				lda			L1f46, y
				sta			STRLOC+1

				jsr			L22fe								; Draw string

				rts


L1918:
				jsr			L2340								; Clear screen

				;; Set ($10-11) to $420c
				lda			#$0c
				sta			SCRLOC
				lda			#$42
				sta		SCRLOC+1

				;; Set ($14-15) to $27c7 = END_OF_GAME
				ldy			#$00
				lda			L1f44, y
				sta			STRLOC
				iny
				lda			L1f44, y
				sta			STRLOC+1

				jsr			L22fe								; Draw string

				jsr			L2386										; Delay 84 frames  
				jsr			L2386										; Delay 84 frames  
				rts

				;; Decrement credits
L193a:
				lda			CREDIT							; Credits
				bne			L1941
				nop
				sec													; Carry = no credits
				rts

L1941:
				sed													; Decimal mode
				sec													; Clear borrow
				sbc			#$01									;
				sta			CREDIT							; Credits
				cld													; Clear decimal
				jsr			L2bea								; Draw CREDITS_##
				clc													; No carry = credits
				rts


L194d:
				jsr			L1971

				ldx			#$00									; P1 offset
				lda			PNUM									; Current player
				cmp			#$01
				beq			L195b								; Is P1
				nop

				ldx			#$18									; P2 offset
L195b:
				lda			#$00

				jsr			L2a52								; Add a to current player score
				lda			$2f
				sta			ARROWS
				jsr			L2c2b
				dec			$28
				bpl			L1970
				nop
				lda			#$00
				sta			$28
L1970:
				rts
L1971:
				jsr			L197b
				jsr			L2a3b										; Draw player scores
				jsr			L2a7d
				rts

L197b:
				jsr			L2c2b
				lda			#$00
				sta			SPR1V
				sta			$30
				sta			$3e
				sta			$1f
				sta			$31
				sta			$b3
				sta			$b8
				sta			$bc
				lda			#$08
				sta			SPR1H
				lda			#$f3
				sta			SPRVAL
				jsr			L246d										; Update MOBLAT 
				lda			#$01
				sta			$1e
				jsr			L2eaa
				lda			#$06
				sta			$b6
				sta			$b7
				lda			#$03
				sta			$20
				sta			$21
				lda			#$80
				sta			$b9
				jsr			L2340										; Clear screen
				jsr			L2bea										; Draw CREDITS_##
				jsr			L26c8
				lda			#$0a
				sta			$2f
				lda			#$04
				sta			$b0
				rts
L19c4:
				lda			$bc
				bne			L19ca
				nop
				rts
L19ca:
				ldx			PNUM
				beq			L1a0d
				nop
				cpx			#$01
				beq			L19d9
				nop
				ldx			#$18
				jmp			L19db
L19d9:
				ldx			#$00
L19db:
				lda			$bc
				bmi			L19e5
				nop
				lda			$c3
				jmp			L19ef
L19e5:
				lda			#$60
				jsr			L23cf
				inc			$a8
				jsr			L1a12
L19ef:
				jsr			L2a52								; Add a to current player score
				cpx			#$18
				bcs			L19fe
				nop

				ldx			#$18									; Offset +$18
				ldy			#$01									; Player 2
				jmp			L1a02

L19fe:
				ldy			#$00									; Player 1
				ldx			#$00									; Location +00
L1a02:
				lda			$00d0, y							; Score lo
				sta			$03
				lda			$00d2, y							; Score hi
				jsr			L2a60								; Draw 2 byte score from a, $03

L1a0d:
				lda			#$00
				sta			$bc
				rts

L1a12:
				stx			$01
				lda			ARROWS											; # active arrows
				bne			L1a1f
				nop

				lda			$a7
				ora			#$10										; Set bit 5
				sta			$a7

L1a1f:
				lda			#$00
				sta			AUDIO2
				jsr			L23a4										; Kick PRNG
				and			#$03
				tax
				lda			L1fec, x								; Table (01 02 03 05)
				tax
				ldy			#$00
				sta			$00
				lda			($9b), y
				sta			$0041, y
				lda			$00
				ora			#$30
				sta			($9b), y
				iny
				lda			($9b), y
				sta			$0041, y
				iny
				lda			($9b), y
				sta			$0041, y
				dey
				lda			#$30										; '0'
				sta			($9b), y								; Add 0
				iny
				sta			($9b), y								; Add 0
				txa
				asl			a												; x<<1
				asl			a												; x<<2
				asl			a												; x<<3
				asl			a												; x<<4
				sta			$00
				ldx			$01
				jsr			L2389										; Delay 42 frames  
				jsr			L238c										; Delay 21 frames  
				ldy			#$00
				jsr			L1a6e
				jsr			L1a6e
				jsr			L1a6e
				lda			$00
				rts

L1a6e:
				lda			$0041, y
				sta			($9b), y
				iny
				rts

L1a75:
				dec			$b6
				bne			L1ab8
				nop

				lda			#$05
				sta			$b6
				lda			$20
				bpl			L1aa4
				nop

				inc			$b7
				lda			$b7
				cmp			#$0f
				bcc			L1a93
				nop

				lda			#$0e
				sta			$b7
				jmp			L1ab8

L1a93:
				tax
				lda			L1ff0, x
				sta			$00
				lda			$20
				and			#$c0
				ora			$00
				sta			$20
				jmp			L1ab8

L1aa4:
				lda			$20
				and			#$40
				beq			L1ab8
				nop

				dec			$b7
				lda			$b7
				bpl			L1a93

				lda			#$00
				sta			$b7
				jmp			L1a93

L1ab8:
				dec			$21
				bne			L1ad4										; --> $2d9d  
				nop

				jsr			L226a
				ldy			#$00
				lda			($2a), y
				cmp			#$20
				beq			L1ad1										; --> $2d94 
				nop

				cmp			#$21
				beq			L1ad1										; --> $2d94 
				nop

				jmp			L3f69

L1ad1:
				jmp			L2d94

L1ad4:
				jmp			L2d9d



L1ad7:
				lda			#$91
				jsr			L1b02

				;; Short delay
				ldx			$0316
L1adf:
				dex
				nop
				nop
				bne			L1adf										; Loop?
				nop

				lda			#$9e
				jsr			L1b07

				;; Short delay
				ldx			$0316
L1aed:
				dex
				nop
				nop
				bne			L1aed										; Loop?

				dec			$a9
				bne			L1afc										; Loop
				nop

				dec			$aa
				bne			L1ad7										; Loop
				rts

L1afc:
				beq			L1afe										; Does nothing 

L1afe:
				beq			L1b00										; Does nothing 

L1b00:
				bne			L1ad7

L1b02:
				ora			$ab											; 
				bne			L1b09
				nop

L1b07:
				and			$ab

L1b09:
				sta			$ab
				ora			#$90										; Set D7,4 
				and			#$f1										; Clear D3-1 
				sta			AUDIO1
				rts


				;; y = $00 or $12
L1b13:
				lda			L1bd9, y
				sta			$0310
				iny
				lda			#$00
				sta			AUDIO2
L1b1f:
				lda			L1bd9, y
				and			#$e0										; Mask high 3 bits
				lsr			a												; a>>1
				lsr			a												; a>>2
				lsr			a												; a>>3
				lsr			a												; a>>4
				lsr			a												; a>>5
				sta			$ac
L1b2b:
				lda			L1bd9, y
				beq			L1b6b
				nop

				cmp			#$01
				beq			L1b66
				nop

				cmp			#$ff
				beq			L1b91
				nop

				and			#$1f										; Mask low 5 bits
				tax
				lda			L1b97, x
				sta			$0316
				lda			$0310
				beq			L1b51
				nop

				lda			L1bb8, x
				lsr			a
				jmp			L1b54
L1b51:
				lda			L1bb8, x
L1b54:
				lsr			a												; a>>1 
				sta			$a9
				lda			#$01
				sta			$aa
				jsr			L1ad7										; Called once 
				dec			$ac
				bne			L1b2b

				iny
				jmp			L1b1f										; Loop back

L1b66:
				lda			#$30
				jmp			L1b6d
L1b6b:
				lda			#$03
L1b6d:
				sta			$0317
				lda			#$00
				sta			$0312
				sta			$0313
L1b78:
				inc			$0312
L1b7b:
				inc			$0313
				lda			#$80
				cmp			$0313
				bne			L1b7b
				lda			$0312
				cmp			$0317
				bne			L1b78
				iny
				jmp			L1b1f
L1b91:
				lda			#$10
				jsr			L1b02
				rts

				;; Table $20 long
L1b97:
				.db			$F6, $E8, $DC, $CE, $C2, $B9, $AD, $A4	;
				.db			$9B, $91, $89, $81, $7A, $73, $6C, $66	;
				.db			$60, $5B, $55, $50, $4C, $48, $43, $3F	;
				.db			$3C, $38, $34, $31, $2E, $2C, $29, $26	;
				.db			$24																			; ?

				;; Table $20 long -- sound related?
L1bb8:
				.db			$1F, $21, $23, $25, $27, $29, $2C, $2E	;
				.db			$31, $34, $37, $3A, $3E, $42, $46, $4A	;
				.db			$4E, $53, $58, $5D, $63, $69, $6F, $75	;
				.db			$7C, $83, $8B, $94, $9D, $A6, $B0, $BA	;
				.db			$C6																			; ?

L1bd9:
				.db			$FF, $32, $35, $3D, $32, $35, $3D, $32	;
				.db			$35, $3D, $32, $35, $3D, $32, $35, $3D	;
				.db			$FF, $FF, $32, $35, $3D, $FF, $FF, $32	;
				.db			$35, $3D, $32, $35, $3D, $FF						;

				;; Garbage 
				;; Was alt IRQ code?
L1bf7:
				.db			                                   $08		; DATA
				.db			$48, $8a, $48, $98, $48, $ad, $03, $51		; DATA
				.db			$a8, $29, $60, $d0, $0f, $ea, $98, $10		; DATA
				.db			$08, $ea, $68, $a8, $68, $aa, $68, $28		; DATA
				.db			$40, $4c, $4d, $3f, $a5, $a2, $c9, $06		; DATA
				.db			$90, $f0, $98, $48, $a5, $14, $48, $a5		; DATA
				.db			$15, $48, $a5, $10, $48, $a5, $11, $48		; DATA
				.db			$98, $29, $60, $8d, $01, $03, $a9, $00		; DATA
				.db			$85, $a2, $2c, $00, $51, $30, $43, $ea		; DATA
				.db			$98, $29, $20, $d0, $1e, $ea, $ad, $00		; DATA
				.db			$51, $49, $ff, $29, $02, $d0, $11, $ea		; DATA
				.db			$e6, $a0, $a5, $a0, $c9, $02, $90, $3d		; DATA
				.db			$ea, $a9, $00, $85, $a0, $4c, $80, $1c		; DATA
				.db			$4c, $80, $1c, $ad, $00, $51, $49, $ff		; DATA
				.db			$29, $02, $d0, $0a, $ea, $20, $db, $1c		; DATA
				.db			$20, $db, $1c, $4c, $80, $1c, $20, $db		; DATA
				.db			$1c, $20, $db, $1c, $20, $db, $1c, $4c		; DATA
				.db			$65, $1c, $98, $29, $40, $f0, $0e, $ea		; DATA
				.db			$20, $9e, $1c, $24, $a7, $30, $06, $ea		; DATA
				.db			$a0, $12, $20, $13, $1b, $68, $85, $11		; DATA
				.db			$68, $85, $10, $68, $85, $15, $68, $85		; DATA
				.db			$14, $68, $a8, $4c, $0a, $1c, $ad, $03		; DATA
				.db			$51, $29, $60, $d0, $02, $ea, $60, $a9		; DATA
				.db			$ff, $8d, $00, $03, $ad, $03, $51, $29		; DATA
				.db			$60, $4d, $01, $03, $d0, $e8, $ce, $00		; DATA
				.db			$03, $d0, $f1, $ad, $03, $51, $29, $60		; DATA
				.db			$4d, $01, $03, $d0, $f6, $ce, $00, $03		; DATA
				.db			$ad, $03, $51, $29, $60, $4d, $01, $03		; DATA
				.db			$d0, $e9, $ce, $00, $03, $d0, $f1, $20		; DATA
				.db			$db, $1c, $60, $ad, $00, $51, $29, $18		; DATA
				.db			$c9, $10, $d0, $0b, $ea, $e6, $a0, $a5		; DATA
				.db			$a0, $c9, $02, $b0, $02, $ea, $60, $4c		; DATA
				.db			$d7, $2b																	; DATA

				
				.org		$1cf2
L1cf2:
				jsr			L2340										; Clear screen
				jsr			L1d80
				lda			PNUM
				lsr			a
				tax
				sed
				clc
				lda			$dc, x
				cmp			#$09
				bcs			L1d09
				nop
				adc			#$01
				sta			$dc, x
L1d09:
				clc
				adc			SCOREP+1
				sta			SCOREP+1
				lda			$c3
				cmp			#$09
				bcs			L1d19
				nop
				adc			#$01
				sta			$c3
L1d19:
				cld
				jsr			L1880

				;; ($10-11) = $414b
				lda			#$4b
				sta			SCRLOC
				lda			#$41
				sta		SCRLOC+1

				;; ($14-15) = $1e72
				ldy			#$00
				lda			L1f48, y
				sta			STRLOC
				iny
				lda			L1f48, y
				sta			STRLOC+1

				jsr			L22fe								; Draw string

				;; ($14-15) = $2f9b
				ldy			#$00
				lda			L2ff2, y
				sta			STRLOC
				iny
				lda			L2ff2, y
				sta			STRLOC+1

				;; ($10-11) = $420e
				lda			#$0e
				sta			SCRLOC
				lda			#$42
				sta		SCRLOC+1

				jsr			L22fe								; Draw string

				jsr			L23ea
				lda			$c3
				ora			#$30
				sta			$426d
				lda			#$10
				sta			AUDIO1
				ldy			#$00
				jsr			L1b13
				jsr			L1d8e
				ldx			#$2f
L1d66:
				jsr			L1d6d
				dex
				bpl			L1d66
				rts
L1d6d:
				dec			$16
				bne			L1d6d
				ldy			#$07
L1d73:
				jsr			L23a4								; Kick PRNG
				sta			$49e8, y
				sta			$4df0, y
				dey
				bpl			L1d73
				rts
L1d80:
				lda			#$ff
				ldy			#$07
L1d84:
				sta			$49e8, y
				sta			$4df0, y
				dey
				bpl			L1d84
				rts
L1d8e:
				lda			#$09
				sta			$3f
				lda			#$12
				sta			$b7
L1d96:
				jsr			L1da0
				dec			$b7
				dec			$3f
				bne			L1d96
				rts
L1da0:
				lda			$03
				cmp			#$be
				beq			L1dc8
				nop
				lda			#$be
				sta			$03
				jsr			L1884

				;; Delay ~3 frames
L1dae:
				lda			#$12
				sta			$17
L1db2:
				dec			$16
				bne			L1db2										; Inner loop 
				lda			$17
				and			#$03										; Mask LSBs 
				sta			ARROWS
				lda			$17
				and			#$06
				bne			L1dc3
				nop
L1dc3:
				dec			$17
				bne			L1db2										; Outer loop 
				rts


L1dc8:
				jsr			L1880
				jsr			L1dae										; Delay 3 frames 
				rts

				;; Set up pence coinage
L1dcf:
				lda			$5100										; DIPs
				ldy			#$00
				eor			#$ff										; Invert
				and			#$02										; Mask coinage
				bne			L1de9
				nop

				;; ($14-15) = $1f09
				lda			L1f50, y
				sta			STRLOC
				iny
				lda			L1f50, y
				sta			STRLOC+1								; 1G = 20P
				jmp			L1df4

				;; ($14-15) = $1ed4
L1de9:
				lda			L1f4e, y
				sta			STRLOC
				iny
				lda			L1f4e, y
				sta			STRLOC+1								; 1G = 10P

				;; ($10-11) = $4164
L1df4:
				lda			#$64
				sta			SCRLOC
				lda			#$41
				sta			SCRLOC+1

				jsr			L22fe										; Draw string

				iny
				lda			#$69
				sta			SCRLOC									; ($4169) 
				jsr			L2300										; Draw next string
				rts


L1e08:
				lda			SCOREP+1
				cmp			SCOREH+1
				beq			L1e13
				nop
				bcs			L1e1b
				nop
				rts
L1e13:
				lda			SCOREP
				cmp			SCOREH
				bcs			L1e1b
				nop
				rts


L1e1b:
				lda			SCOREP
				sta			SCOREH
				lda			SCOREP+1
				sta			SCOREH+1
				lda			$a7
				and			#$fc										; Clear bits 1-0 
				sta			$a7
				lda			PNUM
				and			#$03										; Mask bits 1-0 
				ora			$a7
				sta			$a7
				rts


L1e32:
				lda			#$01
				sta			$29
				sta			$28
				lda			#$0b
				sta			$2f
				lda			#$0a
				sta			ARROWS
				jsr			L197b
				jsr			L2a3b								; Draw player scores
				jsr			L18e2
				lda			#$02
				sta			$20
				sta			$21
				lda			#$00
				sta			$a7
				rts

L1e54:
				.db			"TOP HIGH SCORE FOR EXTRA PLAY", $00

L1e72:
				.db			"EXTRA POINTS",$00

L1e7f:
				.db			"EXTENDED PLAY FOR PLAYER   ", $00

L1e9b:
				.db			"TOPPING HIGH SCORE ", $00

L1eaf:
				.db			"EXTRA CREDIT ", $00

L1ebd:
				.db			"FOR TOPPING HIGH SCORE", $00

L1ed4:
				.db			"1 GAME  ONE 10 PENCE COIN ", $00

L1eef:
				.db			"6 GAMES ONE 50 PENCE COIN", $00

L1f09:
				.db			"1 GAME  TWO 10 PENCE COINS", $00

L1f24:
				.db			"3 GAMES ONE 50 PENCE COIN", $00

L1f3e:
				.db			"HI SCR"

				;; Text pointers Could be hard coded
L1f44:
				.dw			$27C7										; $27c7 = END_OF_GAME
L1f46:
				.dw			$1E54										; $1e54 = TOP_HIGH_SCORE...
L1f48:
				.dw			$1E72										; $1e72 = EXTRA_POINTS
L1f4a:
				.dw			$1E7F										; $1e7f = EXTENDED_PLAY...
L1f4c:
				.dw			$1EAF										; $1eaf = EXTRA_CREDIT_

				;; Coinage table pointers
L1f4e:
				.dw			$1ED4										; $1ed4 = 1G_10P
L1f50:
				.dw			$1F09										; $1f09 = 1G_2x20P

				;; Table ($FF terminated)
L1f52:
				.db			$01, $02, $20, $23, $40, $43, $60, $63	;
				.db			$80, $83, $A1, $A2, $FF									;

				.db			$00, $01, $21, $41, $61, $81, $A0, $A1	;
				.db			$A2, $FF																;

				.db			$00, $01, $02, $20, $22, $42, $60, $61	;
				.db			$62, $80, $A0, $A1, $A2, $FF						;

				.db			$00, $01, $02, $22, $41, $42, $62, $82	;
				.db			$A0, $A1, $A2, $FF											;
				
				.db			$02, $20, $22, $40, $42, $60, $61, $62	;
				.db			$63, $82, $A1, $A2, $A3, $FF						;

				.db			$00, $01, $02, $20, $40, $41, $42, $43	;
				.db			$63, $83, $A0, $A1, $A2, $A3, $FF				;
				
				.db			$00, $01, $02, $20, $40, $60, $61, $62	;
				.db			$63, $80, $83, $A0, $A1, $A2, $A3, $FF	;

				.db			$00, $01, $02, $03, $23, $42, $43, $61	;
				.db			$62, $81, $A1, $FF											;

				.db			$01, $02, $03, $21, $23, $40, $41, $42	;
				.db			$43, $60, $63, $80, $83, $A0, $A1, $A2	;
				.db			$A3, $FF																;
				
				.db			$00, $01, $02, $03, $20, $23, $40, $41	;
				.db			$42, $43, $63, $83, $A1, $A2, $A3, $FF	;
				
			
L1fde:
				.db			$00, $0d								;
				.db			$17, $25
				.db			$31, $3f
				.db			$4e, $5e
				.db			$6a, $7c

L1fe8:
				.db			$20, $40, $04, $08		; (4 entries)
L1fec:
				.db			$01, $02, $03, $05		; (4 entries)

				;; Table
L1ff0:
				.db			$0a, $09, $08, $06
				.db			$05, $04, $04, $03
				.db			$03, $03, $02, $02
				.db			$02, $02, $02, $02

				;; Check fire button
L2000:
				lda			IN0B										; Control inputs
				cmp			#$ff
				bne			L200d										; Something pressed
				nop

				lda			#$00										; No controls
				sta			CURIN0										; IN0 store
				rts

				;; Validate inputs
L200d:
				sta			CURIN0									; IN0 store
				ldx			#$04										; Loop counter
L2011:
				lda			IN0B										; Control inputs
				ora			CURIN0									; IN0 store
				sta			CURIN0									; IN0 store
				dex
				bne			L2011										; Loop

				eor			#$ff
				sta			CURIN0									; IN0 store

				and			#$10										; Button
				beq			L202e										; Button pressed 
				nop

				lda			OLDIN0									; Old IN0 store
				sta			OOLDIN0									; Old Old IN0 store
				lda			CURIN0									; IN0 Store
				and			#$ef										; Clear Button
				sta			OLDIN0									; Old IN0 store
L202e:
				rts


L202f:
				lda			$30
				and			#$60
				bne			L203b
				nop
				lda			#$16
				sta			$38
				rts
L203b:
				dec			$38
				bmi			L2041
				nop

				rts

L2041:
				lda			$30
				and			#$20
				bne			L2054
				nop

				lda			$3a
				jsr			L2093
				lda			$30
				and			#$bf
				sta			$30
				rts

L2054:
				jsr			L23a4								; Kick PRNG
				and			#$01
				tax
				lda			SPR1H
				beq			L2070
				nop

				lda			SPR1V
				beq			L206a
				nop

				lda			L27ad, x
				jmp			L207e

L206a:
				lda			L27ab, x
				jmp			L207e

L2070:
				lda			SPR1V
				beq			L207b
				nop
				lda			L27af, x
				jmp			L207e

L207b:
				lda			L27b1, x
L207e:
				jsr			L2093
				lda			$30
				and			#$9f
				sta			$30
				rts

L2088:
				lda			CURIN0
				and			#$ef										; Clear d4 
				bne			L2093 
				nop

				jsr			L2225										; (if 0) 
				rts

L2093:
				cmp			#$20
				beq			L20ea
				nop

				cmp			#$40
				beq			L2113
				nop

				cmp			#$04
				bne			L20a5
				nop

				jmp			L213e

L20a5:
				cmp			#$08
				bne			L20ad
				nop

				jmp			L2169
L20ad:
				rts

L20ae:
				lda			$31
				beq			L20b4
				nop

				rts

L20b4:
				lda			CURIN0
				and			#$10
				bne			L20bc
				nop

				rts

L20bc:
				lda			#$0c
				sta			$a4
				lda			#$01
				sta			$31
				lda			#$02
				sta			$26
				sta			$27
				lda			SPRVAL
				asl			a
				asl			a
				asl			a
				asl			a
				ora			#$40
				sta			$00
				lda			SPRVAL
				and			#$0f										; Clear MOB1 
				ora			$00
				sta			SPRVAL

				;; Copy SPR1 pos to SPR2
				lda			SPR1H
				sta			SPR2H
				lda			SPR1V
				sta			SPR2V
				jsr			L21d9
				jmp			L246d										; Update MOBLAT (and rts)


L20ea:
				lda			$1f
				beq			L2101
				nop
				bmi			L20f5
				nop
				jmp			L21f4
L20f5:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L2108
				nop
				jmp			L220a
L2101:
				jsr			L21a1
				bcs			L2108
				nop
				rts
L2108:
				lda			#$01
				sta			$1f
				lda			#$00
				sta			$1e
				jmp			L2191
L2113:
				lda			$1f
				beq			L212a
				nop
				bpl			L211e
				nop
				jmp			L21f4
L211e:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L2131
				nop
				jmp			L220a
L212a:
				jsr			L21a1
				bcs			L2131
				nop
				rts
L2131:
				lda			#$fe
				sta			$1f
				lda			#$00
				sta			$1e
				lda			#$01
				jmp			L2191
L213e:
				lda			$1e
				beq			L2155
				nop
				bpl			L2149
				nop
				jmp			L21f4
L2149:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L215c
				nop
				jmp			L220a
L2155:
				jsr			L21a9
				bcs			L215c
				nop
				rts
L215c:
				lda			#$fe
				sta			$1e
				lda			#$00
				sta			$1f
				lda			#$02
				jmp			L2191
L2169:
				lda			$1e
				beq			L2180
				nop
				bmi			L2174
				nop
				jmp			L21f4
L2174:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L2187
				nop
				jmp			L220a
L2180:
				jsr			L21a9
				bcs			L2187
				nop
				rts
L2187:
				lda			#$01
				sta			$1e
				lda			#$00
				sta			$1f
				lda			#$03
L2191:
				pha
				lda			SPRVAL
				and			#$f0
				sta			SPRVAL
				pla
				ora			SPRVAL
				sta			SPRVAL
				jsr			L246d										; Update MOBLAT 
				rts
L21a1:
				lda			SPR1H
				beq			L21c7
				nop
				jmp			L21ae
L21a9:
				lda			SPR1V
				beq			L21c7
				nop
L21ae:
				sta			$01
				ldx			#$0a
				lda			#$00
				sta			$00
L21b6:
				cmp			$01
				beq			L21c7
				nop
				lda			#$18
				clc
				adc			$00
				sta			$00
				dex
				bne			L21b6
				clc
				rts
L21c7:
				lda			$39
				sta			$3a
				lda			CURIN0
				and			#$ef
				sta			$39
				lda			$30
				and			#$bf
				sta			$30
				sec
				rts
L21d9:
				lda			$1e
				jsr			L21e8
				sta			$24
				lda			$1f
				jsr			L21e8
				sta			$25
				rts
L21e8:
				beq			L21f0
				nop
				bmi			L21f1
				nop
				lda			#$02
L21f0:
				rts
L21f1:
				lda			#$fd
				rts
L21f4:
				lda			$20
				bpl			L21fa
				nop
				rts
L21fa:
				lda			$36
				cmp			$35
				bne			L2209
				nop
				lda			$20
				and			#$bf
				ora			#$80
				sta			$20
L2209:
				rts
L220a:
				lda			$20
				and			#$40
				beq			L2212
				nop
				rts
L2212:
				lda			$36
				cmp			$35
				bne			L2209
				lda			$20
				and			#$7f
				ora			#$40
				sta			$20
				lda			$3c
				sta			$2e
				rts
L2225:
				lda			$20
				and			#$3f
				sta			$20
				rts
L222c:
				jsr			L226a
L222f:
				lda			SCRLOC
				and			#$1f
				sta			$00
				lda			$2a
				and			#$1f
				sec
				sbc			$00
				sta			$2d
				lda		SCRLOC+1
				sta			$19
				lda			SCRLOC
				sta			$18
				jsr			L225c
				sta			$00
				lda			$2b
				sta			$19
				lda			$2a
				sta			$18
				jsr			L225c
				sec
				sbc			$00
				sta			$2c
				rts
L225c:
				ldx			#$05
L225e:
				ror			$19
				ror			$18
				dex
				bne			L225e
				lda			$18
				and			#$1f
				rts
L226a:
				lda			SPR1V
				sta			$18
				lda			SPR1H
				sta			$19
				jmp			L227d
L2275:
				lda			SPR2V
				sta			$18
				lda			SPR2H
				sta			$19
L227d:
				lda			#$00
				sta			$2b
				lda			$18
				eor			#$ff
				lsr			a
				lsr			a
				lsr			a
				clc
				adc			#$01
				sbc			#$04
				sta			$2a
				clc
				adc			$2a
				sta			$2a
				ldx			#$04
L2296:
				asl			$2a
				rol			$2b
				dex
				bne			L2296
				lda			$2a
				adc			#$60
				sta			$2a
				lda			$2b
				adc			#$40
				sta			$2b
				lda			$19
				eor			#$ff
				lsr			a
				lsr			a
				lsr			a
				clc
				adc			#$01
				sec
				sbc			#$03
				clc
				adc			$2a
				sta			$2a
				rts

				;; Write character RAM
L22bc:
				lda			#$00
				sta			STRLOC
				lda			#$48
				sta			STRLOC+1

				;; Set ($18-19) to $3800 (char data source)
				ldy			#$00
				lda			L27fc, y
				sta			$18
				iny
				lda			L27fc, y
				sta			$19
				ldx			#$08										; 8 pages 
				jsr			L22e9										; Copy x pages (only called here)
				rts
				
L22d7:
				jsr			L22e0
				inc			$19
				dex
				bne			L22d7
				rts
L22e0:
				ldy			#$00
				tya
L22e3:
				sta			($18), y
				iny
				bne			L22e3
				rts

				;; Copy x pages from ($18-19) to ($14-15)
L22e9:
				jsr			L22f4
				inc			STRLOC+1								; $15 
				inc			$19
				dex
				bne			L22e9										; Loop
				rts

				;; Copy $0100 bytes from ($18-19) to ($14-15)
L22f4:
				ldy			#$00
L22f6:
				lda			($18), y
				sta			($14), y
				iny
				bne			L22f6										; Loop
				rts

				;; Draw string from ($14-15) at ($10-11)
L22fe:
				ldy			#$00
L2300:
				lda			($14), y								; Get char
				bne			L2306										; 0 terminated
				nop

				rts															; Exit 

L2306:
				sta			($10), y								; Store char
				iny
				jmp			L2300										; Loop


				;; Add 3 lines to SCRLOC
L230c:
				lda			#$60
				jmp			L2318

				;; Add 2 lines to SCRLOC
L2311:
				lda			#$40
				jmp			L2318

				;; Add 1 line  to SCRLOC
L2316:
				lda			#$20

L2318:
				clc
				adc			SCRLOC
				sta			SCRLOC
				lda			SCRLOC+1
				adc			#$00
				sta			SCRLOC+1
				rts

				;; Back 3 lines
L2324:
				lda			#$60
				jmp			L2330										; SCRLOC =- a

				;; Back 2 lines
L2329:
				lda			#$40
				jmp			L2330										; SCRLOC =- a 


				;; SCRLOC -= #$20
L232e:
				lda			#$20

				;; SCRLOC -= a
L2330:
				sta			$00
				sec
				lda			SCRLOC
				sbc			$00
				sta			SCRLOC
				lda			SCRLOC+1
				sbc			#$00
				sta			SCRLOC+1
				rts


				;; Clear screen
L2340:
				jsr			L2359										; ($10-11) = $4000

				tay															; y=a=0
				ldx			#$04										; Loop counter
L2346:
				jsr			L2351										; Clear y chars at ($10-11)

				inc		SCRLOC+1
				dex
				bne			L2346										; Loop
				rts

				;; Clear $20 chars at ($10-11)
				ldy			#$20

				;; Clear y chars at ($10-11)
L2351:
				lda			#$20										; (space char)
L2353:
				dey
				sta			($10), y
				bne			L2353										; Loop
				rts

				;; ($10-11) = $4000
L2359:
				lda			#$40
				bne			L236a
				nop

				;; ($10-11) = $4100
				lda			#$41
				bne			L236a
				nop

				;; ($10-11) = $4200
				lda			#$42
				bne			L236a
				nop

				;; ($10-11) = $4300
L2368:
				lda			#$43
L236a:
				sta		SCRLOC+1
				lda			#$00
				sta			SCRLOC
				rts


L2371:
				lda			ARROWS
				cmp			$a8
				bne			L237e
				nop
				lda			#$9f
				jsr			L23ca
				rts
L237e:
				sta			$a8
				lda			#$60
				jsr			L23cf
				rts

				
				;; Delay ~84 frames
L2386:
				jsr			L2389										; Delay 42 frames  
				
				;; Delay ~42 frames
L2389:
				jsr			L238c										; Delay 21 frames  

				;; Delay ~21 frames
L238c:
				jsr			L238f										; Delay ~10 frames

				;; Delay ~10 frames
L238f:
				lda			#$00
				sta			$16
				sta			$17
L2395:
				inc			$16
L2397:
				inc			$17
				lda			#$26
				cmp			$17
				bne			L2397										; Inner loop 
				cmp			$16
				bne			L2395										; Outer loop 
				rts


				;; Kick PRNG
L23a4:
				tya
				pha															; Push y

				ldy			#$23
L23a8:
				lda			PRNG+1
				beq			L23bd										; ==0
				nop

				and			#$60
				cmp			#$20
				beq			L23bd										; == 20/60/a0/e0
				nop

				cmp			#$40
				beq			L23bd										; == 40/c0
				nop

				clc															; Clear carry
				bcc			L23be										; (Always)
				nop

L23bd:
				sec															; Set carry
L23be:
				rol			PRNG
				rol			PRNG+1
				dey
				bne			L23a8
				pla
				tay
				lda			PRNG
				rts


				;; Clear AUDIO1 bits
L23ca:
				and			VAUD1
				jmp			L23d1

				;; Set AUDIO1 bits
L23cf:
				ora			VAUD1
L23d1:
				sta			VAUD1
				sta			AUDIO1
				rts


L23d7:
				lda			$5100										; DIPs
				eor			#$ff										; Invert 
				and			#$60										; Mask lives
				lsr			a
				lsr			a
				lsr			a
				lsr			a
				lsr			a
				tax
				lda			L27c3, x								; Lives table 
				sta			LIVES
				rts


L23ea:
				lda			#$01
				sta			$426b

				;; ($10-11) = $426d
				lda			#$6d
				sta			SCRLOC
				lda			#$42
				sta		SCRLOC+1

				;; ($14-15) = $27ec
				ldy			#$00
				lda			L27fa, y
				sta			STRLOC
				iny
				lda			L27fa, y
				sta			STRLOC+1

				jsr			L22fe								; Draw string
				rts

				;; ($10-11) = $42ef
L2408:
				lda			#$ef
				sta			SCRLOC
				lda			#$42
				sta			SCRLOC+1

				;; ($14-15) = $27de
				ldy			#$00
				lda			L27f6, y
				sta			STRLOC
				iny
				lda			L27f6, y
				sta			STRLOC+1

				jsr			L22fe								; Draw string
				rts

L2421:
				ldy			#$00
				lda			#$10
				sta			AUDIO1
				lda			#$ee
				sta			MOBLAT							; Sprite latch

				;; ($10-11) = $420d
				lda			#$0d
				sta			SCRLOC
				lda			#$42
				sta		SCRLOC+1

				;; ($14-15) = $27d8
				lda			L27f8, y
				sta			STRLOC
				iny
				lda			L27f8, y
				sta			STRLOC+1
				jsr			L22fe								; Draw string

				;; ($10-11) = $430d
				lda			#$43
				sta			SCRLOC
				iny
				jsr			L2300								; Draw next string

				lda			PNUM
				ora			#$30
				sta			$4255
				jsr			L2386										; Delay 84 frames  
				jsr			L2386										; Delay 84 frames  
				rts


				;; Update sprite locations
L2459:
				lda			SPR1H
				sta			MOB1H
				lda			SPR1V
				sta			MOB1V
				lda			SPR2H
				sta			MOB2H
				lda			SPR2V
				sta			MOB2V
L246d:
				lda			SPRVAL
				sta			MOBLAT							; Sprite latch
				rts


L2473:
				lda			$1e
				beq			L249b
				nop
				clc
				adc			SPR1H
				adc			#$00
				jsr			L24ce
				sta			SPR1H
				bcs			L2486
				nop
				rts
L2486:
				lda			$30
				and			#$40
				bne			L2494
				nop
				lda			$30
				ora			#$40
				sta			$30
				rts
L2494:
				lda			$30
				ora			#$20
				sta			$30
				rts
L249b:
				lda			$1f
				bne			L24a1
				nop
				rts
L24a1:
				clc
				adc			SPR1V
				adc			#$00
				jsr			L24ce
				sta			SPR1V
				bcs			L2486
				rts
L24ae:
				lda			$24
				beq			L24bd
				nop
				clc
				adc			SPR2H
				adc			#$00
				jsr			L24df
				sta			SPR2H
L24bd:
				lda			$25
				bne			L24c3
				nop
				rts
L24c3:
				clc
				adc			SPR2V
				adc			#$00
				jsr			L24df
				sta			SPR2V
				rts
L24ce:
				cmp			#$fc
				bcs			L24d9
				nop
				cmp			#$d8
				bcs			L24dc
				nop
				rts
L24d9:
				lda			#$00
				rts
L24dc:
				lda			#$d8
				rts
L24df:
				cmp			#$fc
				bcs			L24ea
				nop
				cmp			#$da
				bcs			L24ea
				nop
				rts
L24ea:
				sta			$00
				lda			SPRVAL
				ora			#$f0
				sta			SPRVAL
				lda			#$00
				sta			$31
				lda			$00
				rts
L24f9:
				lda			$0c
				and			#$18
				eor			#$08
				sta			$0c
				rts


				;; Store SCRLOC to temp
L2502:
				lda			SCRLOC
				sta			SCRLOCT
				lda			SCRLOC+1
				sta			SCRLOCT+1
				rts


				;; Restore SCRLOC from temp
L250b:
				lda			SCRLOCT
				sta			SCRLOC
				lda			SCRLOCT+1
				sta			SCRLOC+1
				rts


L2514:
				jsr			L2502										; Store SCRLOC to temp
				lda			$0c
				and			#$18
				tax
				cmp			#$08
				beq			L2529
				nop
				cmp			#$10
				beq			L2531
				nop
				jsr			L2324										; Back 3 lines
L2529:
				lda			#$03
				jsr			L2330										; SCRLOC =- a 
				jmp			L2534


L2531:
				jsr			L2324										; Back 3 lines
L2534:
				txa
				asl			a
				tax
				lda			#$00
				sta			$00
L253b:
				ldy			L2757, x
				beq			L2554
				nop
				lda			($10), y
				stx			$01
				ldx			$00
				and			#$7f
				sta			$41, x
				inx
				stx			$00
				ldx			$01
				inx
				jmp			L253b


L2554:
				jsr			L250b										; Restore SCRLOC from temp
				rts


L2558:
				lda			$41
				cmp			#$60
				bcs			L2560
				nop
				rts
L2560:
				lda			$4b
				cmp			#$60
				bcs			L2579
				nop
				lda			$4a
				cmp			#$60
				bcs			L256f
				nop
				rts
L256f:
				cmp			#$20
				bcc			L258c
				nop
				lda			#$04
				jmp			L2580
L2579:
				cmp			#$20
				bcc			L258c
				nop
				lda			#$02
L2580:
				ora			$05
				sta			$05
				rts
L2585:
				lda			$41
				cmp			#$20
				beq			L2593
				nop
L258c:
				lda			$05
				ora			#$01
				sta			$05
				rts
L2593:
				lda			$05
				ora			#$80
				sta			$05
				rts
L259a:
				lda			$4a
				cmp			#$20
				bne			L25a7
				nop
				lda			$05
				ora			#$10
				sta			$05
L25a7:
				lda			$4b
				cmp			#$20
				bne			L25b4
				nop
				lda			$05
				ora			#$08
				sta			$05
L25b4:
				rts
				lda			$4a
				cmp			#$20
				bcc			L25e0
				nop
				lda			$4b
				cmp			#$20
				bcc			L25e0
				nop
				lda			$4c
				cmp			#$20
				bcc			L25e0
				nop
				lda			$4d
				cmp			#$20
				bcc			L25e0
				nop
				lda			$45
				cmp			#$20
				bcc			L25e0
				nop
				lda			$49
				cmp			#$20
				bcc			L25e0
				nop
				rts
L25e0:
				lda			$05
				ora			#$40
				sta			$05
				rts
				lda			$41
				cmp			#$20
				bne			L25ef
				nop
				rts
L25ef:
				lda			$43
				cmp			#$20
				bne			L25fe
				nop
				lda			$47
				cmp			#$20
				bne			L25fe
				nop
				rts
L25fe:
				lda			$05
				ora			#$20
				sta			$05
				rts
L2605:
				jsr			L2664
				ldx			$3d
				lda			L2797, x
				sta			$0c
				ldy			L279f, x
				jsr			L269e
				lda			L27a7, x
				jsr			L2318
				lda			$3d
				cmp			#$03
				beq			L2623
				nop

				rts

L2623:
				jsr			L232e										; Could be jmp 
				rts


L2627:
				jsr			L2664
				ldx			$3d
				lda			L279b, x
				sta			$0c
				ldy			L27a3, x
				jsr			L269e
				lda			$3d
				cmp			#$03
				beq			L2654
				nop
				cmp			#$01
				beq			L264b
				nop

				cmp			#$02
				beq			L264f
				nop

				dec			SCRLOC									; Back 1 char 
				rts

L264b:
				jsr			L2316										; Add 1 line 
				rts

L264f:
				inc			SCRLOC									; Add 1 char 
				jsr			L232e
L2654:
				rts


				;; Get new PRNG every 4th call
L2655:
				dec			$0b
				bmi			L265c
				nop

				clc															; Clr = no new PRNG 
				rts

L265c:
				jsr			L2664
				jsr			L23a4										; Kick PRNG
				sec															; Set = new PRNG 
				rts

L2664:
				lda			#$04
				sta			$0b
				rts


L2669:
				lda			$0c
				and			#$18										; Mask D4,3 
				sta			$0c
				beq			L268d
				nop

				cmp			#$08										; Check D3 
				beq			L2684
				nop

				cmp			#$10										; Check D4 
				beq			L2696
				nop

				ldy			#$01										; == $18 
				jsr			L269e
				dec			SCRLOC
				rts


				;; == $08
L2684:
				ldy			#$00
				jsr			L269e
				jsr			L2316										; Add 1 line
				rts


				;; == $00
L268d:
				ldy			#$20
				jsr			L269e
				jsr			L232e
				rts


				;; == $10
L2696:
				ldy			#$00
				jsr			L269e
				inc			SCRLOC
				rts


				;; == $18
L269e:
				lda			#$20
				sta			($10), y
				rts


L26a3:
				lda			$0c
				and			#$1f
				ldy			#$00
				sta			($10), y
				inc			$0c
				lda			$0c
				and			#$1f
				ldy			$04
L26b3:
				sta			($10), y
				lda			$0c
				and			#$07
				cmp			#$07
				beq			L26c1
				nop
				inc			$0c
				rts
L26c1:
				lda			$0c
				ora			#$40
				sta			$0c
				rts
L26c8:
				jsr			L2700
				jsr			L2359								; ($10-11) = $4000
				lda			#$80
				sta			SCRLOC
				ldx			#$09
L26d4:
				lda			#$ba
				jsr			L26e8
				jsr			L2316
				lda			#$bc
				jsr			L26e8
				jsr			L2311										 ; Add 2 lines 
				dex
				bne			L26d4
				rts

L26e8:
				ldy			#$03
				sta			$03
				sta			$04
				inc			$04
L26f0:
				lda			$03
				sta			($10), y
				iny
				lda			$04
				sta			($10), y
				iny
				iny
				cpy			#$1d
				bcc			L26f0
				rts
L2700:
				jsr			L2359								; ($10-11) = $4000
				lda			#$42
				sta			SCRLOC
				lda			#$60
				jsr			L273d
				jsr			L2368								; ($10-11) = $4300
				lda			#$e2
				sta			SCRLOC
				lda			#$61
				jsr			L273d
				jsr			L2359								; ($10-11) = $4000
				lda			#$60
				sta			SCRLOC
				lda			#$63
				jsr			L2743
				jsr			L2359								; ($10-11) = $4000
				lda			#$61
				sta			SCRLOC
				lda			#$62
				jsr			L2748
				jsr			L2359								; ($10-11) = $4000
				lda			#$61
				sta			SCRLOC
				lda			#$62
				jsr			L2743
				rts
L273d:
				ldy			#$1c
				jsr			L2353
				rts
L2743:
				ldy			#$1e
				jmp			L274a
L2748:
				ldy			#$00
L274a:
				ldx			#$1c
L274c:
				sta			($10), y
				pha
				jsr			L2316
				pla
				dex
				bne			L274c
				rts

				;; Table
L2757:
				.db			$43, $42								;
				.db			$23, $44								;
				.db			$41, $22								;
				.db			$03, $24								;
				.db			$45, $62								;
				.db			$64, $61								;
				.db			$65, $60								;
				.db			$66, $00								;
				.db			$43, $44								;
				.db			$63, $42								;
				.db			$45, $64								;
				.db			$83, $62								;
				.db			$41, $24								;
				.db			$22, $25								;
				.db			$21, $26								;
				.db			$20, $00								;
				.db			$62, $42								;
				.db			$63, $82								;
				.db			$22, $43								;
				.db			$64, $83								;
				.db			$A2, $41								;
				.db			$81, $21								;
				.db			$A1, $01								;
				.db			$61, $00								;
				.db			$62, $82								;
				.db			$61, $42								;
				.db			$A2, $81								;
				.db			$60, $41								;
				.db			$22, $83								;
				.db			$43, $A3								;
				.db			$23, $C3								;
				.db			$03, $00								;

L2797:
				.db			$10, $18, $08, $00			;
L279b:
				.db			$18, $10, $00, $08			;
L279f:
				.db			$20, $00, $00, $01			;
L27a3:
				.db			$20, $00, $00, $01			;
L27a7:
				.db			$00, $1F, $01, $00			;
L27ab:
				.db			$04, $20								;
L27ad:
				.db			$40, $04								;
L27af:
				.db			$08, $40								;
L27b1:
				.db			$20, $08								;
L27b3:
				.db			$00, $02, $01, $80			;
L27b7:
				.db			$02, $00, $80, $01			;
L27bb:
				.db			$01, $80, $02, $00			;
L27bf:
				.db			$80, $01, $00, $02			;
				
L27c3:
				.db			$02, $03, $04, $05							; Lives table				

L27c7:
				.db			"END OF GAME", $00

L27d3:
				.db			"TARG", $00

L27d8:
				.db			"GET READY", $00

L27e2:
				.db			"PLAYER   ", $00

L27ec:
				.db			"10 POINTS", $00

L27f6:
				.dw			L27d3														; Pointer to "GET READY"
L27f8:
				.dw			L27d8														; Pointer to "PLAYER   "
L27fa:
				.dw			L27ec														; Pointer to "10 POINTS"

L27fc:
				.dw			$3800														;  (Char data source)
				.dw			$2020														;

L2800:
				lda			$3e
				bpl			L280b
				nop

				jsr			L29f3
				jmp			L2820

L280b:
				lda			ARROWS
				cmp			#$03
				bcc			L2820
				nop
				dec			$0e
				beq			L281c
				nop
				lda			#$ff
				sta			$b2
				rts
L281c:
				lda			ARROWS
				sta			$0e
L2820:
				ldx			$3d
				lda			$2d
				bpl			L2829
				nop
				eor			#$ff
L2829:
				sta			$00
				lda			$2c
				bpl			L2832
				nop
L2830:
				eor			#$ff
L2832:
				cmp			$00
				bcs			L2848
				nop
				lda			$2d
				bpl			L2842
				nop
				lda			L27bb, x
				jmp			L2856
L2842:
				lda			L27bf, x
				jmp			L2856
L2848:
				lda			$2c
				bpl			L2853
				nop
				lda			L27b3, x
				jmp			L2856
L2853:
				lda			L27b7, x
L2856:
				beq			L285c
				nop
				sta			$b2
				rts
L285c:
				lda			$3e
				bpl			L288b
				nop
				lda			SPRVAL
				and			#$03
				clc
				adc			$3d
				cmp			#$01
				beq			L2875
				nop
				cmp			#$05
				beq			L287f
				nop
				jmp			L288b
L2875:
				lda			$30
				and			#$10
				bne			L2886
				nop
				jmp			L288b
L287f:
				lda			$30
				and			#$08
				beq			L288b
				nop
L2886:
				lda			#$03
				sta			$b2
				rts
L288b:
				lda			#$00
				sta			$b2
				rts
				lda			#$80
				sta			$b2
				rts
				lda			#$01
				sta			$b2
				rts
L289a:
				jsr			L2514
				jsr			L299a
				lda			$0c
				and			#$18
				lsr			a
				lsr			a
				lsr			a
				sta			$3d
				lda			#$00
				sta			$05
				jsr			L2800
				jsr			L2585
				lda			$05
				and			#$01
				beq			L28c4
				nop
				lda			$41
				cmp			#$3a
				bcs			L28d9
				nop

				jmp			L24f9

L28c4:
				jsr			L2558
				lda			$05
				and			#$06
				beq			L28d9
				nop
				cmp			#$02
				beq			L28d6
				nop
				jmp			L2605
L28d6:
				jmp			L2627
L28d9:
				jsr			L259a
				lda			$05
				bmi			L28ff
				nop
				and			#$18
				beq			L28fc
				nop
				cmp			#$08
				beq			L28f9
				nop
				cmp			#$10
				beq			L28f6
				nop
				jsr			L23a4								; Kick PRNG
				bmi			L28f9
				nop
L28f6:
				jmp			L2627
L28f9:
				jmp			L2605
L28fc:
				jmp			L24f9
L28ff:
				lda			$05
				and			#$18
				beq			L2927
				nop
				cmp			#$18
				beq			L2930
				nop
				lda			$3e
				bmi			L294f
				nop
				jsr			L2655
				bcc			L2927
				nop
				bmi			L2927
				nop
L2919:
				lda			$05
				and			#$18
				cmp			#$08
				beq			L292d
				nop
				cmp			#$10
				beq			L292a
				nop
L2927:
				jmp			L2974
L292a:
				jmp			L2627
L292d:
				jmp			L2605
L2930:
				lda			$b2
				beq			L2927
				cmp			#$03
				beq			L2945
				nop
				cmp			#$01
				beq			L292a
				cmp			#$80
				beq			L292d
				cmp			#$02
				beq			L28fc
L2945:
				jsr			L2655
				bcc			L2927
				bmi			L292a
				jmp			L292d
L294f:
				lda			$b2
				beq			L2927
				bmi			L2962
				nop
				cmp			#$01
				beq			L296b
				nop
				cmp			#$02
				beq			L28fc
				jmp			L2919
L2962:
				lda			$05
				and			#$10
				bne			L292d
				jmp			L2927
L296b:
				lda			$05
				and			#$08
				bne			L292a
				jmp			L2927
L2974:
				jsr			L2669
				rts
L2978:
				ldy			#$00
				lda			($10), y
				cmp			#$21
				beq			L2998
				nop
				lda			$0c
				and			#$10
				bne			L298d
				nop
				ldy			#$20
				jmp			L298f
L298d:
				ldy			#$01
L298f:
				lda			($10), y
				cmp			#$21
				beq			L2998
				nop
				clc
				rts
L2998:
				sec
				rts
L299a:
				jsr			L222c
				lda			$2d
				bpl			L29a4
				nop
				eor			#$ff
L29a4:
				cmp			#$07
				bcs			L29d7
				nop
				cmp			#$02
				bcs			L29b4
				nop
				lda			$30
				ora			#$10
				sta			$30
L29b4:
				lda			$2c
				bpl			L29bb
				nop
				eor			#$ff
L29bb:
				cmp			#$07
				bcs			L29d7
				nop
				cmp			#$02
				bcs			L29cb
				nop
				lda			$30
				ora			#$08
				sta			$30
L29cb:
				lda			$3e
				ora			#$80
				sta			$3e
				lda			#$01
				sta			$0f
				clc
				rts
L29d7:
				lda			ARROWS
				cmp			#$04
				bcs			L29e5
				nop
				lda			$3e
				ora			#$80
				sta			$3e
				rts
L29e5:
				lda			$30
				and			#$e7
				sta			$30
				lda			$3e
				and			#$7f
				sta			$3e
				sec
				rts
L29f3:
				lda			SPRVAL
				and			#$03
				beq			L2a09
				nop
				cmp			#$01
				beq			L2a19
				nop
				cmp			#$02
				beq			L2a29
				nop
				inc			$2a
				jmp			L2a2b
L2a09:
				lda			#$20
				clc
				adc			$2a
				sta			$2a
				lda			$2b
				adc			#$00
				sta			$2b
				jmp			L2a2b
L2a19:
				lda			$2a
				sec
				sbc			#$20
				sta			$2a
				lda			$2b
				sbc			#$00
				sta			$2b
				jmp			L2a2b
L2a29:
				dec			$2a
L2a2b:
				jsr			L222f
				rts

				;; Split nybbles
L2a2f:
				tay													; Stash a
				lsr			a										; a>>1
				lsr			a										; a>>2
				lsr			a										; a>>3
				lsr			a										; a>>4
				pha													; Hi nybble
				tya
				and			#$0f									; Low nybble
				tay													; Stash in y
				pla													; Hi nybble
				rts

				;; Draw player scores
L2a3b:
				ldy			#$00									; P1
				ldx			#$00									; P1 offset
				jsr			L2a46
				
				ldy			#$01									; P2
				ldx			#$18									; P2 offset
L2a46:
				lda			$00d0, y							; Score lo
				sta			$03
				lda			$00d2, y							; Score hi
				jsr			L2a60								; Draw 2 byte score from a, $03
				rts

				;; Add a to current player score & redraw
				;; (X = offset)
L2a52:
				sed
				clc
				adc			SCOREP
				sta			SCOREP
				sta			$03
				lda			SCOREP+1
				adc			#$00
				sta			SCOREP+1

				;; Draw 2 byte score from a, $03 + 0
L2a60:
				jsr			L2a6a
				lda			#$30
				sta			$4022, x								; Append 0
				cld
				rts

				;; Draw 2-byte score from a, $03
L2a6a:
				jsr			L2a6f										; Do hi byte
				lda			$03											; Get lo byte

L2a6f:
				jsr			L2a2f										; Split nybbles
				jsr			L2a76										; Do hi nubble
				tya															; Get lo nybble
L2a76:
				ora			#$30										; BCD to char
				sta			$4022, x								; Store to screen
				inx
				rts

L2a7d:
				lda			PNUM
				cmp			#$01
				beq			L2a89
				nop

				ldx			#$09
				jmp			L2a8b

L2a89:
				ldx			#$00
L2a8b:
				lda			#$64
				ldy			LIVES
L2a8f:
				sta			$402a, x
				inx
				dey
				bne			L2a8f
				rts
L2a97:
				lda			$3e
				and			#$02
				bne			L2aba
				nop
				inc			$16
				bmi			L2aa4
				nop
				rts
L2aa4:
				jsr			L23a4								; Kick PRNG
				and			#$47
				cmp			#$40
				beq			L2ab3
				nop
				lda			#$00
				sta			$16
				rts
L2ab3:
				lda			$3e
				ora			#$02
				sta			$3e
				rts
L2aba:
				jsr			L2e76
				rts
				ldx			#$07
L2ac0:
				lda			$96, x
				sta			$0b, x
				dex
				bpl			L2ac0
				dec			$0f
				bpl			L2ae2
				nop
				lda			$b0
				cmp			#$08
				bcc			L2ad8
				nop
				lda			#$02
				jmp			L2adf
L2ad8:
				eor			#$ff
				and			#$07
				clc
				adc			#$02
L2adf:
				jsr			L2d07
L2ae2:
				ldx			#$07
L2ae4:
				lda			$0b, x
				sta			$96, x
				dex
				bpl			L2ae4

				bit			$a7
				bpl			L2b20
				nop

				bit			$0c
				bmi			L2b20
				nop

				bit			$0d
				bmi			L2b20
				nop

				lda			#$ef
				jsr			L23ca
				bit			$3e
				bmi			L2b2c
				nop

				lda			$2d
				beq			L2b2c
				nop

				lda			$2c
				beq			L2b2c
				nop

				lda			$30
				and			#$18
				bne			L2b2c
				nop

				lda			#$fe
				jsr			L23ca
				lda			#$08
				jsr			L23cf
				rts


L2b20:
				lda			VAUD1
				and			#$f0										; Mask high nybble 
				ora			#$10										; Set d4 
				sta			VAUD1
				sta			AUDIO1
				rts


L2b2c:
				lda			#$f7
				jsr			L23ca
				lda			#$01
				jsr			L23cf
				rts

				;; ($10-11) = $4343
L2b37:
				ldy			#$00
				lda			#$43
				sta			SCRLOC
				sta		SCRLOC+1

				;; ($14-15) = $2fc8
				lda			L2ff8, y
				sta			STRLOC
				iny
				lda			L2ff8, y
				sta			$0014, y
				jsr			L22fe										; Draw string
				rts


				;; Draw DEPOSIT COIN / OR PRESS START
L2b4f:
				jsr			L2b63										; Draw DEPOSIT COIN
				lda			CREDIT									; Credits
				bne			L2b58
				nop
				rts

				;; Draw OR_PRESS_START
L2b58:
				ldy			#$02										; (OR PRESS START)

				lda			#$0a
				sta			SCRLOC
				lda			#$42										; ($420a) 
				jmp			L2b6b

L2b63:
				ldy			#$00										; (DEPOSIT COIN) 
				lda			#$eb
				sta			SCRLOC
				lda			#$41										; ($41eb) 
L2b6b:
				sta		SCRLOC+1

				lda			L2fee, y								; (DEPOSIT COIN) 
				sta			STRLOC
				iny
				lda			L2fee, y
				sta			STRLOC+1
				jsr			L22fe										; Draw string

				rts


				;; Set up quarter coinage
L2b7c:
				lda			#$69
				sta			SCRLOC
				lda			#$41
				sta			SCRLOC+1								; ($4169) 
				lda			$5100										; DIPs
				and			#$18										; Mask coinage
				bne			L2b8d										; Non 1C_1P setting
				nop
				rts															; No display for 1C/1P

L2b8d:
				cmp			#$18
				beq			L2b9c										; == $18
				nop

				cmp			#$08
				beq			L2ba1										; == $08
				nop

				;; $10 = 2C/1P
				ldy			#$06
				jmp			L2ba3

				;; $18 = 1C/2P
L2b9c:
				ldy			#$00
				jmp			L2ba3

				;; $08 = 1C/1C (with display)
				;; ($14-15) = $2f37
L2ba1:
				ldy			#$02
L2ba3:
				lda			L2fe4, y
				sta			STRLOC
				iny
				lda			L2fe4, y
				sta			STRLOC+1
				jsr			L22fe								; Draw string

				lda			$5100								; DIPs
				and			#$18
				cmp			#$18
				bne			L2bbc
				nop
				rts

L2bbc:
				lda			#$77
				sta			SCRLOC
				iny
				jsr			L2300										; Draw next string

				rts


				;; Garbage code
L2bc5:
				lda			IN0B										; Control inputs
				and			#$18										; Mask B1, Left
				cmp			#$10										; Left only?
				bne			L2bd7
				nop

				lda			HCOIN											; Half coins
				cmp			#$02
				bcs			L2bd7										; <2
				nop
				rts
				;; Until here


				;; Add credit
L2bd7:
				lda			CREDIT									; Credits
				cmp			#$99
				bne			L2bdf										; <99
				nop
				rts

				;; Increment credits BCD
L2bdf:
				sed
				clc
				adc			#$01
				sta			CREDIT
				cld
				lda			#$00
				sta			HCOIN											; Clear half coins


				;; Draw CREDITS_##
				;; ($10-11) = $400c
L2bea:
				ldy			#$00
				lda			#$0c
				sta			SCRLOC
				lda			#$40
				sta		SCRLOC+1

				;; ($14-15) = $2fa1	= CREDITS
				lda			L2ff4, y
				sta			STRLOC
				iny
				lda			L2ff4, y
				sta			STRLOC+1
				jsr			L22fe										; Draw string

				;; (Duplicate of above)
				;; ($14-15) = $2fa1 = CREDITS
				ldy			#$00
				lda			L2ff4, y
				sta			STRLOC
				iny
				lda			L2ff4, y
				sta			STRLOC+1

				;; ($10-11) = $400c
				lda			#$40
				sta			SCRLOC+1
				lda			#$0c
				sta			SCRLOC

				jsr			L22fe								; Draw string

				lda			CREDIT
				jsr			L2a2f								; Split nybbles
				ora			#$30
				sta			$4014
				tya
				ora			#$30
				sta			$4015
				rts
L2c2b:
				lda			#$71
				sta			SCRLOC
				lda			#$6e
				sta			SCRLOC+1
				ldy			ARROWS
				ldx			#$00
L2c37:
				jsr			L23a4								; Kick PRNG
				and			#$0f
				sta			$50, x
				inx
				lda			#PRNG
				sta			$50, x
				inx
				tya
				beq			L2c51
				nop
				bmi			L2c51
				nop
				lda			#$00
				dey
				jmp			L2c53
L2c51:
				lda			#$a0
L2c53:
				sta			$50, x
				inx
				lda			ARROWS
				sta			$50, x
				inx
				lda			#$1f
				sta			$50, x
				inx
				txa
				and			#$01
				beq			L2c71
				nop
				lda			SCRLOC
				inc			SCRLOC
				inc			SCRLOC
				inc			SCRLOC
				jmp			L2c79
L2c71:
				lda		SCRLOC+1
				dec		SCRLOC+1
				dec		SCRLOC+1
				dec		SCRLOC+1
L2c79:
				sta			$50, x
				inx
				lda			#$40
				sta			$50, x
				inx
				cpx			#$45
				bcc			L2c37
				lda			ARROWS
				cmp			#$03
				bcs			L2c98
				nop

				lda			#$18
				ldx			#$01
				sta			$50, x
				lda			#$10
				ldx			#PRNG
				sta			$50, x
L2c98:
				rts

L2c99:
				lda			$30
				and			#$7f
				sta			$30
				bit			$30
				bmi			L2c99

				ldx			$2f
				ldy			#$00
				lda			L2ffa, y
				sta			$32
				iny
				lda			L2ffa, y
				sta			$33
L2cb2:
				txa
				pha
				jsr			L2cbd
				pla
				tax
				dex
				bne			L2cb2
				rts

				;; Copy bytes from ($32-33) == $0050 to $000b
L2cbd:
				ldy			#$00
L2cbf:
				lda			($32), y
				sta			$000b, y
				iny
				cpy			#$07
				bne			L2cbf								; Loop

				jsr			L2ce6

				;; Copy bytes from $000b to ($32-33) == $0050
				ldy			#$00
L2cce:
				lda			$000b, y
				sta			($32), y
				iny
				cpy			#$07
				bne			L2cce								; Loop

				;; $32-33 += 7
				lda			$32
				clc
				adc			#$07
				sta			$32
				lda			$33
				adc			#$00
				sta			$33
				rts


L2ce6:
				dec			$0f
				bmi			L2cec								; $0f was 0
				nop

				rts

L2cec:
				lda			$0d
				and			#$20									; Mask bit 5
				beq			L2cf4								; Clear
				nop

				rts

L2cf4:
				lda			ARROWS
				cmp			#$04
				bcc			L2d04
				nop

				lda			#$00
				sta			$0e
				lda			#$04
				jmp			L2d07

L2d04:
				clc
				adc			$28

L2d07:
				sta			$0f
				jsr			L2978
				bcs			L2d51
				nop

				lda			$0c
				bmi			L2d51
				nop

				and			#$40
				beq			L2d1c
				nop

				jsr			L289a
L2d1c:
				lda			$0c
				and			#$10
				bne			L2d28
				nop

				lda			#$20
				jmp			L2d2a

L2d28:
				lda			#$01
L2d2a:
				sta			$04
				lda			$0d
				and			#$40
				bne			L2d37
				nop

				jsr			L26a3
				rts

L2d37:
				lda			$0c
				and			#$1f
				ora			#$c0
				sta			$03
				ldy			#$00
				sta			($10), y
				inc			$03
				lda			$03
				ldy			$04
				sta			($10), y
				inc			$0c
				jsr			L26b3
				rts
L2d51:
				lda			$0c
				bmi			L2d68
				nop

				lda			#$21
				jsr			L2d7b
				lda			$0c
				ora			#$80										; Set d7 
				sta			$0c
				lda			#$01
				sta			$bc
				dec			ARROWS
				rts

L2d68:
				lda			$0d
				bmi			L2d7a
				nop
				lda			$0d
				ora			#$80
				sta			$0d
				ldy			#$00
				lda			#$20
				jsr			L2d7b
L2d7a:
				rts
L2d7b:
				sta			$03
				ldy			#$00
				sta			($10), y
				lda			$0c
				and			#$10
				bne			L2d8d
				nop
				ldy			#$20
				jmp			L2d8f
L2d8d:
				ldy			#$01
L2d8f:
				lda			$03
				sta			($10), y
				rts
				
L2d94:
				jsr			L2473
				lda			$20
				and			#$3f
				sta			$21

L2d9d:
				lda			$31
				bne			L2dad
				nop

				lda			#$00
				sta			$c2
				lda			SPRVAL
				ora			#$f0
				sta			SPRVAL
				rts

L2dad:
				dec			$27
				bne			L2dc7
				nop

				inc			$c2
				jsr			L2275
				ldy			#$00
				lda			($2a), y
				cmp			#$20
				bne			L2dc8
				nop

L2dc0:
				jsr			L24ae
				lda			$26
				sta			$27
L2dc7:
				rts

L2dc8:
				sta			$03
				lda			$c2
				cmp			#$06
				bcc			L2dc0

				lda			#$21
				sta			($2a), y
				lda			SPRVAL
				ora			#$f0
				sta			SPRVAL
				lda			$30
				ora			#$04
				sta			$30
				lda			#$00
				sta			$31
				lda			$03
				cmp			#$c0
				bcs			L2dec
				nop

				rts

L2dec:
				lda			$3e
				and			#$9f										; Clear D6,5 
				sta			$3e
				lda			#$00
				sta			$b8
				lda			#$80
				sta			$b9
				jsr			L23a4										; Kick PRNG
				ora			#$c0										; Set D7,6 
				sta			$b3
				jsr			L2eaa
				lda			#$80
				sta			$bc
				lda			$3e
				and			#$fd
				sta			$3e
				inc			$b0
				rts


L2e11:
				lda			$b8
				cmp			#PRNG
				bcs			L2e1f
				nop

				lda			$97
				ora			#$80
				sta			$97
				rts

L2e1f:
				lda			$3e
				and			#$20
				beq			L2e27
				nop

				rts

L2e27:
				lda			$b4
				sec
				sbc			#$20
				sta			$9b
				lda			$b5
				sbc			#$00
				sta			$9c
				ldy			#$00
				lda			($9b), y
				cmp			#$20
				beq			L2e3e
				nop

				rts

L2e3e:
				dec			$9b
				lda			($9b), y
				inc			$9b
				cmp			#$20
				beq			L2e4a
				nop

				rts

L2e4a:
				iny
				lda			($9b), y
				cmp			#$20
L2e4f:
				beq			L2e53
				nop
				rts

L2e53:
				jsr			L23a4								; Kick PRNG
				and			#$08
				ora			#$12
				sta			$97
				lda			#$43
				sta			$98
				lda			#$04
				sta			$96
				lda			#$01
				sta			$9a
				lda			$3e
				ora			#$20
				sta			$3e
				lda			#$8c
				sta			$b9
				jsr			L2e95
				rts

L2e76:
				lda			$3e
				and			#$20
				beq			L2e7e
				nop

				rts

L2e7e:
				dec			$b3
				beq			L2e84
				nop

				rts

L2e84:
				lda			#$2f
				sta			$b3
				inc			$b8
				lda			$b9
				cmp			#$90
				bcc			L2e95
				nop

				lda			#$80
				sta			$b9

L2e95:
				ldy			#$00
				jsr			L2e9c
				ldy			#$20
L2e9c:
				lda			$b9
				sta			($b4), y
				iny
				inc			$b9
				lda			$b9
				sta			($b4), y
				inc			$b9
				rts


L2eaa:
				lda			#$40
				sta			$b5
				lda			#$20
				sta			$b4
				jsr			L2ed9
				tax
L2eb6:
				lda			#$60
				clc
				adc			$b4
				sta			$b4
				lda			$b5
				adc			#$00
				sta			$b5
				dex
				bpl			L2eb6
				jsr			L2ed9

				;; a=3*a
				tax
				ldy			#$00
L2ecc:
				iny
				iny
				iny
				dex
				bpl			L2ecc										; Loop 
				tya

				clc
				adc			$b4
				sta			$b4
				rts

L2ed9:
				jsr			L23a4										; Kick PRNG
				and			#$0f
				cmp			#$09
				bcc			L2ee4
				nop

				lsr			a
L2ee4:
				rts


				;; Copy P1 store to player data
L2ee5:
				ldx			#$00										; For P1
				jmp			L2eec

				;; Copy P2 store to player data
L2eea:
				ldx			#$01										; For P2
L2eec:
				lda			$d0, x
				sta			SCOREP									; Score lo
				lda			$d2, x
				sta			SCOREP+1								; Score hi
				lda			$d4, x
				sta			ARROWS									; Active arrows
				lda			$d6, x
				sta			LIVES										; Lives left
				lda			$d8, x
				sta			$b0											; Shots at special
				lda			$da, x
				sta			$c3											; Points/arrow
				rts

				;; Copy player data to P1 store
L2f05:
				ldx			#$00										; For P1
				jmp			L2f0c

				;; Copy player data to P2 store
L2f0a:
				ldx			#$01										; For P2
L2f0c:
				lda			SCOREP									; Score lo
				sta			$d0, x
				lda			SCOREP+1								; Score hi
				sta			$d2, x
				lda			ARROWS									; Active arrows
				sta			$d4, x
				lda			LIVES										; Lives left
				sta			$d6, x
				lda			$b0											; Shots at special
				sta			$d8, x							
				lda			$c3											; Points/arrow
				sta			$da, x
				rts

L2f25:
				.db			"2 PLAYERS 1 COIN ", $00

L2f37:
				.db			"1 PLAYER  1 COIN ", $00

L2f49:
				.db			"2 PLAYERS 2 COINS", $00

L2f5b:
				.db			"1 PLAYER  2 COINS", $00

L2f6d:
				.db			"2 PLAYERS 4 COINS", $00

L2f7f:
				.db			"DEPOSIT COIN", $00

L2f8c:
				.db			"OR PRESS START", $00

L2f9b:
				.db			"BONUS", $00

L2fa1:
				.db			"CREDITS", $00

L2fa9:
				.db			"TOP THIS SCORE FOR EXTRA BONUS", $00

L2fc8:
				.db			"COPYRIGHT 1980 BY EXIDY INC", $00

				;; Pointers to above text
L2fe4:
				.dw			$2F25										; $2f25		2P_1C
				.dw			$2F37										; $2f37		1P_1C
				.dw			$2F49										; $2f49		2P_2C
				.dw			$2F5B										; $2f5b		1P_2C
				.dw			$2F6D										; $2f6d		2P_4C
L2fee:
				.dw			$2F7F										; $2f7f		DEPOSIT_COIN
				.dw			$2F8C										; $2f8c		OR PRESS START
L2ff2:
				.dw			$2F9B										; $2f9b		BONUS
L2ff4:
				.dw			$2FA1										; $2fa1		CREDITS
				.dw			$2FA9										; $2fa9		TOP_THIS...
L2ff8:
				.dw			$2FC8										; $2fc8		COPYRIGHT...

L2ffa:
				.dw			$0050										; $0050
				.dw			$110d
				.dw			$2080


				;; Reset vector
L3000:
				sei															; Disable interrupts
				ldx			#$ff										; Stack pointer, loop counter
				txs															; Set stack pointer

				;; Wait for vblank
L3004:
				lda			$5103										; IRQ source
				dex
				bmi			L3004										; Loop

				cld
				lda			#$00
				sta			HCOIN
				sta			CREDIT
L3011:
				sta			$a2
				cli															; Enable interrupts

				jsr			L22bc										; Write character RAM 

				lda			#$00
				sta			$ab											; ?? 
				sta			VAUD1										; ?? 
				sta			SCOREP									; Clear player score 
				sta			SCOREP+1

				;; Set default high score
				sta			SCOREH									; HS lo
				lda			#$10
				sta			SCOREH+1								; HS hi

				jsr			L180c										; Copy player data to P1
				jsr			L1806										; Copy player data to P2
				jmp			L3383


L3030:
				sei
				ldx			#$ff
				txs
				cli
				lda			#$00
				sta			SCOREP									; Clear player score 
				sta			SCOREP+1
				sta			$dc
				sta			$dd
				lda			#$01
				sta			PNUM
				sta			$c3
				jsr			L23d7
				jsr			L180c										; Copy player data to P1
				jsr			L1806										; Copy player data to P2
				jsr			L1971
				jsr			L2a3b										; Draw player scores
				jsr			L1806
				lda			ARROWS
				sta			$a8
				lda			#$00
				sta			$a4
				lda			#$90
				sta			VAUD1
				sta			AUDIO1
				lda			#$20
				sta			$35
				sta			$36

				;; Main game play loop
L306c:
				jsr			L2c99
				jsr			L3307
				jsr			L2000										; Check fire button
				jsr			L2088
				jsr			L20ae
				jsr			L1a75
				jsr			L19c4
				jsr			L202f
				jsr			L2a97
				jsr			L2e11
				jsr			L1828
				lda			ARROWS									; Active arrows 
				beq			L309e										; Next level? 
				nop

				lda			$30
				and			#$02
				beq			L306c
				jsr			L316e
				jmp			L306c


				;; End of level
L309e:
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				jsr			L238c										; Delay 21 frames  
				lda			#$10
				sta			AUDIO1
				ldx			PNUM
				dex
				jsr			L1800										; Copy player data to PX
				jsr			L238c										; Delay 21 frames  
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				sta			SPRVAL
				jsr			L1cf2
				jsr			L194d
				jmp			L306c										; Next level
				
				 
L30c4:
				lda			#$10
				sta			AUDIO1
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				jsr			L238c										; Delay 21 frames  
				lda			$a7
				and			#$03
				bne			L30de
				nop

L30d8:
				jsr			L1918
				jmp			L3383


L30de:
				lda			$5100								; DIPs
				eor			#$ff
				and			#$04
				bne			L313a
				nop
				bit			$a7
				bvs			L30d8
				jsr			L2340								; Clear screen
				lda			$a7
				and			#$03
				sta			PNUM
				beq			L30d8
				lsr			a
				tax
				lda			#$01
				sta			$d6, x

				;; Set ($10-11) to $4204
				ldy			#$00
				lda			#$04
				sta			SCRLOC
				lda			#$42
				sta		SCRLOC+1

				;; Set ($14-15) to $1e7f
				lda			L1f4a, y
				sta			STRLOC
				iny
				lda			L1f4a, y
				sta			STRLOC+1

				jsr			L22fe										; Draw string

				lda			#$2c
				sta			SCRLOC
				iny
				jsr			L2300										; Draw next string

				lda			PNUM
				ora			#$30										; To ASCII 
				sta			$421d										; Player # in ASCII 
				jsr			L2386										; Delay 84 frames  
				jsr			L2386										; Delay 84 frames  
				lda			$a7
				ora			#$40
				sta			$a7
				lda			PNUM										; P1=1, P2=0
				lsr			a												; P1=0, P2=1 
				tax
				jsr			L1814										; Copy PX store to player data
				jmp			L309e

L313a:
				jsr			L2340										; Clear screen
				jsr			L2bea										; Draw CREDITS_##
				inc			CREDIT									; Credits

				;; Set ($10-11) to $420b
				lda			#$0b
				sta			SCRLOC
				lda			#$42
				sta			SCRLOC+1								; ($420b)

				;; Set ($14-15) to $1eaf
				ldy			#$00
				lda			L1f4c, y
				sta			STRLOC
				iny
L3152:
				lda			L1f4c, y
				sta			STRLOC+1

				jsr			L22fe										; Draw string

				iny
				lda			#$38
				sta			SCRLOC									; ($4238) 
				jsr			L2300										; Draw next string

				jsr			L2386										; Delay 84 frames  
				jsr			L2bea										; Draw CREDITS_##
				jsr			L2386										; Delay 84 frames  
				jmp			L30d8
L316e:
				lda			#$10
				jsr			L23cf
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				jsr			L1e08

				lda			$2f											; ?? Not new level?
				bne			L3186
				nop

				lda			#$0a
				sta			$2f
				sta			ARROWS									; # Active arrows

L3186:
				dec			LIVES										; Lives left
				bpl			L318f										; >= 0
				nop

				;; Reset to 0 if negative
				lda			#$00
				sta			LIVES										; Lives left

L318f:
				lda			NUMP										; # Players
				cmp			#$02
				bne			L31b9										; 1P only -- no swap
				nop

				;; Swap players
				lda			$bf											; Player #
				cmp			#$01
				beq			L31ac										; Currently P1
				nop

				;; Swap data to P1
				lda			#$01
				sta			$bf
				jsr			L1806										; Copy player data to P2
				jsr			L1820										; Copy P1 store to player data
				lda			LIVES										; Lives left
				bne			L31c1
				nop

				;; Swap data to P2
L31ac:
				lda			#$02
				sta			$bf
				jsr			L180c										; Copy player data to P1
				jsr			L181a										; Copy P2 store to player data
				jmp			L31bc


L31b9:
				jsr			L180c
L31bc:
				lda			LIVES
				beq			L31ce										; Game over 
				nop

L31c1:
				jsr			L2340										; Clear screen
				jsr			L2421
				jsr			L1971
				jsr			L2a3b										; Draw player scores
				rts

L31ce:
				jmp			L30c4


				;; IRQ vector
				php
				pha
				txa
				pha
				tya
				pha

				lda			$5103										; IRQ source
				tay
				and			#$60
				bne			L31ee										; Coin 1 or 2 pressed

				nop
				tya
				bpl			L31eb										; VBlank?
				nop

L31e4:
				pla
				tay
				pla
				tax
				pla
				plp
				rti

L31eb:
				jmp			L3f4d										; Change this for new irq

				;; Coin pressed
L31ee:
				lda			$a2
				cmp			#$06
				bcc			L31e4										; Exit NMI if $a2 <= 6
				
				jsr			L3279
				bcs			L31e4										; No valid coin

				;; Push y, $10-11, $14-15
				tya
				pha
				lda			STRLOC
				pha
				lda			STRLOC+1
				pha
				lda			SCRLOC
				pha
				lda			SCRLOC+1
				pha

				lda			#$00
				sta			$a2
				bit			$5100										; DIPs
				bmi			L3252										; Quarters!
				nop

				;; Handle Pence
				lda			$0301
				cmp			#$40										; Was coin 1
				bne			L3233
				nop

				lda			$5100										; DIPs
				eor			#$ff
				and			#$02										; Mask 1/2 C_C
				bne			L3230										; 1 Coin/credit
				nop

				;; 2 coin per
				inc			HCOIN										; Inc half coin
				lda			HCOIN										; Half coin
				cmp			#$02
				bcc			L3268
				nop

				;; 1 coin per
				lda			#$00
				sta			HCOIN										; Half coin
L3230:
				jmp			L3258										;

L3233:
				lda			$5100										; DIPs
				eor			#$ff
				and			#$02
				bne			L3246										; Add 5 coins
				nop

				;; Add 2 coins
L323d:
				jsr			L32ee										; Add coin

				;; Add 1 coin
				jsr			L32ee										; Add coin
				jmp			L3258

				;; Add 5 coins total
L3246:
				jsr			L32ee										; Add coin
				jsr			L32ee										; Add coin
				jsr			L32ee										; Add coin
				jmp			L323d

				;; Handle quarters
L3252:
				bit			$0301
				bmi			L3268										; Skip to end
				nop

L3258:
				jsr			L32ee										; Add credit
				bcc			L3268
				nop

				bit			$a7
				bmi			L3268
				nop

				ldy			#$12
				jsr			L1b13

				;; End of coin routine
L3268:
				pla
				sta		SCRLOC+1
				pla
				sta			SCRLOC
				pla
				sta			STRLOC+1
				pla
				sta			STRLOC
				pla
				tay
				jmp			L31e4										; End of ISR


				;; IRQ Coin handler
L3279:
				lda			#$05										; 5 tries to catch coin
				sta			$0300										; Loop counter
				bit			$5101										; Control inputs
				bpl			L3298										; Coin 1
				nop

				lda			$5100										; DIPs
				and			#$01										; Mask Coin 2
				bne			L32c0										; Coin 2
				nop

				dec			$0300
				bne			L3279										; Loop

				lda			#$00										; No coin?
				sta			$0301
				sec															; Invalid coin
				rts

				;; Validate Coin 1
L3298:
				lda			#$ff										; Loop counter
				sta			$0300
L329d:
				bit			$5101										; Control inputs
				bmi			L3279										; No Coin 1
				dec			$0300
				bne			L329d										; Loop

L32a7:
				bit			$5101										; Control inputs
				bpl			L32a7										; Coin 1
				
				dec			$0300										; Loop counter (#ff)
L32af:
				bit			$5101										; Control inputs
				bpl			L32a7										; Coin 1
				dec			$0300
				bne			L32af										; Loop

				lda			#$40										; Coin 1
				sta			$0301
				clc															; Valid Coin 1
				rts

				;; Validate Coin 2
L32c0:
				lda			#$ff										; Loop counter
				sta			$0300
L32c5:
				lda			$5100										; DIPs
				and			#$01
				beq			L3279										; No coin 2

				dec			$0300
				bne			L32c5										; Loop
				
L32d1:
				lda			$5100										; DIPs
				and			#$01
				bne			L32d1										; Coin 2

				dec			$0300
L32db:
				lda			$5100										; DIPs
				and			#$01
				bne			L32d1										; Coin 2
				
				dec			$0300
				bne			L32db										; Loop
				lda			#$80										; Coin 2
				sta			$0301
				clc															; Valid Coin 2
				rts


L32ee:
				lda			$5100										; DIPs
				and			#$18										; Mask coinage
				
				cmp			#$10
				bne			L3302										; Not 2C_1C
				nop

				inc			HCOIN										; Half coins
				lda			HCOIN
				cmp			#$02
				bcs			L3302										; <2
				nop
				rts

L3302:
				jsr			L2bd7										; Add credit
				sec
				rts

				;; Copy $96-9d to $0b-$12
L3307:
				ldx			#$07
L3309:
				lda			$96, x
				sta			$0b, x
				dex
				bpl			L3309										 ; Loop

				dec			$0f
				bpl			L332b
				nop

				lda			$b0
				cmp			#$08
				bcc			L3321
				nop

				lda			#$02
				jmp			L3328

L3321:
				eor			#$ff
				and			#$07
				clc
				adc			#$02
L3328:
				jsr			L2d07

 
				;; Copy $0b-12 to $96-9d
L332b:
				ldx			#$07
L332d:
				lda			$0b, x
				sta			$96, x
				dex
				bpl			L332d										; Loop

				bit			$a7
				bpl			L3369
				nop

				bit			$0c
				bmi			L3369
				nop

				bit			$0d
				bmi			L3369
				nop

				lda			$97
				and			#$40
				bne			L334b
				nop

				rts

L334b:
				lda			#$ef
				jsr			L23ca
				inc			$030f
				lda			$030f
				and			#$40
				bne			L3375
				nop
				lda			VAUD1
				and			#$08
				beq			L3363
				nop
				rts
L3363:
				lda			#$08
				jsr			L23cf
				rts
L3369:
				lda			VAUD1
				and			#$f0
				ora			#$10
				sta			VAUD1
				sta			AUDIO1
				rts
L3375:
				lda			VAUD1
				and			#$08
				bne			L337d
				nop
				rts
L337d:
				lda			#$f7
				jsr			L23ca
				rts


				;; Attract mode
L3383:
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				sta			SPRVAL
				jsr			L246d										; Update MOBLAT (redundant)
				lda			#$10
				sta			VAUD1
				sta			AUDIO1
				lda			#$00
				sta			$a7
				jsr			L2340										; Clear screen
				jsr			L18ba										; Draw coinage (only here)
				
				lda			#$1f
				sta			$17											; Loop Counter

L33a2:
				jsr			L2b4f										; Draw DEPOSIT_COIN
				lda			#$2a
				sta			$41											; Loop counter
				sta			$42											; Loop counter


L33ab:
				lda			CREDIT									; Credits
				bne			L33ef										; Credits -- check starts
				nop

				;; No credits
				inc			$3f											; ?? 
				bne			L33a2										; Inner loop

				dec			$17
				bne			L33a2										; Outer Loop
				
				jsr			L1e32

				;; Fake gameplay loop -- make this a sub
				lda			#$0d
				sta			$17

L33bf:
				jsr			L2c99
				jsr			L3307
				jsr			L346e
				jsr			L2088
				jsr			L20ae
				jsr			L1ab8
				jsr			L202f
				jsr			L2e76
				jsr			L2e11

				lda			CREDIT
				bne			L3383										; Check starts

				lda			$30
				and			#$02
				bne			L3383										; Check starts 

				dec			$3f											; Inner loop counter 
				bne			L33bf										; Loop

				dec			$17											; Outer loop counter 
				bne			L33bf										; Loop

				jmp			L3383


				;; Check starts
L33ef:
				lda			IN0B										; Control inputs
				eor			#$ff										; Invert
				and			#$03										; Mask Start buttons
				cmp			#$01										; 1P Start
				beq			L343e
				nop

				cmp			#$02										; 2P Start
				beq			L3425
				nop

				dec			$16
				bne			L33ab										; Loop
				dec			$41
				bne			L33ab										; Loop
				lda			#$01
				sta			$41
				ldx			#$0a
				lda			$420d
				cmp			#$20
				beq			L341e
				nop

				lda			#$20
L3418:
				sta			$420d, x
				dex
				bpl			L3418

L341e:
				dec			$42
				bne			L33ab										; Loop
				
				jmp			L33a2										; Loop

				;; 2P Start pressed
L3425:
				lda			$5100										; DIPs
				and			#$18
				cmp			#$18
				beq			L343c										; 2P per credit?
				nop

				lda			CREDIT									; Credits
				cmp			#$02
				bcs			L3439
				nop
				jmp			L33a2										; Not enough credits
				
L3439:
				jsr			L193a										; Decrement credits

L343c:
				lda			#$02

				;; 1P Start
L343e:
				sta			NUMP										; # Players
				jsr			L193a										; Decrement credits

				lda			#$0b
				sta			$2f
				lda			#$0a
				sta			ARROWS
				lda			#$03
				sta			$28
				jsr			L2340										; Clear screen
				lda			#$01
				sta			$bf
				lda			#$80										; D7 = game mode
				sta			$a7											; Status
				ldy			#$16
				lda			NUMP
				cmp			#$02
				beq			L3465
				nop

				ldy			#$12
L3465:
				jsr			L1b13
				jsr			L2421
				jmp			L3030


L346e:
				lda			$3f											; ??
				and			#$1f										; Mask low 5 bits 
				cmp			#$0f
				bne			L3481
				nop

				jsr			L23a4										; Kick PRNG
				sta			$00											; Store PRN
				and			#$49										; 0100_1001
				bne			L3486
				nop

L3481:
				lda			#$00
				sta			CURIN0
				rts

L3486:
				lda			$00
				and			#$03										; Clear high 6 bits
				tax
				lda			L1fe8, x								; Table (20 40 04 08)
				sta			CURIN0

				lda			$00
				and			#$10
				ora			CURIN0									; May set bit 4
				sta			CURIN0									; 04 08 20 40 / 14 1
				and			#$ef										; D0 never set anyway?
				sta			OLDIN0									; Store
				rts

				;;
				;; Garbage assembly text
				;;
L349d:
				.db			                         $54, $0d, $10		; DATA
				.db			$30, $20, $41, $43, $54, $49, $56, $45		; DATA
				.db			$3d, $24, $30, $30, $42, $31, $20, $3b		; DATA
				.db			$4e, $55, $4d, $42, $45, $52, $20, $4f		; DATA
				.db			$46, $20, $41, $43, $54, $49, $56, $45		; DATA
				.db			$20, $41, $52, $52, $4f, $57, $53, $0d		; DATA
				.db			$10, $40, $20, $53, $4d, $4f, $56, $45		; DATA
				.db			$3d, $24, $30, $30, $42, $32, $20, $3b		; DATA
				.db			$53, $4d, $41, $52, $54, $20, $4d, $4f		; DATA
				.db			$56, $45, $20, $43, $4f, $44, $45, $0d		; DATA
				.db			$10, $50, $20, $46, $53, $48, $43, $4e		; DATA
				.db			$54, $3d, $24, $30, $30, $42, $33, $20		; DATA
				.db			$3b, $46, $4c, $41, $53, $48, $20, $43		; DATA
				.db			$4f, $55, $4e, $54, $45, $52, $0d, $10		; DATA
				.db			$60, $20, $46, $53, $43, $52, $4e, $3d		; DATA
				.db			$24, $30, $30, $42, $34, $20, $3b, $46		; DATA
				.db			$4c, $41, $53, $48, $20, $53, $43, $52		; DATA
				.db			$45, $45, $4e, $20, $4c, $4f, $43, $41		; DATA
				.db			$54, $49, $4f, $4e, $0d, $10, $70, $20		; DATA
				.db			$43, $41, $42, $54, $4d, $3d, $24, $30		; DATA
				.db			$30, $42, $36, $20, $3b, $43, $41, $52		; DATA
				.db			$20, $42, $41, $53, $45, $20, $54, $49		; DATA
				.db			$4d, $45, $52, $0d, $10, $80, $20, $43		; DATA
				.db			$41, $52, $43, $41, $4c, $3d, $24, $30		; DATA
				.db			$30, $42, $37, $20, $3b, $43, $41, $52		; DATA
				.db			$20, $43, $41, $4c, $45, $4e, $44, $41		; DATA
				.db			$52, $0d, $10, $90, $20, $4f, $42, $4a		; DATA
				.db			$43, $54, $52, $3d, $24, $30, $30, $42		; DATA
				.db			$38, $20, $3b, $53, $50, $45, $43, $49		; DATA
				.db			$41, $4c, $20, $4f, $42, $4a, $45, $43		; DATA
				.db			$54, $20, $43, $4f, $55, $4e, $54, $45		; DATA
				.db			$52, $0d, $11, $00, $20, $46, $49, $4d		; DATA
				.db			$41, $47, $3d, $24, $30, $30, $42, $39		; DATA
				.db			$20, $3b, $46, $4c, $41, $53, $48, $49		; DATA
				.db			$4e, $47, $20, $49, $4d, $41, $47, $45		; DATA
				.db			$0d, $11, $10, $20, $54, $50, $4f, $49		; DATA
				.db			$4e, $54, $3d, $24, $30, $30, $42, $43		; DATA
				.db			$20, $3b, $54, $59, $50, $45, $20, $4f		; DATA
				.db			$46, $20, $50, $4f, $49, $4e, $54, $20		; DATA
				.db			$54, $4f, $20, $42, $45, $20, $41, $57		; DATA
				.db			$41, $52, $44, $45, $44, $20, $28, $41		; DATA
				.db			$52, $52, $4f, $57, $2d, $53, $50, $45		; DATA
				.db			$43, $20, $54, $41, $52, $47, $29, $0d		; DATA
				.db			$11, $20, $20, $50, $4c, $59, $52, $53		; DATA
				.db			$43, $3d, $24, $30, $30, $42, $44, $20		; DATA
				.db			$3b, $50, $4c, $41, $59, $45, $52, $20		; DATA
				.db			$53, $43, $4f, $52, $45, $20, $28, $32		; DATA
				.db			$20, $42, $59, $54, $45, $53, $29, $0d		; DATA
				.db			$11, $30, $20, $50, $4c, $59, $4e, $3d		; DATA
				.db			$24, $30, $30, $42, $46, $20, $3b, $50		; DATA
				.db			$4c, $41, $59, $45, $52, $20, $4e, $55		; DATA
				.db			$4d, $42, $45, $52, $0d, $11, $40, $20		; DATA
				.db			$4e, $50, $4c, $59, $52, $53, $3d, $24		; DATA
				.db			$30, $30, $43, $30, $20, $3b, $4e, $55		; DATA
				.db			$4d, $42, $45, $52, $20, $4f, $46, $20		; DATA
				.db			$50, $4c, $41, $59, $45, $52, $53, $20		; DATA
				.db			$28, $31, $20, $4f, $52, $20, $32, $29		; DATA
				.db			$0d, $11, $50, $20, $4e, $43, $41, $52		; DATA
				.db			$53, $3d, $24, $30, $30, $43, $31, $20		; DATA
				.db			$3b, $4e, $55, $4d, $42, $45, $52, $20		; DATA
				.db			$4f, $46, $20, $43, $41, $52, $53, $20		; DATA
				.db			$50, $45, $52, $20, $47, $41, $4d, $45		; DATA
				.db			$0d, $11, $60, $20, $42, $43, $41, $4c		; DATA
				.db			$4e, $3d, $24, $30, $30, $43, $32, $20		; DATA
				.db			$3b, $42, $55, $4c, $4c, $45, $54, $20		; DATA
				.db			$43, $41, $4c, $45, $4e, $44, $41, $52		; DATA
				.db			$0d, $11, $70, $20, $4e, $50, $4f, $49		; DATA
				.db			$4e, $54, $3d, $24, $30, $30, $43, $33		; DATA
				.db			$20, $3b, $4e, $55, $4d, $42, $45, $52		; DATA
				.db			$20, $4f, $46, $20, $50, $4f, $49, $4e		; DATA
				.db			$54, $53, $20, $50, $45, $52, $20, $41		; DATA
				.db			$52, $52, $4f, $57, $0d, $11, $80, $20		; DATA
				.db			$53, $43, $4f, $52, $45, $31, $3d, $24		; DATA
				.db			$30, $30, $44, $30, $20, $3b, $53, $43		; DATA
				.db			$4f, $52, $45, $20, $53, $54, $4f, $52		; DATA
				.db			$41, $47, $45, $0d, $11, $90, $20, $53		; DATA
				.db			$43, $4f, $52, $31, $31, $3d, $24, $30		; DATA
				.db			$30, $44, $32, $20, $3b, $48, $2e, $4f		; DATA
				.db			$2e, $20, $53, $43, $4f, $52, $45, $20		; DATA
				.db			$53, $54, $4f, $52, $41, $47, $45, $0d		; DATA
				.db			$12, $00, $20, $41, $43, $54, $49, $56		; DATA
				.db			$31, $3d, $24, $30, $30, $44, $34, $20		; DATA
				.db			$3b, $4e, $55, $4d, $42, $45, $52, $20		; DATA
				.db			$4f, $46, $20, $41, $43, $54, $49, $56		; DATA
				.db			$45, $20, $41, $52, $52, $4f, $57, $53		; DATA
				.db			$20, $53, $54, $4f, $52, $41, $47, $45		; DATA
				.db			$0d, $12, $10, $20, $4e, $43, $41, $52		; DATA
				.db			$53, $31, $3d, $24, $30, $30, $44, $36		; DATA
				.db			$20, $3b, $4e, $55, $4d, $42, $45, $52		; DATA
				.db			$20, $4f, $46, $20, $43, $41, $52, $53		; DATA
				.db			$20, $4c, $45, $46, $54, $20, $53, $54		; DATA
				.db			$4f, $52, $41, $47, $45, $0d, $12, $20		; DATA
				.db			$20, $4e, $53, $46, $49, $52, $53, $3d		; DATA
				.db			$24, $30, $30, $44, $38, $20, $3b, $4e		; DATA
				.db			$55, $4d, $42, $45, $52, $20, $4f, $46		; DATA
				.db			$20, $54, $49, $4d, $45, $53, $20, $46		; DATA
				.db			$49, $52, $45, $44, $20, $41, $54, $20		; DATA
				.db			$53, $50, $45, $43, $49, $41, $4c, $20		; DATA
				.db			$54, $41, $52, $47, $45, $54, $0d, $12		; DATA
				.db			$30, $20, $4e, $50, $4f, $49, $54, $53		; DATA
				.db			$3d, $24, $30, $30, $44, $41, $20, $3b		; DATA
				.db			$4e, $55, $4d, $42, $45, $52, $20, $4f		; DATA
				.db			$46, $20, $50, $4f, $49, $4e, $54, $53		; DATA
				.db			$20, $50, $45, $52, $20, $41, $52, $52		; DATA
				.db			$4f, $57, $0d, $12, $40, $20, $48, $53		; DATA
				.db			$43, $4f, $52, $4e, $3d, $24, $30, $30		; DATA
				.db			$44, $43, $20, $3b, $48, $49, $47, $48		; DATA
				.db			$20, $53, $43, $4f, $52, $45, $20, $4e		; DATA
				.db			$55, $4d, $42, $45, $52, $0d, $12, $50		; DATA

				.org		$3800
				.include "targ_char.asm"

				;; Garbage
L3f00:
				.db			$a9, $00, $85, $a4, $60, $08, $48, $8a		; DATA
				.db			$48, $98, $48, $ad, $03, $51, $a8, $29		; DATA
				.db			$40, $d0, $0e, $ea, $98, $29, $80, $f0		; DATA
				.db			$34, $ea
				
L3f1a:
				pla
				tay
				pla
				tax
				pla
				plp
				rti

L3f21:
				.db		       $a5, $a2, $c9, $06, $90, $f3, $a5		; DATA
				.db			$14, $48, $a5, $15, $48, $a5, $10, $48		; DATA
				.db			$a5, $11, $48, $a9, $00, $85, $a2, $20		; DATA
				.db			$c5, $2b, $68, $85, $11, $68, $85, $10		; DATA
				.db			$68, $85, $15, $68, $85, $14, $4c, $1a		; DATA
				.db			$3f, $ea, $4c, $1a, $3f										; DATA


				.org		$3f4d
				;; VBlank IRQ jumps to here
L3f4d:
				lda			$a7
				and			#$20
				bne			L3f57
				nop

				jsr			L2459										; Update sprite locations 

L3f57:
				inc			$a2
				bpl			L3f60
				nop

				lda			#$80										; Max out at #$80 
				sta			$a2

L3f60:
				lda			$30
				ora			#$80										; Set D7
				sta			$30
				jmp			$3f1a										; Orig end of ISR 
;				jmp			L31e4										; End of ISR

				;; Patch for end of L1ab8
L3f69:
				lda			#$50
				jsr			L23cf
				lda			#$00
				sta			AUDIO2
				jsr			L3fe2
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				lda			SPRVAL
				and			#$02
				bne			L3f8c
				nop

				lda			SPR1H
				clc
				adc			#$08
				sta			SPR1H
				jmp			L3f93

L3f8c:
				lda			SPR1V
				clc
				adc			#$08
				sta			SPR1V
L3f93:
				lda			SPRVAL
				ora			#$0f										; Set 4 LSBs 
				sta			SPRVAL
				lda			$a7
				ora			#$20										; Set D5 
				sta			$a7
				lda			#$f8
				sta			$0a
L3fa3:
				sta			MOBLAT							; Sprite latch

				;; Delay
				lda			#$30
				sta			$40
L3faa:
				dec			$3f
				bne			L3faa

				dec			$40
				bne			L3faa

				inc			$0a
				lda			$0a
				cmp			#$fa
				bcs			L3fbd
				nop

				lda			$0a
L3fbd:
				cmp			#$fe
				bne			L3fa3

				jsr			L238c										; Delay 21 frames  
				lda			#$10
				jsr			L23cf
				lda			$30
				ora			#$02
				sta			$30
				lda			SPRVAL
				ora			#$f0
				sta			SPRVAL
				sta			MOBLAT									; Sprite latch
				jsr			L2389										; Delay 42 frames  
				lda			$a7
				and			#$df
				sta			$a7
				rts
L3fe2:
				bit			$a7
				bpl			L3fec
				nop

				lda			#$70
				sta			AUDIO1
L3fec:
				rts


				;; Garbage
L3fed:
				.db			                         $4e, $45, $0d		; DATA
				.db			$17, $50, $20, $3b, $53, $54, $4d, $4f		; DATA

				.org		$3ff8
				.dw			$3000										; ???   vector
				.dw			$3000										; BRK   vector
				.dw			$3000										; Reset vector
				.dw			$31D1										; IRQ   vector

				.end
