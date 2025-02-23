unit Unit15;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  math,maintype;


type Tmsg=record
          from:inttype;{�������}
          into:inttype;{�������}
          time:inttype;{����� ��������� 1}
          end;
type TTop=record
          time:inttype;
          recive:inttype;
          n:inttype;
          msg:array of inttype;
          end;
Type Tgraphgeneticinto=record
            n:inttype;
            Top:array of TTop;
            Nmsg:inttype;
            msg:array of Tmsg;
            end;

type Tway=record
          port:inttype;
          time:inttype;
          end;

Type Tsystemgeneticinto=record
            n:inttype;
            Proc:array of inttype;
            links:array of array of inttype;
            duplex:array of array of inttype;
            Ways:array of array of Tway;
            end;

type Tgenotip=record
              time:inttype;
              Tproc:array of inttype;
              Tpriority:array of inttype;
              end;

type TgentoFen=record
               recive:array of inttype;
               processor:array of inttype;
               timeBegin:array of inttype;
               timeEnd:array of inttype;
               complete:array of inttype;

               processorTime:array of inttype;
               procstep:array of inttype;

               priority:array of inttype;
               NMpriority:array of inttype;
               Mpriority:array of array of inttype;

               lnktime:array of array of inttype;

               end;
type Tgenetic_data =record
                  graph:Tgraphgeneticinto;
                  system:Tsystemgeneticinto;
                  Gnumber:inttype;
                  Gbest:inttype;
                  Mver:realtype;
                  Npriority:inttype;
                  bestsort:array of inttype;
                  genotipsort:array of inttype;
                  best:array of Tgenotip;
                  genotip:array of Tgenotip;
                  gtmp:array of Tgenotip;
                  end;

type Tgenetic=class(Tobject)
private
date:Tgenetic_data;
tmp:TgentoFen;
procedure PPPAll;
procedure crossover;virtual;
procedure mutation;virtual;
procedure fenotip;virtual;
procedure getbest;virtual;
procedure changedublicate;virtual;
public
 constructor Create(GNumber,Gbest,Npriority:inttype;
 var graph:Tgraphgenetic;var system:Tsystemgenetic;
 Mver:realtype);
 procedure epoha(var N:inttype);
 procedure getAllbest(var BB:array of Tgenotip);
 procedure bestofbest(var BB:Tgenotip);
 procedure getsize(var sizeg,sizes:inttype);
 procedure getevent(Ne:inttype;var events:Toutmsg);
 procedure getNbest(var N:inttype);
 function getbesttime:inttype;
 function getkrittime:inttype;virtual;
 destructor Free;
end;


implementation

function Tgenetic.getkrittime:inttype;
var i,j,n,msg,maxx:inttype;
begin

for i:=1 to date.graph.n do
begin
tmp.timeBegin[i]:=0;
tmp.timeEnd[i]:=0;
tmp.recive[i]:=date.graph.Top[i].recive;
tmp.complete[i]:=0;
end;

for i:=1 to date.graph.n do
for j:=1 to date.graph.n do
if tmp.complete[j]=0 then
if tmp.recive[j]=0 then
begin
tmp.timeEnd[j]:=tmp.timeBegin[j]+date.graph.top[j].time;
tmp.complete[j]:=1;

if date.graph.top[j].n<>0 then
for n:=1 to date.graph.top[j].n do
begin
msg:=date.graph.top[j].msg[n];

tmp.timeBegin[date.graph.msg[msg].into]:=
max(tmp.timeBegin[date.graph.msg[msg].into],
tmp.timeEnd[j]);

dec(tmp.recive[date.graph.msg[msg].into]);
end;
end;

maxx:=0;
for i:=1 to date.graph.n do
if maxx<tmp.timeEnd[i] then
maxx:=tmp.timeEnd[i];

getkrittime:=maxx;
end;

function Tgenetic.getbesttime:inttype;
begin
getbesttime:=date.best[1].time;
end;

procedure Tgenetic.getevent(Ne:inttype;var events:Toutmsg);
var i,j,m,k,n,msg,f,complete,now,msgtime,into,port:inttype;
begin
events.tkrit:=getkrittime;
m:=ne;
events.time:=0;
SetLength(events.proc,date.system.n+1);
SetLength(events.links,date.system.n+1,date.system.n+1);

for i:=1 to date.system.n do
events.proc[i].N:=0;
for i:=1 to date.system.n do
for j:=1 to date.system.n do
events.links[i,j].N:=0;

for i:=1 to date.system.n do
begin
tmp.processorTime[i]:=0;
tmp.procstep[i]:=0;
end;

for i:=1 to date.system.n do
for j:=1 to date.system.n do
tmp.lnktime[i,j]:=0;

for i:=1 to date.graph.n do
if date.graph.Top[i].n>1 then
for j:=1 to date.graph.Top[i].n-1 do
for k:=i+1 to date.graph.Top[i].n do
if (date.best[m].Tpriority[date.graph.msg[date.graph.Top[i].msg[j]].into])<
(date.best[m].Tpriority[date.graph.msg[date.graph.Top[i].msg[k]].into]) then
begin
n:=date.graph.Top[i].msg[j];
date.graph.Top[i].msg[j]:=date.graph.Top[i].msg[k];
date.graph.Top[i].msg[j]:=n;
end;

for i:=1 to date.graph.n do
begin
tmp.recive[i]:=date.graph.Top[i].recive;
tmp.processor[i]:=date.best[m].Tproc[i];
tmp.timeBegin[i]:=0;
tmp.timeEnd[i]:=0;
tmp.complete[i]:=0;
end;

for i:=1 to date.Npriority do
tmp.NMpriority[i]:=0;

for i:=1 to date.graph.n do
begin
inc(tmp.NMpriority[date.best[m].Tpriority[i]]);
tmp.Mpriority[date.best[m].Tpriority[i],
tmp.NMpriority[date.best[m].Tpriority[i]]]:=i;
end;

k:=0;
for i:=date.Npriority downto 1 do
if tmp.NMpriority[i]<>0 then
for j:=1 to tmp.NMpriority[i] do
begin
inc(k);
tmp.priority[k]:=tmp.Mpriority[i,j];
end;

complete:=0;
while complete=0 do
begin

for i:=1 to date.system.n do
tmp.procstep[i]:=0;

{������������, ����� ������, �������� ��������}
for i:=1 to date.graph.n do
begin
k:=tmp.priority[i];
if tmp.complete[k]=0 then
if tmp.recive[k]=0 then
if tmp.procstep[tmp.processor[k]]=0 then
begin

tmp.timeBegin[k]:=max(tmp.timeBegin[k],
tmp.processorTime[tmp.processor[k]]);

tmp.timeEnd[k]:=tmp.timeBegin[k]+date.graph.Top[k].time*
date.system.Proc[tmp.processor[k]];

tmp.processorTime[tmp.processor[k]]:=tmp.timeEnd[k];
tmp.complete[k]:=1;
tmp.procstep[tmp.processor[k]]:=1;

inc(events.proc[tmp.processor[k]].N);
n:=events.proc[tmp.processor[k]].N;
SetLength(events.proc[tmp.processor[k]].Event,n+1);
events.proc[tmp.processor[k]].Event[n].process:=k;
events.proc[tmp.processor[k]].Event[n].timebegin:=
tmp.timeBegin[k];
events.proc[tmp.processor[k]].Event[n].timeend:=
tmp.timeEnd[k];

if date.graph.Top[k].n<>0 then
for n:=1 to date.graph.Top[k].n do
begin
msg:=date.graph.Top[k].msg[n];
now:=tmp.processor[k];
into:=tmp.processor[date.graph.msg[msg].into];
msgtime:=tmp.timeEnd[k];

while now<>into do
begin
port:=date.system.Ways[now,into].port;

inc(events.links[now,port].N);
f:=events.links[now,port].N;
SetLength(events.links[now,port].Event,f+1);
events.links[now,port].Event[f].from:=k;
events.links[now,port].Event[f].into:=date.graph.msg[msg].into;
events.links[now,port].Event[f].timebegin:=
max(tmp.lnktime[now,port],msgtime);

msgtime:=max(tmp.lnktime[now,port],msgtime);
tmp.lnktime[now,port]:=
msgtime+(date.graph.msg[msg].time*date.system.links[now,port]);
msgtime:=tmp.lnktime[now,port];

events.links[now,port].Event[f].timeend:=msgtime;

{�� ����������}
if date.system.duplex[now,port]=0 then
begin
tmp.lnktime[port,now]:=tmp.lnktime[now,port];

end;

now:=port;
end;

dec(tmp.recive[date.graph.msg[msg].into]);

tmp.timeBegin[date.graph.msg[msg].into]:=
max(tmp.timeBegin[date.graph.msg[msg].into],msgtime)
end;
end;
end;

complete:=1;
for i:=1 to date.graph.n do
if tmp.complete[i]=0 then
complete:=0;
end;

k:=0;
for i:=1 to date.system.n do
k:=max(k,tmp.processorTime[i]);

events.time:=k;
end;

procedure Tgenetic.getsize(var sizeg,sizes:inttype);
begin
sizeg:=date.graph.n;
sizes:=date.system.n;
end;

procedure Tgenetic.changedublicate;
var i,j,k,db:inttype;
begin
randomize;
for i:=1 to date.Gnumber-1 do
for j:=i to date.Gnumber do
begin
db:=1;
for k:=1 to date.graph.n do
begin
if date.genotip[i].Tproc[k]<>date.genotip[j].Tproc[k] then
db:=0;

if date.genotip[i].Tpriority[k]<>date.genotip[j].Tpriority[k] then
db:=0;
end;

if db=1 then
for k:=1 to Date.graph.n do
begin
date.genotip[j].Tproc[k]:=Trunc(Random(date.system.n+1));
date.genotip[j].Tpriority[k]:=Trunc(Random(date.Npriority+1));
if date.genotip[j].Tproc[k]<1 then
date.genotip[j].Tproc[k]:=1;
if date.genotip[j].Tpriority[k]<1 then
date.genotip[j].Tpriority[k]:=1;
end;
end;

end;


procedure Tgenetic.epoha(var N:inttype);
var
i:inttype;
begin
changedublicate;
for i:=1 to n do
begin
crossover;
mutation;
fenotip;
getbest;
end;
end;


procedure Tgenetic.PPPAll;
var
X:array of inttype;
Xpoint:array of inttype;
Xm: array of boolean; { Mask of X}
P,i,j,n: inttype; { N }

begin
  SetLength(Xm,date.system.n+1);
  SetLength(X,date.system.n+1);
  SetLength(Xpoint,date.system.n+1);

  for j:=1 to date.system.N do
  begin

  for i:=1 to date.system.N do
  begin
  Xm[i]:=False;
  X[i]:=$FFFF;
  Xpoint[i]:=0;
  end;

  P:=j;
  Xm[P]:=True; X[P]:=0;                { step 1}
  repeat
   for i:=1 to date.system.N do if date.system.links[P, i]<>0 then
   begin
   if (X[i]>(X[P]+date.system.links[P, i])) then
   Xpoint[i]:=P;
   X[i]:=min(X[i], X[P]+date.system.links[P, i]);                   {step2 }
   end;
   for i:=1 to date.system.N do if not Xm[i] then
   P:=i;
   for i:=1 to date.system.N do
    if (not Xm[i]) and (X[i]<=X[P]) then
    P:=i;                { step 4 }
   if Xm[P] then P:=0
            else Xm[P]:=True;          { step 3}
  until P=0;


for i:=1 to date.system.N do
if (X[i]<>$FFFF) and (X[i]<>0)
then begin
n:=i;
     repeat
     if (Xpoint[n]=j) and
     (X[n]<>$FFFF)then
     begin
     date.system.ways[j,i].port:=n;
     date.system.ways[j,i].time:=X[i];
     end;
     if (Xpoint[n]<>j) then
     n:=Xpoint[n];
     if (Xpoint[n]=j) and
     (X[n]<>$FFFF)then
     begin
     date.system.ways[j,i].port:=n;
     date.system.ways[j,i].time:=X[i];
     end;
     until (Xpoint[n]=j)
end;

end;


Xm:=nil;
Xpoint:=nil;
X:=nil;
end;


constructor Tgenetic.Create(GNumber,Gbest,Npriority:inttype;
 var graph:Tgraphgenetic;var system:Tsystemgenetic;
 Mver:realtype);
var
i,j,msg:inttype;
gtmp:inttype;
begin
date.Gnumber:=Gnumber;
date.Gbest:=Gbest;
date.Npriority:=Npriority;
date.Mver:=Mver;

date.system.n:=system.n;
SetLength(date.system.Proc,date.system.n+1);
SetLength(date.system.Ways,date.system.n+1,date.system.n+1);
SetLength(date.system.links,date.system.n+1,date.system.n+1);
SetLength(date.system.duplex,date.system.n+1,date.system.n+1);
for i:=1 to date.system.n do
date.system.Proc[i]:=system.point[i];
for i:=1 to date.system.n do
for j:=1 to date.system.n do
begin
date.system.links[i,j]:=system.links[i,j];
date.system.duplex[i,j]:=system.duplex[i,j];
end;
PPPAll;


date.graph.n:=graph.n;
SetLength(date.graph.Top,date.graph.n+1);
msg:=0;
for i:=1 to date.graph.n do
for j:=1 to date.graph.n do
if graph.links[i,j]<>0 then
inc(msg);
date.graph.Nmsg:=msg;
SetLength(date.graph.msg,date.graph.Nmsg+1);
for i:=1 to date.graph.n do
begin
SetLength(date.graph.Top[i].msg,date.graph.Nmsg+1);
date.graph.Top[i].time:=graph.point[i];
date.graph.Top[i].n:=0;
date.graph.Top[i].recive:=0;
end;
date.graph.Nmsg:=0;
for i:=1 to date.graph.n do
for j:=1 to date.graph.n do
if graph.links[i,j]<>0 then
begin
inc(date.graph.Nmsg);
date.graph.msg[date.graph.Nmsg].from:=i;
date.graph.msg[date.graph.Nmsg].into:=j;
date.graph.msg[date.graph.Nmsg].time:=graph.links[i,j];
inc(date.graph.Top[i].n);
date.graph.Top[i].msg[date.graph.Top[i].n]:=date.graph.Nmsg;
inc(date.graph.Top[j].recive);
end;


SetLength(Date.best,date.Gbest+1);
SetLength(date.genotip,date.Gnumber+1);
SetLength(date.gtmp,date.Gnumber+1);
SetLength(date.bestsort,date.Gbest+1);
SetLength(date.genotipsort,date.Gnumber+1);
for i:=1 to Date.Gbest do
begin
SetLength(date.best[i].Tproc,graph.n+1);
SetLength(date.best[i].Tpriority,graph.n+1);
end;
for i:=1 to Date.Gnumber do
begin
SetLength(date.genotip[i].Tproc,graph.n+1);
SetLength(date.genotip[i].Tpriority,graph.n+1);
SetLength(date.gtmp[i].Tproc,graph.n+1);
SetLength(date.gtmp[i].Tpriority,graph.n+1);
end;
randomize;
for i:=1 to Date.Gnumber do
for j:=1 to Date.graph.n do
begin
date.genotip[i].Tproc[j]:=Trunc(Random(date.system.n+1));
date.genotip[i].Tpriority[j]:=Trunc(Random(date.Npriority+1));
if date.genotip[i].Tproc[j]<1 then
date.genotip[i].Tproc[j]:=1;
if date.genotip[i].Tpriority[j]<1 then
date.genotip[i].Tpriority[j]:=1;
end;

//tmp//
SetLength(tmp.recive,graph.n+1);
SetLength(tmp.timeBegin,graph.n+1);
SetLength(tmp.timeEnd,graph.n+1);
SetLength(tmp.complete,graph.n+1);
SetLength(tmp.priority,graph.n+1);
SetLength(tmp.NMpriority,date.Npriority+1);
SetLength(tmp.Mpriority,date.Npriority+1,graph.n+1);
SetLength(tmp.lnktime,date.system.n+1,date.system.n+1);
SetLength(tmp.processor,graph.n+1);
SetLength(tmp.processorTime,date.system.n+1);
SetLength(tmp.procstep,date.system.n+1);
//tmp//

fenotip;

for i:=1 to date.Gnumber do
date.genotipsort[i]:=i;

for i:=1 to date.Gnumber-1 do
for j:=i to date.Gnumber do
if date.genotip[date.genotipsort[i]].time>
date.genotip[date.genotipsort[j]].time then
begin
gtmp:=date.genotipsort[i];
date.genotipsort[i]:=date.genotipsort[j];
date.genotipsort[j]:=gtmp;
end;

for i:=1 to Date.Gbest do
begin
gtmp:=date.genotipsort[i];
date.best[i].time:=date.genotip[gtmp].time;
for j:=1 to Date.graph.n do
begin
date.best[i].Tproc[j]:=date.genotip[gtmp].Tproc[j];
date.best[i].Tpriority[j]:=date.genotip[gtmp].Tpriority[j];
end;
end;

end;

destructor Tgenetic.Free;
var
i:inttype;
begin
tmp.recive:=nil;
tmp.processor:=nil;
tmp.timeBegin:=nil;
tmp.timeEnd:=nil;
tmp.complete:=nil;
tmp.processorTime:=nil;
tmp.procstep:=nil;
tmp.priority:=nil;
tmp.NMpriority:=nil;
tmp.Mpriority:=nil;
tmp.lnktime:=nil;

date.system.Proc:=nil;
date.system.links:=nil;
date.system.Ways:=nil;
date.graph.msg:=nil;
for i:=1 to date.graph.n do
date.graph.Top[i].msg:=nil;

for i:=1 to date.Gnumber do
begin
date.genotip[i].Tproc:=nil;
date.gtmp[i].Tproc:=nil;
date.genotip[i].Tpriority:=nil;
date.gtmp[i].Tpriority:=nil;
end;

for i:=1 to date.Gbest do
begin
date.best[i].Tproc:=nil;
date.best[i].Tpriority:=nil;
end;

date.graph.Top:=nil;
date.best:=nil;
date.genotip:=nil;
date.gtmp:=nil;
date.bestsort:=nil;
date.genotipsort:=nil;


end;

procedure Tgenetic.crossover;
var
i,j,k:inttype;
begin
randomize;
for i:=1 to date.Gnumber do
begin
k:=trunc(random(date.Gnumber+1));
if k<1 then
k:=1;
for j:=1 to date.graph.n do
if trunc(random(2))<>0 then
begin
date.gtmp[i].Tproc[j]:=date.genotip[k].Tproc[j];
date.gtmp[i].Tpriority[j]:=date.genotip[k].Tpriority[j];
end
else
begin
date.gtmp[i].Tproc[j]:=date.genotip[i].Tproc[j];
date.gtmp[i].Tpriority[j]:=date.genotip[i].Tpriority[j];
end;
end;

for i:=1 to date.Gnumber do
for j:=1 to date.graph.n do
begin
date.genotip[i].Tproc[j]:=date.gtmp[i].Tproc[j];
date.genotip[i].Tpriority[j]:=date.gtmp[i].Tpriority[j];
end;

end;


procedure Tgenetic.mutation;
var
i,j:inttype;
begin
randomize;
for i:=1 to date.Gnumber do
if (random<=date.Mver) then
for j:=1 to Date.graph.n do
if (random<=date.Mver) then
begin
date.genotip[i].Tproc[j]:=Trunc(Random(date.system.n+1));
date.genotip[i].Tpriority[j]:=Trunc(Random(date.Npriority+1));
if date.genotip[i].Tproc[j]<1 then
date.genotip[i].Tproc[j]:=1;
if date.genotip[i].Tpriority[j]<1 then
date.genotip[i].Tpriority[j]:=1;
end;

end;

procedure Tgenetic.fenotip;
var
i,j,m,k,n,msg,complete,now,msgtime,into,port:inttype;
begin
for m:=1 to date.Gnumber do
begin

for i:=1 to date.system.n do
begin
tmp.processorTime[i]:=0;
tmp.procstep[i]:=0;
end;

for i:=1 to date.system.n do
for j:=1 to date.system.n do
tmp.lnktime[i,j]:=0;

for i:=1 to date.graph.n do
if date.graph.Top[i].n>1 then
for j:=1 to date.graph.Top[i].n-1 do
for k:=i+1 to date.graph.Top[i].n do
if (date.genotip[m].Tpriority[date.graph.msg[date.graph.Top[i].msg[j]].into])<
(date.genotip[m].Tpriority[date.graph.msg[date.graph.Top[i].msg[k]].into]) then
begin
n:=date.graph.Top[i].msg[j];
date.graph.Top[i].msg[j]:=date.graph.Top[i].msg[k];
date.graph.Top[i].msg[j]:=n;
end;

for i:=1 to date.graph.n do
begin
tmp.recive[i]:=date.graph.Top[i].recive;
tmp.processor[i]:=date.genotip[m].Tproc[i];
tmp.timeBegin[i]:=0;
tmp.timeEnd[i]:=0;
tmp.complete[i]:=0;
end;

for i:=1 to date.Npriority do
tmp.NMpriority[i]:=0;

for i:=1 to date.graph.n do
begin
inc(tmp.NMpriority[date.genotip[m].Tpriority[i]]);
tmp.Mpriority[date.genotip[m].Tpriority[i],
tmp.NMpriority[date.genotip[m].Tpriority[i]]]:=i;
end;

k:=0;
for i:=date.Npriority downto 1 do
if tmp.NMpriority[i]<>0 then
for j:=1 to tmp.NMpriority[i] do
begin
inc(k);
tmp.priority[k]:=tmp.Mpriority[i,j];
end;

complete:=0;
while complete=0 do
begin

for i:=1 to date.system.n do
tmp.procstep[i]:=0;

{������������, ����� ������, �������� ��������}
for i:=1 to date.graph.n do
begin
k:=tmp.priority[i];
if tmp.complete[k]=0 then
if tmp.recive[k]=0 then
if tmp.procstep[tmp.processor[k]]=0 then
begin

tmp.timeBegin[k]:=max(tmp.timeBegin[k],
tmp.processorTime[tmp.processor[k]]);

tmp.timeEnd[k]:=tmp.timeBegin[k]+date.graph.Top[k].time*
date.system.Proc[tmp.processor[k]];

tmp.processorTime[tmp.processor[k]]:=tmp.timeEnd[k];
tmp.complete[k]:=1;
tmp.procstep[tmp.processor[k]]:=1;

if date.graph.Top[k].n<>0 then
for n:=1 to date.graph.Top[k].n do
begin
msg:=date.graph.Top[k].msg[n];
now:=tmp.processor[k];
into:=tmp.processor[date.graph.msg[msg].into];
msgtime:=tmp.timeEnd[k];

while now<>into do
begin
port:=date.system.Ways[now,into].port;

msgtime:=max(tmp.lnktime[now,port],msgtime);
tmp.lnktime[now,port]:=
msgtime+(date.graph.msg[msg].time*date.system.links[now,port]);
msgtime:=tmp.lnktime[now,port];

{�� ����������}
if date.system.duplex[now,port]=0 then
tmp.lnktime[port,now]:=tmp.lnktime[now,port];

now:=port;
end;

dec(tmp.recive[date.graph.msg[msg].into]);

tmp.timeBegin[date.graph.msg[msg].into]:=
max(tmp.timeBegin[date.graph.msg[msg].into],msgtime)
end;
end;
end;

complete:=1;
for i:=1 to date.graph.n do
if tmp.complete[i]=0 then
complete:=0;
end;

k:=0;
for i:=1 to date.system.n do
k:=max(k,tmp.processorTime[i]);

date.genotip[m].time:=k;
end;
end;

procedure Tgenetic.getbest;
var
i,j,k:inttype;
gtmp:inttype;
begin

for i:=1 to date.Gnumber-1 do
for j:=i to date.Gnumber do
if date.genotip[date.genotipsort[i]].time>
date.genotip[date.genotipsort[j]].time then
begin
gtmp:=date.genotipsort[i];
date.genotipsort[i]:=date.genotipsort[j];
date.genotipsort[j]:=gtmp;
end;

k:=date.Gnumber-date.Gbest+1;
for i:=k to Date.Gnumber do
begin

gtmp:=date.genotipsort[i];
date.genotip[gtmp].time:=date.best[i-k+1].time;
for j:=1 to Date.graph.n do
begin
date.genotip[gtmp].Tproc[j]:=date.best[i-k+1].Tproc[j];
date.genotip[gtmp].Tpriority[j]:=date.best[i-k+1].Tpriority[j];
end;
end;


for i:=1 to date.Gnumber-1 do
for j:=i to date.Gnumber do
if date.genotip[date.genotipsort[i]].time>
date.genotip[date.genotipsort[j]].time then
begin
gtmp:=date.genotipsort[i];
date.genotipsort[i]:=date.genotipsort[j];
date.genotipsort[j]:=gtmp;
end;

for i:=1 to Date.Gbest do
begin
gtmp:=date.genotipsort[i];
date.best[i].time:=date.genotip[gtmp].time;
for j:=1 to Date.graph.n do
begin
date.best[i].Tproc[j]:=date.genotip[gtmp].Tproc[j];
date.best[i].Tpriority[j]:=date.genotip[gtmp].Tpriority[j];
end;
end;

end;


procedure Tgenetic.getAllbest(var BB:array of Tgenotip);
var
i,j:inttype;
begin
for i:=1 to date.Gbest do
begin
BB[i].time:=date.best[i].time;
for j:=1 to date.graph.n do
begin
BB[i].Tproc[j]:=date.best[i].Tproc[j];
BB[i].Tpriority[j]:=date.best[i].Tpriority[j];
end;
end;

end;

procedure Tgenetic.bestofbest(var BB:Tgenotip);
var
j:inttype;
begin
BB.time:=date.best[1].time;
for j:=1 to date.graph.n do
begin
BB.Tproc[j]:=date.best[1].Tproc[j];
BB.Tpriority[j]:=date.best[1].Tpriority[j];
end;
end;

procedure Tgenetic.getNbest(var N:inttype);
begin
n:=date.Gbest;
end;
end.
