library IEEE;

use IEEE.STD_LOGIC_1164.all;

-- �������� ������� PLM � 3 �������

entity PLM_3 is
	generic ( td: TIME := 0 ns );	-- ��������
	port
	( 
		A : in STD_LOGIC;		-- ������� ����������
		B : in STD_LOGIC;
		C : in STD_LOGIC;
		Y : out STD_LOGIC		-- ���������
	);
end PLM_3;