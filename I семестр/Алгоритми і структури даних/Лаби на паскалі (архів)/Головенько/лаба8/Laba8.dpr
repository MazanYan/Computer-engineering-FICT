program Laba8;

{$APPTYPE CONSOLE}


uses
  Unit2 in 'Unit2.pas';

begin
  CreateMatrix(n, f, Matrix);
  CreateVector(n, Matrix, Vector);
  SortVector(n,Vector);
  WriteVector(n, Vector);
  WriteMatrix(n, Matrix);
end.
