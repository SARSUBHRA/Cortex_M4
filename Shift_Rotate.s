.syntax unified
.thumb

.global main
main:

    // --- LSL: Logical Shift Left ---
    MOV     R0, #0x01
    LSL     R1, R0, #3         // R1 = 0x01 << 3 = 0x08
    LDR     R2, =0x08
    CMP     R1, R2
    BNE     fail

    // --- ASR: Arithmetic Shift Right ---
    LDR     R0, =0xF0000000    // A negative value (signed)
    ASR     R1, R0, #4         // Arithmetic shift: preserves sign = 0xFF000000
    LDR     R2, =0xFF000000
    CMP     R1, R2
    BNE     fail

    // --- ROR: Rotate Right ---
    LDR     R0, =0x80000001
    ROR     R1, R0, #1         // R1 = 0xC0000000
    LDR     R2, =0xC0000000
    CMP     R1, R2
    BNE     fail

    // --- RRX: Rotate Right with Carry ---
    // Set carry flag first by adding a value that causes a carry
    MOV     R0, #0xFFFFFFFF
    ADDS    R0, R0, #1         // Carry set
    LDR     R3, =0x80000000
    MOV     R1, #0x00000000
    RRX     R2, R3             // R2 = 0xC0000000 (carry in shifted to MSB)
    LDR     R4, =0xC0000000
    CMP     R2, R4
    BNE     fail

    // --- All Passed ---
    MOV     R5, #1
    B       done

fail:
    MOV     R5, #0xFF          // Failure flag

done:
    B       done               // Loop forever
