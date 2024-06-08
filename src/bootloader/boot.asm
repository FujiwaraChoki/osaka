; org
; calculate label addresses
org 0x7C00

; emit 16 bit values
bits 16

; start at new line
%define ENDL 0x0D, 0x0A

; FAT12 header
jmp short start
nop

bdb_oem:                    db 'MSWIN4.1'
bdb_bytes_per_sector:       dw 512
bdb_sectors_per_cluster:    db 1
bdb_reserved_sectors:       dw 1
bdb_fat_count:              db 2
bdb_dir_entries_count:      dw 0E0h
bdb_total_sectors:          dw 2880
bdb_media_descriptor:       db 0F0h
bdb_sectors_per_fat:        dw 9
bdb_sectors_per_track:      dw 18
bdb_heads:                  dw 2
bdb_hidden_sectors:         dd 0
bdb_large_sector_count:     dd 0

; extended boot record
ebr_drive_number:           db 0
                            db 0
ebr_signature:              db 29h
ebr_volume_id:              db 12h, 34h, 56h, 78h
ebr_volume_label:           db ' OSAKER OS '
ebr_system_id:              db 'FAT12   '


; code HEREE


start:
    jmp main

; print str to screen
; params
; - ds:si points to str
puts:
    ; save registers (so they aren't modified)
    push si
    push ax
    push bx

.loop:
    lodsb               ; loads next char in al
    or al, al           ; check if next char is null
    jz .done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

main:
    ; ds setup
    mov ax, 0   ; can't write to ds/es directly
    mov dx, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00

    ; print silly osaker message
    mov si, osaker_prefix
    call puts
    mov si, osaker
    call puts

    ; silly chiyo-can message
    mov si, chiyo_prefix
    call puts
    mov si, chiyo
    call puts


    hlt

.halt:
    jmp .halt

osaker_prefix: db 'Osaker says: ', 00
chiyo_prefix: db 'Chiyo-Chan: ', 00

osaker: db 'America Ya!', ENDL, 00
chiyo: db 'Hallo!', ENDL, 00

times 510-($-$$) db 0 ; length of program so far
dw 0AA55h ; bios needs this