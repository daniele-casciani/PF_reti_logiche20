LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_comparato_5bit IS
END TB_comparato_5bit;
 
ARCHITECTURE behavior OF TB_comparato_5bit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comp_5bit
    PORT(
         X : IN  std_logic_vector(4 downto 0);
         Z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Z : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comp_5bit PORT MAP (
          X => X,
          Z => Z
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		x <= "01001";
		wait for 100 ns;	
		x <= "00000";
		wait for 100 ns;	
		x <= "11111";
		wait for 100 ns;	
		x <= "00000";
		wait for 100 ns;	
		x <= "11110";
		wait for 100 ns;	
		x <= "00011";
		wait for 100 ns;	
		x <= "10111";
		wait for 100 ns;	
		x <= "01110";
		wait for 100 ns;	
		x <= "10000";





      wait;
   end process;

END;
