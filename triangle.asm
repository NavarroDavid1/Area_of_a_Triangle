section .note.GNU-stack noexec

section .data
    prompt db "The manager is here to help you find the area of your triangle.", 10, 0
    prompt2 db "Input your 3 floating point numbers representing the sides of a triangle.", 10, 0
    prompt3 db "Press enter after each number.", 10, 0
    nonsense_msg db "Your triangle is nonsense!", 10, 0
    return_msg db "The area will be returned to Heron.", 10, 0
    len1 equ $ - prompt - 1
    len2 equ $ - prompt2 - 1
    len3 equ $ - prompt3 - 1
    nonsense_len equ $ - nonsense_msg - 1
    return_len equ $ - return_msg - 1

section .text
    global triangle
    extern get_sides
    extern compute_area
    extern show_results

triangle:
    push rbp
    mov rbp, rsp
    sub rsp, 32  ; Space for three doubles (8*3=24) + alignment

    ; Print prompts
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, len1
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt2
    mov rdx, len2
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt3
    mov rdx, len3
    syscall

    ; Call get_sides(double* s1, double* s2, double* s3)
    lea rdi, [rbp-8]   ; side1
    lea rsi, [rbp-16]  ; side2
    lea rdx, [rbp-24]  ; side3
    call get_sides

    ; Check return value for valid input
    test eax, eax
    jz invalid_input

    ; Check if triangle sides form a valid triangle
    ; Compare side1 + side2 > side3
    movsd xmm0, [rbp-8]
    addsd xmm0, [rbp-16]
    comisd xmm0, [rbp-24]
    jbe print_nonsense

    ; Call compute_area with the three sides
    movsd xmm0, [rbp-8]
    movsd xmm1, [rbp-16]
    movsd xmm2, [rbp-24]
    call compute_area

    ; Store result
    movsd [rbp-32], xmm0

continue:
    ; Call show_results with the three sides and area
    movsd xmm0, [rbp-8]
    movsd xmm1, [rbp-16]
    movsd xmm2, [rbp-24]
    movsd xmm3, [rbp-32]
    call show_results

    ; Print return message
    mov rax, 1
    mov rdi, 1
    mov rsi, return_msg
    mov rdx, return_len
    syscall

    ; Return the area
    movsd xmm0, [rbp-32]
    
    mov rsp, rbp
    pop rbp
    ret

print_nonsense:
    mov rax, 1
    mov rdi, 1
    mov rsi, nonsense_msg
    mov rdx, nonsense_len
    syscall
    jmp continue

invalid_input:
    xorpd xmm0, xmm0  ; Return 0.0
    movsd [rbp-32], xmm0
    jmp continue

