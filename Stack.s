.syntax unified
.thumb

.global main
.type main, %function

main:
    MOV     R0, #0              // R0 = test pass counter

    // --- Test PUSH & POP ---
    MOV     R1, #0x11111111
    MOV     R2, #0x22222222
    PUSH    {R1, R2}            // Store R1 and R2

    // Clear values to check if POP works
    MOV     R1, #0
    MOV     R2, #0
    POP     {R1, R2}            // Restore R1 and R2

    LDR     R3, =0x11111111
    CMP     R1, R3
    BNE     fail
    LDR     R3, =0x22222222
    CMP     R2, R3
    BNE     fail

    ADD     R0, R0, #1          // PUSH/POP passed

    // --- Test STMIA & LDMIA ---
    LDR     R4, =0x44444444
    LDR     R5, =0x55555555

    LDR     R6, =test_buffer    // Base address
    STMIA   R6!, {R4, R5}       // Store R4 and R5 to memory

    // Clear values
    MOV     R4, #0
    MOV     R5, #0

    LDR     R6, =test_buffer
    LDMIA   R6!, {R4, R5}       // Load R4 and R5 from memory

    LDR     R7, =0x44444444
    CMP     R4, R7
    BNE     fail
    LDR     R7, =0x55555555
    CMP     R5, R7
    BNE     fail

    ADD     R0, R0, #1          // STMIA/LDMIA passed

    // Final success check (2 tests)
    MOV     R1, #2
    CMP     R0, R1
    BNE     fail

    MOV     R0, #1              // All tests passed
    B       done

fail:
    MOV     R0, #0xFF           // Failure

done:
    B       done                // Infinite loop

// --- Memory buffer for STMIA/LDMIA ---
.data
.align 4
test_buffer:
    .word 0, 0
