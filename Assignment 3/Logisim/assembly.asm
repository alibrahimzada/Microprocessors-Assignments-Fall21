.data
.code
            ldi 5 0x0000
            ldi 7 0x2000
            ldi 3 0x07f0
            ldi 0 isr
            st 3 0
            sti
main_loop   ldi 3 0x6002
            ld 3 3
            ldi 0 0x0001
            and 0 0 3
            jz main_loop
            ldi 1 0x6000
            ld 1 1
            ldi 2 0x6001
            ld 2 2
            call addit
            call to_dec
            ldi 1 0x6004
            st 1 2
            jmp main_loop
addit       add 5 5 1
            add 5 5 2
            ret
to_dec      mov 1 5
            ldi 5 0x0010
            ldi 2 0x0000
alt_loop    ldi 0 0x000f
            and 0 0 2
            ldi 3 0x0004
            sub 0 3 0
            ldi 3 0x8000
            and 0 0 3
            jz check2
            jmp add3_1
check2      ldi 0 0x00f0
            and 0 0 2
            ldi 3 0x0040
            sub 0 3 0
            ldi 3 0x8000
            and 0 0 3
            jz check3
            jmp add3_2
check3      ldi 0 0x0f00
            and 0 0 2
            ldi 3 0x0400
            sub 0 3 0
            ldi 3 0x8000
            and 0 0 3
            jz check4
            jmp add3_3
check4      ldi 0 0xf000
            and 0 0 2
            ldi 3 0x4000
            sub 0 3 0
            ldi 3 0x8000
            and 0 0 3
            jz phase2
            jmp add3_4
phase2      add 2 2 2
            ldi 3 0x8000
            and 0 1 3
            jz msb0
            ldi 3 0x0001
            add 2 2 3
msb0        add 1 1 1
            dec 5
            jz done
            jmp alt_loop
done        ret
add3_1      ldi 3 0x0003
            add 2 2 3
            jmp check2
add3_2      ldi 3 0x0030
            add 2 2 3
            jmp check3
add3_3      ldi 3 0x0300
            add 2 2 3
            jmp check4
add3_4      ldi 3 0x3000
            add 2 2 3
            jmp phase2
isr         push 0
            push 1
            push 2
            push 3
            push 5
            ldi 0 0x0001
            add 5 4 0
            mov 4 5
            call to_dec
            ldi 1 0x6003
            st 1 2
            pop 5
            pop 3
            pop 2
            pop 1
            pop 0
            iret
