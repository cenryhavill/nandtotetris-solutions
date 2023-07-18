// Draws a filled rectangle at the top of the screen's left corner.
// Width: 16px, height: RAM[0] (set the value manually).

    // read the height from RAM[0] and write it to RAM[n]
    @R0
    D=M
    @n
    M=D // n = RAM[0] (height of the rectangle) - how many times to iterate

    // initialize RAM[i] to 0 - counter for loop
    @i
    M=0

    // read the base address from RAM[SCREEN], and store it in RAM[address] - address to blacken
    @SCREEN
    D=A
    @address
    M=D // address = 16384 (base address of the hack screen)

(LOOP)
    // prepare and use jump conditions
    @i
    D=M
    @n
    D=D-M
    @END
    D;JGT // i - n >= 0 - so, if the height is 20, then 0-20=-20, 1-20=-19 ... 21=20=1

    // read base address from RAM[address] and store -1 (16x1) at that address, thus blackening 16 pixels
    @address
    A=M
    M=-1 // RAM[address] = -1 (16 pixels/bits) (width of the rectangle)

    // increase RAM[i] by 1
    @i
    M=M+1

    // increase RAM[address] by 32 -> that is, select next address to set to -1
    @32 // literal, not address
    D=A
    @address
    M=D+M // address = address + 32 (16384 + 32 = 16416, ...)

    @LOOP
    0;JMP // goto LOOP

(END)
    @END
    0;JMP