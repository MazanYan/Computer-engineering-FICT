link l1: ct
link l2: rdm
link ewh: 16
link m: z,z,z,z,z,z,z,14,13,12,11,10


dw 1111h: 08ffh \ ����������� ������� 0 0001 0 00 1111 1111
dw 1112h: 8022h \ ����������� ������� 1 00011 00 001 00 010
dw 1113h: 8062h
dw 1114h: 08ffh
dw 0ffh: 0000000000000010%  \ �������

accept r12: 1111h            \������� �� ���������
accept r1: 0000000000000001%
accept r2: 0000000000000011%
accept r3: 0000000000000001%
accept r14: 0h \Z(8-15) ��������� �����i �i�� ����������
accept r15: 000000000000001% \Z(0-7)  ������i �i�� ����������

          {cjp not z, loading;}
org 000000000011% {cjp nz, double;}
    000000000010% {cjp nz, multing;}

\--------------------------------------------------------------------------
\-----------------������ � ���'����----------------------------------------
\--------------------------------------------------------------------------


loading   {xor nil, r13,r13; oey; ewh;} \  ��������� ���ic��� ������
          {or nil, r12,z; oey; ewl;}  \

comread   {cjp rdm, comread; r; or r11,bus_d,z; load rm, flags;}   \ �������� �������

          {cjp rm_n, double;} \  ���� ������ �� ��� = �� ���i�
          {cjp rm_z, exit;}  \

          {and r13, r11, 400h; load rm, flags;}   \  ���� ������� �������i� = �� ���i�
          {cjp not rm_z, exit;}                   \

          {and rq,r11,0111100000000000%;}
          {jmap; or rq,z; oey;}
          {cjp not rm_z, exit;}                    \

multing   {xor nil, r13,r13; oey; ewh;}         \
          {or r13, 3ffh, z;}                   \ ������������ � ��� ������
          {and nil, r11, r13; oey; ewl;}        \ ��������

readop    {cjp rdm, readop; r; or r13, bus_d, z;}  \ �������� �������

\------------------------------------------------------------------------
\-----------------------��������-----------------------------------------
\------------------------------------------------------------------------
          {xor r10, r10;}
          {or r10, r15;}   \
          {xor r15, r15;}   \
          {or r11, r10;}     \
          {or r9, r13;}       \   ���i����� ����� �i� �����
          {or sll, r10,r10;}   \
          {or sll, r13,r13;}    \
          {or srl, r10,r10;}     \
          {or srl, r13,r13;}      \
          {xor r11, r10;}           \
          {xor r9, r13;}            \
          {add r11,r9;}               \

multstart {load rm, flags;}
extag     {or srl, r13,r13,z;}               \R13=0.r(R13)
          {cjp not rm_c,tag;}
          {add r15, r10;cjp not co, tag;}    \R15=R15+R10
          {add r14, r14, 1;}                 \R14=R14+1 ���� �i������� ������������
tag       {or sll, r10, r10,z;}              \R10=l(R10).0
          {or r13,r13,z;cjp not zo, extag;}
          {or sll, r11,r11;}
          {cjp not rm_c, command;}
 minus    {add r14, r11;}                \
          {xor r15, 0ffffh;}              \ ����������� � ������������ ���
          {xor r14, 0ffffh;}               \
          {add r15, 1h;}
          {cjp not z, command;}
command   {add r12, r12, 1h;}        \  �����i� �� ��������� �������
          {cjp not z, loading;}       \

double    {or r9, r11;}                 \   �����i��� ����������i
          {and r9, 0111110000000000%;}   \  ������i�
          {xor r9, 0h; load rm, flags;}   \
          {cjp not rm_z, exit;}            \

          {or r9, r11;}                  \
          {and r9, 0000001100011000%;}    \ �����i��� �������i�
          {xor r9, 0h; load rm, flags;}    \
          {cjp not rm_z, exit;}             \

          {or r9, r11;}                       \
          {and r9, 0111%;}                     \ ���������� ������� ���i����
          {ewa; oey; or nil, r9,r9; load ra;}   \

          {or r9, r11;}                        \
          {and r9, 11100000%;}                  \ ���������� ������� ���i����
          {or srl, r9,r9,z;}                     \
          {or srl, r9,r9,z;}                      \
          {or srl, r9,r9,z;}                       \
          {or srl, r9,r9,z;}                        \
          {or srl, r9,r9,z;}                         \
          {ewb; oey; or nil, r9,r9; load rb;}         \

          {add rb, ra;}                          \ ���������

          {add r12, r12,1h;}                     \  �������� �������
          {cjp not z, loading;}                   \
 exit     {}
