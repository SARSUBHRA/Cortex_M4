.syntax unified
.thumb
.thumb_func
.global main

main:
    MOV     R0, #0        // Initialize R0 to 0, used for CBZ and CBNZ checks

    // --- CBZ: Compare and Branch if Zero ---
    MOV     R1, #0        // Set R1 to 0
    CBZ     R1, label_cbz // Branch if R1 is zero
    B       fail          // Should not branch here if CBZ works
label_cbz:
    ADD     R0, R0, #1    // Increment R0 if CBZ worked correctly

    // --- CBNZ: Compare and Branch if Non-Zero ---
    MOV     R1, #5        // Set R1 to non-zero value
    CBNZ    R1, label_cbnz // Branch if R1 is non-zero
    B       fail          // Should not branch here if CBNZ works
label_cbnz:
    ADD     R0, R0, #1    // Increment R0 if CBNZ worked correctly

    // --- IT: Conditional Execution ---
    MOVS    R2, #1        // Set R2 to 1
    CMP     R2, #1        // Compare R2 to 1
    IT      EQ            // If Equal, execute following instruction
    ADDEQ   R0, R0, #1    // Increment R0 if R2 == 1

    // --- Final check ---
    MOV     R3, #3        // We expect R0 to be 3 if all tests passed
    CMP     R0, R3
    BEQ     pass          // If passed, branch to pass label

fail:
    MOV     R0, #0xFF     // Failure code
    B       done

pass:
    MOV     R0, #1        // Success code

done:
    B       done          // Infinite loop
