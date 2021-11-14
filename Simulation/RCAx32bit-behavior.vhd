LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RCAx32bit IS
END RCAx32bit;
 
ARCHITECTURE behavior OF RCAx32bit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_subtractor_32bit
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         Y : IN  std_logic_vector(31 downto 0);
         S : IN  std_logic;
         CN : OUT  std_logic;
         K : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal Y : std_logic_vector(31 downto 0) := (others => '0');
   signal S : std_logic := '0';

 	--Outputs
   signal CN : std_logic;
   signal K : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder_subtractor_32bit PORT MAP (
          X => X,
          Y => Y,
          S => S,
          CN => CN,
          K => K
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
     S <= '0'; -- ADD FUNCTION
	  X <= "00000000000000000000000000000000";
	  Y <= "00000000000000000000000000000000";
     wait for 100 ns;	
			X <= "10101010101010101010101010101010";
			Y <= "00101010101010101010101010101010";
     wait for 100 ns;	
			X <= "00000000000000000000101010101010";
			Y <= "00000000000000000000000000000010";
		wait for 200 ns;
		S <= '1'; -- sub FUNCTION
		X <= "00000000000000000000000000001101";
		Y <= "00000000000000000000000000000100";
		wait for 100 ns;	
			X <= "00000000000000000000000000001010";
			Y <= "00000000000000000000000000000011";
		wait for 100 ns;	
			X <= "00000000000000000000000000001111";
			Y <= "00000000000000000000000000000101";
		wait for 100 ns;	
			X <= "00000000000000000000000000000101";
			Y <= "00000000000000000000000000001111";
		wait for 100 ns;	
			X <= "00000000000000000000000000000011";
			Y <= "00000000000000000000000000000101";
		wait for 100 ns;	
			X <= "00000000000000000000000000000111";
			Y <= "00000000000000000000000000001101";
		wait for 100 ns;
		X <= "00000000000000000000000000000000";
	  Y <= "00000000000000000000000000000000";
     wait for 100 ns;	
			X <= "10101010101010101010101010101010";
			Y <= "00101010101010101010101010101010";
     wait for 100 ns;	
			X <= "00000000000000000000101010101010";
			Y <= "00000000000000000000000000000010";
		
     wait;
   end process;

END;