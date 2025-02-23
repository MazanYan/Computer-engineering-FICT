----------------------------------------------------------------
--              Paralel and distributed computing             --
--             Laboratory work #1. Ada. Semaphores            --
--                  Func: a = MIN(MO*MX+alfa*MR)              --
--                   IO-83 Vorobyev Vitaliy                   --
--                        9.02.2011                           --
----------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Synchronous_Task_Control; use Ada.Synchronous_Task_Control;

procedure Lab1 is
   N: integer := 500;   --size of structures
   P: integer := 2;   --count of processors
   H: integer := N/P; --size of piece

   type Vec  is array (1..N) of integer;
   type Matr is array (1..N) of Vec;

   MO, MX, MR: Matr;
   a:          integer := 500000; --min - shared variable
   Alfa:	   Integer;

   --semaphores
   S1, S2, S3, var1, var2: Suspension_Object; 

   procedure Constant_Out(a: integer) is	
   begin
	  Put(a, 4);
	  New_Line;
   end Constant_Out;

   procedure Vec_print(v: Vec) is
   begin
      for i in 1 .. N loop
         Put(v(i), 4);
      end loop;
   end;

   procedure Matr_print(m: Matr) is
   begin
      for i in 1..n loop
         Vec_print(m(i));
         New_Line;
      end loop;
   end Matr_print;

   procedure Task_start is
      task T1;
      task body T1 is
         alfa1: integer;
		 Sum: Integer := 0;
		 A1: Integer := 530000;
         MO1, MBUF1: Matr;
      begin
         Put_Line("T1 start");
         --Data entering
         for i in 1 .. N loop
            for j in 1 .. N loop
               MR(i)(j) := 1;
			   MX(i)(j) := 1;
            end loop;
         end loop;

         Set_True(S1);			 --S2-1
		 Suspend_until_true(S2); --W2-1

		 -- Calculating function
		 Suspend_Until_True(Var1);
         alfa1 := alfa;
         MO1 := MO;
         Set_True(Var1);

		 for i in 1.. N loop
            for j in 1 .. H loop
			   sum := 0;
               for z in 1 .. N loop
                  sum := sum + MO1(i)(z) * MX(Z)(J);
               end loop;
			   MBUF1(I)(J) := Sum + Alfa1 * MR(I)(J);
			   if (A1 > Sum) then
			   	  A1 := Sum;
		   	   end if;
			   Sum := 0;
			end loop;
         end loop;
		 Sum := 0;

         Suspend_until_true(Var2);
         if (a > a1) then
            a := a1;
         end if;
         Set_True(Var2);

         Set_True(S3);           --S2-2

         Put_Line("T1 stop");
      end T1;

      task T2;
      task body T2 is
         alfa2: integer;
		 A2: Integer := 540000;
		 Sum: Integer := 0;
         MO2, MBUF2: Matr;
      begin
         Put_Line("T2 start");
         --Data entering
         for i in 1 .. N loop
            for j in 1 .. N loop
               MO(i)(j) := 1;
            end loop;
         end loop;

		 alfa := 1;

		 Suspend_until_true(S1); --W1-1
		 Set_True(S2);			 --S1-1

		 -- Calculating function
		 Suspend_until_true(Var1);
         alfa2 := alfa;
         MO2 := MO;
         Set_True(Var1);

		 for i in 1.. N loop
            for j in H+1 .. N loop
			   sum := 0;
               for z in 1 .. N loop
                  sum := sum + MO2(i)(z) * MX(Z)(J);
               end loop;
			   MBUF2(I)(J) := Sum + Alfa2 * MR(I)(J);
			   if (A2 > Sum) then
			   	  A2 := Sum;
		   	   end if;
			   Sum := 0;
			end loop;
         end loop;
		 Sum := 0;

         Suspend_until_true(Var2);
         if (a > a2) then
		 	A := A2;
         end if;
         Set_True(Var2);

         Suspend_until_true(S3); --W1-2

		 Constant_Out(A);

         Put_Line("T2 stop");
      end T2;

   begin
      null;
   end Task_start;

begin
   Set_True(Var1);
   Set_True(Var2);
   Task_start;
end Lab1;
