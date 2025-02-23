----------------------------------------------------------------
--              Paralel and distributed computing             --
--                     Laboratory work #1                     --
--                   IO-73 Pustovit Michael                   --
----------------------------------------------------------------
--Variant: 1.27, 2.14, 3.18                                   --
--F1: e = (A*B) + (C*D);                                      --
--Func2: MC = SORT(MA + MB*MO);                                  --
--Func3: p = MAX(SORT(MS) + MA*MB).                              --
----------------------------PACK PROGRAM------------------------
--This program uses StartPack package                         --
----------------------------------------------------------------

with Module,
     module.F2,
     module.F2.F3,
     module.F2.FIO,
     Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab2 is
   package Modu is new Module(3);
   use Modu;

   package Modu_F2 is new Modu.F2;
   use Modu_F2;

   package Modu_F3 is new Modu_F2.F3;
   use Modu_F3;

   package Modu_IO is new Modu_F2.FIO;
   use Modu_IO;

   --Main program variables
   A, B, C, D: Vector;
   MA, MB, MO, MS, MC: Matrix;
   e, p:integer;
begin
   --Func1
   Put_Line("Func1");
   Put_Line("Input vector A");
   VectInput(A);
   Put_Line("Input vector B");
   VectInput(B);
   Put_Line("Input vector C");
   VectInput(C);
   Put_Line("Input vector D");
   VectInput(D);
   Func1(A, B, C, D, e);
   Put_Line("Func1 result");
   Ada.Integer_Text_IO.Put(e);
   New_Line;

   --Func2
   Put_Line("Func2");
   Put_Line("Input matrix MA");
   MatrixInput(MA);
   Put_Line("Input matrix MB");
   MatrixInput(MB);
   Put_Line("Input matrix MO");
   MatrixInput(MO);
   Func2(MA, MB, MO, MC);
   Put_Line("Func2 result");
   MatrixOutput(MC);

   --Func3
   Put_Line("Func3");
   Put_Line("Input matrix MS");
   MatrixInput(MS);
   p := Func3(MS, MA, MB);
   Put_Line("Func3 result");
   Ada.Integer_Text_IO.Put(p);
end Lab2;