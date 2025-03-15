				;; Variables from asm
				;; $0008-0009		= PRNG
				
				;; Constants
HSEC		= $1e										; 1/2 second = 30 IRQs

				;; Memory loc
L0000		= $00										; Misc temp var
L0001		= $01										; Misc temp var
START		= $02										; UNUSED
L0003		= $03										; (2 bytes) Misc temp var
DELL		= $06										; (2 bytes) Delay counter (Was $16)
DELH		= $07										; (2 bytes) Delay counter	(Was $17)
PRNG		= $08										; (2 bytes) PRNG
DEADSPR	= $0a										; Sprite for crash sequence
				
ARRTMP	= $0b										; (7 bytes) arrow temp location   ($0b to $12)
ATPRNT	= $0b										; +0 Arrow PRNG val
ATDIR		= $0c										; +1 Arrow dir
ATFLAG	= $0d										; +2 Arrow flags
ATNUM		= $0e										; +3 Arrow num
ATXXX		= $0f										; +4 ??
ATXPOS	=	$10										; +5 Arrow X
ATYPOS	=	$11										; +6 Arrow Y
				
STRLOC	= $0e										; (2 bytes) String source data (was $14, $18)
SCRLOC	= $10										; (2 bytes) Screen loc to draw string

TIMERA	= $12										; VBlank IRQ countdown timer
				
SPRVAL	= $1a										; Local MOBLAT st
SPR1H		= $1c										; Written to MOB1H during IRQ
SPR1V		= $1d										; Written to MOB1V during IRQ
ADDS1H	= $1e										; MOB1 H "speed"
ADDS1V	= $1f										; MOB1 V "speed"
SPR2H		= $22										; Written to MOB2H during IRQ
SPR2V		= $23										; Written to MOB2V during IRQ
ADDS2H	= $24										; MOB2 H "speed"
ADDS2V	= $25										; MOB2 V "speed"
L002e		= $2e										; Set to #$00, never read
L002f		= $2f										; Set to #$0a only
L0030		= $30										; ??
ARRPTR	= $32										; (2 bytes) Pointer to arrow
CURIN0	= $34										; Validated control inputs
OLDIN0	= $35										; Last $34 (not really used)
OOLDIN0	= $36										; Last $35 (not really used)
L003c		= $3c										; Unused
L0041		= $41										; (3/15 bytes) temp storage
ARRTBL	= $50										; Arrow control table ($07 bytes * $0a arrows == $50-96)
				;; +0		= $00-$0f from PRNG
				;; +1		= Direction ($00/08/10/18 = U, D, R, L)
				;; +2		= $a0 if last arrow, $00 if not?
				;; +3		= Initially arrow #?
				;; +4		= $1f initially
				;; +5-6	= Screen position
				
SPECLOC	= $9b										; (2 bytes) location of special target

HCOIN		= $a0										; Half coins
CREDIT	= $a1										; Credits
COINCNT	= $a2										; Counter in coin routine

VAUD1		= $a3										; AUDIO1 value store
STATUS	= $a7										; D<1:> = P# for HS
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
PSCOREL	= $d0										; $d0-d1 = P1/2 Score lo
PSCOREH = $d2										; $d2-d3 = P1/2 Score hi
PARROW  = $d4										; $d4-d5 = P1/2 Active arrows
PLIVES	= $d5										; $d6-d7 = P1/2 Lives left
				;; $00d8-00d9		= P1/2 shots at special target
				;; $00da-00db		= P1/2 Points per arrow
PLEVEL	= $dc										; $dc-dd = P1/2					Level?
				;; $00de-00df		= P1/2 ??

				;; $00e0-00ff		= Apparently unused


				;; $0300				= Counter to validate coins
				;; $0301				= D7 = Good coin 2, D6 = Good coin 1

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
				jsr			L23cf										; Set AUDIO1 bits 
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


				;; Draw big bonus #s
L1880:
				lda			#$3d
				sta			$03

				;; ($10-11) = $4048
L1884:
				;; Start location = $4045
				;; Width = 4*4+3*2 = 22 
				lda			#$45
				sta			SCRLOC
				lda			#$40
				sta			SCRLOC+1

				lda			PNUM										; Player # (2/1)
				lsr			a												; (1/0)
				tax															; (1/0)
				lda			$dc, x									; Level / bonus #
				tax
				lda			L1fde, x								; Index into table by level
				tax
				jsr			L18a2										; Draw big # 
				jsr			L18a0										; Draw big 0 
				jsr			L18a0										; Draw big 0 

				;; Draw big 0
L18a0:
				ldx			#$00
L18a2:
				ldy			LBIG0, x								; Table
				cpy			#$ff										; $ff ends table 
				beq			L18b2										; Exit loop
				nop

				lda			$03
				sta			(SCRLOC), y
				inx
				jmp			L18a2										; Loop

L18b2:
				clc
				lda			SCRLOC
				adc			#$06										; Space to next # 
				sta			SCRLOC
				rts

	
				;; Draw HI SCR
L18e2:
				lda			#$06										; HI SCR
				jsr			DRAWSTRA
				
				lda			SCOREH									; High score lo
				sta			$03
				lda			SCOREH+1								; High score hi
				ldx			#$11										; Location 
				jsr			L2a60										; Draw 2 byte score from a, $03
				rts


				;; GAME OVER
L1918:
				jsr			L2340										; Clear screen

				;; Draw STR07
				lda			#$07										; END OF GAME
				jsr			DRAWSTRA

				jsr			DEL168
				sta			START										; Clear START to flag game over
				rts


				;; Decrement credits
L193a:
				lda			CREDIT									; Credits
				bne			L1941
				nop
				sec															; Carry = no credits
				rts

L1941:
				sed															; Decimal mode
				sec															; Clear borrow
				sbc			#$01										; Decrement
				sta			CREDIT									; Credits
				cld															; Clear decimal
				jsr			L2bea										; Draw CREDITS_##
				clc															; No carry = credits
				rts


L194d:
				jsr			L1971

				ldx			#$01										; P1 offset
				lda			PNUM										; Current player
				cmp			#$01
				beq			L195b										; Is P1
				nop

				ldx			#$1a										; P2 offset
L195b:
				lda			#$00

				jsr			L2a52										; Add a to current player score
				lda			$2f
				sta			ARROWS
				jsr			L2c2b										; Initial arrow config
				dec			$28
				bpl			L1970
				nop

				lda			#$00										; Don'y dec below 0 
				sta			$28
L1970:
				rts


L1971:
				jsr			L197b
				jsr			L2a3b										; Draw player scores
				jsr			L2a7d
				rts

L197b:
				jsr			L2c2b										; Initial arrow config
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
				lda			#$f3										; MOB1 = player 
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
				lda			#$0a										; # Arrows 
				sta			$2f											; Set
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
				ldx			#$1a										; P2 location 
				jmp			L19db

L19d9:
				ldx			#$01										; P1 location

L19db:
				lda			$bc
				bmi			L19e5
				nop

				lda			$c3
				jmp			L19ef

L19e5:
				lda			#$60
				jsr			L23cf										; Set AUDIO1 bits 
				inc			$a8
				jsr			L1a12										; Special target shot

L19ef:
				jsr			L2a52										; Add a to current player score
				cpx			#$18
				bcs			L19fe
				nop

				ldx			#$1a										; Offset +$18
				ldy			#$01										; Player 2
				jmp			L1a02

L19fe:
				ldy			#$00										; Player 1
				ldx			#$01										; Location +00
L1a02:
				lda			$00d0, y								; Score lo
				sta			$03
				lda			$00d2, y								; Score hi
				jsr			L2a60										; Draw 2 byte score from a, $03

L1a0d:
				lda			#$00
				sta			$bc
				rts


				;; Special target shot
L1a12:
				stx			$01
				lda			ARROWS									; # active arrows
				bne			L1a1f
				nop

				lda			STATUS
				ora			#$10										; Set bit 5
				sta			STATUS

L1a1f:
				lda			#$00
				sta			AUDIO2
				jsr			L23a4										; Kick PRNG
				and			#$03
				tax
				lda			L1fec, x								; Table (01 02 03 05)
				tax
				ldy			#$00
;				sta			$00											; Stash score

				;; Copy 3 PF bytes to storage, draw score
				lda			($9b), y
				sta			$0041, y
;				lda			$00											; Get score
				txa
				ora			#$30										; BCD to char 
				sta			($9b), y								; Score 100s
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
				txa															; Score back to a 
				asl			a												; x<<1
				asl			a												; x<<2
				asl			a												; x<<3
				asl			a												; x<<4 (x10 BCD)
;				sta			$00											; Stash score
				tax
;				ldx			$01											; Needed for score draw, moved
				lda			#$3f
				jsr			DELAY										; Delay 63 frames 

				;; Copy PF chars back
				ldy			#$00
				jsr			L1a6e
				jsr			L1a6e
				jsr			L1a6e
;				lda			$00											; Get score
				txa
				ldx			$01											; Needed for score draw?!
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
				and			#$c0										; Clear D5-0
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
				and			#$fe										; Clear LSB 
				cmp			#$20
				bne			L3f69

.if 0
				beq			L1ad1										; --> $2d94 
				nop

				cmp			#$21
				beq			L1ad1										; --> $2d94 
				nop

				;; Did commenting this kill collision detection?!
				jmp			L3f69
.endif

L1ad1:
;				jmp			L2d94										; Inlined 
L2d94:
				jsr			L2473
				lda			$20
				and			#$3f
				sta			$21

L1ad4:
;				jmp			L2d9d										; Inlined 
L2d9d:
				lda			$31
				bne			L2dad
				nop

				lda			#$00
				sta			$c2
				lda			SPRVAL
				ora			#$f0										; Clear MOB2 
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
				ora			#$04										; Set D2 
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


				;; Moved from end
L3f69:
				lda			#$50
				jsr			L23cf										; Set AUDIO1 bits 
				lda			#$00
				sta			AUDIO2
				jsr			L3fe2
				lda			#$ee										; Clear MOB1,2
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
				ora			#$0f										; Set 4 LSBs (Clear MOB1)
				sta			SPRVAL
				lda			STATUS
				ora			#$20										; Set D5 
				sta			STATUS


				;; Explosion animation
				lda			#$f8										; 1st explosion sprite 
				sta			$0a

L3fa3:
				sta			MOBLAT									; Sprite latch

				;; Delay
				lda			#$08										; Delay 8 frames 
				jsr			DELAY

				inc			$0a
				lda			$0a
				cmp			#$fe										; Last exploision sprite 
				bne			L3fa3

				lda			#$15
				jsr			DELAY										; Delay 21 frames

				lda			#$10
				jsr			L23cf										; Set AUDIO1 bits 
				lda			$30
				ora			#$02										; Set D1 
				sta			$30
				lda			SPRVAL
				ora			#$f0										; Clear MOB2
				sta			SPRVAL
				sta			MOBLAT									; Sprite latch

				lda			#$2a
				jsr			DELAY										; Delay 42 frames

				lda			STATUS
				and			#$df										; Clear D5 
				sta			STATUS
				rts

L3fe2:
				bit			STATUS
				bpl			L3fec										; D7 clear 
				nop

				lda			#$70
				sta			AUDIO1
L3fec:
				rts
				;; End of moved 


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

				;; End of level bonus screen
L1cf2:
				jsr			L2340										; Clear screen
				jsr			L1d80										; $3d, $be chars -> solid

				lda			PNUM										; 1 or 2 
				lsr			a												; 0 or 1
				tax
				
				sed
				clc
				lda			$dc, x									; Level bonus 
				cmp			#$09
				bcs			L1d09										; >=9, skip increment 
				nop

				adc			#$01										; Increment 
				sta			$dc, x									; Store

L1d09:
				clc
				adc			SCOREP+1
				sta			SCOREP+1
				lda			$c3											; Level bonus 
				cmp			#$09
				bcs			L1d19										; >= 9, skip increment 
				nop

				adc			#$01										; Increment
				sta			$c3											; Store 

L1d19:
				cld
				jsr			L1880										; Draw big bonus #s 

				lda			#$01										; EXTRA POINTS
				jsr			DRAWSTRA								; Draw string

				lda			#$13										; BONUS
				jsr			DRAWSTRA								; Draw string

				lda			#$0b										; 10 POINTS 
				jsr			DRAWSTRA								; Draw string (and return)

				lda			$c3											; Arrow score 
				ora			#$30										; BCD to char 
				sta			$428d										; Location 
				lda			#$10
				sta			AUDIO1
				ldy			#$00
				jsr			L1b13
				jsr			L1d8e
				ldx			#$2f										; Loop count 
L1d66:
				jsr			L1d6d										; $3d, $be chars -> random
				dex
				bpl			L1d66										; Loop 
				rts

				;; Overwrite 2 char codes with random data
L1d6d:
				dec			DELL
				bne			L1d6d
				ldy			#$07
L1d73:
				jsr			L23a4										; Kick PRNG
				sta			$49e8, y								; Char $3d 
				sta			$4df0, y								; Char $be (not used)
				dey
				bpl			L1d73										; Loop 

				rts

				;; Overwrite 2 char codes with $ff
L1d80:
				lda			#$ff
				ldy			#$07
L1d84:
				sta			$49e8, y								; Char $3d 
				sta			$4df0, y								; Char $be (not used)
				dey
				bpl			L1d84										; Loop 

				rts

L1d8e:
				lda			#$09 
				sta			$3f											; Loop counter 
				lda			#$12
				sta			$b7
L1d96:
				jsr			L1da0
				dec			$b7
				dec			$3f											; Dec counter 
				bne			L1d96										; Loop 
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
				sta			DELH
L1db2:
				dec			DELL
				bne			L1db2										; Inner loop 
				lda			DELH
				and			#$03										; Mask LSBs 
				sta			ARROWS
				lda			DELH
				and			#$06
				bne			L1dc3
				nop
L1dc3:
				dec			DELH
				bne			L1db2										; Outer loop 
				rts


L1dc8:
				jsr			L1880
				jsr			L1dae										; Delay 3 frames 
				rts


				;; Compare player score to high score
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

				;; Copy player score to high score
L1e1b:
				lda			SCOREP
				sta			SCOREH
				lda			SCOREP+1
				sta			SCOREH+1

				;; LSBs of status = Player # for high score
				lda			STATUS
				and			#$fc										; Clear bits 1-0 
				sta			STATUS
				lda			PNUM
				and			#$03										; Mask bits 1-0 
				ora			STATUS
				sta			STATUS
				rts


				;; Table ($FF terminated)
				;; Set pixels for large font
L1f52:
LBIG0:
				.db			     $01, $02
				.db			$20,           $23
				.db			$40,           $43
				.db			$60,           $63
				.db			$80,           $83
				.db			     $A1, $A2
				.db			$FF									

LBIG1:	
				.db			          $02
				.db			     $21, $22
				.db			          $42
				.db			          $62
				.db			          $82
				.db			     $A1, $A2, $A3
				.db			$FF

LBIG2:
				.db			     $01, $02
				.db			$20,            $23
				.db			                $43
				.db			     $61,	$62
				.db			$80
				.db			$A0, $A1, $A2, $A3
				.db			$FF

LBIG3:
				.db			$00, $01, $02, 
				.db			               $23
				.db			     $41, $42
				.db			               $63
				.db			$80,           $8e
				.db			     $A1, $A2
				.db			$FF

LBIG4:				
				.db			          $02
				.db			$20,      $22
				.db			$40,      $42
				.db			$60, $61, $62, $63
				.db			          $82
				.db		            $A2     
				.db			$FF

LBIG5:
				.db			$00, $01, $02, $03
				.db			$20
				.db			$40, $41, $42
				.db			               $63
				.db			$80,           $83
				.db			     $A1, $A2
				.db			$FF

LBIG6:				
				.db			     $01, $02, $03
				.db			$20
				.db			$40, $41, $42
				.db			$60,           $63
				.db			$80,           $83
				.db			     $A1, $A2     
				.db			$FF

LBIG7:
				.db			$00, $01, $02, $03
				.db			               $23
				.db			          $42, $43
				.db			     $61,	$62
				.db			     $81
				.db			     $A1
				.db			$FF

LBIG8:
				.db			     $02, $03
				.db			$21,           $23
				.db			     $41, $42     
				.db			$60,           $63
				.db			$80,           $83
				.db			     $A1, $A2     
				.db			$FF

LBIG9:
				.db		       $01, $02     
				.db			$20,           $23
				.db			     $41, $42, $43
				.db			               $63
				.db			$80,           $83
				.db		       $A1, $A2      
				.db			$FF


				;; Indicies into above table
L1fde:
				.db			LBIG0-LBIG0
				.db			LBIG1-LBIG0
				.db			LBIG2-LBIG0
				.db			LBIG3-LBIG0
				.db			LBIG4-LBIG0
				.db			LBIG5-LBIG0
				.db			LBIG6-LBIG0
				.db			LBIG7-LBIG0
				.db			LBIG8-LBIG0
				.db			LBIG9-LBIG0

				;; Fake game move table
L1fe8:
				.db			$20, $40, $04, $08			; (4 entries) {U,D,R,L}


				;; Score for special target (x100)
L1fec:
				.db			$01, $02, $03, $05			; (4 entries)

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
				sta			CURIN0									; IN0 store
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
				and			#$60										; Check D6,5
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
				and			#$20										; Check D5 
				bne			L2054
				nop

				lda			$3a
				jsr			L2093
				lda			$30
				and			#$bf										; Clear D6 
				sta			$30
				rts

L2054:
				jsr			L23a4										; Kick PRNG
				and			#$01										; Mask LSB 
				tax

				lda			SPR1H
				beq			L2070
				nop

				lda			SPR1V
				beq			L206a
				nop

				lda			L27ad, x								; SPR1H!=0, SPR1V!=0 
				jmp			L207e

L206a:
				lda			L27ab, x								; SPR1H!=0, SPR1V==0 
				jmp			L207e

L2070:
				lda			SPR1V
				beq			L207b
				nop

				lda			L27af, x								; SPR1H==0, SPR1V!=0 
				jmp			L207e

L207b:
				lda			L27b1, x								; SPR1H==0, SPR1V==0 
L207e:
				jsr			L2093										; a = New dir? 
				lda			$30
				and			#$9f										; Clear D6,5 
				sta			$30
				rts

L2088:
				lda			CURIN0
				and			#$ef										; Clear d4 
				bne			L2093 

				jsr			L2225										; (if 0) 
				rts

L2093:
				cmp			#$20
				beq			L20ea

				cmp			#$40
				beq			L2113

				cmp			#$04
				bne			L20a5

				jmp			L213e

L20a5:
				cmp			#$08
				bne			L20ad

				jmp			L2169
L20ad:
				rts

L20ae:
				lda			$31
				beq			L20b4

				rts

L20b4:
				lda			CURIN0
				and			#$10
				bne			L20bc

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
;				jsr			L21d9										; Only called here

L21d9:
				lda			$1e
				jsr			L21e8
				sta			$24
				lda			$1f
				jsr			L21e8
				sta			$25

				jmp			L246d										; Update MOBLAT (and rts)


L20ea:
				lda			$1f
				beq			L2101

				bmi			L20f5

				jmp			L21f4

L20f5:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L2108										; Missile Up 

				jmp			L220a

L2101:
				jsr			L21a1
				bcs			L2108										; Missile Up 

				rts

				;; Missile up?
L2108:
				lda			#$01
				sta			$1f											; MOB1 V speed
				lda			#$00
				sta			$1e											; MOB1 H speed
				jmp			L2191

L2113:
				lda			$1f
				beq			L212a

				bpl			L211e

				jmp			L21f4

				;; $1f > 0
L211e:
				lda			$20
				and			#$3f										; Mask 6 LSBs 
				cmp			#$0a
				bcs			L2131										; Missile down 

				jmp			L220a

L212a:
				jsr			L21a1
				bcs			L2131										; Missile down 

				rts

				;; Missile down?
L2131:
				lda			#$fe
				sta			$1f											; MOB1 V speed
				lda			#$00
				sta			$1e											; MOB1 H speed
				lda			#$01
				jmp			L2191

L213e:
				lda			$1e
				beq			L2155

				bpl			L2149

				jmp			L21f4

L2149:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L215c										; Missile left 

				jmp			L220a

L2155:
				jsr			L21a9
				bcs			L215c										; Missile left 

				rts

				;; Missile left?
L215c:
				lda			#$fe 
				sta			$1e											; MOB1 H speed
				lda			#$00
				sta			$1f											; MOB1 V speed
				lda			#$02
				jmp			L2191

L2169:
				lda			$1e											; MOB1 H speed
				beq			L2180
				nop

				bmi			L2174
				nop

				jmp			L21f4

L2174:
				lda			$20
				and			#$3f
				cmp			#$0a
				bcs			L2187										; Missile right 
				nop

				jmp			L220a

L2180:
				jsr			L21a9
				bcs			L2187										; Missile right 
				nop

				rts

				;; Missile right?
L2187:
				lda			#$01
				sta			$1e											; MOB1 H speed
				lda			#$00
				sta			$1f											; MOB1 V speed
				lda			#$03										; MOB1 

L2191:
				pha
				lda			SPRVAL
				and			#$f0										; Clear MOB2
				sta			SPRVAL
				pla
				ora			SPRVAL
				sta			SPRVAL
;				jsr			L246d										; Update MOBLAT (unneeded)
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
				bne			L21b6										 ; Loop 

				clc
				rts

L21c7:
				lda			$39
				sta			$3a
				lda			CURIN0
				and			#$ef
				sta			$39
				lda			$30
				and			#$bf										 ; Clear D6 
				sta			$30
				sec
				rts


				;; a --> #$02, #$00, #$fd
L21e8:
				beq			L21f0										; 0 -> 0 
				nop

				bmi			L21f1
				nop

				lda			#$02										; pos -> $02 
L21f0:
				rts
L21f1:
				lda			#$fd										; neg -> $fd 
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
				and			#$7f										; Clear D7 
				ora			#$40										; Set D6 
				sta			$20
;				lda			$3c											; Not used
;				sta			$2e											; Never read 
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
				lda			SCRLOC+1
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
				sta			SCRLOC
				lda			#$38
				sta			STRLOC+1
				lda			#$48
				sta			SCRLOC+1

				ldx			#$08										; 8 pages
				ldy			#$00
CHLOOP:
				lda			(STRLOC), y
				sta			(SCRLOC), y
				iny
				bne			CHLOOP									; Loop

				inc			STRLOC+1
				inc			SCRLOC+1
				dex
				bne			CHLOOP									; Loop
				rts


				;; Draw string #a
DRAWSTRA:
				asl			a												; a<<1
				tax
				
				;; ROM loc of string  
				lda			TXTTBL,x
				sta			STRLOC
				lda			TXTTBL+1,x
				sta			STRLOC+1

				;; Screen loc of string  
				lda			TXTLOC,x
				sta			SCRLOC
				lda			TXTLOC+1,x
				sta			SCRLOC+1

				;; Draw string from (STRLOC) at (SCRLOC)
				;; Deprecated
DRAWSTR:
L22fe:
				ldy			#$00
DRAWSTRN:
L2300:
				lda			(STRLOC), y							; Get char
				bne			L2306										; 0 terminated
				nop

				rts															; Exit 

L2306:
				sta			(SCRLOC), y							; Store char
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
				sta			(SCRLOC), y
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
				jsr			L23cf										; Set AUDIO1 bits 
				rts


				;; Kick PRNG
L23a4:
				tya
				pha															; Push y

				ldy			#$23										; Loop counter 
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
				bne			L23a8										; Loop 
				pla
				tay
				lda			PRNG
				rts


				;; Set AUDIO1 bits
L23cf:
				ora			VAUD1
				bne			L23d1										; Always

				;; Clear AUDIO1 bits
L23ca:
				and			VAUD1

L23d1:
				sta			VAUD1
				sta			AUDIO1
				rts


				;; Set LIVES froom DIPs
L23d7:
				lda			DSW											; DIPs
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


				;; Draw STR08

L2421:
				ldy			#$00
				lda			#$10
				sta			AUDIO1
				lda			#$ee
				sta			MOBLAT									; Sprite latch

				;; Draw STR09
				lda			#$09										; GET READY 
				jsr			DRAWSTRA								; Draw string

				;; Draw STR0A
				lda			#$0a										; PLAYER___
				jsr			DRAWSTRA								; Draw sting

				lda			PNUM
				ora			#$30
				sta			$4253										; Location

;				jmp			DEL168									; Delay 168 frames
				
DEL168:	
				lda			#$a8										; 168 frames 
DELAY:
				sta			TIMERA

				;; Spin until TIMERA==0
DLOOP:
				lda			TIMERA
				bne			DLOOP

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
				sta			MOBLAT									; Sprite latch
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
				and			#$40										; Check D6 
				bne			L2494
				nop

				lda			$30
				ora			#$40										; Set D6 
				sta			$30
				rts

L2494:
				lda			$30
				ora			#$20										; Set D5 
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


L2514:
				;; Stash SCRLOC
				lda			SCRLOC
				pha
				lda			SCRLOC+1
				pha

				lda			$0c											; Arrow dir?
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
				txa															; x<<1
				asl			a
				tax															; Selects $10 byte tabkes at L2757 
				lda			#$00
				sta			$00

				;; Copy 15 chars to ($41-4f)
L253b:
				ldy			L2757, x								; Offset from SCRLOC
				beq			L2554
				nop

				lda			(SCRLOC), y
				stx			$01
				ldx			$00
				and			#$7f
				sta			$41, x
				inx
				stx			$00
				ldx			$01
				inx
				jmp			L253b										; Loop 


L2554:
				;; Restore SCRLOC
				pla
				sta			SCRLOC+1
				pla
				sta			SCRLOC
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

				lda			#$04										; Set D2 
				jmp			L2580

L2579:
				cmp			#$20
				bcc			L258c
				nop

				lda			#$02										; Set D1 
L2580:
				ora			$05
				sta			$05
				rts

L2585:
				lda			$41
				cmp			#$20										; Check D5 
				beq			L2593
				nop
L258c:
				lda			$05
				ora			#$01										; Set D0 
				sta			$05
				rts
L2593:
				lda			$05
				ora			#$80										; Set D7 
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

				;; Code can't get here?
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
				ora			#$20										; Set D5 
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
				sta			(SCRLOC), y
				rts


L26a3:
				lda			$0c
				and			#$1f
				ldy			#$00
				sta			(SCRLOC), y
				inc			$0c
				lda			$0c
				and			#$1f
				ldy			$04
L26b3:
				sta			(SCRLOC), y
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
				jsr			L2359										; (SCRLOC) = $4000
				lda			#$80
				sta			SCRLOC
				ldx			#$09
L26d4:
				lda			#$ba
				jsr			L26e8
				jsr			L2316										; Add 1 line
				lda			#$bc
				jsr			L26e8
				jsr			L2311										; Add 2lines
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
				sta			(SCRLOC), y
				iny
				lda			$04
				sta			(SCRLOC), y
				iny
				iny
				cpy			#$1d
				bcc			L26f0
				rts
L2700:
				jsr			L2359										; ($10-11) = $4000
				lda			#$42
				sta			SCRLOC
				lda			#$60
				jsr			L273d
				jsr			L2368										; ($10-11) = $4300
				lda			#$e2
				sta			SCRLOC
				lda			#$61
				jsr			L273d
				jsr			L2359										; ($10-11) = $4000
				lda			#$60
				sta			SCRLOC
				lda			#$63
				jsr			L2743
				jsr			L2359										; ($10-11) = $4000
				lda			#$61
				sta			SCRLOC
				lda			#$62
				jsr			L2748
				jsr			L2359										; ($10-11) = $4000
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
				sta			(SCRLOC), y
				pha
				jsr			L2316										; ($10-11) += $20 (1 line)
				pla
				dex
				bne			L274c
				rts


				;; Tables ($00 terminated)
L2757:
				.db			$43, $42, $23, $44,	$41, $22, $03, $24	;
				.db			$45, $62, $64, $61, $65, $60, $66, $00	;

				.db			$43, $44, $63, $42, $45, $64, $83, $62	;
				.db			$41, $24, $22, $25, $21, $26, $20, $00	;

				.db			$62, $42, $63, $82, $22, $43, $64, $83	;
				.db			$A2, $41, $81, $21, $A1, $01, $61, $00	;

				.db			$62, $82, $61, $42, $A2, $81, $60, $41	;
				.db			$22, $83, $43, $A3, $23, $C3, $03, $00	;

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
				.db			$04, $20												; SPR1H!=0, SPR1V==0 
L27ad:
				.db			$40, $04												; SPR1H!=0, SPR1V!=0 
L27af:
				.db			$08, $40												; SPR1H==0, SPR1V!=0 
L27b1:
				.db			$20, $08												; SPR1H==0, SPR1V==0
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
				and			#$10										; Check D4 
				bne			L2886
				nop

				jmp			L288b

L287f:
				lda			$30
				and			#$08										; Check D3 
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

				;; Can't get here
L2890:
				lda			#$80
				sta			$b2
				rts

				;; Can't get here
L2895:
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
				lda			(SCRLOC), y
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
				lda			(SCRLOC), y
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
				ora			#$10										; Set D4 
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
				ora			#$08										; Set D3 
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
				and			#$e7										; Clear D4,3 
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
				tay															; Stash a
				lsr			a												; a>>1
				lsr			a												; a>>2
				lsr			a												; a>>3
				lsr			a												; a>>4
				pha															; Hi nybble
				tya
				and			#$0f										; Low nybble
				tay															; Stash in y
				pla															; Hi nybble
				rts

				;; Draw player scores
L2a3b:
				ldy			#$00										; P1
				ldx			#$01										; P1 offset
				jsr			L2a46
				
				ldy			#$01										; P2
				ldx			#$1a										; P2 offset
L2a46:
				lda			$00d0, y								; Score lo
				sta			$03
				lda			$00d2, y								; Score hi
				jsr			L2a60										; Draw 2 byte score from a, $03
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
				sta			$4020, x								; Append 0
				cld
				rts

				;; Draw 2-byte score from a, $03
L2a6a:
				jsr			DRAWBCD									; Do hi byte
				lda			$03											; Get lo byte

				;; DrawBCD at $4020+x
DRAWBCD:
L2a6f:
				jsr			L2a2f										; Split nybbles
				jsr			L2a76										; Do hi nubble
				tya															; Get lo nybble
L2a76:
				ora			#$30										; BCD to char
				sta			$4020, x								; Store to screen
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

				inc			DELL
				bmi			L2aa4
				nop

				rts

L2aa4:
				jsr			L23a4										; Kick PRNG
				and			#$47
				cmp			#$40
				beq			L2ab3
				nop

				lda			#$00
				sta			DELL
				rts

L2ab3:
				lda			$3e
				ora			#$02										; Set D1 
				sta			$3e
				rts

L2aba:
				jsr			L2e76
				rts


				;; Draw DEPOSIT COIN / OR PRESS START
L2b4f:
				bit			DSW
				bpl			DICPRESS								; (Free play)

ICNOFP:
				lda			#$11										; DEPOSIT COIN
				jsr			DRAWSTRA								; Draw string (and return)
				
				lda			CREDIT									; Credits
				bne			L2b58

				rts

L2b58:
				lda			#$12										; OR
				jsr			DRAWSTRA								; Draw string

DICPRESS:
				lda			DELH
				and			#$01										; Mask LSB
				clc
				adc			#$18										; blank or PRESS START 
				jmp			DRAWSTRA								; Draw string (and return)


				;; Draw CREDITS_##
L2bea:
				bit			DSW
				bmi			DCNOFP

				lda			#$16										; FREE PLAY 
				jmp			DRAWSTRA								; Draw string (and return)
				 
DCNOFP:
				lda			#$14										; CREDITS
				jsr			DRAWSTRA

				lda			CREDIT
				jsr			L2a2f										; Split nybbles
				ora			#$30										; BCD to Char
				sta			$4013
				tya
				ora			#$30										; BCD to Char
				sta			$4014
				rts


				;; Initial arrow config
L2c2b:
				lda			#$71										; Middle right arrow pos 
				sta			SCRLOC
				lda			#$6e										; Middle left arrow pos 
				sta			SCRLOC+1
				ldy			ARROWS
				ldx			#$00

L2c37:
				jsr			L23a4										; Kick PRNG
				and			#$0f										; Mask low nybble 
				sta			$50, x									; ($50) 
				inx															; x=1 mod 7
				lda			#$08										; (Down) 
				sta			$50, x									; ($51) 
				inx															; x=2 mod 7
				tya															; a=ARROWS 
				beq			L2c51										; No arrows 
				nop

				bmi			L2c51										; Negative arrows ?!
				nop

				lda			#$00										; Not last arrow 
				dey
				jmp			L2c53

L2c51:
				lda			#$a0										; Last arrow 
L2c53:
				sta			$50, x									; ($52) 
				inx															; x=3 mod 7
				lda			ARROWS
				sta			$50, x									; ($53) 
				inx															; x=4 mod 7
				lda			#$1f
				sta			$50, x									; ($54) 
				inx															; x=5 mod 7
				txa
				and			#$01										; Odd or even 
				beq			L2c71
				nop

				;; Get right arrow loc and +=3
				lda			SCRLOC 
				inc			SCRLOC
				inc			SCRLOC
				inc			SCRLOC
				jmp			L2c79

L2c71:
				;; Get left arrow loc and --3
				lda		SCRLOC+1
				dec		SCRLOC+1
				dec		SCRLOC+1
				dec		SCRLOC+1

L2c79:
				sta			$50, x									; ($55)
				inx															; x=6 mod 7
				lda			#$40
				sta			$50, x									; ($56)
				inx															; x= 0 mod 7 
				cpx			#$45										; $07 * $0a - 1
				bcc			L2c37										; More arrows!

				lda			ARROWS
				cmp			#$03
				bcs			L2c98
				nop

				lda			#$18										; (Left) 
				ldx			#$01
				sta			$50, x									; ($51) 
				lda			#$10										; (Right) 
				ldx			#$08
				sta			$50, x									; ($58) 

L2c98:
				rts


L2c99:
				lda			$30
				and			#$7f										; Clear MSB 
				sta			$30
				bit			$30
				bmi			L2c99										; Never -- you just cleared it! 

				ldx			$2f											; Always #$10 

				lda			#(ARRTBL&$ff)
				sta			ARRPTR
				lda			#((ARRTBL>>8)&$ff)
				sta			ARRPTR+1

L2cb2:
				txa
				pha															; Stash x
				jsr			L2cbd
				pla
				tax															; Restore x
				dex
				bne			L2cb2
				rts

				;; Manipulate arrows
				;; Copy data from (ARRPTR) to ($0b)
L2cbd:
				ldy			#$00
L2cbf:
				lda			(ARRPTR), y
				sta			$000b, y
				iny
				cpy			#$07
				bne			L2cbf										; Loop

				jsr			L2ce6

				;; Copy bytes from ($0b) to (ARRPTR)
				ldy			#$00
L2cce:
				lda			$000b, y
				sta			(ARRPTR), y
				iny
				cpy			#$07
				bne			L2cce										; Loop

				;; ARRPTR += 7
				lda			ARRPTR
				clc
				adc			#$07
				sta			ARRPTR
				lda			ARRPTR+1
				adc			#$00
				sta			ARRPTR+1
				rts


L2ce6:
				dec			$0f
				bmi			L2cec										; $0f was 0
				nop

				rts

L2cec:
				lda			$0d
				and			#$20										; Mask bit 5
				beq			L2cf4										; Clear
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
				sta			(SCRLOC), y
				inc			$03
				lda			$03
				ldy			$04
				sta			(SCRLOC), y
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
				ora			#$80										; Set D7 
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
				sta			(SCRLOC), y
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
				sta			(SCRLOC), y							; Why was this STRLOC? 
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
				jsr			L23a4										; Kick PRNG
				and			#$08										; Mask D3  
				ora			#$12										; Set D4,1 
				sta			$97											; ??
				lda			#$43
				sta			$98											; ??

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


				;;
				;; Common text include
				;;

.include "targ_txt.asm"

				;; Reset vector
				.org		$3000
LRESET:
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
				sta			START
				sta			COINCNT
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

MAINLOOP:				
				jsr			ATTRACT									; Attract mode 
				jsr			FAKEGAME								; Fake gameplay
;				jsr			SHOWHS									; High score screen
;				jsr			FAKEGAME								; Fake gameplay

				lda			START
				beq			MAINLOOP

				jsr			CFGGAME
				jsr			PLAYGAME
				jmp			MAINLOOP

				;; Real game play
PLAYGAME:
L3030:
				sei
;				ldx			#$ff										; Trash stack ptr
;				txs															; Trash stack ptr
				cli
				lda			#$00
				sta			SCOREP									; Clear player score 
				sta			SCOREP+1
				sta			$dc
				sta			$dd
				lda			#$01
				sta			PNUM
				sta			$c3											; Level 
				jsr			L23d7										; Set LIVES froom DIPs
				jsr			L180c										; Copy player data to P1
				jsr			L1806										; Copy player data to P2
				jsr			L1971
				jsr			L2a3b										; Draw player scores
				jsr			L1806										; Copy player data to P2
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
				and			#$02										; Check D1 
				beq			L306c										; No death
				
				jsr			L316e										; Handle death

				lda			START										; $00 for game over
				bne			L306c

				rts															; GAME OVER 


				;; End of level
L309e:
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				lda			#$15
				jsr			DELAY										; Delay 21 frames

				lda			#$10
				sta			AUDIO1
				ldx			PNUM
				dex
				jsr			L1800										; Copy player data to PX
				lda			#$15
				jsr			DELAY										; Delay 21 frames

				lda			#$ee										; Clear sprites 
				sta			MOBLAT									; Sprite latch
				sta			SPRVAL
				jsr			L1cf2										; Bonus screen 
				jsr			L194d
				jmp			L306c										; Next level
				
				 
L30c4:
				lda			#$10
				sta			AUDIO1
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				lda			#$15
				jsr			DELAY										; Delay 21 frames

				lda			STATUS
				and			#$03
				bne			L30de										; Extended play
				nop

L30d8:
				jmp			L1918										; GAME OVER

L30de:
				lda			DSW											; DIPs
				eor			#$ff
				and			#$04
				bne			L313a
				nop
				bit			STATUS
				bvs			L30d8
				jsr			L2340										; Clear screen
				lda			STATUS
				and			#$03
				sta			PNUM
				beq			L30d8
				lsr			a
				tax
				lda			#$01
				sta			$d6, x

				;; Draw STR02
				lda			#$02										; EXTENDED PLAY
				jsr			DRAWSTRA 

				;; Draw STR03
				lda			#$03										; TOPPING HIGH
				jsr			DRAWSTRA
				
				lda			PNUM
				ora			#$30										; To ASCII 
				sta			$421d										; Player # in ASCII 
				jsr			DEL168
				
				lda			STATUS
				ora			#$40
				sta			STATUS
				lda			PNUM										; P1=1, P2=0
				lsr			a												; P1=0, P2=1 
				tax
				jsr			L1814										; Copy PX store to player data
				jmp			L309e

L313a:
				jsr			L2340										; Clear screen
				jsr			L2bea										; Draw CREDITS_##
				inc			CREDIT									; Credits

				;; Draw STR04
				lda			#$04										; EXTRA CREDIT
				jsr			DRAWSTRA
				
				;; Draw STR05
				lda			#$05										; FOR TOPPING
				jsr			DRAWSTRA

				lda			#$54
				jsr			DELAY										; Delay 84 frames  

				jsr			L2bea										; Draw CREDITS_##
				lda			#$54
				jsr			DELAY										; Delay 84 frames  

				jmp			L30d8

L316e:
				lda			#$10
				jsr			L23cf										; Set AUDIO1 bits 
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				jsr			L1e08										; Update high score? 

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
LIRQ:
L3131:
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
				bmi			IRQEND									; Not Vblank

L3f4d:
				lda			STATUS
				and			#$20
				bne			L3f57
				nop

				jsr			L2459										; Update sprite locations 

L3f57:
				inc			COINCNT
				bpl			L3f60
				nop

				lda			#$80										; Max out at #$80 
				sta			COINCNT

L3f60:
				lda			$30
				ora			#$80										; Set D7
				sta			$30


				;; Check P2 start
CHKP2:
				lda			IN0
				and			#$02										; 2P start
				bne			CHKP1										; Not pressed 
				
DOP2:
				bit			DSW											; DIPs
				bpl			P2DEC0									; Free play
				
				lda			CREDIT
				cmp			#$02
				bcs			P2DEC2									; >=2 credits

				cmp			#$01
				bcc			CHKP1										; <1 credit

				lda			DSW
				and			#$18										; Mask coinage 
				cmp			#$18										; 2P_1C 
				beq			P2DEC1

				bne			CHKP1										; Not enough credits 
				
P2DEC2:
				jsr			L193a										; Decrement credits
P2DEC1:	
				jsr			L193a										; Decrement credits
P2DEC0:
				lda			#$02										; 2P
				bne			SETSTART


				;; Check P1 start
CHKP1:
				lda			IN0
				and			#$01										; 1P start 
				bne			DECTA										; Not pressed

DOP1:
				bit			DSW											; DIPs 
				bpl			P1DEC0									; Free play
				 
				lda			CREDIT
				beq			DECTA										; No credits
				
P1DEC1: 
				jsr			L193a										; Decrement credits

P1DEC0:
				lda			#$01										; 1P

SETSTART:
				sta			START


				;; Decrement TIMERA down to zero
				;; Added to eliminate delay code
DECTA:
				lda			TIMERA
				beq			IRQEND

				dec			TIMERA

IRQEND:
L31e4:
				pla
				tay
				pla
				tax
				pla
				plp
				rti


				;; Coin pressed
L31ee:
				;; Coin debounce?
				lda			COINCNT
				cmp			#$06
				bcc			L31e4										; Exit NMI if $a2 <= 6
				
				jsr			IRQCOIN									; Validate coin 
				bcs			IRQEND									; No valid coin

.if 0
				;; Push y, $10-11, $14-15
				;; Apparently unneeded
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
.endif

				lda			#$00
				sta			COINCNT
			
				;; Handle quarters only
L3252:
;				bit			$0301										; ?? 
;				bmi			L3268										; Skip to end
				lda			$0301										; Valid coins
				beq			L3268										; Skip to end

				jsr			L32ee										; Add coin 
				
				bit			STATUS
				bmi			L3268										; (In game)

				ldy			#$12
				jsr			L1b13										; Play song? 

				;; End of coin routine
L3268:
				
.if 0
				;; Apparently unneeded
				pla
				sta			SCRLOC+1
				pla
				sta			SCRLOC
				pla
				sta			STRLOC+1
				pla
				sta			STRLOC
				pla
				tay
.endif
				jmp			IRQEND									; End of ISR



				;; IRQ Coin handler
IRQCOIN:
L3279:
				lda			#$05										; 5 tries to catch coin
				sta			$0300										; Loop counter
				bit			IN0											; Control inputs
				bpl			L3298										; Coin 1
				nop

				lda			DSW											; DIPs
				and			#$01										; Mask Coin 2
				bne			L32c0										; Coin 2
				nop

				dec			$0300
				bne			IRQCOIN									; Loop

				lda			#$00										; No coin, clear D7
				sta			$0301
				sec															; Invalid coin
				rts

				;; Validate Coin 1
L3298:
				lda			#$ff										; Loop counter
				sta			$0300
L329d:
				bit			IN0											; Control inputs
				bmi			IRQCOIN									; No Coin 1
				dec			$0300
				bne			L329d										; Loop

L32a7:
				bit			IN0											; Control inputs
				bpl			L32a7										; Coin 1
				
				dec			$0300										; Loop counter (#ff)
L32af:
				bit			IN0											; Control inputs
				bpl			L32a7										; Coin 1 pressed
				
				dec			$0300
				bne			L32af										; Loop

				lda			#$40										; Coin 1 = Set D6
				sta			$0301
				clc															; Valid Coin 1
				rts


				;; Validate Coin 2
L32c0:
				lda			#$ff										; Loop counter
				sta			$0300
L32c5:
				lda			DSW											; DIPs
				and			#$01
				beq			IRQCOIN									; No coin 2

				dec			$0300
				bne			L32c5										; Loop
				
L32d1:
				lda			DSW											; DIPs
				and			#$01										; Coin 2 
				bne			L32d1										; Coin 2 pressed

				dec			$0300
				bne			L32d1										; Loop
				
				lda			#$80										; Coin 2 = Set D7
				sta			$0301
				clc															; Valid Coin 2
				rts


L32ee:
				lda			DSW											; DIPs
				and			#$18										; Mask coinage
				
				cmp			#$10
				bne			L3302										; Not 2C_1C

				inc			HCOIN										; Half coins
				lda			HCOIN
				cmp			#$02
				bcs			L3302										; <2

;				clc															; Carry already clear 
				rts

				;; Add credit
L3302:
L2bd7:
				lda			CREDIT									; Credits
				cmp			#$99
				beq			CRED99

				;; Increment credits BCD
L2bdf:
				sed
				clc
				adc			#$01
				sta			CREDIT
				cld
				lda			#$00
				sta			HCOIN										; Clear half coins
						
				sec
CRED99:	
				rts


				;; Copy Arrow struct to ($0b-12)
L3307:
;				ldx			#$07										; Should be 6?
				ldx			#$06
L3309:
				lda			$96, x
				sta			$0b, x
				dex
				bpl			L3309										; Loop

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

 
				;; Copy ($0b-12) back
L332b:
;				ldx			#$07										; Should be 6
				ldx			#$06
L332d:
				lda			$0b, x
				sta			$96, x
				dex
				bpl			L332d										; Loop

				bit			STATUS
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
				jsr			L23cf										; Set AUDIO1 bits 
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


				;; Attract mode text
ATTRACT:
				lda			START
				beq			L3383										; No valid start 

				rts
				
L3383:
				lda			#$ee
				sta			MOBLAT									; Sprite latch
				sta			SPRVAL
				jsr			L246d										; Update MOBLAT (redundant)
				lda			#$10
				sta			VAUD1
				sta			AUDIO1
				lda			#$00
				sta			STATUS									; Clear status

				jsr			L2340										; Clear screen

				;; Draw coinage
L18ba:
				bit			DSW											; DIPs
				bmi			COINQ										; (Quarters) 

				;; Free play
				lda			#$17										; FREE PLAY
				jsr			DRAWSTRA
				beq			COINEND									; (Always)

COINQ:
L18c6:
L2b7c:
				lda			DSW											; DIPs
				and			#$18										; Mask coinage
				beq			COINEND									; Non-display 1C_1P setting

L2b8d:
				clc
				lsr			a												; {$08,$10,$18} -> ($04,$08,$0c)
				lsr			a												; {$08,$10,$18} -> ($02,$04,$06)
				adc			#$0b										; {$08,$10,$18} -> {$0d,$0f,$11}
				pha															; Stash value
				and			#$fe										; Clear LSB 
				jsr			DRAWSTRA								; Draw string

				pla															; Restore
				cmp			#$11										; (clears carry) 
				beq			COINEND									; Only line for 1C_2P 
				
				jsr			DRAWSTRA								; Draw string

COINEND:
L18c9:
				jsr			L18e2										; Draw HI SCR 

L18f9:
				lda			STATUS
				ora			#$10										; Set bit 5 -- why?
				sta			STATUS

				lda			#$08										; TARG 
				jsr			DRAWSTRA								; Draw string (and return)
				
				lda			#$15										; COPYRIGHT 
				jsr			DRAWSTRA								; Draw string (ann return)
				
				lda			#$0b										; 10 POINTS 
				jsr			DRAWSTRA								; Draw string (and return)

				lda			#$00										; "TOP HIGH SCORE..."
				jsr			DRAWSTRA								; Draw string

				jsr			L2a3b										; Draw player scores
				
				lda			#$13										; 20 x 1/2 second total
				sta			DELH										; Outer Loop counter

L33a2:
				jsr			L2bea										; Draw CREDITS_##
				jsr			L2b4f										; Draw DEPOSIT_COIN

				lda			#$1e										; 1/2 second
				sta			TIMERA									; IRQ frame count down
				 
L33ab:
				lda			START										; Credits
				bne			ATTEND									; Credits -- check starts
				nop

				;; No valid start
				lda			TIMERA									; IRQ frame count down
				bne			L33ab 									; Inner loop

				dec			DELH
				bne			L33a2										; Outer Loop

ATTEND:
				rts


				;; Fake gameplay loop
FAKEGAME:
				lda			START
				beq			L33b8										; No valid start 

				rts
				
L33b8:
;				jsr			L1e32										; Set up fake gameplay 
L1e32:
				lda			#$01
				sta			$29
				sta			$28
				lda			#$0b
				sta			$2f
				lda			#$0a
				sta			ARROWS
				jsr			L197b										; ?? 
				jsr			L2a3b										; Draw player scores
				jsr			L18e2										; Draw HI SCR 
				lda			#$02
				sta			$20
				sta			$21
				lda			#$00
				sta			STATUS									; Clear status 

				lda			#$0d 
				sta			DELH										; Outer loop timer 

L33bf:
				jsr			L2c99
				jsr			L3307
				jsr			L346e										; Inputs for fake gameplay 
				jsr			L2088
				jsr			L20ae
				jsr			L1ab8
				jsr			L202f
				jsr			L2e76
				jsr			L2e11

				lda			START
				bne			FGEND										; Leave on credits 

				lda			$30
				and			#$02										; Check D1 
				bne			FGEND										; Leave on crash 
				
				dec			$3f											; Inner loop counter 
				bne			L33bf										; Loop

				dec			DELH										; Outer loop counter 
				bne			L33bf										; Loop

				;; Fake gameplay timeout
FGEND:
				rts


				;; Configure start game
CFGGAME:
L343e:
				lda			START
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
				sta			STATUS									; Status
				ldy			#$16
				lda			NUMP
				cmp			#$02
				beq			L3465
				nop

				ldy			#$12
L3465:
				jsr			L1b13
				jsr			L2421
				rts


				;; Inputs for fake gameplay
L346e:
				lda			$3f											; ??
				and			#$1f										; Mask low 5 bits 
				cmp			#$0f
				bne			L3481
				nop

				jsr			L23a4										; Kick PRNG
				sta			$00											; Store PRNG
				and			#$49										; 0100_1001
				bne			L3486
				nop

L3481:
				lda			#$00										; Clear inputs
				sta			CURIN0
				rts

L3486:
				lda			$00
				and			#$03										; Mask low bits
				tax
				lda			L1fe8, x								; Get fake move
				sta			CURIN0									; Store 

				;; Fake fire?
				lda			$00
				and			#$10
				ora			CURIN0									; May set bit 4
				sta			CURIN0									; 04 08 20 40 / 14 1
				and			#$ef										; D0 never set anyway?
				sta			OLDIN0									; Store
				rts


				.org		$3800
				.include "targ_char.asm"

				.org		$3f00
				;; Patch for end of L1ab8

				;; Vectors
				.org		$3ff8
				.dw			LRESET									; ???   vector
				.dw			LRESET									; BRK   vector
				.dw			LRESET									; Reset vector
				.dw			LIRQ										; IRQ   vector

				.end
