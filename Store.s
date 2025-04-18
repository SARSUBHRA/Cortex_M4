.syntax unified
.thumb

.global main
main:

    // --- Initialize test value ---
    LDR     R0, =0x12345678   // Value to store
    LDR     R1, =test_addr    // Address to store to

    // --- STR: Store R0 into memory at test_addr ---
    STR     R0, [R1]

    // --- LDR: Load from memory at test_addr into R2 ---
    LDR     R2, [R1]

    // --- Compare loaded value with original ---
    CMP     R0, R2
    BNE     fail

    // --- Success ---
    MOV     R3, #1
    B       done

fail:
    MOV     R3, #0xFF         // Indicate failure

done:
    B       done              // Infinite loop

// --- Memory location for STR/LDR test ---
    .data
    .align 4
test_addr:
    .word 0
