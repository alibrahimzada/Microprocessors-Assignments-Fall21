.data
.code
            ldi 0 0x0000
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
            ldi 4 0x0001
            sub 5 5 4
mult_loop   add 6 6 3
            dec 5
            jz mult_ret
            jmp mult_loop
mult_ret    ret
to_dec      ldi 1 0x6004
            st 1 6
            ret
