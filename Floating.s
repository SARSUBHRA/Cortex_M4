.syntax unified
.thumb
.fpu fpv4-sp-d16
.thumb_func

.global main
.type main, %function

main:
    MOV     R0, #0            // Success counter

    // --- Test VMOV ---
    VMOV.F32 S0, #1.0         // Immediate move to S0
    VMOV     R1, S0           // Move S0 to R1
    LDR     R2, =0x3F800000   // IEEE-754 for 1.0
    CMP     R1, R2
    BNE     fail
    ADD     R0, R0, #1

    // --- VADD.F32: 1.5 + 2.5 = 4.0 ---
    LDR     R1, =flt_1_5
    VLDR    S1, [R1]
    LDR     R2, =flt_2_5
    VLDR    S2, [R2]
    VADD.F32 S3, S1, S2
    LDR     R3, =flt_4_0
    VLDR    S4, [R3]
    VCMP.F32 S3, S4
    VMRS    APSR_nzcv, FPSCR
    BNE     fail
    ADD     R0, R0, #1

    // --- VSUB.F32: 5.5 - 1.5 = 4.0 ---
    LDR     R1, =flt_5_5
    VLDR    S1, [R1]
    LDR     R2, =flt_1_5
    VLDR    S2, [R2]
    VSUB.F32 S3, S1, S2
    LDR     R3, =flt_4_0
    VLDR    S4, [R3]
    VCMP.F32 S3, S4
    VMRS    APSR_nzcv, FPSCR
    BNE     fail
    ADD     R0, R0, #1

    // --- VMUL.F32: 2.0 * 3.0 = 6.0 ---
    LDR     R1, =flt_2_0
    VLDR    S1, [R1]
    LDR     R2, =flt_3_0
    VLDR    S2, [R2]
    VMUL.F32 S3, S1, S2
    LDR     R3, =flt_6_0
    VLDR    S4, [R3]
    VCMP.F32 S3, S4
    VMRS    APSR_nzcv, FPSCR
    BNE     fail
    ADD     R0, R0, #1

    // --- VDIV.F32: 6.0 / 2.0 = 3.0 ---
    LDR     R1, =flt_6_0
    VLDR    S1, [R1]
    LDR     R2, =flt_2_0
    VLDR    S2, [R2]
    VDIV.F32 S3, S1, S2
    LDR     R3, =flt_3_0
    VLDR    S4, [R3]
    VCMP.F32 S3, S4
    VMRS    APSR_nzcv, FPSCR
    BNE     fail
    ADD     R0, R0, #1

    // --- VCMP.F32: 1.0 == 1.0 ---
    LDR     R1, =flt_1_0
    VLDR    S1, [R1]
    LDR     R2, =flt_1_0
    VLDR    S2, [R2]
    VCMP.F32 S1, S2
    VMRS    APSR_nzcv, FPSCR
    BNE     fail
    ADD     R0, R0, #1

    // --- Final check ---
    MOV     R1, #6
    CMP     R0, R1
    BNE     fail

    MOV     R0, #1            // All passed
    B       done

fail:
    MOV     R0, #0xFF         // Error flag

done:
    B       done              // Infinite loop

.data
.align 4
flt_1_0: .float 1.0
flt_1_5: .float 1.5
flt_2_0: .float 2.0
flt_2_5: .float 2.5
flt_3_0: .float 3.0
flt_4_0: .float 4.0
flt_5_5: .float 5.5
flt_6_0: .float 6.0
