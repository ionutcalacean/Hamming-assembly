.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern fopen:proc
extern fclose:proc
extern fscanf:proc
extern fprintf:proc
extern printf:proc

include mylib.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.data
;aici declaram date
data db 32 dup(30h),0
mode_read db "r",0
mode_write db "w",0
file_name db "fisier.txt",0
file_verify db "coduri.txt",0
file_out_generare db "hamming_codes.txt",0
file_out_verificat db "hamming_codes_verified.txt",0
data_format db "%s",0
coded_data db 38 dup(30h),0
linie_noua db 13,10,0
spatiu db 32,0
pozitie_gresita dd 0
format_intreg db "%d",0
nr_teste dd 1024
nr_teste1 dd 1024
MESAJ1 db "DATA CITITA:",0
MESAJ2 db " CODUL HAMMING:",0
MESAJ3 db "HAMMING CITIT:",0
MESAJ4 db " POZITIA GRESITA:",0
MESAJ5 db " COD CORECTAT:",0
pointer_fisier_out dd 0
pointer_fisier dd 0


.code
start:
     call GENERARE
	 call VERIFICARE
     jmp FINAL	 
	 
	

	
FINAL:
	;terminarea programului
	push 0
	call exit
end start


 