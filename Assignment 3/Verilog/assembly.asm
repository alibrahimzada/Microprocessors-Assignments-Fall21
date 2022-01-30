.data
.code
            ldi 6 0x0000
            ldi 7 0x0700
            ldi 0 0x0002
main_loop   ldi 2 0x6001
            ld 2 2
            ldi 4 0x0001
            and 4 4 2
            jz check_kp
            ldi 1 0x6000
            ld 1 1
            jmp store
check_kp    ldi 2 0x0901
            ld 2 2
            ldi 4 0x0001
            and 4 4 2
            jz main_loop
            ldi 1 0x0900
            ld 1 1
            ldi 4 0x000e
            sub 4 4 1
            jz ch_act
            ldi 4 0x000a
            sub 4 4 1
            jz reset
            ldi 4 0x0009
            mov 2 3
twodig      add 3 3 2
            dec 4
            jz done
            jmp twodig
done        add 3 3 1
            mov 1 3
store       call to_dec
            jmp main_loop
do_add      call addit
            jmp store
ch_act      ldi 5 0x0002
            sub 5 5 0
            jz begin0
            ldi 5 0x0001
            sub 5 5 0
            jz begin1
begin0      dec 0
            call addit
            ldi 1 0x0000
            jmp store
begin1      inc 0
            jmp do_add
addit       add 6 6 3
            mov 1 6
            ldi 3 0x0000
            ret
to_dec      push 0
            ldi 4 0x0010
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
display     ldi 5 0x0b00
            st 5 2
            pop 0
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
reset       ldi 3 0x0000
            ldi 6 0x0000
            mov 1 6
            jmp store
