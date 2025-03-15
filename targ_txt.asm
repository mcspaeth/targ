
STR00:																					; L1e54
				.db			"BEAT HIGH SCORE FOR EXTRA PLAY", $00

STR01:																					; L1e72
				.db			"EXTRA POINTS",$00

STR02:																					; L1e7f
				.db			"EXTENDED PLAY FOR "x
				
STR0A:																					; L27e2
				.db			"PLAYER   ", $00

STR03:																					; L1e9b
				.db			"TOPPING HIGH SCORE ", $00

STR04:																					; L1eaf
				.db			"EXTRA CREDIT ", $00

STR05:																					; L1ebd
				.db			"FOR TOPPING HIGH SCORE", $00

STR06:																					; L1f3e
				.db			"HI SCR", $00

STR07:																					;	L27c7
				.db			"GAME  OVER", $00

STR08:																					; L27d3
STR1A:
				.db			"TARG", $00

STR09:																					; L27d8
				.db			"GET  READY", $00

STR0B:																					; L27ec
				.db			$01,"  10 POINTS", $00

STR0C:																					; L2f37
				.db			"1 PLAYER  1 COIN", $00				  ; Coinage 08 #1

STR0D:																					; L2f49
				.db			"2 PLAYERS  2 COINS", $00				; Coinage 08 #2

STR0E:																					; L2f5b
				.db			"1 PLAYER   2 COINS", $00				; Coinage 10 #1

STR0F:																					; L2f6d
				.db			"2 PLAYERS  4 COINS", $00				; Coiange 10 #2 

STR10:																					; L2f25
				.db			"2 PLAYERS   1 COIN", $00				; Coinage 18

STR11:																					; L2f7f
STR1E:																					; HS Screen
				.db			"INSERT  COIN", $00

STR12:																					;	L2f8c
STR1F:
				.db			"OR", $00

STR13:																					; L2f9b
				.db			"NEXT LEVEL", $00

STR14:																					; L2fa1
				.db			"CREDITS", $00

STR15:																					; L2fc8
				.db			"COPYRIGHT ?1980 BY EXIDY INC", $00

STR16:																					; Normal 
STR17:																					; Top of screen
				.db			" FREE  PLAY ", $00

STR18:																					; Normal 
STR26:																					; HS Screen 
				.db			"            ", $00

STR19:																					; Normal 
STR25:																					; HS Screen
				.db			"PRESS  START", $00

STR1B:
				.db			"ALL TIME HIGH SCORES",$00

STR1C:
				.db			"RANK   SCORE  NAME",$00

STR1D:
				.db			"GREAT SCORE",$00
				
STR20:
				.db			"1ST",$00

STR21:
				.db			"2ND",$00

STR22:
				.db			"3RD",$00

STR23:
				.db			"4TH",$00

STR24:
				.db			"5TH",$00


TXTTBL:
				.dw			STR00
				.dw			STR01
				.dw			STR02
				.dw			STR03
				.dw			STR04
				.dw			STR05
				.dw			STR06
				.dw			STR07
				.dw			STR08
				.dw			STR09
				.dw			STR0A
				.dw			STR0B
				.dw			STR0C
				.dw			STR0D
				.dw			STR0E
				.dw			STR0F
				.dw			STR10
				.dw			STR11
				.dw			STR12
				.dw			STR13
				.dw			STR14
				.dw			STR15
				.dw			STR16
				.dw			STR17
				.dw			STR18
				.dw			STR19
				.dw			STR1A
				.dw			STR1B
				.dw			STR1C
				.dw			STR1D
				.dw			STR1E
				.dw			STR1F
				.dw			STR20
				.dw			STR21
				.dw			STR22
				.dw			STR23
				.dw			STR24
				.dw			STR25
				.dw			STR26

				;; Screen locations
TXTLOC:
				.dw			$40c1														; STR00
				.dw			$414a														; STR01
				.dw			$4204														; STR02  
				.dw			$422c														; STR03
				.dw			$420b														; STR04 
				.dw			$4238														; STR05 
				.dw			$402a														; STR06
				.dw			$420b														; STR07 
				.dw			$430e														; STR08
				.dw			$420b														; STR09
				.dw			$424c														; STR0A
				.dw			$428a														; STR0B
				.dw			$4148														; STR0C 
				.dw			$4187														; STR0D 
				.dw			$4147														; STR0E 
				.dw			$4187														; STR0F 
				.dw			$4147														; STR10 
				.dw			$41ea														; STR11
				.dw			$420f														; STR12
				.dw			$420b														; STR13
				.dw			$400b														; STR14
				.dw			$4382 													; STR15
				.dw			$400a														; STR16
				.dw			$416a														; STR17
				.dw			$422a														; STR18
				.dw			$422a														; STR19
				.dw			$406e														; STR1A
				.dw			$40c6														; STR1B
				.dw			$4107														; STR1C
				.dw			$4000														; STR1D
				.dw			$42ea														; STR1E
				.dw			$430f														; STR1F
				.dw			$4167														; STR20
				.dw			$41a7														; STR21
				.dw			$41e7														; STR22
				.dw			$4227														; STR23
				.dw			$4267														; STR24
				.dw			$432a														; STR25
				.dw			$432a														; STR26
				
.if 0
				;; Remove unused text
STRxx:																					; L2fa9
				.db			"TOP THIS SCORE FOR EXTRA BONUS", $00

STRXX:																					; L1ed4
				.db			"1 GAME  ONE 10 PENCE COIN ", $00

STRXX:																					; L1eef
				.db			"6 GAMES ONE 50 PENCE COIN", $00

STRXX:																					; L1f09
				.db			"1 GAME  TWO 10 PENCE COINS", $00

STRXX:																					; L1f24
				.db			"3 GAMES ONE 50 PENCE COIN", $00
.endif