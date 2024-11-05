section .note.GNU-stack noexec

section .text
    global compute_area

compute_area:
    ; Parameters passed in:
    ; xmm0 = side1
    ; xmm1 = side2
    ; xmm2 = side3
    
    push rbp
    mov rbp, rsp
    
    ; Save original sides
    movsd xmm3, xmm0  ; side1
    movsd xmm4, xmm1  ; side2
    movsd xmm5, xmm2  ; side3
    
    ; Check triangle inequality: sum of any two sides must be greater than the third side
    ; Check if (a + b) > c
    movsd xmm0, xmm3
    addsd xmm0, xmm4  ; a + b
    ucomisd xmm0, xmm5  ; Compare (a + b) with c
    jbe invalid_triangle
    
    ; Check if (b + c) > a
    movsd xmm0, xmm4
    addsd xmm0, xmm5  ; b + c
    ucomisd xmm0, xmm3  ; Compare (b + c) with a
    jbe invalid_triangle
    
    ; Check if (a + c) > b
    movsd xmm0, xmm3
    addsd xmm0, xmm5  ; a + c
    ucomisd xmm0, xmm4  ; Compare (a + c) with b
    jbe invalid_triangle
    
    ; Calculate s = (a + b + c) / 2
    movsd xmm0, xmm3
    addsd xmm0, xmm4  ; a + b
    addsd xmm0, xmm5  ; a + b + c
    
    ; Divide by 2 to get semiperimeter
    mov rax, 2
    cvtsi2sd xmm6, rax
    divsd xmm0, xmm6  ; xmm0 = s
    
    ; Calculate (s-a), (s-b), (s-c)
    movsd xmm1, xmm0  ; s
    subsd xmm1, xmm3  ; s-a
    
    movsd xmm2, xmm0  ; s
    subsd xmm2, xmm4  ; s-b
    
    movsd xmm6, xmm0  ; s
    subsd xmm6, xmm5  ; s-c
    
    ; Multiply s*(s-a)*(s-b)*(s-c)
    mulsd xmm0, xmm1  ; s*(s-a)
    mulsd xmm0, xmm2  ; s*(s-a)*(s-b)
    mulsd xmm0, xmm6  ; s*(s-a)*(s-b)*(s-c)
    
    ; Check if result is negative or zero (invalid triangle)
    xorpd xmm1, xmm1
    ucomisd xmm0, xmm1
    jbe invalid_triangle
    
    ; Calculate square root
    sqrtsd xmm0, xmm0
    
    pop rbp
    ret

invalid_triangle:
    xorpd xmm0, xmm0  ; Return 0.0
    pop rbp
    ret
