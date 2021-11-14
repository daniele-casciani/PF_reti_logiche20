library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_subtractor_32bit is
	port(
		X: 	in std_logic_vector(31 downto 0);
		Y: 	in std_logic_vector(31 downto 0);
		S: 	in std_logic;
		CN:	out std_logic;
		K:		out std_logic_vector(31 downto 0)
	);
end adder_subtractor_32bit;

architecture rtl of adder_subtractor_32bit is

	COMPONENT RCA_32bit
		PORT(
			X : IN std_logic_vector(31 downto 0);
			Y : IN std_logic_vector(31 downto 0);
			CIN : IN std_logic;          
			COUT : OUT std_logic;
			S : OUT std_logic_vector(31 downto 0)
			);
	END COMPONENT;
	
	signal Z: std_logic_vector(31 downto 0);
	
begin
	
	G1: for N in 0 to 31 generate
		Z(N) <= Y(N) xor S;
	end generate;
	
	Inst_RCA_32bit: RCA_32bit PORT MAP(
		X => 		X,
		Y => 		Z,
		CIN => 	S,
		COUT => 	CN,
		S => 		K
	);

end rtl;
