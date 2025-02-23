library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity et is
	port (
		CLK : in STD_LOGIC;
		WR0 : in STD_LOGIC;
		RD  : in STD_LOGIC;
		DI  : in STD_LOGIC;
		A12 : in STD_LOGIC;
		DCA : in STD_LOGIC_VECTOR(5 downto 0);
		Et  : out STD_LOGIC
	);
end et;

architecture Behavior of et is
	component DFF port (
		D   : in STD_LOGIC;
      CLK : in STD_LOGIC;
      CLRN: in STD_LOGIC;
      PRN : in STD_LOGIC;
      Q   : out STD_LOGIC );
	end component;
	
	component TRI port (
		A_IN : in STD_LOGIC;
      OE: in STD_LOGIC;
      A_OUT: out STD_LOGIC );
	end component;
	
	constant gnd : STD_LOGIC := '0';
	signal q, clock, tmp : STD_LOGIC;
begin
	clock <= CLK and WR0 and A12 and DCA(5)and DCA(4)and DCA(3)and DCA(2)and DCA(1)and DCA(0);
	tmp <= RD and A12 and DCA(5)and DCA(4)and DCA(3)and DCA(2)and DCA(1)and DCA(0);
	U_DFF: DFF port map
		(D => Di, CLK => clock, Q => q, CLRN => gnd, PRN => gnd);
	U_TRI: TRI port map
		(A_IN => q, OE => tmp, A_OUT => Et);
end Behavior;