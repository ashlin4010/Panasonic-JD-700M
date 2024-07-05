.org $0000


RESET:
    MVI A, $00      ; Worst case scenario reset
    OUT $51        ; Mode Instruction
    OUT $51         ; Sync character
    OUT $51         ; Sync character

    MVI A, $40        ; Reset command
    OUT $51

SETUP:
    MVI A, $04E     ; 1 stop bit
    OUT $051        ; Odd parity
                    ; Disable parity
    MVI A, $33      ; Character length 8 bits
    OUT $51         ; Baud Factor x16

OUTPUT_H:
    IN $51          ; read status
    ANI $01         ; AND status (all but the LSB will become zero)
    JZ OUTPUT_H     ; If TxRDY is zero read status once more
    MVI A, 'H'      ; H
    OUT $50

OUTPUT_E:
    IN $51          ; read status
    ANI $01         ; AND status (all but the LSB will become zero)
    JZ OUTPUT_E     ; If TxRDY is zero read status once more
    MVI A, 'E'      ; E
    OUT $50

OUTPUT_L:
    IN $51          ; read status
    ANI $01         ; AND status (all but the LSB will become zero)
    JZ OUTPUT_L     ; If TxRDY is zero read status once more
    MVI A, 'L'      ; L
    OUT $50

OUTPUT_LL:
    IN $51          ; read status
    ANI $01         ; AND status (all but the LSB will become zero)
    JZ OUTPUT_LL    ; If TxRDY is zero read status once more
    MVI A, 'L'      ; L
    OUT $50


OUTPUT_O:
    IN $51          ; read status
    ANI $01         ; AND status (all but the LSB will become zero)
    JZ OUTPUT_O     ; If TxRDY is zero read status once more
    MVI a, 'O'      ; O
    OUT $50

OUTPUT__:
    IN $51          ; read status
    ANI $01         ; AND status (all but the LSB will become zero)
    JZ OUTPUT__     ; If TxRDY is zero read status once more
    MVI A, ' '      ; O
    OUT $50

jmp OUTPUT_H