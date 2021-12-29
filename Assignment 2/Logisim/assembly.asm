.data
.code
            ldi 6 0x0000
            ldi 7 0x0700
main_loop   ldi 1 0x6000
            ld 1 1
            ldi 2 0x6001
            ld 2 2
check_1     ldi 3 0x6002
            ld 3 3
            ldi 4 0x0001
            and 4 4 3
            jz check_2
            call addit
            call to_dec
            jmp main_loop
check_2     ldi 3 0x6003
            ld 3 3
            ldi 4 0x0001
            and 4 4 3
            jz main_loop
            call mult
            call to_dec
            jmp main_loop
addit       add 6 6 6
            add 6 6 1
            ret
mult        mov 5 2
            mov 3 6
            ldi 4 0x0000
            or 4 5 4
            jz mult_zero
            jmp mult_cond
mult_loop   add 6 6 3
mult_cond   dec 5
            jz mult_ret
            jmp mult_loop
mult_zero   ldi 6 0x0000
mult_ret    ret
to_dec      ldi 4 0x0010
            mov 1 6
            ldi 2 0x0000
alt_loop    ldi 0 0x000f
            and 0 0 2
            ldi 5 0x0004
            sub 0 5 0
            ldi 5 0x8000
            and 0 0 5
            jz check2
            jmp add3_1
check2      ldi 0 0x00f0
            and 0 0 2
            ldi 5 0x0040
            sub 0 5 0
            ldi 5 0x8000
            and 0 0 5
            jz check3
            jmp add3_2
check3      ldi 0 0x0f00
            and 0 0 2
            ldi 5 0x0400
            sub 0 5 0
            ldi 5 0x8000
            and 0 0 5
            jz check4
            jmp add3_3
check4      ldi 0 0xf000
            and 0 0 2
            ldi 5 0x4000
            sub 0 5 0
            ldi 5 0x8000
            and 0 0 5
            jz phase2
            jmp add3_4
phase2      add 2 2 2
            ldi 5 0x8000
            and 0 1 5
            jz msb0
            ldi 5 0x0001
            add 2 2 5
msb0        add 1 1 1
            dec 4
            jz display
            jmp alt_loop
display     ldi 1 0x6004
            st 1 2
            ret
add3_1      ldi 5 0x0003
            add 2 2 5
            jmp check2
add3_2      ldi 5 0x0030
            add 2 2 5
            jmp check3
add3_3      ldi 5 0x0300
            add 2 2 5
            jmp check4
add3_4      ldi 5 0x3000
            add 2 2 5
            jmp phase2
