library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity comparator_32bit is
	port(
		X: 	in std_logic_vector(31 downto 0);
		Z:		out std_logic
	);
end comparator_32bit;

architecture Behavioral of comparator_32bit is
	signal K: std_logic;
	
begin
	K <= X(31) OR X(30) OR X(29) OR X(28) OR X(27) OR X(26) OR X(25) OR X(24) OR X(23) OR X(22) OR X(21) OR
		X(20) OR X(19) OR X(18) OR X(17) OR X(16) OR X(15) OR X(14) OR X(13) OR
		X(12) OR X(11) OR X(10) OR X(9) OR X(8) OR X(7) OR X(6) OR X(5) OR X(4) 
		OR X(3) OR X(2) OR X(1) OR X(0);
		
	Z <= NOT K;
end Behavioral;
