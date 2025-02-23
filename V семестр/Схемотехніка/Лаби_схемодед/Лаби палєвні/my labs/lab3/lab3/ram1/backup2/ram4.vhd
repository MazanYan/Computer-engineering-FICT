library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ram4 is
	port (
		CLK : in STD_LOGIC;
		WR : in STD_LOGIC;
		RD  : in STD_LOGIC;
		DI  : in STD_LOGIC;
		A12 : in STD_LOGIC;
		DC5 : in STD_LOGIC_VECTOR(3 downto 0);
		DC4 : in STD_LOGIC_VECTOR(3 downto 0);
		DC3 : in STD_LOGIC_VECTOR(3 downto 0);
		DC2 : in STD_LOGIC_VECTOR(3 downto 0);
		DC : in STD_LOGIC_VECTOR(1 downto 0);
		BI  : out STD_LOGIC
	);
end ram4;

architecture Behavior of ram4 is
	component ram3 port (
		CLK : in STD_LOGIC;
		WR : in STD_LOGIC;
		RD  : in STD_LOGIC;
		DI  : in STD_LOGIC;
		A12 : in STD_LOGIC;
		DC5 : in STD_LOGIC_VECTOR(3 downto 0);
		DC4 : in STD_LOGIC_VECTOR(3 downto 0);
		DC3 : in STD_LOGIC_VECTOR(3 downto 0);
		DC : in STD_LOGIC_VECTOR(2 downto 0);
		BI  : out STD_LOGIC );
	end component;
	
begin
	U1_ram3: ram3 port map
		(CLK => CLK, WR => WR, RD => RD, DI => DI, A12 => A12, 
		DC5 => DC5, DC4 => DC4, DC3 => DC3, DC(2) => DC2(3), DC(1 downto 0) => DC, BI => BI);
	U2_ram3: ram3 port map
		(CLK => CLK, WR => WR, RD => RD, DI => DI, A12 => A12, 
		DC5 => DC5, DC4 => DC4, DC3 => DC3, DC(2) => DC2(2), DC(1 downto 0) => DC, BI => BI);
	U3_ram3: ram3 port map
		(CLK => CLK, WR => WR, RD => RD, DI => DI, A12 => A12, 
		DC5 => DC5, DC4 => DC4, DC3 => DC3, DC(2) => DC2(1), DC(1 downto 0) => DC, BI => BI);
	U4_ram3: ram3 port map
		(CLK => CLK, WR => WR, RD => RD, DI => DI, A12 => A12, 
		DC5 => DC5, DC4 => DC4, DC3 => DC3, DC(2) => DC2(0), DC(1 downto 0) => DC, BI => BI);
end Behavior;