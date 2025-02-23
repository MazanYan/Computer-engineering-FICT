;                     ������� 13.2
;     ���� 䠩�� AUTOEXEC.BAT � ��୥��� ��⠫���
;       �����᪮�� ��᪠ "C:" � �⮡ࠦ���� ���
;             ��砫쭮�� ���⪠ �� ��࠭�
;
; ���� ⥪�� �ணࠬ�� �㫠��� �������� ������쥢��.
; ���� lst13_02.asm, 11.02.2001.

IDEAL
P386
LOCALS
MODEL MEDIUM

; ��������� 䠩� ��������᪨� ������祭��
; ����� �ࠢ����� ������ � 梥⮢�� �����
include "lst03_01.inc"
; ��������� 䠩� ����ᮢ
include "lst03_04.inc"

; ������ ��୥���� ��⠫��� � ᥪ���
RootDirSize equ 32

DATASEG
; ����⮢� ᮮ�饭��
Txt00 DB LIGHTCYAN,0,30,"����� �������� �����",0
      DB YELLOW,24,35,"���� ...",0
Txt10 DB YELLOW,0,6,"�������������� � ������ �������� "
      DB "������ ��������� ������� ����� �:",0
Txt11 DB 2,4,"��砫�� ᥪ�� �᭮����� ࠧ����:",0
      DB 3,13,"��� FAT �᭮����� ࠧ����:",0
      DB 4,19,"����஢ � ������:",0
      DB 5,14,"��᫮ १�ࢭ�� ᥪ�஢:",0
      DB 6,23,"��᫮ ����� FAT:",0
      DB 7,1,"��᫮ ᥪ�஢, ���������� ������ FAT:",0
      DB 8,18,"��砫�� ᥪ�� FAT:",0
      DB 9,7,"��砫�� ᥪ�� ������ ������:",0
      DB 10,3,"��砫�� ᥪ�� ��୥���� ��⠫���:",0
Txt20 DB YELLOW,0,11,"���������� ������� ������� FAT "
      DB "��������� ������� ����� �:",0
Txt30 DB YELLOW,0,21
      DB "��������� ������� ��������� ��������",0
      DB LIGHTGREEN,2,0,"  ��� 䠩��     ������    "
      DB "��ਡ���     ���      �६�",0
Txt40 DB YELLOW,0,23
      DB "������ ������ ����� AUTOEXEC.BAT",0
; ��� FAT
FAT16 DB 3,40,"FAT16",0
FAT32 DB 3,40,"FAT32",0
; �������� ��� ������
AnyK DB YELLOW,24,29,"������ ���� �������",0
; ����饭�� �� �訡���
Err1 DB LIGHTRED,12,25
     DB "��� �� �����ন���� ०�� LBA",0
Err2 DB LIGHTRED,12,25
     DB "�᭮���� ࠧ��� DOS �� ������",0
Err3 DB LIGHTRED,12,16,"���� AUTOEXEC.BAT � ��୥��� "
     DB "��⠫��� �� ������",0
; ������ ���� � �६���
ZeroDate DB "00.00.0000  00:00:00",0
; ��砫�� ᥪ�� �᭮����� ࠧ���� DOS
PriDOS_StartSector DD ?
; ������� ���� ����㧮筮�� ᥪ��
BootSector         DD ?
; ��᫮ ᥪ�஢ � ������
SectorsInCluster   DW ?
; ��᫮ १�ࢭ�� ᥪ�஢
RSects             DD ?
; ��᫮ ⠡��� FAT �� ��᪥
FATsOnDisk         DW ?
; ������ ����� ⠡���� FAT � ᥪ���
FATSize            DD ?
; ��᮫��� ����� ��砫쭮�� ᥪ�� FAT
FATStartSect       DD ?
; ����� ��ࢮ�� ������ ��୥���� ��⠫��� � FAT32
RootDirClaster     DD ?
; ��᮫��� ����� ��砫쭮�� ᥪ�� ������ ������
DataAreaStartSect  DD ?
; ��᮫��� ����� ��砫쭮�� ᥪ�� ��୥���� ��⠫���
RootDirStartSect   DD ?
; ��砫�� ������ 䠩��
FileStartCluster   DD ?
; ��᮫��� ����� ��砫쭮�� ᥪ�� 䠩��
FileStartSect      DD ?
; ����� 䠩�� � �����
FileSize           DD ?
; ���稪 ᥪ�஢
SectorCounter      DW ?
; ���稪 ������⮢ ��⠫���
ElementCounter     DW ?
; ������� ��� 䠩�� (�� ����� 64 ᨬ�����)
LongFileName DB 65 DUP (?)
ENDS

SEGMENT sseg para stack 'STACK'
        DB 400h DUP(?)
ENDS


CODESEG
;*****************************
;* �᭮���� ����� �ணࠬ�� *
;*****************************
PROC SearchAutoexecBat
        mov     AX,DGROUP
        mov     DS,AX
; ��⠭����� ⥪�⮢� ०�� � ������ ��࠭
        mov     AX,3
        int     10h
; ������ ����� - ���� �� ������ �࠭��� ��࠭�
        mov     [ScreenString],25
        mov     [ScreenColumn],0
        call    SetCursorPosition
; �뢥�� ��������� ��࠭�
        MShowColorText 2,Txt00
; ���� ���⪨� ��� "C:"
        call    FindHDD
; �஢���� ����稥 �����প� ०��� LBA 
        cmp     [dword ptr Sector512+60*2],0
        je      @@LBANotSupported

; ������ ����㧮�� ᥪ�� ��᪠
        mov     [dword ptr SectorAddress],0
        call    ReadHDDSector
; ������� ����� ��砫쭮�� ᥪ�� �᭮����� ࠧ����
        mov     SI,offset Sector512
        add     SI,1BEh      ;ᬥ饭�� ��ࢮ� �����
        mov     EAX,[SI+8]
        mov     [PriDOS_StartSector],EAX
; �஢���� ��� �᭮����� ࠧ����
        mov     SI,offset Sector512
        add     SI,1BEh    ;ᬥ饭�� ��ࢮ� �����
        mov     AL,[SI+4]  ;������� ⨯ ࠧ����
        cmp     AL,04h
        je      @@FAT16
        cmp     AL,06h
        je      @@FAT16
        cmp     AL,0Bh
        je      @@FAT32
        cmp     AL,0Eh
        jne     @@PrimPartNotFound
@@FAT16:; ��ࠡ�⪠ ������� FAT16
        call    FAT16_Structures
@@FAT32:; ��ࠡ�⪠ ������� FAT32
        call    FAT32_Structures

; ��ࠡ�⪠ �訡��
@@LBANotSupported:
        ; ����饭�� "��� �� �����ন���� LBA"
        MShowColorText 1,Err1
        jmp short @@AllErr
@@PrimPartNotFound:
        ; ����饭�� "�� ������ �᭮���� ࠧ���"
        MShowColorText 1,Err2
@@AllErr:
        ; ���� ���� ��ࠡ�⪨ �訡��
        MShowColorText 1,AnyK
        call    GetChar
; �����襭�� ࠡ��� �ணࠬ��
@@End:  ; �����⠭����� ⥪�⮢� ०��
        mov     ax,3
        int     10h
        ; ��室 � DOS
        mov     AH,4Ch
        int     21h
ENDP SearchAutoexecBat


;***********************************
;* ��������� �������� ������ FAT16 *
;***********************************
PROC FAT16_Structures NEAR
; ������ BOOT-ᥪ�� �᭮����� ࠧ����
        mov     EAX,[PriDOS_StartSector]
        mov     [SectorAddress],EAX
        call    ReadHDDSector
; ������� �᭮��� ��ࠬ���� ��� ���⮢
        mov     SI, offset Sector512
        ; ��᫮ ᥪ�஢ � ������
        movzx   AX,[byte ptr SI+0Dh]
        mov     [SectorsInCluster],AX
        ; ��᫮ १�ࢭ�� ᥪ�஢
        movzx   EAX,[word ptr SI+0Eh]
        mov     [RSects],EAX
        ; ��᫮ ����� FAT � ࠧ����
        movzx   AX,[byte ptr SI+10h]
        mov     [FATsOnDisk],AX
        ; ������ ����� ⠡���� FAT � ᥪ���
        xor     EAX,EAX
        mov     AX,[SI+16h]
        mov     [FATSize],EAX
; ���᫨�� ��砫�� ᥪ�� FAT
        mov     EAX,[PriDOS_StartSector]
        add     EAX,[RSects]
        mov     [FATStartSect],EAX
; ���᫨�� ��砫�� ᥪ�� ��୥���� ��⠫���
        mov     EAX,[FATSize]
        movzx   EDX,[FATsOnDisk]
        mul     EDX
        add     EAX,[FATStartSect]
        mov     [RootDirStartSect],EAX
; ���᫨�� ��砫�� ᥪ�� ������ ������
        add     EAX,RootDirSize
        mov     [DataAreaStartSect],EAX
; �⮡ࠧ��� ���祭�� ��ࠬ��஢
        call    ShowParameters
        MShowText 1,FAT16
; �뤠�� 㪠����� ������� � ����� ������ ������
        MShowColorText 1,AnyK
        call    GetChar

; ��������� � �������� ��������� ������� FAT
; ������ ��࠭ � �뢥�� ⥪�⮢� ᮮ�饭��
        call    ClearScreen
        MShowColorText 1,Txt20
        MShowColorText 1,AnyK
; ������ ��砫�� ᥪ�� FAT
        mov     EAX,[FATStartSect]
        mov     [SectorAddress],EAX
        call    ReadHDDSector
; �⮡ࠧ��� ��砫�� ���⮪ FAT
        mov     [ScreenString],2
        mov     [ScreenColumn],0
        mov     SI,offset Sector512
        mov     CX,256
@@FAT:  lodsw
        call    ShowHexWord
        inc     [ScreenColumn]
        loop    @@FAT
; ������� ������ �� ������
        call    GetChar

; ��������� � �������� ������ ������ ��������� ��������
        call    ShowRootDir

; ����� ���� AUTOEXEC.BAT � �������� ��������
; ������ ��࠭ � �뢥�� ⥪�⮢� ᮮ�饭��
        call    ClearScreen
        MShowColorText 1,Txt40
; ���㫨�� ���稪 ᥪ�஢ ��⠫���
        mov     [SectorCounter],0
; ������ ����� ��砫쭮�� ᥪ�� ��⠫���
        mov     EAX,[RootDirStartSect]
        mov     [SectorAddress],EAX
; ������ ��।��� ᥪ�� ��୥���� ��⠫���
@@ReadNextCatalogSector:
        call    ReadHDDSector
        mov     SI,offset Sector512
        mov     CX,16 ;�᫮ ������⮢ � ����� ᥪ��
; ���� ��ᬮ�� ������⮢ ��⠫���
@@TestNextElement:
        ; ��� ᮢ������?
        cmp     [dword ptr SI],'OTUA'
        jne     @@NotAutoexec
        cmp     [dword ptr SI+4],'CEXE'
        jne     @@NotAutoexec
        ; ����७�� ᮢ������?
        cmp     [dword ptr SI+7],'TABC'
        je      @@AutoexecFileFound
@@NotAutoexec:
        add     SI,32 ;�ਡ����� ࠧ��� �������
        loop    @@TestNextElement
        ; ���� AUTOEXEC.BAT � ᥪ�� �� ������
        inc     [dword ptr SectorAddress]
        inc     [SectorCounter]
        cmp     [SectorCounter],RootDirSize
        jb      @@ReadNextCatalogSector
        ; �訡�� - 䠩� AUTOEXEC.BAT �� ������
        je      @@AutoexecFileNotFound

; �������� ��砫�� ���⮪ 䠩�� AUTOEXEC.BAT
@@AutoexecFileFound:
        ; ��।����� ��砫�� ������ 䠩��
        xor     EAX,EAX
        mov     AX,[SI+1Ah]  ;����㧨�� ����襥 ᫮��
        mov     [FileStartCluster],EAX
        ; ��।����� ����� 䠩�� � �����
        mov     EAX,[SI+1Ch]
        mov     [FileSize],EAX
        ; ���᫨�� ��᮫��� ����� ��砫쭮�� ᥪ��
        mov     EAX,[FileStartCluster]
        sub     EAX,2
        movzx   EDX,[SectorsInCluster]
        mul     EDX
        add     EAX,[DataAreaStartSect]
        mov     [FileStartSect],EAX
        ; ������ ��砫�� ᥪ�� 䠩��
        mov     [SectorAddress],EAX
        call    ReadHDDSector
        ; �������� ᮤ�ন��� ᥪ��
        mov     SI,offset Sector512
        call    ShowSector512
        ; ������� ������ �� ������
        MShowColorText 1,AnyK
        call    GetChar
        jmp short @@End

; ����饭�� "�� ������ 䠩� AUTOEXEC"
@@AutoexecFileNotFound:
        MShowColorText 1,Err3
        MShowColorText 1,AnyK
        call    GetChar

; �����襭�� ࠡ��� �ணࠬ��
@@End:  ; �����⠭����� ⥪�⮢� ०��
        mov     ax,3
        int     10h
        ; ��室 � DOS
        mov     AH,4Ch
        int     21h
ENDP FAT16_Structures


;***********************************
;* ��������� �������� ������ FAT32 *
;***********************************
PROC FAT32_Structures NEAR
; ������ BOOT-ᥪ�� �᭮����� ࠧ����
        mov     EAX,[PriDOS_StartSector]
        mov     [SectorAddress],EAX
        call    ReadHDDSector
; ������� �᭮��� ��ࠬ���� ��� ���⮢
        mov     SI, offset Sector512
        ; ��᫮ ᥪ�஢ � ������
        movzx   AX,[byte ptr SI+0Dh]
        mov     [SectorsInCluster],AX
        ; ��᫮ १�ࢭ�� ᥪ�஢
        movzx   EAX,[word ptr SI+0Eh]
        mov     [RSects],EAX
        ; ��᫮ ����� FAT � ࠧ����
        movzx   AX,[byte ptr SI+10h]
        mov     [FATsOnDisk],AX
        ; ������ ����� ⠡���� FAT � ᥪ���
        mov     EAX,[SI+24h]
        mov     [FATSize],EAX
        ; ����� ��ࢮ�� ������ ��୥���� ��⠫���
        mov     EAX,[SI+2Ch]
        mov     [RootDirClaster],EAX
; ���᫨�� ��砫�� ᥪ�� FAT
        mov     EAX,[PriDOS_StartSector]
        add     EAX,[RSects]
        mov     [FATStartSect],EAX
; ���᫨�� ��砫�� ᥪ�� ������ ������
        ; ���᫨�� ��砫쭮� ᬥ饭��
        mov     EAX,[PriDOS_StartSector]
        add     EAX,[RSects]
        mov     [DataAreaStartSect],EAX
        ; �ਡ����� ࠧ��� ������ FAT
        mov     EAX,[FATSize]
        movzx   EDX,[FATsOnDisk]
        mul     EDX
        add     [DataAreaStartSect],EAX
; ���᫨�� ��砫�� ᥪ�� ��୥���� ��⠫���
        mov     EAX,[RootDirClaster]
        sub     EAX,2
        movzx   EDX,[SectorsInCluster]
        mul     EDX
        add     EAX,[DataAreaStartSect]
        mov     [RootDirStartSect],EAX
; �⮡ࠧ��� ���祭�� ��ࠬ��஢
        call    ShowParameters
        MShowText 1,FAT32
; �뤠�� 㪠����� ������� � ����� ������ ������
        MShowColorText 1,AnyK
        call    GetChar

; ��������� � �������� ��������� ������� FAT
; ������ ��࠭ � �뢥�� ⥪�⮢� ᮮ�饭��
        call    ClearScreen
        MShowColorText 1,Txt20
        MShowColorText 1,AnyK
; ������ ��砫�� ᥪ�� FAT
        mov     EAX,[FATStartSect]
        mov     [SectorAddress],EAX
        call    ReadHDDSector
; �⮡ࠧ��� ��砫�� ���⮪ FAT
        mov     [ScreenString],2
        mov     [ScreenColumn],0
        mov     SI,offset Sector512
        mov     CX,128
@@FAT:  mov     EAX,[SI]
        call    ShowHexDWord
        add     [ScreenColumn],2
        add     SI,4
        loop    @@FAT
; ������� ������ �� ������
        call    GetChar

; ��������� � �������� ������ ������ ��������� ��������
        call    ShowRootDir

; ����� ���� AUTOEXEC.BAT � �������� ��������
; ������ ��࠭ � �뢥�� ⥪�⮢� ᮮ�饭��
        call    ClearScreen
        MShowColorText 1,Txt40
; ���㫨�� ���稪 ᥪ�஢ ��⠫���
        mov     [SectorCounter],0
; ������ ����� ��砫쭮�� ᥪ�� ��⠫���
        mov     EAX,[RootDirStartSect]
        mov     [SectorAddress],EAX
; ������ ��।��� ᥪ�� ��୥���� ��⠫���
@@ReadNextCatalogSector:
        call    ReadHDDSector
        mov     SI,offset Sector512
        mov     CX,16 ;�᫮ ������⮢ � ����� ᥪ��
; ���� ��ᬮ�� ������⮢ ��⠫���
@@TestNextElement:
        ; ��� ᮢ������?
        cmp     [dword ptr SI],'OTUA'
        jne     @@NotAutoexec
        cmp     [dword ptr SI+4],'CEXE'
        jne     @@NotAutoexec
        ; ����७�� ᮢ������?
        cmp     [dword ptr SI+7],'TABC'
        je      @@AutoexecFileFound
@@NotAutoexec:
        add     SI,32 ;�ਡ����� ࠧ��� �������
        loop    @@TestNextElement
        ; ���� AUTOEXEC.BAT � ᥪ�� �� ������
        inc     [dword ptr SectorAddress]
        inc     [SectorCounter]
        mov     AX,[SectorsInCluster]
        cmp     [SectorCounter],AX
        jb      @@ReadNextCatalogSector
        ; �訡�� - 䠩� AUTOEXEC.BAT �� ������
        ; � ��ࢮ� ������ ��⠫���
        je      @@AutoexecFileNotFound

; �������� ��砫�� ���⮪ 䠩�� AUTOEXEC.BAT
@@AutoexecFileFound:
        ; ��।����� ��砫�� ������ 䠩��
        mov     AX,[SI+14h]  ;����㧨�� ���襥 ᫮��
        shl     EAX,16
        mov     AX,[SI+1Ah]  ;����㧨�� ����襥 ᫮��
        mov     [FileStartCluster],EAX
        ; ��।����� ����� 䠩�� � �����
        mov     EAX,[SI+1Ch]
        mov     [FileSize],EAX
        ; ���᫨�� ��᮫��� ����� ��砫쭮�� ᥪ��
        mov     EAX,[FileStartCluster]
        sub     EAX,2
        movzx   EDX,[SectorsInCluster]
        mul     EDX
        add     EAX,[DataAreaStartSect]
        mov     [FileStartSect],EAX
        ; ������ ��砫�� ᥪ�� 䠩��
        mov     [SectorAddress],EAX
        call    ReadHDDSector
        ; �������� ᮤ�ন��� ᥪ��
        mov     SI,offset Sector512
        call    ShowSector512
; ������� ������ �� ������
        MShowColorText 1,AnyK
        call    GetChar
        jmp short @@End

; ����饭�� "�� ������ 䠩� AUTOEXEC"
@@AutoexecFileNotFound:
        MShowColorText 1,Err3
        MShowColorText 1,AnyK
        call    GetChar

; �����襭�� ࠡ��� �ணࠬ��
@@End:  ; �����⠭����� ⥪�⮢� ०��
        mov     ax,3
        int     10h
        ; ��室 � DOS
        mov     AH,4Ch
        int     21h
ENDP FAT32_Structures


;*******************************************
;* ������� ���������� � ���������� ������� *
;*******************************************
PROC ShowParameters NEAR
        pushad
; �뢥�� ��������� ��࠭� � ��������� �����
        MShowColorText 1,Txt10
        mov     [TextColorAndBackground],LIGHTGREEN
        MShowText 9,Txt11
        mov     [TextColorAndBackground],WHITE
; �뢥�� ����� ��砫쭮�� ᥪ��
        MShowDecDWord 2,40,[PriDOS_StartSector]
; �⮡ࠧ��� ���祭�� ��ࠬ��஢
        MShowDecWord 4,40,[SectorsInCluster]
        MShowDecDWord 5,40,[RSects]
        MShowDecWord 6,40,[FATsOnDisk]
        MShowDecDWord 7,40,[FATSize]
        MShowDecDWord 8,40,[FATStartSect]
        MShowDecDWord 9,40,[DataAreaStartSect]
        MShowDecDWord 10,40,[RootDirStartSect]
        popad
        ret
ENDP ShowParameters


;**************************************************
;* ��������� � �������� ������ ��������� �������� *
;**************************************************
PROC ShowRootDir NEAR
        pushad
; ���㫨�� ������� ���
        mov     [LongFileName],0
        mov     [LongFileName+64],0
; ������ ��࠭
        call    ClearScreen
; �뢥�� ���������
        MShowColorText 2,Txt30
; �ᯮ�짮���� �� �뢮�� ��ப ��� 梥�, ��� 䮭
        mov     [TextColorAndBackground],LIGHTGREY
; ������ ��砫�� ᥪ�� ��୥���� ��⠫���
        mov     EAX,[RootDirStartSect]
        mov     [SectorAddress],EAX
; ����� �뢮� � ���쥩 ��ப� ��࠭�
        mov     [ScreenString],3
; ���㫨�� ���稪 ��ࠡ�⠭��� ᥪ�஢ ��⠫���
        mov     [SectorCounter],0
@@NextSector:
; ������ ��।��� ᥪ�� ��୥���� ��⠫���
        call    ReadHDDSector
; ���� �뢮�� ������⮢ ��⠫���
        mov     SI,offset Sector512
        mov     [ElementCounter],0
@@NextElement:
        ; �஢���� ����� ��ப� ��࠭�
        cmp     [ScreenString],22
        ja      @@End

; ����� ������� ��� ��������� �������� �����?
        ; �뤥���� ����訥 4 ࠧ�鸞 ���� ��ਡ�⮢
        mov     AL,[SI+0Bh]
        and     AL,0Fh
        cmp     AL,0Fh
        je      @@LongNameComponent

; �஢���� �ਧ��� ���� ��⠫���
        cmp     [byte ptr SI],0
        je      @@End

; �஢���� ����稥 ������ � ������� ��⠫���
        cmp     [byte ptr SI],0E5h
        je      @@ElementNotUsed

; �������� 05h �� 0E5h
        cmp     [byte ptr SI],05h   ;��� ᯥ�ᨬ����?
        jne     @@NormalChar
        mov     [byte ptr SI],0E5h
@@NormalChar:

; �⮡ࠧ��� ��ப� ��⠫���
        ; ��� 䠩��
        mov     [ScreenColumn],0
        mov     BX,0
        mov     CX,8
        call    ShowASCIIField
        ; ����७�� ����� 䠩��
        mov     [ScreenColumn],9
        mov     BX,8
        mov     CX,3
        call    ShowASCIIField
        ; ������ 䠩�� � �����
        mov     [ScreenColumn],15
        mov     EAX,[SI+1Ch]
        call    ShowDecDWord
        ; ��ਡ��� 䠩��
        mov     [ScreenColumn],26
        mov     AL,[SI+0Bh]
        call    ShowBinByte
        ; ��� � �६� ᮧ�����
        mov     [ScreenColumn],36
        call    TimeAndDate
        jmp     @@IncStringNumber
; ��ࠡ�⪠ ���������� �������� �����
@@LongNameComponent:
        ; ����� ���ᨢ� ����� �� 13 ����
        mov     CX,64-13
        mov     BX,63
@@NextChar:
        mov     AL,[BX+LongFileName-13]
        mov     [BX+LongFileName],AL
        dec     BX
        loop    @@NextChar
        
; ����஢���� ���������� �������� ����� � ��砫� ���ᨢ�
        mov     DI,offset LongFileName
        ; ����஢���� ��ࢮ�� ���⪠
        mov     CX,5
        mov     BX,01h
@@NameComponent1:
        mov     AX,[SI+BX]
        call    UnicodeToASCII
        mov     [DI],AL
        add     BX,2
        inc     DI
        loop    @@NameComponent1
        ; ����஢���� ��ண� ���⪠
        mov     CX,6
        mov     BX,0Eh
@@NameComponent2:
        mov     AX,[SI+BX]
        call    UnicodeToASCII
        mov     [DI],AL
        add     BX,2
        inc     DI
        loop    @@NameComponent2
        ; ����஢���� ���쥣� ���⪠
        mov     CX,2
        mov     BX,1Ch
@@NameComponent3:
        mov     AX,[SI+BX]
        call    UnicodeToASCII
        mov     [DI],AL
        add     BX,2
        inc     DI
        loop    @@NameComponent3

; ���⨣��� ��砫� �������� �����?
        mov     AL,[SI]
        and     AL,0111111b ;�뤥���� ����� ����������
        cmp     AL,01h
        jne     @@ElementNotUsed
; �뢥�� ������� ���
        mov     [ScreenColumn],0
        push    SI
        mov     SI,offset LongFileName
        mov     CX,64 ;�।��쭠� ����� ��ப�
@@NextLongNameChar:
        lodsb
        cmp     AL,0
        je      @@EndOfName
        call    ShowChar
        inc     [ScreenColumn]
        loop    @@NextLongNameChar
@@EndOfName:
        pop     SI
        ; ����� ������� ���
        mov     [LongFileName],0

; ��३� � ᫥���饩 ��ப� ��࠭�
@@IncStringNumber:
        inc     [ScreenString]
; ��३� � ᫥���饬� ��������
@@ElementNotUsed:
        add     SI,32
        inc     [ElementCounter]
        cmp     [ElementCounter],16
        jb      @@NextElement
; ��३� � ��ࠡ�⪥ ᫥���饣� ᥪ�� ��⠫���
        inc     [dword ptr SectorAddress]
        inc     [SectorCounter]
        cmp     [SectorCounter],8
        jb      @@NextSector

; ������� ������ �� ������
@@End:  MShowColorText 1,AnyK
        call    GetChar
        popad
        ret
ENDP ShowRootDir


;****************************************************
;*        �������� ���� � ����� ������ �����        *
;* ��।������ ��ࠬ����:                          *
;* DS:SI - 㪠��⥫� �� ������� ��⠫���;           *
;* ���� �������� ��६����� TextColorAndBackground. *
;* ���न���� ����樨 ��।����� �१ ��������   *
;* ��६���� ScreenString � ScreenColumn.          *
;****************************************************
PROC TimeAndDate near
        pusha
; ���࠭��� ��࠭�� ���न����
        push    [ScreenColumn]

; �뢥�� ���������� ��ﬨ 蠡��� ����
        push    SI
        mov     SI,offset ZeroDate
        mov     BX,0
        mov     CX,20
        call    ShowASCIIField
        pop     SI
; �뢥�� ����
        ; �뢥�� ����� ���
        push    [ScreenColumn]
        mov     AX,[SI+18h]
        and     AL,11111b
        cmp     AL,9
        ja      @@Day
        inc     [ScreenColumn]
@@Day:  call    ShowDecByte
        pop     [ScreenColumn]
        add     [ScreenColumn],3
        ; �뢥�� ����� �����
        push    [ScreenColumn]
        mov     AX,[SI+18h]
        shr     AX,5
        and     AL,1111b
        cmp     AL,9
        ja      @@Mon
        inc     [ScreenColumn]
@@Mon:  call    ShowDecByte
        pop     [ScreenColumn]
        add     [ScreenColumn],3
        ; �뢥�� ����� ����
        mov     AX,[SI+18h]
        shr     AX,9
        and     AL,1111111b
        add     AX,1980
        call    ShowDecWord
; �뢥�� �६�
        add     [ScreenColumn],6
        ; �뢥�� ��
        push    [ScreenColumn]
        mov     AX,[SI+16h]
        shr     AX,11
        and     AL,11111b
        cmp     AL,9
        ja      @@H
        inc     [ScreenColumn]
@@H:    call    ShowDecByte
        pop     [ScreenColumn]
        add     [ScreenColumn],3
        ; �뢥�� ������
        push    [ScreenColumn]
        mov     AX,[SI+16h]
        shr     AX,5
        and     AL,111111b
        cmp     AL,9
        ja      @@M
        inc     [ScreenColumn]
@@M:    call    ShowDecByte
        pop     [ScreenColumn]
        add     [ScreenColumn],3
        ; �뢥�� ᥪ㭤�
        mov     AX,[SI+16h]
        and     AL,11111b
        shl     AL,1
        cmp     AL,9
        ja      @@S
        inc     [ScreenColumn]
@@S:    call    ShowDecByte
; ����⠭����� ��࠭�� ���न����
        pop     [ScreenColumn]
        popa
        ret
ENDP TimeAndDate


;************************************************
;* ������������� ��� ������� �� UNICODE � ASCII *
;* ��।������ ��ࠬ���:                       *
;* AX - ᨬ��� � �ଠ� Unicode.               *
;* ��室��� ��ࠬ���:                           *
;* AL - ᨬ��� � ���� ASCII (AH = 0).           *
;************************************************
PROC UnicodeToASCII near
; �८�ࠧ����� ᨬ��� � ��� ASCII
        ; ��⨭᪨� ᨬ����?
        cmp     AX,80h
        jb      @@Exit
        ; �㪢� "�"?
        cmp     AX,401h
        je      @@E1
        cmp     AX,451h
        je      @@E2
        ; ���᪨� ᨬ����?
        cmp     AX,410h
        jb      @@UndefinedChar
        cmp     AX,44Fh
        ja      @@UndefinedChar
        cmp     AX,43Fh
        ja      @@Group2
; �८�ࠧ������ ���᪨� ᨬ����� ��ࢮ� ��㯯�
        add     AL,70h
        jmp     @@Exit
; �८�ࠧ������ ���᪨� ᨬ����� ��ன ��㯯�
@@Group2:
        add     AL,0A0h
        jmp     @@Exit
; �८�ࠧ������ �㪢� "�"
@@E1:   mov     AL,0F0h
        jmp     @@Exit
@@E2:   mov     AL,0F1h
        jmp     @@Exit
; �८�ࠧ������ ���������� ᨬ����� � ���� �����
@@UndefinedChar:
        mov     AL,'?'
@@Exit: mov     AH,0
        ret
ENDP UnicodeToASCII
ENDS

; ��������� ��楤��� �����/�뢮��
include "lst03_02.inc"
; ��������� ��楤��� ��� ��ॢ��� �ᥫ �� ����筮��
; ���� � �������
include "lst03_03.inc"
; ��������� ��楤��� ��� ����� ATA-�������
include "lst11_01.inc"
; ��������� ��楤��� ��� ���᪠ ���⪮�� ��᪠,
; ���뢠��� ��� ��ࠬ��஢ � �⥭�� ᥪ��
include "lst11_02.inc"
END
