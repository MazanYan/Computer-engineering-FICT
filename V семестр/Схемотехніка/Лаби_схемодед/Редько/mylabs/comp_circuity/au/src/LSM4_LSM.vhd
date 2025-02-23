
library IEEE;

use IEEE.STD_LOGIC_1164.all;

architecture LSM4_LSM of LSM4 is
	signal xi, yi, di, c : STD_LOGIC_VECTOR(4 downto 0);
begin
	
	c(0) <= c0;
	
	LSM4_X_Y: for i in 0 to 3 generate
		
		LNI: entity work.PLM_6(PLM6_X) port map
			(A => P(i), B => Q(i), C => F(0), D => F(1), E => F(2), F => F(3), Y => xi(i));
		
		LNQ: entity work.PLM_5(PLM5_Y) port map
			(A => Q(i), B => F(0), C => F(1), D => F(2), E => F(3),	Y => yi(i));
		
	end generate;
	
	LNC1: entity work.PLM_6_2(PLM6_C) port map
		(A => c(0), B => xi(0), C => xi(1), D => yi(0), E => yi(1), F => F(2),
		Y0 => c(2), Y1 => c(1));
	
	LNC2: entity work.PLM_6_2(PLM6_C) port map
		(A => c(2), B => xi(2), C => xi(3), D => yi(2), E => yi(3), F => F(2),
		Y0 => c(4), Y1 => c(3));
	
	LSM4_xor2: for i in 0 to 3 generate
		
		XOR2: entity work.PLM_3(PLM3_xor3) port map
			(A => xi(i), B => yi(i), C => c(i), Y => di(i));
		
	end generate;
	
	D <= di(3 downto 0);  
	CI <= c(4);
	
end LSM4_LSM;
