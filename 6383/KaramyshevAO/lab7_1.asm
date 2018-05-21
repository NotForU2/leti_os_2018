CODE      SEGMENT
          ASSUME         CS:CODE, DS:NOTHING, SS:NOTHING, ES:NOTHING

OVERLAY   PROC      FAR
          push      AX
          push      DI
          push      DS
          mov       AX,CS
          mov       DS,AX
          mov       DI,OFFSET ADDRESS + 30
          call      WORD_TO_HEX
          call      PRINT
          pop       DS
          pop       DI
          pop       AX
          RETF   
OVERLAY   ENDP

PRINT   PROC      NEAR
          push      AX
          push      DX
          mov       DX,OFFSET ADDRESS
          mov       AH,09H
          int       21H
          pop       DX
          pop       AX
          ret
PRINT   ENDP

TETR_TO_HEX  PROC      NEAR
          and       AL,0FH
          cmp       AL,09
          JBE       NEXT
          add       AL,07
NEXT:     add       AL,30H
          ret
TETR_TO_HEX  ENDP

BYTE_TO_HEX  PROC      NEAR
          push      CX
          mov       AH,AL
          call      TETR_TO_HEX
          XCHG      AL,AH
          mov       CL,4
          shr       AL,CL
          call      TETR_TO_HEX     
          pop       CX             
          ret
BYTE_TO_HEX  ENDP

WORD_TO_HEX  PROC      NEAR
          push      BX
          mov       BH,AH
          call      BYTE_TO_HEX
          mov       [DI],AH
          dec       DI
          mov       [DI],AL
          dec       DI
          mov       AL,BH
          call      BYTE_TO_HEX
          mov       [DI],AH
          dec       DI
          mov       [DI],AL
          pop       BX
          ret
WORD_TO_HEX  ENDP

ADDRESS  DB        'Сегментный адресс Оверлея1:    H',0DH,0AH,'$'
CODE      ENDS
          END       OVERLAY
