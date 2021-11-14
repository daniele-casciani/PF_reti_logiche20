library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shif_left is
	port ( 
			x: in std_logic_vector ( 30 downto 0);
			y: in std_logic;
			z: out std_logic_vector (31 downto 0));
end shif_left;

architecture rtl of shif_left is
begin	
	z <= x (30 downto 0) & y; 
end rtl;
