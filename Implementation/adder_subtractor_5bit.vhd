library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_subtractor_5bit is
	port(
		X: 	in std_logic_vector(4 downto 0);
		Y: 	in std_logic_vector(4 downto 0);
		S: 	in std_logic;
		
		K:		out std_logic_vector(4 downto 0)
	);
end adder_subtractor_5bit;

architecture rtl of adder_subtractor_5bit is

	COMPONENT RCA_5bit
		PORT(
			X : IN std_logic_vector(4 downto 0);
			Y : IN std_logic_vector(4 downto 0);
			CIN : IN std_logic;          
			
			S : OUT std_logic_vector(4 downto 0)
			);
	END COMPONENT;
	
	signal Z: std_logic_vector(4 downto 0);
	
begin
	
	G1: for N in 0 to 4 generate
		Z(N) <= Y(N) xor S;
	end generate;
	
	Inst_RCA_5bit: RCA_5bit PORT MAP(
		X => 		X,
		Y => 		Z,
		CIN => 	S,

		S => 		K
	);

end rtl;
