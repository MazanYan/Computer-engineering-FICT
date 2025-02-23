unit snowU;
interface
type
    tI = 1..10000;
    tM = array[tI,tI] of integer;

procedure right(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
procedure down(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
procedure up(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
procedure left(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
procedure outs(n: tI; m : tM);

implementation
procedure right(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
var
    i : tI;
begin
    if a < n div 2 then
        for i := a to n-a+1 do
            begin
                m[a,i]:= e;
                e := e + s;
            end;
    //a := a + 1;
    down(n,m,a,e,s);
end;
procedure down(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
var
    i : tI;
begin
    if a < n div 2 then
        for i := a+1 to n-a+1 do
            begin
                m[i,n-a+1]:= e;
                e := e + s;
            end;
    //a := a + 1;
    left(n,m,a,e,s);
end;
procedure left(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
var
    i : tI;
begin
    if a < n div 2 then
        for i := n-a downto a do
            begin
                m[n-a+1,i]:= e;
                e := e + s;
            end;
    //a := a + 1;
    up(n,m,a,e,s);
end;
procedure up(n : tI; var m : tM; var a : tI; var e : integer; s: integer);
var
    i : tI;
begin
    if a < n div 2 then
        for i := n-a downto a+1 do
            begin
                m[i,a]:= e;
                e := e + s;
            end;
    a := a + 1;
    right(n,m,a,e,s);
end;

procedure outs(n: tI; m : tM);
var
    i,j : tI;
begin
    for i := 1 to n do
        begin
            for j := 1 to n do
                write(m[i,j]:4);
            writeln();
        end
end;

begin

end.