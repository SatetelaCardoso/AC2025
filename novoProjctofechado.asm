;********************************
linhaG EQU 3840H
colunaG EQU 38A4H
linhacomida1 EQU 3200H ;  12800
colunacomida1 EQU 3264H; 12900
linhacomida2  EQU 32C8H ; 
colunacomida2 EQU 332CH ; 
linhacomida3  EQU 3390H ; 
colunacomida3 EQU 33F4H ; 
linhacomida4  EQU 3458H ; 
colunacomida4 EQU 34BCH ; 
linhacasa  EQU 3520H ; 
colunacasa EQU 3584H ; 
linhainimigo1  EQU 35E8H ; 
colunainimigo1 EQU 364CH ; 
linhainimigo2  EQU 36B0H ; 
colunainimigo2 EQU 3714H ; 
linhaartista  EQU 3778H ; 
colunaartista EQU 37DCH ; 
;*******************************
; **********************************************************************
BUFFER	EQU	4000H	
LINHA	EQU	8H	
PIN     EQU 0E000H
POUT    EQU 0C000H
; **********************************************************************
;-------------------------------------------------------
stackSize EQU 100H
pixelsMatriz  EQU 8000H
PLACE 3B7EH
pilha: TABLE stackSize
stackBase:
PLACE 3D7EH
ptable:STRING 01H,02H,04,08H,10H,20H,40H,80H
;-------------------------------------------------------

PLACE 0
main: MOV SP,stackBase
    CALL inicializacaoP

inicioPrincipal:
    call dComidas
    call dinimigo
    call desenhaPrd
    CALL art
    CALL parede
    CALL teclado

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,2H
    CMP R4,R5
    JZ subir

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,0AH
    CMP R4,R5
    JZ descer

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,7H
    CMP R4,R5
    JZ direita

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,5H
    CMP R4,R5
    JZ esquerda

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,3H
    CMP R4,R5
    JZ supdir

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,1H
    CMP R4,R5
    JZ supesq

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,0fH
    CMP R4,R5
    JZ infdir

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,0DH
    CMP R4,R5
    JZ infesq

JMP inicioPrincipal

    JMP fimtudo
    ;a funcao  dcomidas chama a funcao dComidaV e esta chama a funcao dcomidaH

subir:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
SUB R1,1H
MOV [R10],R1
JMP inicioPrincipal

descer:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
ADD R1,1H
MOV [R10],R1
JMP inicioPrincipal

direita:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
ADD R2,1H
MOV [R9],R2
JMP inicioPrincipal

esquerda:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
SUB R2,1H
MOV [R9],R2
JMP inicioPrincipal

supdir:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
SUB R1,1H
ADD R2,1H
MOV [R10],R1
MOV [R9],R2
JMP inicioPrincipal

supesq:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
SUB R1,1H
SUB R2,1H
MOV [R10],R1
MOV [R9],R2
JMP inicioPrincipal

infdir:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
ADD R1,1H
ADD R2,1H
MOV [R10],R1
MOV [R9],R2
JMP inicioPrincipal

infesq:
call limpatela
MOV R10,linhaartista;
MOV R9, colunaartista
MOV R1,[R10]
MOV R2,[R9]
ADD R1,1H
SUB R2,1H
MOV [R10],R1
MOV [R9],R2
JMP inicioPrincipal

dComidaV:
MOV R3, linhaG
MOV R1,[R3]
MOV R3, colunaG
MOV R2,[R3]
MOV R9,3H
MOV R10,1H
CALL pixel_xy
inicioDcomidaV:
SUB R1,1H
ADD R10,1H
CMP R9,R10
JN dcomidaH;
CALL pixel_xy
JMP inicioDcomidaV 

limpatela:
        MOV R1, 8000H
        MOV R2, 807FH
        MOV R0,0H
    limpatudo:
        MOVB [R1],R0
        ADD R1,1H
        CMP R2,R1
        JN retHelp
        JMP limpatudo
retHelp:
RET

dcomidaH:
SUB R2,1H
ADD R1,2H
MOV R9,3H
MOV R10,1H
CALL pixel_xy
inicioDcomidaH:
ADD R2,1H
ADD R10,1H
CMP R9,R10
JN fim
CALL pixel_xy
JMP inicioDcomidaH

desenhaPrd:
MOV R9 ,20H
MOV R10,1H
MOV R1, 0H
MOV R2,0H
inicDPrd:
CALL pixel_xy
ADD R2,1H
ADD R10,1H
CMP R9,R10
JN dshPrdV1
JMP inicDPrd
dshPrdV1:
MOV R9 ,20H
MOV R10,1H
MOV R2, 0H
MOV R1,1H
inicdshPrdV1:
CALL pixel_xy
ADD R1,1H
ADD R10,1H
CMP R9,R10
JN desenhaPrdV2
JMP inicdshPrdV1
desenhaPrdV2:
MOV R9 ,20H
MOV R10,1H
MOV R1, 0H
MOV R2,01FH
inicdshPrdV2:
CALL pixel_xy
ADD R1,1H
ADD R10,1H
CMP R9,R10
JN desenhaPrCh
JMP inicdshPrdV2;
desenhaPrCh:
MOV R9 ,20H
MOV R10,1H
MOV R1, 01FH
MOV R2,0H
inicdshPrCh:
CALL pixel_xy
ADD R2,1H
ADD R10,1H
CMP R9,R10
JN fim
JMP inicdshPrCh

fim:
RET;

pixel_xy: 
PUSH R4
PUSH R6
PUSH R7
PUSH R2
PUSH R5
PUSH R3
MOV R4,4
MOV R6,8
MOV R7,R2
MUL R4,R1
DIV R7,R6
ADD R4,R7
MOV R7, pixelsMatriz
ADD R4,R7
MOV R6,7H
CMP R2,R6
JLE bitpixel
MOV R6,0FH
CMP R2,R6
JLE bitpixel
MOV R6,17H
CMP R2,R6
JLE bitpixel
MOV R6 , 1FH
bitpixel:
SUB R6,R2
MOV R5,ptable
ADD R5,R6
MOVB R3,[R5]
MOVB R6,[R4]
OR R6,R3
MOVB [R4],R6
POP R3
POP R5
POP R2
POP R7
POP R6
POP R4
RET

inicializacaoP: 
    MOV R1, linhacomida1
    MOV R2, 3
    MOV [R1], R2
    MOV R1,colunacomida1
    MOV R2,3 
    MOV [R1],R2

    MOV R1, linhacomida2
    MOV R2, 3
    MOV [R1], R2
    MOV R1,colunacomida2
    MOV R2,1CH
    MOV [R1],R2

    MOV R1, linhacomida3
    MOV R2,1EH
    MOV [R1], R2
    MOV R1,colunacomida3
    MOV R2,1CH
    MOV [R1],R2

    MOV R1, linhacomida4
    MOV R2,1EH
    MOV [R1], R2
    MOV R1,colunacomida4
    MOV R2,3
    MOV [R1],R2


MOV R1, linhacasa
MOV R2,0DH
MOV [R1], R2
MOV R1,colunacasa
MOV R2,0FH
MOV [R1],R2

MOV R1, linhainimigo1
MOV R2, 8H
MOV [R1], R2  ;A linha e a coluna vao se unir no mesmo registo
MOV R1,colunainimigo1
MOV R2,15H
MOV [R1],R2

MOV R1, linhainimigo2
MOV R2, 10H
MOV [R1], R2
MOV R1,colunainimigo2
MOV R2,10H
MOV [R1],R2

MOV R1, linhaartista
MOV R2, 1AH
MOV [R1], R2
MOV R1,colunaartista
MOV R2,10H
MOV [R1],R2
RET

dComidas:
MOV R8,4
MOV R0,1       ;Agrupar a linha e a coluna no mesmo registo
MOV R4, linhaG
MOV R5, linhacomida1
MOV R6,[R5]
MOV [R4], R6
MOV R4, colunaG
MOV R5, colunacomida1
MOV R6,[R5]
MOV [R4], R6
CALL dComidaV     ;funcao que desenha a comida
MOV R4, linhaG
MOV R5, linhacomida2
MOV R6,[R5]
MOV [R4], R6
MOV R4, colunaG
MOV R5, colunacomida2
MOV R6,[R5]
MOV [R4], R6
CALL dComidaV
MOV R4, linhaG
MOV R5, linhacomida3
MOV R6,[R5]
MOV [R4], R6
MOV R4, colunaG
MOV R5, colunacomida3
MOV R6,[R5]
MOV [R4], R6
CALL dComidaV
MOV R4, linhaG
MOV R5, linhacomida4
MOV R6,[R5]
MOV [R4], R6
MOV R4, colunaG
MOV R5, colunacomida4
MOV R6,[R5]
MOV [R4], R6
CALL dComidaV
RET


dinimigo:
MOV R8,4
MOV R0,1       ;Agrupar a linha e a coluna no mesmo registo
MOV R4, linhaG
MOV R5, linhainimigo1 
MOV R6,[R5]
MOV [R4], R6
MOV R4, colunaG
MOV R5, colunainimigo1
MOV R6,[R5]
MOV [R4], R6
CALL inimigo
MOV R4, linhaG
MOV R5, linhainimigo2
MOV R6,[R5]
MOV [R4], R6
MOV R4, colunaG
MOV R5, colunainimigo2
MOV R6,[R5]
MOV [R4], R6
CALL inimigo
RET


inimigo:
MOV R3, linhaG
MOV R1,[R3]
MOV R3, colunaG
MOV R2,[R3]
CALL pixel_xy
ADD R2,2H
CALL pixel_xy
ADD R1,1H
SUB R2,1H
CALL pixel_xy
SUB R2,1H
ADD R1,1H
CALL pixel_xy
ADD R2,2H
CALL pixel_xy
JMP fim

art:     
    MOV R4, linhaG
    MOV R5, linhaartista
    MOV R6,[R5]
    MOV [R4], R6
    MOV R4, colunaG
    MOV R5, colunaartista
    MOV R6,[R5]
    MOV [R4], R6
    CALL dese
    RET

    dese:
    MOV R3, linhaG
    MOV R1,[R3]
    MOV R3, colunaG
    MOV R2,[R3]
    CALL pixel_xy
    SUB R2,1H
    CALL pixel_xy
    SUB R2,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    JMP fim

    parede:     
    MOV R4, linhaG
    MOV R5, linhacasa
    MOV R6,[R5]
    MOV [R4], R6
    MOV R4, colunaG
    MOV R5, colunacasa
    MOV R6,[R5]
    MOV [R4], R6
    CALL dparede
    RET

    dparede:
    MOV R3, linhaG
    MOV R1,[R3]
    MOV R3, colunaG
    MOV R2,[R3]
    CALL pixel_xy
    SUB R2,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R1,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    ADD R2,1H
    CALL pixel_xy
    SUB R1,1H
    CALL pixel_xy
    SUB R1,1H
    CALL pixel_xy
    SUB R1,1H
    CALL pixel_xy
    SUB R1,1H
    CALL pixel_xy
    SUB R1,1H
    CALL pixel_xy
    SUB R1,1H
    CALL pixel_xy
    SUB R2,1H
    CALL pixel_xy
    JMP fim



teclado:
   ;CALL movimentaOBJ
    PUSH R1
    PUSH R6
    PUSH R2
    PUSH R3
    PUSH R8
    PUSH R10
    PUSH R4

    inicio:
    MOV R5, BUFFER	; R5 com endere�o de mem�ria BUFFER
        MOV	R1, 1	; testar a linha 1
        MOV R6,PIN
        MOV	R2, POUT	; R2 com o endere�o do perif�rico
    ;corpo principal do programa
    ciclo:MOVB 	[R2], R1	; escrever no porto de sa�da
        MOVB 	R3, [R6]	; ler do porto de entrada
        AND 	R3, R3		; afectar as flags (MOVs n�o afectam as flags)
        JZ 	inicializarLinha		; nenhuma tecla premida
        MOV R8,1
        CMP R8,R1
        JZ linha1
        MOV R8,2
        CMP R8,R1
        JZ linha2
        MOV R8,4
        CMP R8,R1
        JZ linha3
        MOV R8,8
        CMP R8,R1
        JZ linha4
    linha4:
        linha4C1:MOV R8,1
        CMP R8,R3
        JZ EC
        JNZ linha4C2
        linha4C2:MOV R8,2
        CMP R8,R3
        JZ ED
        JNZ linha4C3
        linha4C3:MOV R8,4
        CMP R8,R3
        JZ EE
        JNZ linha4C4
        linha4C4:MOV R8,8
        CMP R8,R3
        JZ EF
    linha3:
        linha3C1:MOV R8,1
        CMP R8,R3
        JZ Eoito
        JNZ linha3C2
        linha3C2:MOV R8,2
        CMP R8,R3
        JZ Enove
        JNZ linha3C3
        linha3C3:MOV R8,4
        CMP R8,R3
        JZ EA
        JNZ linha3C4
        linha3C4:MOV R8,8
        CMP R8,R3
        JZ EB

    linha2:
        linha2C1:MOV R8,1
        CMP R8,R3
        JZ Equatro
        JNZ linha2C2
        linha2C2:MOV R8,2
        CMP R8,R3
        JZ Ecinco
        JNZ linha2C3
        linha2C3:MOV R8,4
        CMP R8,R3
        JZ Eseis
        JNZ linha2C4
        linha2C4:MOV R8,8
        CMP R8,R3
        JZ Esete


    linha1:
        linha1C1:MOV R8,1
        CMP R8,R3
        JZ Ezero
        JNZ linha1C2
        linha1C2:MOV R8,2
        CMP R8,R3
        JZ Eum
        JNZ linha1C3
        linha1C3:MOV R8,4
        CMP R8,R3
        JZ Edois
        JNZ linha1C4
        linha1C4:MOV R8,8
        CMP R8,R3
        JZ Etres

        Ezero:MOV R10,0H
        JMP armazena
        Eum:MOV R10,1H
        JMP armazena
        Edois:MOV R10,2H
        JMP armazena
        Etres:MOV R10,3H
        JMP armazena
        Equatro:MOV R10,4H
        JMP armazena
        Ecinco:MOV R10,5H
        JMP armazena
        Eseis:MOV R10,6H
        JMP armazena
        Esete:MOV R10,7H
        JMP armazena
        Eoito:MOV R10,8H
        JMP armazena
        Enove:MOV R10,9H

        JMP armazena
        EA:MOV R10,9H
        ADD R10,1H
        JMP armazena
        EB:MOV R10,9H
        ADD R10,2H
        JMP armazena
        EC:MOV R10,9H
        ADD R10,3H
        JMP armazena
        ED:MOV R10,9H
        ADD R10,4H
        JMP armazena
        EE:MOV R10,9H
        ADD R10,5H
        JMP armazena
        EF:MOV R10,9H
        ADD R10,6H
    armazena:
        MOV	R4, R10		; guardar tecla premida em registo
        MOVB 	[R5], R4	; guarda tecla premida em mem�ria
        JMP RETOR

    inicializarLinha:
        MOV R8,2
        MUL R1,R8
        MOV R8,8
        CMP R8,R1
        JN inicio
        JNN ciclo

RETOR:
    POP R4
    POP R10
    POP R8
    POP R3
    POP R2
    POP R6
    POP R1
    RET

fimtudo:
JMP fimtudo


