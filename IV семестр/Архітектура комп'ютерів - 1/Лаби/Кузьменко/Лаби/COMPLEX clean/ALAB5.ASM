
       dw 01h:0110110000001010%         \�������.   1101 - mul
       dw 00h:1000110100001001%         \��㠤�. ���. ॣ���஢��
                                        \r0 = r0 & r1

       dw 0Ah:000000000100000%         \���࠭� � ��

       link     l3:ct
       link     l1:rdm
       link     ewh:16

       accept    r0:111111100001%
       accept    r1:100001111111%
       accept    r7:0
       accept   r15:0FFE0h

\---------------------------------------------------------------
\       r7  - ip
\       r8  - ॣ���� ������
\       r9  - ॣ���� ������, 1� ���࠭� 㬭������
\       r10 -
\       r11 - ���稪 横��� 㬭������
\       r12 -
\       r13 - ���� �� 㬭������
\       r14 - ���襥 ᫮�� �㬬���
\       r15 - ��������, 2� ���࠭� 㬭������
\---------------------------------------------------------------
        include macro.inc
\ �롮ઠ ������� �� �����
Start
{sub nil,r7,2,z;load rm,flags;cem_c;} \���६��� � ��-
{cjp rm_z, end;} \��ઠ �� ��� ���稪� (R11)
       {ewh;oey;xor nil,r7,r7;}         \����砥� �� r7 ���� �������
       {ewl;oey;or nil,r7,r7;}
r_w    {cjp rdm,r_w;R;or r8,bus_d,z;}   \���� �⥭�� � r8

\ ��।������ �ଠ� �������
\ {and rq,r8,1000000000000000%;load rm,flags;}
\ {cjp not rm_z,two_adr;} �᫨ ���堤�᭠�
\ {jmp one_adr;}

\������� �������᭠� ?
       {or sll,R9,R8,Z;}             \R9:=R8; � ������ ���-�� � R8
       {cjp rm_c,two_adr;}           \R9[15]=1 - ���-�� 2-� ��p�᭠�
       {jmp one_adr;}

\ ��ॢ�� �� dk � ������⥫쭮� �� (ॣ���� r15 � r15)
dk2pk
   {or  r13,0,z;}             \ ������� � r13 ���
   {or  sll,r12,r9,z;}        \ �஢���� ������� ࠧ�� r9
   {cjp not rm_c, oklevel1;}  \ �᫨ ������⥫쭮�, � �� ������� ��ॢ���
   {add r9,r9,0ffffh,z;}      \ ����� 1 �� r9
   {xor r9,r9,0ffffh;}        \ �ந�����஢��� �� ࠧ��� (������ ����)
   {or  r13,1,z;}              \ ������� � r13 ������� � ����訩 ࠧ��
oklevel1

   {or  sll,r12,r15,z;}       \ �஢���� ������� ࠧ�� r15
   {cjp not rm_c, oklevel2;}  \ ������⥫쭮� �� �ॡ�� ��ॢ���
   {add r15,r15,0ffffh,z;}    \ ����� 1 �� r15
   {xor r15,r15,0ffffh;}      \ �ந�����஢��� �� ࠧ���
   {add r13,r9,z,nz;}          \ �ਡ����� 1 � ����� १����
oklevel2
   {ret;}                     \ �⤠�� �ࠢ�����
\dk2pk endp


\���४�஢�� ����� १���� r14
nres
   {or  srl,r12,r13,z;}       \ �஢���� ����訩 ࠧ�� ॣ���� r13
   {cjp not rm_c, exitret;}  \ ������⥫�� १����
   {or  r14,r14,8000h;}      \ �᫨ १���� ����⥫��, � ���塞 ���� १����
exitret
   {ret;}                    \ �⤠�� �ࠢ�����


mul_it
          {or  r14,0,z;}          \���㫥��� r14
          {or  r11,17,z;}         \R11 - ���稪 横���

          {cont;load rm, z;}      \���㫥��� RM
label1    {cjp not rm_c,label2;}  \������ ���� �����⥫�
          {add r14,r14,r9,z;}     \���������� ��������� � r14
label2    {or srl,r14,r14,z;}     \����� � r14 � r15 �㬬�
          {or sr.9,r15,r15,z;}    \������ �ந��������
          {sub r11,r11,z,z;load rm,flags;cem_c;} \���६��� � ��-
          {cjp not rm_z, label1;} \��ઠ �� ��� ���稪� (R11)
          {ret;}                  \१���� r14:r15

\---------------------------------------------------------------------------
\
one_adr
          {add  r7, r7, 1, z;}          \㢥��稢��� r7
          {or   r9, r8, z; }

          {and  r9, r9, 111100000000000%;} \������� 㬭������ ?
          {sub  r9, r9, 110100000000000%, nz;load RM,Flags;}
          {cjp  not rm_z, notmul;}

          {or   r9, r8, z; }
          {or   r9, 0400h, z;}
          {and  nil,r8,r9;cjp not zo,i_mul;} \ ��ᢥ���� ������ ?
          {cjp nz,next;} \���
i_mul

          \��⠥� ���࠭� �� ����� �� �� � ॣ���� R9

          {and r8,r8,3FFh;}
          {or  r12,r8,z;oey;ewl;}
          {r;or r9,BUS_D,z;cjp rdm,cp;}  \R9 - �����⥫�

multiple
          {call dk2pk;}             \ �८�ࠧ����� x � y � ��
          {call mul_it;}
          {call nres;}
          {jmp  next;}

notmul
          {jmp  next;}

\��ࠡ�⪠ ���堤�᭮� ��������
two_adr

          {or   r9, r8, z; }
          {and  r9, r9, 111110000000000%;} \������� ����樨 ?
          {sub  r9, r9, 000110000000000%, nz;load RM,Flags;}
          {cjp  not rm_z, next;}

          \{or   r9, r8, z; }
          \{and  r9, r9, 0000001100000000%;} ������� ����樨 ?
          \{sub  r9, r9, 0000001100000000%, nz;load RM,Flags;}
          \{cjp  not rm_z, next;}
          {or   r9, r8, z; }
          {and  r9, r9, 0111%;}
          {ewa; oey; or nil,r9,r9;load ra;}

          {or   r9, r8,z;}

          {and  r9, r9, 11100000%;}
          {or srl,r9,r9,z;}
          {or srl,r9,r9,z;}
          {or srl,r9,r9,z;}
          {or srl,r9,r9,z;}
          {or srl,r9,r9,z;}
          {ewb; oey; or nil,r9,r9;load rb;}

          {and  rb, rb, ra;}\{and  rb, rb, ra, nz;}

next
          {add  r7, r7, 1, z;}          \㢥��稢��� r7
          {jmp  Start;}
end
          {add r7,2;}
          {}
