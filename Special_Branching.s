.syntax unified
.thumb
.thumb_func
.global main

main:
    MOV     R5, #0          // Clear result register

    // --- Test BX ---
    LDR     R0, =target_bx
    BX      R0
after_bx:

    // --- Test BLX ---
    LDR     R1, =target_blx
    BLX     R1
after_blx:

    // Copy final result for easy inspection
    MOV     R0, R5
    B       done

// === BX target ===
target_bx:
    ORR     R5, R5, #0x01   // Set bit 0 (BX passed)
    B       after_bx        // Manually return

// === BLX target ===
target_blx:
    ORR     R5, R5, #0x02   // Set bit 1 (BLX passed)
    BX      LR              // Return from BLX

done:
    B       done            // Infinite loop
