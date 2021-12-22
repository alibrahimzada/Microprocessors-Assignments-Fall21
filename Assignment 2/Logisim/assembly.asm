.data
            SUM: 0x0000
            SB1: 0x8000
            SB2: 0x8001
            PB1: 0x8002
            PB2: 0x8003
            SSEG: 0x8004
.code
            ldi 0 SUM       // decimal version of sum
            ldi 6 SUM       // binary/hex version of sum
main_loop   ldi 1 SB1       // load address of SB1 in reg1
            ld 1 1          // load value of SB1 in reg1
            ldi 2 SB2       // load address of SB2 in reg2
            ld 2 2          // load value of SB2 in reg2
check_1     ldi 3 PB1       // load address of PB1 in reg3
            ld 3 3          // load value of PB1 in reg3
            ldi 4 0x0001    // reg4 = 1
            and 4 4 3       // reg4 = 1 and PB1
            jz check_2      // if reg4 == 0, then PB1 was not 1 and we need to check PB2
            call addit      // else, PB1 was 1 and we need to call add function
            call to_dec     // call to_dec and change sum (reg6) into binary
            jmp main_loop   // restart everything from main_loop
check_2     ldi 3 PB2       // load address of PB2 in reg3
            ld 3 3          // load value of PB2 in reg3
            ldi 4 0x0001    // reg4 = 1
            and 4 4 3       // reg4 = 1 and PB2
            jz main_loop    // if reg4 == 0, then PB2 was not 1 and we need to restart from main_loop
            call mult       // else, PB2 was 1 and we need to call the mult function
            call to_dec     // call to_dec and change sum into binary
            jmp main_loop   // restart everything from main_loop
addit       add 6 6 6       // sum = sum * 2
            add 6 6 1       // sum = sum + SB1
            ret             // return
mult        mov 5 2         // reg5 = SB2
            mov 3 6         // reg3 = sum (temp value)
            ldi 4 0x0001    // reg4 = 1
            sub 5 5 4       // reg5 = reg5 - 1
mult_loop   add 6 6 3       // sum = sum + reg3
            dec 5           // reg5 = reg5 - 1
            jz mult_ret     // if reg5 == 0, then exit loop
            jmp mult_loop   // re-iterate
mult_ret    ret             // once exited from loop, then return the mult function
to_dec      // beyza in here we need to change the current value of reg6 to decimal
            // after converting to decimal, we need to write it in reg0 and then store it in SSEG (0x8004)
            // you may use reg1-reg5 as helping (temp) variables/registers
            ldi 1 SSEG
            st 1 0
            ret
