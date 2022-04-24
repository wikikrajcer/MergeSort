;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                                  
; Autor: Wiktoria Krajcer                                                          
; Nazwa procedury: MergeSortAsm                                                                  
; Procedura ta realizuje czêœæ algorytmu sortowania przez scalanie, która scala dwa posortowane podci¹gi
; w jeden posortowany podci¹g
; Input:                                                                            
; arrayOfNumbers - tablica z liczbami do posortowania
; temporaryArray - tablica tymczasowa
; leftIndex - indeks pierwszego elementu tablicy (pierwszego elementu m³odszego podci¹gu)
; middleIndex - indeks srodkowego elementu tablicy (pierwszego elementu starszego podci¹gu)
; rightIndex - indeks ostatniego elementu tablicy (ostatniego elementu starszego podci¹gu)                         
; Output: brak - operacje s¹ wykonywane na oryginalne tablicy    
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.code
i = 0
k = 8
j = 16
arrayOfNumbers = 32
temporaryArray = 40
leftIndex = 48
middleIndex = 56
rightIndex = 64
MergeSortFuncAsm PROC
read_data:
        mov     DWORD PTR [rsp+32], r9d  ;wczytanie middleIndex
        mov     DWORD PTR [rsp+24], r8d  ;wczytanie leftIndex
        mov     QWORD PTR [rsp+16], rdx  ;wczytanie temporaryArray
        mov     QWORD PTR [rsp+8], rcx   ;wczytanie arrayOfNumbers
        sub     rsp, 24                  ;przygotowanie stosu
        mov     eax, DWORD PTR leftIndex[rsp] ;skopiowanie do eax wartosci leftIndex
        mov     DWORD PTR i[rsp], eax ;skopiowanie do i wartosci z eax, czyli leftIndex
        mov     eax, DWORD PTR middleIndex[rsp] ;skopiowanie do eax wartosci middleIndex
        inc     eax ;inkrementacja eax, czyli wartosci middleIndex
        mov     DWORD PTR j[rsp], eax ;skopiowanie do j wartosci z eax, czyli zinkrementowanego middleIndex
        mov     eax, DWORD PTR i[rsp] ;skopiowanie do eax wartosci i
        mov     DWORD PTR k[rsp], eax ;skopiowanie do k wartosci z eax, czyli k
        mov     eax, DWORD PTR leftIndex[rsp] ;skopiowanie do eax wartosci leftIndex
        mov     DWORD PTR i[rsp], eax ;skopiowanie do i wartosci z eax, czyli leftIndex
        jmp     SHORT for_loop_table_copying ;skok do for_loop_table_copying

increment_i_in_for_loop:
        mov     eax, DWORD PTR i[rsp] ;skopiowanie do eax wartosci i
        inc     eax ;inkrementacja wartosci z eax, czyli i
        mov     DWORD PTR i[rsp], eax ;skopiowanie do i wartosci z eax, czyli zinkrementowanego i
for_loop_table_copying:
        mov     eax, DWORD PTR rightIndex[rsp] ;skopiowanie do eax wartosci rightIndex
        cmp     DWORD PTR i[rsp], eax ;porownanie i z wartosci¹ w eax, czyli z rightIndex
        jg      SHORT break_for_loop ;skok do break_loop jesli i > rightIndex
        movsxd  rax, DWORD PTR i[rsp] ;skopiowanie do rax wartosci i
        movsxd  rcx, DWORD PTR i[rsp] ;skopiowanie do rcx wartosci i
        mov     rdx, QWORD PTR temporaryArray[rsp] ;skopiowanie temporaryArray do rdx
        mov     r8, QWORD PTR arrayOfNumbers[rsp] ;skopiowanie arrayOfNumbers do r8
        mov     eax, DWORD PTR [r8+rax*4] ;skopiowanie do eax wartosci arrayOfNumbers[i]
        mov     DWORD PTR [rdx+rcx*4], eax ;skopiowanie do temporaryArray[i] wartosci z eax czyli arrayOfNumbers[i]
        jmp     SHORT increment_i_in_for_loop ;skok do increment_i
break_for_loop:
        mov     eax, DWORD PTR leftIndex[rsp] ;skopiowanie do eax wartosci leftIndex
        mov     DWORD PTR i[rsp], eax ;skopiowanie do i wartosci z eax, czyli leftIndex
while_loop:
        mov     eax, DWORD PTR middleIndex[rsp] ;skopiowanie do eax wartosci middleIndex
        cmp     DWORD PTR i[rsp], eax ;porownanie i z wartosci¹ w eax, czyli z middleIndex
        jg      SHORT while_loop_nr2 ;skok do while_loop_nr2 jesli i > middleIndex
        mov     eax, DWORD PTR rightIndex[rsp] ;skopiowanie do eax wartosci rightIndex
        cmp     DWORD PTR j[rsp], eax ;porownanie j z wartosci¹ w eax, czyli z rightIndex
        jg      SHORT while_loop_nr2 ;skok do while_loop_nr2 jesli j > rightIndex

        movsxd  rax, DWORD PTR i[rsp] ;skopiowanie do rax wartosci i
        movsxd  rcx, DWORD PTR j[rsp] ;skopiowanie do rcx wartosci j
        mov     rdx, QWORD PTR temporaryArray[rsp] ;skopiowanie temporaryArray do rdx
        mov     r8, QWORD PTR temporaryArray[rsp] ;skopiowanie temporaryArray do r8
        mov     ecx, DWORD PTR [r8+rcx*4] ;skopiowanie do ecx wartosci temporaryArray[j]
        cmp     DWORD PTR [rdx+rax*4], ecx ;porownanie wartosci temporaryArray[i] z wartosci¹ temporaryArray[j]
        jg      SHORT else_ ;skok do else_ jesli temporaryArray[i]>temporaryArray[j]
        movsxd  rax, DWORD PTR i[rsp] ;skopiowanie do rax wartosci i
        movsxd  rcx, DWORD PTR k[rsp] ;skopiowanie do rcx wartosci k
        mov     rdx, QWORD PTR arrayOfNumbers[rsp] ;skopiowanie arrayOfNumbers do rdx
        mov     r8, QWORD PTR temporaryArray[rsp] ;skopiowanie temporaryArray do r8
        mov     eax, DWORD PTR [r8+rax*4] ;skopiowanie do eax wartosci temporaryArray[i]
        mov     DWORD PTR [rdx+rcx*4], eax ;skopiowanie do arrayOfNumbers[k] wartosci temporaryArray[i]
        mov     eax, DWORD PTR i[rsp] ;sksopiowanie do eax wartosci i
        inc     eax ;inkrementacja wartosci z eax, czyli i
        mov     DWORD PTR i[rsp], eax ;skopiowanie do i wartosci z eax, czyli zinkrementowanego i
        jmp     SHORT increment_k ;skok do increment_k
else_:
        movsxd  rax, DWORD PTR j[rsp] ;skopiowanie do eax wartosci j
        movsxd  rcx, DWORD PTR k[rsp] ;skopiowanie do rcx wartosci k
        mov     rdx, QWORD PTR arrayOfNumbers[rsp] ;skopiowanie arrayOfNumbers do rdx
        mov     r8, QWORD PTR temporaryArray[rsp] ;skopiowanie temporaryArray do r8
        mov     eax, DWORD PTR [r8+rax*4] ;skopiowanie do eax wartosci temporaryArray[j]
        mov     DWORD PTR [rdx+rcx*4], eax ;skopiowanie do arrayOfNumbers[k] wartosci temporaryArray[j]
        mov     eax, DWORD PTR j[rsp] ;skopiowanie do eax wartosci j
        inc     eax ;inkrementacja wartosci z eax, czyli j
        mov     DWORD PTR j[rsp], eax ;skopiowanie do j wartosci z eax, czyli zinkrementowanego j
increment_k:
        mov     eax, DWORD PTR k[rsp] ;skopiowanie do eax wartosci k
        inc     eax ;inkrementacja wartosci z eax, czyli k
        mov     DWORD PTR k[rsp], eax ;skopiowanie do k wartosci z eax, czyli zinkrementowanegok
        jmp     while_loop ;skok do while_loop
while_loop_nr2:
        mov     eax, DWORD PTR middleIndex[rsp]  ;skopiowanie do eax wartosci middleIndex
        cmp     DWORD PTR i[rsp], eax ;porownanie wartosci i z wartoscia middleIndex
        jg      SHORT end_procedure ;skok do end_procedure jeœli i>middleIndex
        movsxd  rax, DWORD PTR i[rsp] ;skopiowanie do rax wartosci i
        movsxd  rcx, DWORD PTR k[rsp] ;skopiowanie do rcx wartosci k
        mov     rdx, QWORD PTR arrayOfNumbers[rsp] ;skopiowanie arrayOfNumbers do rdx
        mov     r8, QWORD PTR temporaryArray[rsp] ;skopiowanie temporaryArray do r8
        mov     eax, DWORD PTR [r8+rax*4] ;skopiowanie do eax wartosci temporaryArray[j]
        mov     DWORD PTR [rdx+rcx*4], eax ;skopiowanie do arrayOfNumbers[k] wartosci temporaryArray[j]
        mov     eax, DWORD PTR i[rsp] ;skopiowanie do eax wartosci i
        inc     eax ;inkrementacja wartosci z eax, czyli i
        mov     DWORD PTR i[rsp], eax ;skopiowanie do i wartosci z eax, czyli zinkrementowanego i
        mov     eax, DWORD PTR k[rsp] ;skopiowanie do eax wartosci k
        inc     eax ;inkrementacja wartosci z eax, czyli k
        mov     DWORD PTR k[rsp], eax ;skopiowanie do k wartosci z eax, czyli zinkrementowanego k
        jmp     SHORT while_loop_nr2
end_procedure:
        add     rsp, 24 ;przywrocenie stanu poczatkowego stosu
        ret     0  ;koniec
MergeSortFuncAsm ENDP  
END