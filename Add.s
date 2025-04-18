.syntax unified
.thumb

.global main
main:

    // ---- ADD Test ----
    MOV     R0, #0x10        // R0 = 0x10
    MOV     R1, #0x20        // R1 = 0x20
    ADD     R2, R0, R1       // R2 = 0x10 + 0x20 = 0x30

    // Optional check
    LDR     R3, =0x30
    CMP     R2, R3
    BNE     fail             // Branch to fail if mismatch

    // ---- ADC Test ----
    MOV     R4, #0x01        // R4 = 1
    MOV     R5, #0x01        // R5 = 1

    ADDS    R4, R4, R5       // R4 = 1 + 1 = 2, and resets carry flag
    ADC     R6, R5, #0       // R6 = R5 + carry = 1 + 0 = 1

    LDR     R3, =0x01
    CMP     R6, R3
    BNE     fail

    // ---- ADR Test ----
    // ADR gets the address of a label
    ADR     R7, here         // R7 = address of 'here'

here:
    NOP                     // Just a placeholder
    CMP     R7, #0          // Optional: verify it points somewhere non-zero
    BEQ     fail

    // Indicate success
    MOV     R3, #0x01
    B       done

fail:
    MOV     R3, #0xFF

done:
    B       done
