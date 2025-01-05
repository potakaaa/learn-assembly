.386                            ; Use 80386 instruction set
.model flat, stdcall            ; Flat memory model, stdcall calling convention
.stack 4096                     ; Allocate stack of 4096 bytes

.data                           ; Data segment
    userMsg db 'Please enter a number: $' ; Message to prompt the user
    dispMsg db 'You have entered: $'      ; Message to display entered number
    num db 5 DUP(?)                       ; Reserve space for 5 characters input

.code                           ; Code segment
main PROC                       ; Main procedure
    ; Print the prompt message
    lea dx, userMsg             ; Load address of userMsg into DX
    mov ah, 09h                 ; Function 09h: Display string
    int 21h                     ; Call DOS interrupt

    ; Read user input
    lea dx, num                 ; Load address of num buffer into DX
    mov ah, 0Ah                 ; Function 0Ah: Buffered keyboard input
    int 21h                     ; Call DOS interrupt

    ; Print the output message
    lea dx, dispMsg             ; Load address of dispMsg into DX
    mov ah, 09h                 ; Function 09h: Display string
    int 21h                     ; Call DOS interrupt

    ; Print the entered number
    lea dx, num+1               ; Load address of actual input into DX (skip count byte)
    mov ah, 09h                 ; Function 09h: Display string
    int 21h                     ; Call DOS interrupt

    ; Exit program
    mov ah, 4Ch                 ; Function 4Ch: Exit program
    xor al, al                  ; Return code 0
    int 21h                     ; Call DOS interrupt
main ENDP
END main
