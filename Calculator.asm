.model small 
.stack 100h
.data
msg0 db 13,10,"         ***Simple Calculator***$" ,13,10                                                                                                                                                                                                                       
msg db 13,10,"1-Add",13,10,"2-Subtract",13,10,"3-Multiply",13,10,"4-Divide", 13,10,"5-Power of a Number", 13,10,"6-Factorial",13,10,13,10,"Enter a number between (1-6) for calculation",13,10,'$'
msg1 db 13,10,"Choose an option : $"
msg2 db 13,10,"Enter First No : $"
msg3 db 13,10,"Enter Second No : $"
msg4 db 13,10,"Please Enter an Valid option : $" 
msg5 db 13,10,"Result : $" 
msg6 db 13,10,'Thank you for using the calculator.', 13,10, '$'
msg7 db 13,10,"Press `1' for continue : $", 13,10 
msg8 db 13,10,"Press any key for exit : $", 13,10
msg9 db 13,10,"Enter the number: $", 13,10
msg10 db 13,10,"Reminder: $", 13,10
msg11 db 13,10,"Enter the Base: $", 13,10
msg12 db 13,10,"Enter the exponent or power: $", 13,10 
msg13 db 13,10,"Result is out of range!!!$", 13,10


.code
      
main proc
    mov ax,@data
    mov ds,ax
    
      
    mov ah,9
    lea dx, msg0 
    int 21h
    menu:
    mov ah,9
    lea dx, msg 
    int 21h        

    mov ah,9                  
    lea dx, msg1
    int 21h 
    
    start:
    mov ah,1                       
    int 21h
    mov bl,al
    call newline
    
    cmp bl,'1'  
    je Addition 
    cmp bl,'2'  
    je Subtract
    cmp bl,'3'  
    je Multiply
    cmp bl,'4'  
    je Divide
    cmp bl,'5'  
    je powerof_numbers 
    cmp bl,'6'
    je Factorial
    
    ;invalid prompt
    mov ah,9
    lea dx, msg4
    int 21h
    
    jmp start 

Addition:
    mov ah,9  
    lea dx, msg2  
    int 21h
    mov cx,0 
    call InputNo
    push dx
    
    mov ah,9
    lea dx, msg3
    int 21h 
    mov cx,0
    call InputNo
    pop bx ;extract first number
        
    add dx,bx     
    push dx
          
    mov ah,9
    lea dx, msg5
    int 21h
    mov cx,10000
    pop dx
    call View
    
    ;if user wants to continue
    call contineu
Subtract:   
    mov ah,09h
    mov dx, offset msg2
    int 21h
    mov cx,0
    call InputNo
    push dx
    mov ah,9
    mov dx, offset msg3
    int 21h 
    mov cx,0
    call InputNo
    pop bx ;extract first number
    sub bx,dx
    mov dx,bx
    
    push dx 
    mov ah,9
    mov dx, offset msg5
    int 21h
    mov cx,10000
    pop dx
    call View 
    ;if user wants to continue
    call contineu

Multiply:   
    mov ah,09h
    mov dx, offset msg2
    int 21h
    mov cx,0
    call InputNo
    push dx
    mov ah,9
    mov dx, offset msg3
    int 21h 
    mov cx,0
    call InputNo
    pop bx ;extract first number
    mov ax,dx
    mul bx 
    mov dx,ax
    
    push dx 
    mov ah,9
    mov dx, offset msg5
    int 21h
    mov cx,10000
    pop dx
    call View 
    ;if user wants to continue
    call contineu

Divide:   
    mov ah,09h
    lea dx, msg2
    int 21h
    mov cx,0
    call InputNo
    push dx
    mov ah,9
    lea dx, msg3
    int 21h 
    mov cx,0
    call InputNo
    pop bx ;extract first number
    mov ax,bx
    mov cx,dx
    mov dx,0
    mov bx,0
    div cx
    
    mov bx,dx
    mov dx,ax
    push bx ;remainder
    push dx ;Quotient
        
    mov ah,9
    lea dx, msg5
    int 21h
    mov cx,10000
    pop dx
    call View
    mov ah,9
    lea dx, msg10
    int 21h
    mov cx,10000
    pop dx
    call View  
    ;if user wants to continue
    call contineu  
         
powerof_numbers:
    mov ah,09h
    mov dx, offset msg11
    int 21h
    mov cx,0
    call InputNo
    push dx
    mov ah,9
    mov dx, offset msg12
    int 21h 
    mov cx,0
    call InputNo
    pop bx ;extract base number
    mov ax,1
    mov cx,dx
    start_loop:
    mul bx
    dec cx
    cmp cx,0
    jne start_loop 
    mov dx,ax
    
    push dx 
    mov ah,9
    mov dx, offset msg5
    int 21h
    mov cx,10000
    pop dx
    call View 
    ;if user wants to continue
    call contineu
Factorial:
    mov ah,9
    mov dx, offset msg9
    int 21h
    mov cx,0
    call InputNo
    push dx
    cmp dx,0
    jne factorialloop
     
    mov dx,1
    
    push dx 
    mov ah,9
    mov dx, offset msg5
    int 21h
    mov cx,10000
    pop dx
    call View 
    ;if user wants to continue
    call contineu
     
factorialloop:
    pop bx ;extract  number
    mov ax,1
    factorial_loop:
    mul bx
    dec bx
    cmp bx,0
    jne factorial_loop
    mov dx,ax
    
    push dx 
    mov ah,9
    mov dx, offset msg5
    int 21h
    mov cx,10000
    pop dx
    call View 
    ;if user wants to continue
    call contineu
    
InputNo:    
    mov ah,1
    int 21h 
    mov dx,0  
    mov bx,1 
    cmp al,0dh 
    je FormNo 
    sub ax,'0'  
    mov ah,0
    push ax  
    inc cx   
    jmp InputNo 


FormNo:     
    pop ax  
    push dx      
    mul bx
    pop dx
    add dx,ax
    mov ax,bx       
    mov bx,10
    push dx
    mul bx
    pop dx
    mov bx,ax
    dec cx
    cmp cx,0
    jne FormNo
    ret   

;for display the result
View:  
    mov ax,dx
    mov dx,0
    div cx
    call ViewNo
    mov bx,dx 
    mov dx,0
    mov ax,cx 
    mov cx,10
    div cx
    mov dx,bx 
    mov cx,ax
    cmp ax,0
    jne View
    ret

;for display the result
ViewNo:    
    push ax
    push dx 
    mov dx,ax 
    add dl,'0' 
    mov ah,2
    int 21h
    pop dx  
    pop ax
    ret


newline:
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    ret 
contineu:
    call newline
    mov ah,9
    lea dx, msg7
    int 21h
    mov ah,9
    lea dx, msg8
    int 21h
    mov ah,9
    lea dx, msg1
    int 21h
    mov ah,1
    int 21h
    mov bl,al
    call newline
    cmp bl,'1'   
    je menu 
    
    jmp exit

error:
    call newline
    mov ah,9
    lea dx,msg13
    int 21h
    call contineu
    

   

exit:   
    lea dx, msg6
    mov ah, 09h
    int 21h  
    mov ax,4ch
    int 21h
    

    main endp
end main
    
