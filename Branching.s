.syntax unified
.thumb
.thumb_func
.global main

main:
    MOV     R5, #0          // Clear result register

    // --- Test B ---
    B       test_b
after_b:

    // --- Test BL ---
    BL      test_bl
after_bl:

    // Copy final result to R0 for easy inspection
    MOV     R0, R5
    B       done

// === Target for B ===
test_b:
    ORR     R5, R5, #0x01   // Set bit 0 (B passed)
    B       after_b

// === Target for BL ===
test_bl:
    ORR     R5, R5, #0x02   // Set bit 1 (BL passed)
    BX      LR

done:
    B       done            // Infinite loop
