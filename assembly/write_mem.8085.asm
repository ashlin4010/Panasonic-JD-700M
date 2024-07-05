.org $0000

LOOP:
    LXI H, $7FFF    ; Initialize memory pointer
    MVI M, $00      ; Writing ’1′ into RAM
JMP LOOP