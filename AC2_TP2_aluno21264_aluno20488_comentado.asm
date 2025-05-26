org 100h

;variaveis
.data
y DW 0
x DW 0
dividendo_Array_Pos DW -2
dividendo DW 5 DUP (0)
dividendo_Digitos DB 0
divisor_Digitos DB 0
auxiliar_Dividendo DW 0
resto DW 0
quociente DW 0
itera_Array_Resto DW 0
array_Resto DW 5 DUP (0)
i DW 0
divisor DW 0
divisor_Array_Pos DW -2
itera_Array_Quociente DW 0
count_Negativo DW 0
negativo_Existe DW 0
array_Quociente DW 5 DUP (0)
guarda_Var DW 0
guarda_Tamanho_Var DW 0
guarda_Input DW 0
tamanho_x DW 0
tamanho_y DW 0
lim_y DW 0
lim_x DW 0
rato_Num DW 0
num_espacos DW 3
num_Next_Line DW 3
input_Menu_Inicial DW 0
texto_Introducao DB "ESCOLHA O ALGORITMO A USAR$"
texto_Divisao DB "DIVISAO$"
texto_Raiz_Quadrada DB "RAIZ QUADRADA$"
texto_Sair DB "SAIR$"
texto_Teclado_Resultado DB "RESULTADO$"
texto_Teclado_Seguinte DB "SEGUINTE$"
texto_Teclado_Apagar DB "DELETE$"
texto_Menu_Divisao_Dividendo DB "DIVIDENDO:$"
texto_Menu_Divisao_Divisor DB "DIVISOR:$"
texto_Quociente DB "QUOCIENTE:$"
texto_Resto DB "RESTO:$"
texto_Menu_Raiz_Radicando DB "RADICANDO:$"
texto_Resultado DB "RESULTADO:$"
;Variaveis Raiz Quadrada
radicando DW 5 DUP (0)
n_Digitos DW 0
radicando_Digitos DW 0
array_Resultado DW 5 DUP (0) 
a DW 0
array_Pos_Raiz DW -2
auxiliar_Radicando DW 0 
resto_Calc DW 0   
resultado_Raiz DW 0
resultado DW 0
itera_Array_Raiz DW 0
resultado_To_Array DW 5 DUP (0)

;codigo para uma calculadora que calcule divisoes e raizes quadradas
;feito utilizando o modo grafico
.code
main proc
    call inicia_data
    menu_Inicial_Loop:
        call inicia_Modo_Grafico
        mov ax, 00h
        int 33h
        call menu_Inicial
        call verifica_Rato_Menu_Inicial
        cmp input_Menu_Inicial, 0
        je inicia_Divisao
        cmp input_Menu_Inicial, 1
        je inicia_Raiz_Quadrada
        cmp input_Menu_Inicial, 2
        je sair_Programa
    inicia_Divisao:
        call inicia_Modo_Grafico
        mov guarda_Var, 0
        mov ax, 00h
        int 33h
        call menu_Divisao
        call verifica_Local_Rato
        call algoritmo_Divisao
        call mostra_Resultado_Divisao
        call verifica_Mouse_Click
        call reset_Variaveis
        jmp menu_Inicial_Loop 
        
    inicia_Raiz_Quadrada:
        call inicia_Modo_Grafico
        mov guarda_Var, 2
        mov ax, 00h
        int 33h
        call menu_Divisao
        call verifica_Local_Rato
        call algoritmo_Raiz
        call mostra_Resultado_Raiz
        call verifica_Mouse_Click
        call reset_Variaveis
        jmp menu_Inicial_Loop
    sair_Programa:
        ret
main endp

;carrega os dados
proc inicia_Data
    mov DX, @DATA ; carrega o segmento de dados
    mov DS, DX ; carrega o segmento de dados
inicia_Data endp

;inicia modo grafico
proc inicia_Modo_Grafico
    mov ah, 0h          ; Inicia o modo grafico
    mov al, 13h         ; Coloca o modo grafico 320x200 com 256 cores
    int 10h             ; Chama a interruptcao 10h
    ret
inicia_Modo_Grafico endp

;coloca as variaeis no seu estado inicial para ser possivel usar o algoritmo outra vez
proc reset_Variaveis 
    mov n_Digitos, 0
    mov a, 0
    mov array_Pos_raiz, -2
    mov auxiliar_Radicando, 0
    mov resto_Calc, 0
    mov resultado_Raiz, 0
    mov resultado, 0
    mov dividendo_Array_Pos, -2
    mov dividendo_Digitos, 0
    mov divisor_Digitos, 0
    mov auxiliar_Dividendo, 0
    mov resto, 0
    mov quociente, 0
    mov itera_Array_Resto, 0
    mov i, 0
    mov divisor, 0
    mov divisor_Array_Pos, -2
    mov itera_Array_Quociente, 0
    mov count_Negativo, 0
    mov guarda_var, 0
    mov guarda_Tamanho_Var, 0
    mov guarda_Input, 0
    mov itera_Array_Raiz, 0
    mov negativo_Existe, 0
    ret
reset_Variaveis endp

;verifica se o rato foi clicado (usado para sair dos algoritmos)
proc verifica_Mouse_Click
    loop_Rato_Saida: 
        ;mostra cursor
        mov ax, 01H
        int 33h   
        ;recebe a posicao do cursor
        mov ax, 03H
        int 33h
        ;verifica se foi clicado no botao esquerdo do rato
        cmp bx, 1 
        jne loop_Rato_Saida
    ret
verifica_Mouse_Click endp

;menu inicial onde e feita a escolha do algoritmo
proc menu_Inicial
    mov bx, 10
    call muda_Linha
    mov bx, 6
    call coloca_Espacos_Ecra
    mov dx, offset texto_Introducao
    mov ah, 9h
    int 21h
    mov bx, 3
    call muda_Linha
    mov bx, 5
    call coloca_Espacos_Ecra 
    mov dx, offset texto_Divisao
    mov ah, 9h
    int 21h
    mov bx, 8
    call coloca_Espacos_Ecra 
    mov dx, offset texto_Raiz_Quadrada
    mov ah, 9h
    int 21h
    mov bx, 3
    call muda_Linha
    mov bx, 14
    call coloca_Espacos_Ecra
    mov dx, offset texto_Sair
    mov ah, 9h
    int 21h
    ;Retangulo que envolve a opcao da divisao
    mov x, 36
    mov y, 100
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 115
    mov lim_x, 98
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Retangulo que envolve a opcao da raiz Quadrada
    mov x, 155
    mov y, 100
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 115
    mov lim_x, 268
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Retangulo que envolve a opcao de saida
    mov x, 108
    mov y, 123
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 139
    mov lim_x, 148
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical     
    ret
        
menu_Inicial endp

;menu divisão que ira ter um teclado feito por quadrados que inclui os numeros de 0 a 9
proc menu_Divisao
    call desenha_Teclado_Virtual
    ret
menu_Divisao endp

;procedimento para dsenhar uma linha vertical
proc desenha_Linha_Vertical
desenha_Linha_V: ;desenha uma linha vertical
    mov ah, 0Ch
    mov al, 0fh
    mov bh, 0
    mov cx, x
    mov dx, y
    int 10h
    inc y
    mov AX, y
    CMP AX, lim_y
    JB desenha_Linha_V
    ret
desenha_Linha_Vertical endp

;procedimento para desenhar uma linha horizontal
proc desenha_Linha_Horizontal
desenha_Linha_H: ;desenha uma linha horizontal
    mov ah, 0Ch
    mov al, 0fh
    mov bh, 0
    mov cx, x
    mov dx, y
    int 10h
    inc x
    mov AX, x
    CMP AX, lim_x
    JB desenha_Linha_H
    ret
desenha_Linha_Horizontal endp

;procedimento para desenhar o teclado virtual
proc desenha_Teclado_Virtual
    mov bx, 5
    call muda_Linha
    mov bx, 1
    call coloca_Espacos_Ecra    
    mov ah, 2
    mov dl, '0'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '1'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '2'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '3'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '4'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov dx, offset texto_Teclado_Resultado
    mov ah, 9h
    int 21h 
    ;mudar de linha para escrever os proximos numeros
    mov bx, 4
    call muda_Linha
    mov bx, 1
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '5'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '6'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '7'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '8'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '9'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov ah, 2
    mov dl, '-'
    int 21h
    mov bx, 4
    call coloca_Espacos_Ecra
    mov dx, offset texto_Teclado_Apagar
    mov ah, 9h
    int 21h
    ;Quadrado para a tecla 0
    mov x, 2
    mov y, 35
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 53
    mov lim_x, 20
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;quadrado para a tecla 1
    mov x, 42
    mov y, 35
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 53
    mov lim_x, 60
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;quadrado para a tecla 2
    mov x, 82
    mov y, 35
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 53
    mov lim_x, 100
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;quadrado para a tecla 3
    mov x, 122
    mov y, 35
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 53
    mov lim_x, 140
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;quadrado para a tecla 4
    mov x, 162
    mov y, 35
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 53
    mov lim_x, 180
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;quadrado para a tecla RESULTADO
    mov x, 202
    mov y, 35
    mov ax, y
    mov tamanho_y,ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 53
    mov lim_x, 284
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_X
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla 5
    mov x, 2
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 85
    mov lim_x, 20
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla 6
    mov x, 42
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 85
    mov lim_x, 60
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla 7
    mov x, 82
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 85
    mov lim_x, 100
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla 8
    mov x, 122
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 85
    mov lim_x, 140
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla 9
    mov x, 162
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 85
    mov lim_x, 180
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla de sinal negativo
    mov x, 202
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x, bx
    mov lim_y, 85
    mov lim_x, 220
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    ;Quadrado para a tecla do DELETE
    mov x, 242
    mov y, 67
    mov ax, y
    mov tamanho_y, ax
    mov bx, x
    mov tamanho_x,bx
    mov lim_y, 85
    mov lim_x, 300
    call desenha_Linha_Vertical
    call desenha_Linha_Horizontal
    mov ax, lim_x
    sub ax, tamanho_x
    sub x, ax
    mov ax, lim_y
    sub ax, tamanho_y
    sub y, ax
    call desenha_Linha_Horizontal
    call desenha_Linha_Vertical
    cmp guarda_Var, 0
    je inicia_Input_Dividendo
    cmp guarda_Var, 2
    je inicia_Input_Radicando
    ret
    inicia_Input_Dividendo:
        mov bx, 2
        call muda_Linha
        mov dx, offset texto_Menu_Divisao_Dividendo
        mov ah, 9h
        int 21h
        ret
    inicia_Input_Radicando:
        mov bx, 2
        call muda_Linha
        mov dx, offset texto_Menu_Raiz_Radicando
        mov ah, 9h
        int 21h
        ret    
desenha_Teclado_Virtual endp

;mostra o resultado da divisao no ecra
proc mostra_Resultado_Divisao 
    mov bx, 1
    call muda_Linha
    mov dx, offset texto_Quociente
    mov ah, 9h
    int 21h
    call mostra_Quociente_Ecra
    mov bx, 1
    call muda_Linha
    mov dx, offset texto_Resto
    mov ah, 9h
    int 21h
    call mostra_Resto_Ecra 
    
    ret  
mostra_Resultado_Divisao endp

;mostra o resultado da raiz no ecra
proc mostra_Resultado_Raiz
    mov bx, 1
    call muda_Linha
    mov dx, offset texto_Resultado
    mov ah, 9h
    int 21h
    call mostra_Resultado_Ecra    
    ret  
mostra_Resultado_Raiz endp

;verifica a posicao do rato e devolve o input para as variaveis (raiz quadrada e divisao)
proc verifica_Local_Rato
    loop_Rato: 
        ;mostra cursor
        mov ax, 01H
        int 33h   
    
        ;recebe a posicao do cursor
        mov ax, 03H
        int 33h
    
        ;verifica se foi clicado no botao esquerdo do rato
        cmp bx, 1 
        jne loop_Rato
    
    shr cx, 1
    ;cx --> coordenadas x 
    ;dx --> coordenadas y
    cmp dx, 35
    Jb loop_Rato
    cmp dx, 53
    ja loop_Segunda_Fila
    cmp cx, 2
    jb loop_Rato
    cmp cx, 20
    jb input_0
    cmp cx, 42
    jb loop_Rato
    cmp cx, 60
    jb input_1
    cmp cx, 82
    jb loop_Rato
    cmp cx, 100
    jb input_2
    cmp cx, 122
    jb loop_Rato
    cmp cx, 140
    jb input_3
    cmp cx, 162
    jb loop_Rato
    cmp cx, 180
    jb input_4
    cmp cx, 202
    jb loop_Rato
    cmp cx, 284
    jb input_Resultado
    
    loop_Segunda_Fila:
        cmp dx, 67
        jb loop_Rato
        cmp dx, 85
        ja loop_Rato
        cmp cx, 2
        jb loop_Rato
        cmp cx, 20
        jb input_5
        cmp cx, 42
        jb loop_Rato
        cmp cx, 60
        jb input_6
        cmp cx, 82
        jb loop_Rato
        cmp cx, 100
        jb input_7
        cmp cx, 122
        jb loop_Rato
        cmp cx, 140
        jb input_8
        cmp cx, 162
        jb loop_Rato
        cmp cx, 180
        jb input_9
        cmp cx, 202
        jb loop_Rato
        cmp cx, 220
        jb input_Negativo
        cmp cx, 242
        jb loop_Rato
        cmp cx, 300
        jb input_Delete
        cmp cx, 300
        ja loop_Rato
    
    input_0:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 0
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando  
    input_1:        
        cmp guarda_Tamanho_var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 1
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_2:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 2
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_3:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 3
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando    
    input_4:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 4
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_Resultado:
        cmp guarda_Var, 0
        je next_Dividendo_Divisor
        cmp guarda_Var, 2
        je next_Radicando
        jmp sair_Input_Rato
        next_Dividendo_Divisor:
            cmp guarda_Tamanho_Var, 0
            je loop_Rato
            jmp sair_Input_Rato
        next_Radicando:
            cmp n_Digitos, 0
            je loop_Rato
            jmp sair_Input_Rato
    input_5:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 5
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_6:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 6
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_7:        
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 7
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_8:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 8
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_9:
        cmp guarda_Tamanho_Var, 5
        je sair_Input_Rato
        cmp n_Digitos, 5
        je sair_Input_Rato
        mov guarda_Input, 9
        cmp guarda_Var, 0
        je concatena_Dividendo
        cmp guarda_Var, 1
        je concatena_Divisor
        cmp guarda_Var, 2
        je concatena_Radicando
    input_Negativo:
        cmp guarda_Var, 2
        je loop_Rato
        cmp guarda_Var, 0
        je coloca_Negativo_Dividendo
        cmp guarda_Var, 1
        je coloca_Negativo_Divisor
        jmp loop_Rato
        coloca_Negativo_Dividendo:
            cmp guarda_Tamanho_Var,0
            ja loop_Rato
            cmp negativo_Existe, 1
            je loop_Rato
            call adiciona_Negativo
            mov negativo_Existe, 1
            add count_Negativo, 1
            jmp loop_Rato
        coloca_Negativo_Divisor:
            cmp guarda_Tamanho_Var, 0
            ja loop_Rato
            cmp negativo_Existe, 1
            je loop_Rato
            call adiciona_Negativo
            mov negativo_Existe, 1
            add count_Negativo, 1
            jmp loop_Rato
    input_Delete:
        cmp guarda_Var, 0
        je apaga_Dividendo
        cmp guarda_Var, 2
        je apaga_Radicando
        jmp loop_Rato
        apaga_Dividendo:
            cmp guarda_Tamanho_Var, 0
            je loop_Rato
            sub dividendo_Array_Pos, 2
            sub dividendo_Digitos, 1
            sub guarda_Tamanho_Var, 1
            call apaga_Caracter
            jmp loop_Rato
        apaga_Radicando:
            cmp n_Digitos, 0
            je loop_Rato
            sub array_Pos_Raiz, 2
            sub radicando_Digitos, 1
            sub n_Digitos, 1
            call apaga_Caracter
            jmp loop_Rato           
    concatena_Dividendo:
            call concatena_Var_Dividendo
            mov dx, guarda_Input 
            add dx, 30h
            mov ah, 06h
            int 21h
            inc guarda_Tamanho_Var
            jmp loop_Rato
    concatena_Divisor:
            call concatena_Var_Divisor
            mov dx, guarda_Input
            add dx, 30h
            mov ah, 06h
            int 21h
            inc guarda_Tamanho_Var
            jmp loop_Rato
    concatena_Radicando:
            call concatena_Var_Radicando
            mov dx, guarda_Input
            add dx, 30h
            mov ah, 06h
            int 21h
            inc n_Digitos
            jmp loop_Rato          
    sair_Input_Rato:
        inc guarda_Var
        cmp guarda_Var, 1
        je muda_Para_Divisor
        ret
    muda_Para_Divisor:
        mov negativo_Existe, 0
        call imprime_Texto_Divisor
        mov guarda_Tamanho_Var, 0
        jmp loop_Rato                  
    ret
    
verifica_Local_Rato endp

;apaga o caracter anterior (botao delete)
proc apaga_Caracter
    mov ah, 2
    mov dl, 8
    int 21h
    mov dl, 32
    int 21h
    mov dl, 8
    int 21h
    ret    
apaga_Caracter endp
 
;escreve '-' no ecra
proc adiciona_Negativo
    mov ah, 2
    mov dl, '-'
    int 21h
    ret
adiciona_Negativo endp 

;verifica a posicao do cursor e recebe input do user no menu inicial
proc verifica_Rato_Menu_Inicial
    loop_Rato_Menu: 
        ;mostra cursor
        mov ax, 01H
        int 33h  
        ;recebe a posicao do cursor
        mov ax, 03H
        int 33h
        ;verifica se foi clicado no botao esquerdo do rato
        cmp bx, 1 
        jne verifica_Teclado
        shr cx, 1
        ;cx --> coordenadas x 
        ;dx --> coordenadas y
        cmp dx, 100
        Jb loop_Rato_Menu
        cmp dx, 115
        ja verifica_Opcao_Sair
        cmp cx, 36
        jb loop_Rato_Menu
        cmp cx, 98
        jb input_Divisao
        cmp cx, 155
        jb loop_Rato_Menu
        cmp cx, 268
        jb input_Raiz_Quadrada
        cmp cx, 268
        ja loop_Rato_Menu
    verifica_Opcao_Sair:
        cmp dx, 123
        jb loop_Rato_Menu
        cmp dx, 134
        ja loop_Rato_Menu
        cmp cx, 108
        jb loop_Rato_Menu
        cmp cx, 148
        jb input_Opcao_Sair
        cmp cx, 148
        ja loop_Rato_Menu 
    input_Divisao:
        mov input_Menu_Inicial, 0
        ret
    input_Raiz_Quadrada:
        mov input_Menu_Inicial, 1
        ret
    input_Opcao_Sair:
        mov input_Menu_Inicial, 2
        ret          
    verifica_Teclado:
        mov ah, 0Bh
        int 21h
        cmp al, 0
        je loop_Rato_Menu
        mov ah, 0
        int 16h
        cmp al, 'd'
        je input_Divisao
        cmp al, 'r'
        je input_Raiz_Quadrada
        cmp al, 's'
        je input_Opcao_Sair  
    ret         
verifica_Rato_Menu_Inicial endp     
    
;coloca o input selecionado pelo user no dividendo
proc concatena_Var_Dividendo
    mov ax, guarda_Input
    add dividendo_Array_Pos, 2
    mov bx, dividendo_Array_Pos
    mov dividendo[bx], ax
    add dividendo_Digitos, 1
    ret
concatena_Var_Dividendo endp

;coloca o input selecionado pelo user no divisor
proc concatena_Var_Divisor
    mov ax, divisor
    mov cx, 10
    mul cx
    add ax, guarda_Input
    mov divisor, ax
    add divisor_Digitos, 1
    ret
concatena_Var_Divisor endp

;coloca o input selecionado pelo user no radicando
proc concatena_Var_Radicando
    mov ax, guarda_Input
    add array_Pos_Raiz, 2
    mov bx, array_Pos_Raiz
    mov radicando[bx], ax
    add radicando_Digitos, 1
    ret    
concatena_Var_Radicando endp

;coloca espacos (usado para escrever no ecra)
proc coloca_Espacos_Ecra
    loop_Espacos:
        mov ah, 2h
        mov dl, 32
        int 21h
        dec bx
        cmp bx, 0
        JA loop_Espacos
    ret
coloca_Espacos_Ecra endp

;muda de linha (usado para escrever no ecra)
proc muda_Linha
    loop_Linhas:
        mov ah, 2
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h
        dec bx
        cmp bx, 0
        JA loop_Linhas
    ret
muda_Linha endp

;imprime o texto do divisor
proc imprime_Texto_Divisor
    mov bx, 1
    call muda_Linha
    mov dx, offset texto_Menu_Divisao_Divisor
    mov ah, 9h
    int 21h   
imprime_Texto_Divisor endp

;passa o resultado da raiz para array
proc resultado_Para_Array
    mov ax, resultado
    divide_Resultado_Raiz:
        mov bx, 10
        mov cx, 0
        mov dx, 0
        div bx
        push dx
        pop cx
        mov bx, itera_Array_Raiz
        mov resultado_To_Array[bx], cx
        add itera_Array_Raiz, 2
        cmp ax, 0
        ja divide_Resultado_Raiz
    ret
resultado_Para_Array endp    

;imprime o resultado da raiz
proc print_Resultado_Raiz
    sub itera_Array_Raiz, 2
    digitos_Raiz:
        mov bx, itera_Array_Raiz
        mov dx, resultado_To_Array[bx]
        add dx, 130h
        mov ah, 6h
        int 21h
        sub itera_Array_Raiz, 2
        cmp itera_Array_Raiz, 0
        jge digitos_Raiz
    ret       
print_Resultado_Raiz endp

;passa o resultado para array
proc quociente_Para_Array 
    mov ax, quociente
    divide_Resultado:
        mov bx, 10
        mov cx, 0
        mov dx, 0 
        div bx 
        push dx 
        pop cx 
        mov bx , itera_Array_Quociente
        mov array_Quociente[bx],cx 
        add itera_Array_Quociente, 2 
        cmp ax, 0 
        ja divide_Resultado 
    ret    
quociente_Para_Array endp

;verifica se é necessario colocar o -
proc get_Quociente 
    cmp count_Negativo, 1
    je adiciona_Negativo
    call print_Quociente
    ret
    adiciona_Negativo_Quociente:
        mov ah, 6h
        mov dl, '-'
        call print_Quociente
        ret
get_Quociente endp

;imprime o quociente
proc print_Quociente
    sub itera_Array_Quociente, 2
    digito_A_Digito:
        mov bx, itera_Array_Quociente
        mov dx, array_Quociente[bx]
        add dx, 130h
        mov ah, 6h
        int 21h
        sub itera_Array_Quociente, 2
        cmp itera_Array_Quociente, 0
        jge digito_A_Digito
    ret
print_Quociente endp

;mostra o resultado da raiz quadrada 
proc mostra_Resultado_Ecra
    call resultado_Para_Array
    call print_Resultado_Raiz 
    ret    
mostra_Resultado_Ecra endp

;mostra o quociente no ecra
proc mostra_Quociente_Ecra 
    call quociente_Para_Array
    call print_Quociente
    ret      
mostra_Quociente_Ecra endp

;passa o resto para array
proc resto_Para_Array
    mov ax, resto
    divide_Resto:
        mov bx, 10
        mov cx, 0
        mov dx, 0
        div bx
        push dx
        pop cx
        mov bx, itera_Array_Resto
        mov array_Resto[bx], cx
        add itera_Array_resto, 2
        cmp ax, 0
        ja divide_Resto
    ret
resto_Para_Array endp 

;verifica se  necessario colocar o - por ser negativo ou nao
proc get_Resto
    cmp count_Negativo, 1
    je adiciona_Negativo_Resto
    call print_Resto
    adiciona_Negativo_Resto:
        cmp resto, 0
        je restoZero
        mov ah, 6h
        mov dl, '-'
        int 21h
        call print_Resto
        restoZero:
            call print_Resto
            ret
    ret
get_Resto endp

;imprime o array do resto
proc print_Resto
    sub itera_Array_Resto, 2
    print_Digitos:
        mov bx, itera_Array_resto
        mov dx, array_Resto[bx]
        add dx, 130h
        mov ah, 6h
        int 21h
        sub itera_Array_Resto,2
        cmp itera_Array_Resto,0
        jge print_Digitos
    ret
print_Resto endp

;mostra o resto no ecra apos transforma-lo para array
proc mostra_Resto_Ecra 
    call resto_Para_Array
    call print_Resto
    ret      
mostra_Resto_Ecra endp


;algoritmo que calcula a raiz quadrada
algoritmo_Raiz proc
    mov ax, radicando ; move para o ax o radicando
    mov bx, 10 ; move para o bx o valor 10
    mov cx, 0 ; move para o cx o valor
    mov array_Pos_Raiz, -2

    ; loop para calcular a raiz quadrada
    do_While_Raiz:
        mov dx, 0 ; move para o dx o valor 0
        mov a, -1 ; move para o a o valor -1
        mov ax, radicando_Digitos ; move para o ax o numero de digitos
        mov cx, 2 ; move para o cx o valor 2
        div cx ; divide o ax pelo cx
        cmp dx, 0 ; compara o dx com 0
        jne digitos_Impar ; se dx for diferente de 0, vai para a rotina de digitos impares
        jmp digitos_Par ; se o resto da divisao for 0, vai para a rotina de digitos pares

        digitos_Impar:
            dec radicando_Digitos ; decrementa o numero de digitos
            add array_Pos_Raiz, 2 ; incrementa a posicao do array
            mov bx, array_Pos_Raiz ; move para o bx a posicao do array
            mov ax, radicando[bx] ; move para o ax o valor do array na posicao bx
            mov resto_Calc, ax ; move para o restoCalc o valor desempilhado
            jmp calculos ; vai para a rotina de calculos

        digitos_Par:
            sub radicando_Digitos, 2 ; subtrai 2 do numero de digitos
            add array_Pos_Raiz, 2 ; incrementa a posicao do array
            mov bx, array_Pos_Raiz ; move para o bx a posicao do array
            mov ax, radicando[bx] ; move para o ax o valor do array na posicao bx
            mov cx, 10 ; move para o cx o valor 10
            mul cx ; multiplica o ax por 10
            mov auxiliar_Radicando, ax ; move para o restoCalc o valor do ax
            add array_Pos_Raiz, 2 ; incrementa a posicao do array
            mov bx, array_Pos_Raiz ; move para o bx a posicao do array
            mov ax, radicando[bx] ; move para o ax o valor do array na posicao bx
            add auxiliar_Radicando, ax ; concatena ao primeiro digito retirado
            mov ax, resto_Calc ; move para o ax o valor do restoCalc
            mov dx, 100 ; move para o dx o valor 100
            mul dx ; multiplica o ax por 100
            add ax, auxiliar_Radicando ; soma o ax com o grupo retirado do radicando
            mov resto_Calc, ax ; move para o restoCalc o valor do ax
            jmp calculos

        calculos:
            inc a ;incrementa o a
            mov bx, ax ;guarda o valor da itera��o anterior
            mov ax, resultado ; move para o ax o valor do resultado
            mov cx, 2 ; move para o cx o valor 2
            mul cx ; multiplica o ax por 2
            mov cx, 10 ; move para o cx o valor 10
            mul cx ; multiplica o ax por 10
            add ax, a ; soma o ax com o a (2*R*10)
            mul a ; multiplica o ax pelo a (2*R*10) * a
            cmp ax, resto_Calc ; compara o ax com o restoCalc
            jbe calculos ; se ax for maior ou igual ao restoCalc, volta para o loop

        mov cx, bx ; move para o cx o valor do bx (valor que � exatamente antes ao primeiro valor maior que o restoCalc)
        mov ax, resultado ; move para o ax o valor do resultado
        mov bx, 10 ; move para o bx o valor 10
        mul bx ; multiplica o ax por 10
        sub a, 1 ;subtrai 1 ao a
        add ax, a ; soma o ax com o a
        mov resultado, ax ; move para o resultado o valor do ax
        sub resto_Calc, cx ; subtrai o cx do restoCalc
        cmp radicando_Digitos, 0 ; compara o numero de digitos com 0
        ja do_While_Raiz ; se o numero de digitos for maior que 0, volta para o loop
        ret
algoritmo_Raiz endp

;algoritmo da divisão
algoritmo_Divisao proc    

    mov dividendo_Array_Pos, -2 ; move para o arrayPos o valor -2 (para voltar a posicao inicial do array)
    
    do_While: 
        mov dx,0 ; move para o dx o valor 0
        mov i, 10 ; move para o i o valor 
        
    ;label para ter o elemento HO do restante do div
    elemento_HO:
        add dividendo_Array_Pos, 2 ; incrementa a posicao do array
        mov bx, dividendo_Array_Pos ; move para o bx a posicao do array
        mov ax, dividendo[bx] ; move para o ax o valor do dividendo (na posicao do array atual)
            
    ;adiciona o HO ao resto [r = (r * 10) + auxiliarDid]
    conta_Resto:
        mov auxiliar_Dividendo, ax ; move para o auxiliarDividendo o valor do HO
        mov ax, resto ; move para o ax o valor do resto
        mov cx, 10 ; move para o cx o valor 10
        mul cx ; multiplica o ax pelo cx
        add ax, auxiliar_Dividendo ; soma o ax com o auxiliarDividendo
        mov resto, ax ; move para o resto o valor do ax
        
    ;calcula o valor do i necessario para calcular o quociente 
    quociente_Calc: 
        mov dx,0 ; move para o dx o valor 0
        dec i ; decrementa o i
        mov ax, divisor ; move para o ax o valor do divisor
        mul i ; multiplica o ax pelo i
        cmp ax, resto ; compara o ax com o resto
        ja quociente_Calc ; se ax for maior que o resto, volta para o loop
      
    ;soma ao quociente ja existente o novo digito [q = (q*10) + i]     
    mov ax, quociente ; move para o ax o valor do quociente
    mov cx, 10 ; move para o cx o valor 10
    mul cx ; multiplica o ax pelo cx
    add ax, i ; soma o ax com o i
    mov quociente, ax ; move para o quociente o valor do ax
    
    ;subtrai ao resto o (div * i) de modo a dar o novo resto [r = r - (div * i)]
    mov ax, divisor ; move para o ax o valor do divisor
    mul i ; multiplica o ax pelo i
    mov cx, ax ; move para o cx o valor do ax
    mov ax, resto ; move para o ax o valor do resto
    sub ax, cx ; subtrai o ax pelo cx
    mov resto, ax ; move para o resto o valor do ax
    
    dec dividendo_Digitos ; decrementa o numero de digitos
    cmp dividendo_Digitos, 0 ; compara o numero de digitos com 0
    ja do_While ; se o numero de digitos for maior que 0, volta para o loop
    ret 
    
algoritmo_Divisao endp
end code
