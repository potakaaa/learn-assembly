.model small
.stack 100h

.data
    message db "Hello, World!$" ; '$' is the string terminator for DOS interrupts

.code
main proc
    mov ax, @data       ; Load the address of the data segment into AX
    mov ds, ax          ; Set the data segment register

    ; Print the message
    mov ah, 09h         ; DOS interrupt to display a string
    lea dx, message     ; Load the address of the message into DX
    int 21h             ; Call DOS interrupt

    ; Exit the program
    mov ah, 4Ch         ; DOS interrupt to terminate the program
    int 21h             ; Call DOS interrupt
main endp
end main
