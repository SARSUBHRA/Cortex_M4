.syntax unified
.thumb

.global main
main:

    // --- AND ---
    LDR     R0, =0x0F0F0F0F
    LDR     R1, =0x00FF00FF
    AND     R2, R0, R1        // R2 = 0x000F000F
    LDR     R3, =0x000F000F
    CMP     R2, R3
    BNE     fail

    // --- ORR ---
    ORR     R2, R0, R1        // R2 = 0x0FFF0FFF
    LDR     R3, =0x0FFF0FFF
    CMP     R2, R3
    BNE     fail

    // --- EOR ---
    EOR     R2, R0, R1        // R2 = 0x0FF00FF0
    LDR     R3, =0x0FF00FF0
    CMP     R2, R3
    BNE     fail

    // --- BIC ---
    BIC     R2, R0, R1        // R2 = R0 & (~R1) = 0x0F0F0F0F & ~0x00FF00FF = 0x0F000F00
    LDR     R3, =0x0F000F00
    CMP     R2, R3
    BNE     fail

    // --- MVN ---
    MVN     R4, R0            // R4 = NOT 0x0F0F0F0F = 0xF0F0F0F0
    LDR     R3, =0xF0F0F0F0
    CMP     R4, R3
    BNE     fail

    // --- All Passed ---
    MOV     R5, #1
    B       done

fail:
    MOV     R5, #0xFF         // Indicate failure

done:
    B       done              // Loop forever
