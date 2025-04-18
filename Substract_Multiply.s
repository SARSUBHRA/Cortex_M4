.syntax unified
.thumb

.global main
main:

    // --- SUB ---
    MOV     R0, #20
    MOV     R1, #5
    SUB     R2, R0, R1        // R2 = 20 - 5 = 15
    LDR     R3, =15
    CMP     R2, R3
    BNE     fail

    // --- SBC (Subtract with Carry) ---
    MOV     R4, #10
    MOV     R5, #3
    ADDS    R4, R4, #0        // Ensure carry flag is set
    SBC     R6, R4, R5        // R6 = 10 - 3 -1 = 6
    LDR     R3, =6
    CMP     R6, R3
    BNE     fail

    // --- RSB (Reverse Subtract) ---
    MOV     R7, #4
    RSB     R8, R7, #10       // R8 = 10 - 4 = 6
    LDR     R3, =6
    CMP     R8, R3
    BNE     fail

    // --- MUL ---
    MOV     R9, #6
    MOV     R10, #7
    MUL     R11, R9, R10      // R11 = 6 * 7 = 42
    LDR     R3, =42
    CMP     R11, R3
    BNE     fail

    // --- Success ---
    MOV     R0, #1
    B       done

fail:
    MOV     R0, #0xFF         // Set fail flag

done:
    B       done              // Infinite loop to end execution
