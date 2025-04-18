.syntax unified
.thumb

.global main
main:

    // --- CMP: Compare R0 - R1 ---
    MOV     R0, #5
    MOV     R1, #5
    CMP     R0, R1            // Expect Zero flag (Z=1), because 5 - 5 = 0
    BNE     fail              // If not equal, fail

    // --- CMN: Compare Negative (R2 + R3) ---
    MOV     R2, #0x7FFFFFFF
    MOV     R3, #1
    CMN     R2, R3            // Expect overflow (V=1), R2 + R3 = 0x80000000 (signed overflow)
    BVC     fail              // If V (overflow) not set, fail

    // --- TST: Bitwise AND test ---
    MOV     R4, #0b10101010
    MOV     R5, #0b00001000
    TST     R4, R5            // Should not set zero (0b1000 is set in R4)
    BEQ     fail              // If result is 0, then fail

    // --- All Passed ---
    MOV     R6, #1
    B       done

fail:
    MOV     R6, #0xFF         // Failure flag

done:
    B       done              // Infinite loop to hold result
