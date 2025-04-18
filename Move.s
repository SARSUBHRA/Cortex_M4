.syntax unified
.thumb

.global main
main:
    // MOV test (immediate)
    MOV     R0, #0x12        // R0 = 0x00000012

    // MOVW test (write lower 16 bits)
    MOVW    R1, #0x5678      // R1 = 0x00005678

    // MOVT test (write upper 16 bits)
    MOVT    R1, #0x1234      // R1 = 0x12345678

    // MOV with register
    MOV     R2, R1           // R2 = 0x12345678

    LDR     R4, =0x12345678   // Load full 32-bit constant into R4
    CMP     R2, R4            // Now compare R2 with R4

    // Optionally, branch based on result
    BEQ     success
    B       fail

success:
    // Set a known value to indicate success
    MOV     R3, #0x01
    B       done

fail:
    MOV     R3, #0xFF

done:
    B       done
