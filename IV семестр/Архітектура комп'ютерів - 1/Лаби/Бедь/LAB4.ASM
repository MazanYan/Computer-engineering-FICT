link l1:ct
link l2:rdm
link ewh:16
link rb:z,2,1,0

accept rdm_delay:2

equ IMUL:7000h

dw 0000h:7401h \IMUL [R1]
dw 00FFh:0FFAh

accept r1: 00FFh
accept r7: 0000h

accept r15: 00C4h

proccmd
\Ǡ ͢&ŭͯ $ॡȠʮ̠ͤȠ͠ 設㠤-ȥ
{xor nil, r10, r10; oey; ewh;}
{or nil, r7, z; oey; ewl;}

\ Ǡ ͢&ŭͯ ʮ̠ͤȠǠΏ  Њ
ldcmd {cjp rdm, ldcmd; r; or r8, bus_d, z; load rm, flags;}

{cjp rm_z, exit;}

\ϥॢiઠ 䮠̠⣠ʮ̠ͤȍ
{cjp not rm_n, oneaddr;}

\ ĢΠĠš͠ ʮ̠ͤ
       {cjp nz, nextcmd;}

oneaddr
\ Τͮ$ॡ͠ ʮ̠ͤ
       \ ¨ĩ˥ͭΤ㠮ϥࠦii
       {and r10, r8, 7800h;}
       {xor nil,r10,IMUL; load rm, flags;}
       {cjp rm_z,imulop;}
       \ Iͨi ίŠ&ii
               {cjp nz, nextcmd;}
       imulop
       \ ίŠ&iͮƥͭ               \ ϥॢiઠ ⨯㠠Ġš&ii ίŠ-ģ
               {and nil, r8, 0400h; load rm, flags;}
               {cjp not rm_z, indirect;}
               \ Ϡﬠ $ॡ&i                       {cjp nz, nextcmd;}
               indirect
               \ ͥϠﬠ $ॡ&i                       {or nil, r8, z; oey; load rb;}
                       \ Ǡ ͢&ŭͯ $ॡȠίŠ-Ġ ͠ 設㠤-ȥ
                       {xor nil, r10, r10; oey; ewh;}
                       {or nil, rb, z; oey; ewl;}
                       \Ǡ ͢&ŭͯ ίŠ-Ġ  Їύ
                       ldoprnd {cjp rdm, ldoprnd; r; or r13, bus_d, z;}

                       \ ¨ʮͭ͠ͮƥͭॢi̠ᯮᮡά
                       \ Iͩ橠˩Ǡ橯 ॣiᢠi
                       {or r12, r15, z;}
                       {xor r15, r15, r15;}
                       {xor r14, r14, r14;}
                       {or r11, r15, 16;}

                       \ ¨ǭ'ŭͯ ǭ*㠠ŧ㫬⠢㍊                       {xor nil, r12, r13; load rn, flags;}

                       \ ϥॢ®७ͯ X iǠĊ 㠏ʍ
                       {or r12, r12; load rm, flags;}
                       {cjp not rm_n, unsigned;}
                       {sub r12, r12, z, z;}
                       {xor r12, 0ffffh;}  \ not r12

                       {and r13, r13, 7FFFh;}

                       unsigned {load rm, z;}
                       label1 {or sll, r15, r15, z;}
                       {or sl.25, r14, r14, z;}

                       {or sl.25, r12, r12, z;}
                       {cjp not rm_c, label2;}

                       {add r15, r15, r13, z; load rm, flags;}
                       {add r14, r14, z, rm_c;}
                       label2 {sub r11, r11, z, z; load rm, flags;}
                       {cjp  not rm_z, label1;}

                       \ ¡⠭΢˥ͭ͠ʣ १㫬⠢㍊                       {cjp not rn_n, nextcmd;}
                       {or r14, r14, 8000h;}

nextcmd
\ϥ॥iĠĮ ͠ᢣϭΩ ʮ̠ͤȍ
{add r7, r7, z, nz;}
{cjp nz, proccmd;}

exit
{}
