program laba2;

{$APPTYPE CONSOLE}

var
   x: real;
   y: integer;
   S: real;
   q: integer;
   i: integer;
begin
  write('������� �������� ���������� x: ');
  readln(x);
  write('������� �������� ���������� y: ');
  readln(y);
  if x = 0
    then
      if y > 0
        then
          begin
            S := 0;
            writeln('���������� y ����� ���� ����� ������������� ������ S=',S:0:8);
          end
        else
          writeln('�� ��������� ������� ������')
    else
      begin
        S := 1;
        q := abs(y);
        for i := 1 to q do
          if y < 0
            then
              S := S*(1/x)
            else
              S := S*x;
        writeln('S=', S:0:8);
      end;
  readln;
end.
