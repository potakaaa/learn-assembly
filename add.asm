.386                            ; Use 80386 instruction set
.model flat, stdcall            ; Flat memory model, stdcall calling convention
.stack 4096                     ; Allocate stack of 4096 bytes

.data                           ; Data segment
    num1 dw 15                  ; First number (word, 16-bit)
    num2 dw 27                  ; Second number (word, 16-bit)
    result dw ?                 ; Variable to store the result (word, 16-bit)
    msg db 'The sum is: $'      ; Message to display before the result
    resultStr db 6 DUP(?)       ; String to store the result in ASCII

.code                           ; Code segment
main PROC                       ; Main procedure

    ; Add num1 and num2
    mov ax, num1                ; Load the first number into AX
    add ax, num2                ; Add the second number to AX
    mov result, ax              ; Store the result in the result variable

    ; Convert the result to a string
    lea di, resultStr           ; Load the address of resultStr into DI
    mov cx, 0                   ; Initialize counter for digits

    ; Extract each digit in reverse order
convert_loop:
    xor dx, dx                  ; Clear DX for division
    div word ptr 10             ; Divide AX by 10, result in AX, remainder in DX
    add dl, '0'                 ; Convert remainder to ASCII
    mov [di], dl                ; Store ASCII character in resultStr
    inc di                      ; Move to the next character
    inc cx                      ; Increment digit counter
    test ax, ax                 ; Check if AX is zero (all digits processed)
    jnz convert_loop            ; If not, continue the loop

    ; Reverse the string to get correct order
    dec di                      ; Adjust DI to the last character
    lea si, resultStr           ; Load the start of resultStr into SI
reverse_loop:
    cmp si, di                  ; Check if pointers meet
    jge reverse_done            ; If so, we are done
    mov al, [si]                ; Swap characters
    mov bl, [di]
    mov [si], bl
    mov [di], al
    inc si                      ; Move SI forward
    dec di                      ; Move DI backward
    jmp reverse_loop            ; Repeat the loop
reverse_done:

    ; Append the '$' for DOS interrupt
    lea di, resultStr           ; Reset DI to start of the string
    add di, cx                  ; Move DI to the end of the string
    mov byte ptr [di], '$'      ; Append '$' for DOS interrupt

    ; Display the message
    lea dx, msg                 ; Load the address of msg into DX
    mov ah, 09h                 ; Function 09h: Display string
    int 21h                     ; Call DOS interrupt

    ; Display the result
    lea dx, resultStr           ; Load the address of resultStr into DX
    mov ah, 09h                 ; Function 09h: Display string
    int 21h                     ; Call DOS interrupt

    ; Exit program
    mov ah, 4Ch                 ; Function 4Ch: Exit program
    xor al, al                  ; Return code 0
    int 21h                     ; Call DOS interrupt

main ENDP
END main