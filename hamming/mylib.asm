.code
GENERARE proc
	 call DESCHIDERE_FISIER
	 call CREARE_FISIER
citire:
	 call CITIRE_DIN_FISIER
	 ;afisare data citita in consola
	 push offset data     
	 push offset data_format
	 call printf
	 add esp,8
	 ;;;;;;;;;;;;;;;;;;;;;;;
	 ;afisare data citita in fisier iesire
	 push offset MESAJ1
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 push offset data
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 ;;;;;;;;;;;;;;;;;;;;;;;
	
	 call creare_vecor_nou
	
	 call P1
     mov [coded_data],al	 
	 call P2
	 mov[coded_data+1],al
	 call P4
	 mov[coded_data+3],al
	 call P8
	 mov[coded_data+7],al
	 call P16
	 mov[coded_data+15],al
	 call P32
	 mov[coded_data+31],al
	 
	 call space
	 call space
	 ;afisare cod hamming pentru data citita in consola
	 push offset coded_data
	 push offset data_format
	 call printf
	 add esp,8
	 call newline
	 ;afisare cod hamming in fisierul generat
	 push offset MESAJ2
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 push offset coded_data
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 push offset linie_noua
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 ;;;;;;;;;;;;;;;;;;;;
	 dec nr_teste
	 cmp nr_teste,0
	 jne citire
	 call INCHIDERE_FISIER
	 call INCHIDERE_FISIER_GENERAT
	 
	
     ret
GENERARE endp
	 
VERIFICARE proc
     call DESCHIDERE_FISIER_VERIFICARE
	 call CREARE_FISIER_VERIFICARE
citire_cod:
     call CITIRE_HAMMING
	 call newline
	 ;scriere data citita in consola
	 push offset coded_data
	 push offset data_format
	 call printf
	 add esp,8
	 ;scriere data citita in fisier
	 push offset MESAJ3
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 push offset coded_data
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 push offset spatiu
     push offset data_format
     push pointer_fisier_out
     call fprintf
     add esp,12	 
	 mov eax,0
	 mov pozitie_gresita,eax
	 
	 
	 call P1
	 cmp dl,1
	 jne urmator
     add pozitie_gresita,1
urmator:
	 call P2
	 cmp dl,1
	 jne urmator2
	 add pozitie_gresita,2
urmator2:
	call P4
	 cmp dl,1
	 jne urmator3
	 add pozitie_gresita,4
urmator3:
	 call P8
	 cmp dl,1
	 jne urmator4
	 add pozitie_gresita,8
urmator4:
	 call P16
	 cmp dl,1
	 jne urmator5
	 add pozitie_gresita,16
urmator5:
	 call P32
	 cmp dl,1
	 jne urmator6
	 add pozitie_gresita,32
urmator6:
     call space
	 ;printare in consola
	 push pozitie_gresita
	 push offset format_intreg
	 call printf
	 add esp,8
	 ;afisare in fisier pozitie_gresita
	 push offset MESAJ4
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 push pozitie_gresita
	 push offset format_intreg
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 
	 
	 ;aici are loc modificarea bitului de pe pozitia gresita
	 cmp pozitie_gresita,0
	 je do_nothing_with_code
	 mov edx,pozitie_gresita
	 dec edx
	 mov bl,[coded_data+edx]
	 sub bl,30h
	 xor bl,1
	 add bl,30h
	 mov [coded_data+edx],bl
do_nothing_with_code:
	 
	 call space
	 ;printare in consola cod corectat
	 push offset coded_data
	 push offset data_format
	 call printf
	 add esp,8
	 ;afisare in fisier cod corectat
	  push offset MESAJ5
	  push offset data_format
	  push pointer_fisier_out
	 call fprintf
	  add esp,12
	 push offset coded_data
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 
	 push offset linie_noua
	 push offset data_format
	 push pointer_fisier_out
	 call fprintf
	 add esp,12
	 
	 dec nr_teste1
	 cmp nr_teste1,1023
	 jne citire_cod
	 
	 call INCHIDERE_FISIER
	 call INCHIDERE_FISIER_GENERAT
	 
	 ret
VERIFICARE endp
	 
	 
	
DESCHIDERE_FISIER proc
     push offset mode_read
	 push offset file_name
	 call fopen
	 add esp,8
	 mov pointer_fisier,eax
	 ret
DESCHIDERE_FISIER endp

CREARE_FISIER proc
     push offset mode_write
	 push offset file_out_generare
	 call fopen
	 add esp,8
	 mov pointer_fisier_out,eax
	 ret
CREARE_FISIER endp

DESCHIDERE_FISIER_VERIFICARE proc
     push offset mode_read
	 push offset file_verify
	 call fopen
	 add esp,8
	 mov pointer_fisier,eax
     ret
DESCHIDERE_FISIER_VERIFICARE endp	 

CREARE_FISIER_VERIFICARE proc
     push offset mode_write
	 push offset file_out_verificat
	 call fopen
	 add esp,8
	 mov pointer_fisier_out,eax
	 ret
CREARE_FISIER_VERIFICARE endp
	
CITIRE_DIN_FISIER proc	 
     
	 push offset data
	 push offset data_format
	 push pointer_fisier
	 call fscanf
	 add esp,12
	 ret
CITIRE_DIN_FISIER endp

CITIRE_HAMMING proc
     
	 push offset coded_data
	 push offset data_format
	 push pointer_fisier
	 call fscanf
	 add esp,12
	 ret
CITIRE_HAMMING endp



	
	
	 
INCHIDERE_FISIER proc	 
	 push pointer_fisier
	 call fclose
	 add esp,4
	 ret
INCHIDERE_FISIER endp
INCHIDERE_FISIER_GENERAT proc
     push pointer_fisier_out
	 call fclose
	 add esp,4
	 ret
INCHIDERE_FISIER_GENERAT endp
	 
creare_vecor_nou proc
     lea esi,data
	 lea edi,coded_data
	 mov ecx,38 ;lungimea noului vector
creare_sir:
	 mov ax,38
	 sub ax,cx  ;in ax vom avea pozitia de pe noul vector
	 cmp ax,0
	 je parity_bit
	 cmp ax,1
	 je parity_bit
	 cmp ax,3
	 je parity_bit
	 cmp ax,7
	 je parity_bit
	 cmp ax,15
	 je parity_bit
	 cmp ax,31
	 je parity_bit
	 
	 mov dl,[esi]
	 inc esi
	 mov [edi],dl
	 	 
parity_bit:
     
	 inc edi
	 loop creare_sir
	 ret
creare_vecor_nou endp
 
   

P1 proc
     push ebp
	 mov ebp,esp
    lea esi,coded_data
    mov al,0  ; in al vom retine mereu xor-ul numerelor
    mov ecx,19
salt_1_poz:
     mov bl,[esi]
	 sub bl,30h
     xor al,bl
	 add esi,2 ; se sar 2 pozitii
	 loop salt_1_poz
	
	 xor dl,dl
	 mov dl,al ;retinem rez proc P1 in dl
     add al,30h
	; mov [coded_data],al
	mov esp,ebp
	pop ebp
	 ret
P1  endp

P2 proc
     lea esi,coded_data
	 add esi,1 ;incepem de la pozitia a 2 a
	 mov al,0
	 mov ecx,9
salt_2_poz:
     mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 add esi,1
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 add esi,3
	 loop salt_2_poz;
	 ;  a mai ramas de verificat bitul 38
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 
	 xor dl,dl
	 mov dl,al ;retinem rez proc P2 in dl
	 add al,30h
	 ;mov[coded_data+1],al
	 ret
P2 endp

P4  proc
     lea esi,coded_data
	 add esi,3 ;incepem de la pozitia a 4 a
	 mov al,0
	 mov ecx,4
salt_4_poz:
     mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 add esi,5
	 loop salt_4_poz
	 ;aici au mai ramas de verificat bitii 36,37,38
	  mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 
	 xor dl,dl
	 mov dl,al ;retinem rez proc P4 in dl
	 add al,30h
	 ;mov[coded_data+3],al
	 ret
P4   endp

P8   proc
     lea esi,coded_data
	 add esi,7
	 mov al,0
	 mov ecx,2
salt_8_poz:
     
	 mov dx,8 ; incarcare 8 in registru pentru crearea unui loop in vederea verificarii a 8 biti
loop_8:
	 mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 dec dx
	 cmp dx,0
	 jne loop_8
	 ; am verificat totii bitii care intra in acest caz
	 add esi,8 ;sarim 8 pozitii, suntem pe pozitia 16 la iesire din loop, trebuie sa ajungem pe pozitia 24
	 loop salt_8_poz;
	 
	 xor dl,dl
	 mov dl,al ;retinem rez proc P8 in dl
	 add al,30h
	; mov[coded_data+7],al
	 ret
P8   endp

P16  proc
     lea esi,coded_data
	 add esi,15
	 mov al,0
	 mov ecx,16 ;avem doar un loop de 16 aici de la pozitia 16 pana la 31
parcurgere_16_pozitii:
     mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 loop parcurgere_16_pozitii
	 
	 xor dl,dl
	 mov dl,al ;retinem rez proc P16 in dl
	 add al,30h
	 ;mov[coded_data+15],al
	 ret
P16  endp

P32  proc
     lea esi,coded_data
	 add esi,31
	 mov al,0
	 mov ecx,7
parcurgere_7_biti:
     mov bl,[esi]
	 sub bl,30h
	 xor al,bl
	 inc esi
	 loop parcurgere_7_biti
	 
	 xor dl,dl
	 mov dl,al ;retinem rezultatul procedurii in dl
	 add al,30h
	 ;mov[coded_data+31],al
	 ret
P32 endp
	 
	
space  proc
     push offset spatiu
	 push offset data_format
	 call printf
	 add esp,8
	 ret
space endp	
	
newline proc
    push offset linie_noua
	push offset data_format
	call printf
	add esp,8
	ret
newline endp
