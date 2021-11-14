--
-- Create Date:   16:27:22 11/16/2020
-- Design Name:   
-- Module Name:   C:/.Xilinx/project_reti/TB3X32BIT.vhd
-- Project Name:  project_reti
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Fsa
-- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB3X32BIT IS
END TB3X32BIT;
 
ARCHITECTURE behavior OF TB3X32BIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Fsa
    PORT(
         N : IN  std_logic_vector(31 downto 0);
         D : IN  std_logic_vector(31 downto 0);
         CLK : IN  std_logic;
         RESET : IN  std_logic;
			START : IN  std_logic;
			FINISH: OUT std_logic;
			ERROR: OUT std_logic;
         Q : OUT  std_logic_vector(31 downto 0);
         R : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal N : std_logic_vector(31 downto 0) := (others => '0');
   signal D : std_logic_vector(31 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
	signal START : std_logic := '0';
	

 	--Outputs
	signal FINISH : std_logic;
	signal ERROR:  std_logic;
   signal Q : std_logic_vector(31 downto 0);
   signal R : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Fsa PORT MAP (
          N => N,
          D => D,
          CLK => CLK,
          RESET => RESET,
			 START => START,
			 FINISH => FINISH,
			 ERROR => ERROR,
          Q => Q,
          R => R
        );


   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 


   -- Stimulus process
   stim_proc: process
   begin		
		
		RESET <= '1';
		wait for 1000 ns;
		RESET <= '0';
		N <= "00000000000000000000000001011010";
		D <= "00000000000000000000000000001001";
		--q = 1010 r = 0
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
		wait for 5000 ns;
		START <= '1';
		N <= "00000000000000000000000000111000";
		D <= "00000000000000000000000000001000";
		-- q = 111 r = 0
		wait for 400 ns;
		START <= '0';
		wait for 5000 ns;
		START <= '1';
		N <= "00000000000000000000000000111000";
		D <= "00000000000000000000000000111000";
		-- q = 1 r = 0
		wait for 400 ns;
		START <= '0';
		wait for 3000 ns;
		D <= "00000000000000000000000000000000";
		-- error = 1
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
		wait for 1000 ns;
		N <= "00000000000000000000000100010001";
		D <= "00000000000000000000000000011011";
		-- q = 1010 r = 11
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
		wait for 4000 ns;
		N <= "00000000000000000000000110010001";
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
		wait for 3200 ns;
		N <= "00000000000000000000000100111111";
		D <= "00000000000000000000000000111010";
		-- q = 101 r = 11101
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
		wait for 4000 ns;
		N <= "00000000000000010100000000010001";
		D <= "00000000001010000000001000000011";
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
		wait for 1000 ns;
		N <= "00000000000000010100001000010001";
		D <= "00000000000000000000001000000011";
		wait for 300 ns;
		START <= '1';
		wait for 100 ns;
		START <= '0';
      wait;
   end process;

END;
