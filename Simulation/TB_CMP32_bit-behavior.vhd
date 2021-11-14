LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_CMP32_bit IS
END TB_CMP32_bit;
 
ARCHITECTURE behavior OF TB_CMP32_bit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comparator_32bit
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         Z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Z : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comparator_32bit PORT MAP (
          X => X,
          Z => Z
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		X <= "00000000000000000001100000000000";
		wait for 100 ns;	
		X <= "00000000000000000010000000000000";
		wait for 100 ns;	
		X <= "00000000011000000000000000000000";
		wait for 100 ns;	
		X <= "00000000000000000011100000000000";
		wait for 100 ns;	
		X <= "00000000000000000000000000000000";
		wait for 100 ns;	
		X <= "00000000000000000011110000000000";
		
		
      wait;
   end process;

END;
