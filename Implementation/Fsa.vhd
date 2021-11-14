library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Fsa is
	port( N:	 		in std_logic_vector(31 downto 0);
			D: 		in std_logic_vector(31 downto 0);
			CLK: 		in std_logic;
			RESET: 	in std_logic;
			START:	in std_logic;
			FINISH:	out std_logic;
			ERROR:	out std_logic;
			Q: 		out std_logic_vector(31 downto 0);
			R: 		out std_logic_vector(31 downto 0)
			);
end Fsa;

architecture rtl of Fsa is
	
	COMPONENT comp_5bit
	PORT(
		X : IN std_logic_vector(4 downto 0);          
		Z : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT comparator_32bit
	PORT(
		X : IN std_logic_vector(31 downto 0);          
		Z : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT shif_left
	PORT(
		x : IN std_logic_vector(30 downto 0);
		y : IN std_logic;          
		z : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT adder_subtractor_32bit
	PORT(
		X : IN std_logic_vector(31 downto 0);
		Y : IN std_logic_vector(31 downto 0);
		S : IN std_logic;          
		CN : OUT std_logic;
		K : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;	
	
	COMPONENT adder_subtractor_5bit
	PORT(
		X : IN std_logic_vector(4 downto 0);
		Y : IN std_logic_vector(4 downto 0);
		S : IN std_logic;          
		K : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
	signal next_resto, next_quo, next_rout, next_qout: std_logic_vector(31 downto 0);
	signal resto_s1, resto_s2:  std_logic_vector(31 downto 0);
	signal resto_temp, quo_temp: std_logic_vector(30 downto 0);
	signal dvn, dvs: std_logic_vector(31 downto 0);	
	signal count, next_count: std_logic_vector(4 downto 0);
	signal bit_temp, x,signal_error, signal_end, next_end:	std_logic;
	
begin
	
--	resto_s1 <= resto_temp(30 downto 0) & bit temp;
	S1: shif_left PORT MAP(
		x =>	resto_temp,
		y => 	bit_temp,
		z => 	resto_s1
	);
	
	--resto_s2 	<= resto_s1 - dvs; select x it takes 1 if is resto_s1 >= dvs
	subtractor1_32bit: adder_subtractor_32bit PORT MAP(
		X => 		resto_s1,
		Y => 		dvs,
		S => 		'1',
		CN => 	x,
		K => 		resto_s2
	);
	
	-- next resto x = cn
	with x select
	next_resto <= 	resto_s2 when '1',
						resto_s1	when '0',
						"--------------------------------" when others;
	
	-- next quo
	S2: shif_left PORT MAP(
		x =>	quo_temp,
		y =>  x,
		z => 	next_quo
	);
	
	--next_count	<= count - 1;
	subtractor_5bit: adder_subtractor_5bit PORT MAP(
		X => count,
		Y => "00001",
		S => '1', 
		K => next_count
	);
	-- bit temp
	with count select 
	bit_temp <=	dvn(31) when "11111",
					dvn(30) when "11110",
					dvn(29) when "11101",
					dvn(28) when "11100",
					dvn(27) when "11011",
					dvn(26) when "11010",
					dvn(25) when "11001",
					dvn(24) when "11000",
					dvn(23) when "10111",
					dvn(22) when "10110",
					dvn(21) when "10101",
					dvn(20) when "10100",
					dvn(19) when "10011",
					dvn(18) when "10010",
					dvn(17) when "10001",
					dvn(16) when "10000",
					dvn(15) when "01111",
					dvn(14) when "01110",
					dvn(13) when "01101",
					dvn(12) when "01100",
					dvn(11) when "01011",
					dvn(10) when "01010",
					dvn(9) when "01001",
					dvn(8) when "01000",
					dvn(7) when "00111",
					dvn(6) when "00110",
					dvn(5) when "00101",
					dvn(4) when "00100",
					dvn(3) when "00011",
					dvn(2) when "00010",
					dvn(1) when "00001",
					dvn(0) when "00000",
					'-'	 when others;
					
	--error cmp 32 bit in dvs out signel error
	COMP_0X32BIT_SEQ: comparator_32bit PORT MAP(
		X => dvs,
		Z => signal_error
	);
	
	--end function	cmp 5 bit in count exit signal end
	COMP_0X5BIT_SEQ: comp_5bit PORT MAP(
		X => count,
		Z => signal_end
	);
	
	-- Outputs
	Q <= next_qout;
	R <= next_rout;
	ERROR <= signal_error;
	FINISH <= next_end;			
	-- State register
	state_register: process ( CLK )
	begin
		if ( CLK' event and CLK = '1') then 
			if (RESET = '1') then
					count 		<= 	"11111";
					quo_temp 	<= 	"0000000000000000000000000000000";
					resto_temp 	<= 	"0000000000000000000000000000000";
					dvn 			<= 	"11111111111111111111111111111111";
					dvs 			<= 	"11111111111111111111111111111111";
					next_qout	<= 	"00000000000000000000000000000000";
					next_rout	<= 	"00000000000000000000000000000000";
					next_end		<= 	'0';
					
			elsif ( START = '1') then 
					--saving input
					dvn 			<= 	N;	
					dvs 			<= 	D;
					-- resetting signal
					quo_temp 	<= 	"0000000000000000000000000000000";
					resto_temp 	<= 	"0000000000000000000000000000000";
					count 		<= 	"11111";
					next_qout	<= 	next_qout;
					next_rout	<= 	next_rout;
					next_end		<= 	'0';
					
			elsif( signal_end = '1') then 
					dvn 			<= 	dvn;	
					dvs 			<= 	dvs;
					resto_temp 	<= 	resto_temp;
					quo_temp 	<= 	quo_temp;
					count 		<=		count;
					next_qout	<= 	next_quo;
					next_rout	<= 	next_resto;
					next_end		<= 	'1';
			else 
					dvn 			<= 	dvn;	
					dvs 			<= 	dvs;
					resto_temp 	<= 	next_resto (30 downto 0);
					quo_temp 	<= 	next_quo (30 downto 0);
					count 		<=		next_count;
					next_qout	<= 	next_qout;
					next_rout	<= 	next_rout;
					next_end		<= 	'0';
			end if;
		end if;
	end process;
end rtl;	
