.org $0000


RESET:
    MVI A, $00      ; Worst case scenario reset
    OUT $51         ; Mode Instruction
    OUT $51         ; Sync character
    OUT $51         ; Sync character

    MVI A, $40      ; Reset command
    OUT $51


SETUP:
    MVI A, $04E     ; 1 stop bit
    OUT $051        ; Odd parity
                    ; Disable parity
    MVI A, $33      ; Character length 8 bits
    OUT $51         ; Baud Factor x16


    LXI H, $0000    ; Initialize memory pointer
TEST:
    MVI M, $00      ; Writing ’1′ into RAM
    MOV A, M        ; Reading data from RAM
    CPI $AA         ; Compare Accumulator to '1' for ERROR

    ;; Send memory data as string
    MOV C, M        ; Get value from mem, save in C
    JMP PRINT       ; send data out serial port


CON:
    INX H           ; Increment memory pointer
    MOV A, H
    CPI $FF         ; Check for last memory address
    JNZ TEST        ; If not last, repeat
    HLT             ; Stop




PRINT:
    MOV A, C
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_1:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_1     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")


;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_2:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_2     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")


;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_3:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_3     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")

    ;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_4:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_4     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")

    ;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_5:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_5     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")

    ;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_6:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_6     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")

    ;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_7:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_7     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")

    ;;*********************************************************************************
    MOV A, C
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    RRC             ; Right shift
    ANI $01         ; Discard all but bit 0
    ORI $30         ; OR with "0" (add with out any carry)
    MOV E, A        ; Backup char

    ;; send
SNED_8:
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ SNED_8     ; If TxRDY is zero read status once more
    MOV A, E
    OUT $50    ; Data is still in A ("1" or "0")



L_FEED:
    ;; send line feed
    IN $51      ; read status
    ANI $1      ; AND status (all but the LSB will become zero)
    JZ L_FEED   ; If TxRDY is zero read status once more
    MVI a, $20 ; Send Line feed
    OUT $50    ; Send Data

    jmp CON     ; return to mem test