.data 
           TERMS: 7
.code   
           ldi 1 TERMS 
           ld  1 1
           ldi 0 0

loop       ldi 3 0
           mov 4 1
           jmp sqr
cnt        add 0 0 3
           dec 1
           jz infinite
           dec 1
           jmp loop

sqr        jz  cnt
           add 3 3 1
           dec 4
           jmp sqr

                    
infinite   jmp infinite
