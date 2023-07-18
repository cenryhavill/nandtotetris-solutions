// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

    @256
    D=A
    @n
    M=D // n = RAM[0] (height of the rectangle) - how many times to iterate

    // initialize RAM[i] to 0 - counter for loop
    @i
    M=0

    // initialize inner loop controls
    @32
    D=A
    @k
    M=D

    @j
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
    D;JGE // i - n >= 0

    @32
    D=A
    @k
    M=D
    @j
    M=0
    // increase RAM[i] by 1
    @i
    M=M+1
    (INNERL)
        @KBD
        D=M
        @LOOP
        D;JEQ

        @j
        D=M
        @k
        D=D-M
        @LOOP
        D;JGE // j - k >= 0
        // read base address from RAM[address] and store -1 (16x1) at that address, thus blackening 16 pixels
        @address
        A=M
        M=-1 // RAM[address] = -1 (16 pixels/bits)

        @j
        M=M+1

        @address
        M=M+1 // address = address + 1

        @INNERL
        0;JMP // goto INNERL

    @LOOP
    0;JMP // goto LOOP

(END)
    @END
    0;JMP
