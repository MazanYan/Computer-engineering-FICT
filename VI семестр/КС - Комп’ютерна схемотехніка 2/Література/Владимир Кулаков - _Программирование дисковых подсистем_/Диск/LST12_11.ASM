;                     ������� 12.11
; �����।�⢥���� ���ந�������� ��㪠 � �������-��᪠
;        � �ᯮ�짮������ MSF-����樨 ᥪ�஢
;
; ���� ⥪�� �ணࠬ�� �㫠��� �������� ������쥢��.
; ���� lst12_11.asm, 10.04.2001.

IDEAL
P386
LOCALS
MODEL MEDIUM

; ��������� 䠩� ��������᪨� ������祭��
; ����� �ࠢ����� ������ � 梥⮢�� �����
include "lst03_01.inc"
; ��������� 䠩� ����ᮢ
include "lst03_04.inc"

DATASEG
; ����⮢� ᮮ�饭��
Txt1 DB LIGHTCYAN,0,31,"����� CD-���������",0
Txt2 DB LIGHTCYAN,0,23
     DB "��������������� ����� � �����-CD",0
     DB YELLOW,12,10,"��⠭���� � CD-��᪮��� "
     DB "�㤨���� � ������ ���� �������",0
Txt3 DB LIGHTGREEN,12,28,"���ந�������� ����",0
; �������� ��� ������
TxtW DB YELLOW,24,35,"���� ...",0
AnyK DB YELLOW,24,29,"������ ���� �������",0
; ����饭�� �� �訡���
AudioError DB LIGHTRED,12,22
           DB "�訡�� �� �믮������ �㤨��������",0
ENDS

SEGMENT sseg para stack 'STACK'
        DB 400h DUP(?)
ENDS

CODESEG
;*****************************
;* �᭮���� ����� �ணࠬ�� *
;*****************************
PROC PlayCDMusicMSF
        mov     AX,DGROUP
        mov     DS,AX
; ��⠭����� ⥪�⮢� ०�� � ������ ��࠭
        mov     AX,3
        int     10h
; ������ ����� - ���� �� ������ �࠭��� ��࠭�
        mov     [ScreenString],25
        mov     [ScreenColumn],0
        call    SetCursorPosition
; �뢥�� ��������� �� ��࠭
        MShowColorText 1,Txt1
; �뢥�� 㪠����� ������� ������� �����襭�� ���᪠
        MShowColorText 1,TxtW
; ���� ���ன�⢮ ATAPI
        call    FindATAPIDevice

; ������ ��࠭
        call    ClearScreen
; �뢥�� ⥪�⮢� ᮮ�饭��
        MShowColorText 2,Txt2
; ������� ������ �� ������
        call    GetChar

; �������� ��⮢���� ���ன�⢠
        call    WaitUnitReady
; ����� ���ந�������� ��㪠
        ; ����� � ��ன ᥪ㭤� �㫥��� ������
        mov     [MSFStartMinute],0
        mov     [MSFStartSecond],2
        mov     [MSFStartFrame],0
        ; �த������ �� ��砫� ��ࢮ� ������
        mov     [MSFEndMinute],1
        mov     [MSFEndSecond],0
        mov     [MSFEndFrame],0
        ; ����� ���ந��������
        call    PlayAudioMSF
        cmp     [DevErrorCode],0
        jne     @@Err
; ������ ��࠭
        call    ClearScreen
; �뢥�� ᮮ�饭�� � ��砫� �믮������ ����樨
        MShowColorText 1,Txt3
; ��室 � DOS
        mov     AH,4Ch
        int     21h
; ����饭�� �� �訡��
@@Err:  mov     SI,offset AudioError
        call    FatalError
ENDP PlayCDMusicMSF
ENDS

; ��������� ��楤��� �����/�뢮��
include "lst03_02.inc"
; ��������� ��楤��� ��� ��ॢ��� �ᥫ �� ����筮��
; ���� � �������
include "lst03_03.inc"
; ��������� ��楤��� ��� ����� ATA-�������
include "lst11_01.inc"
; ��������� ��楤��� ��� ���᪠ CD-��᪮����
; � ���뢠��� ��� ��ࠬ��஢
include "lst11_04.inc"
; ��������� ��楤��� ��� ����� ������� ������
include "lst11_08.inc"
; ��������� ��楤��� ��⨢�樨 ��㪮���ந��������,
; �ᯮ������� MSF-������ 
include "lst12_04.inc"
; ��������� ��楤��� �஢�ન ��⮢���� ���ன�⢠
include "lst12_10.inc"
END
