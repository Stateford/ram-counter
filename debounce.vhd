-- DEBOUNCE CODE FROM
-- https://www.nandland.com/goboard/debounce-switch-project.html
-- Prevents push button from bouncing

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce is
	port(
		i_clk		: in std_logic;
		i_switch	: in std_logic;
		o_switch	: out std_logic
	);
end entity;

architecture Behavior OF debounce is

	CONSTANT c_DEBOUNCE_LIMIT : integer := 500000;

	signal r_count : integer range 0 to c_DEBOUNCE_LIMIT := 0;
	signal r_state : std_logic := '0';
	
begin

	process (i_clk) is
	begin
	
		if rising_edge(i_clk) then
		
			if(i_switch /= r_state AND r_count < c_DEBOUNCE_LIMIT) then
				r_count <= r_count + 1;
			elsif r_count = c_DEBOUNCE_LIMIT then
				r_state <= i_switch;
				r_count <= 0;
			else
				r_count <= 0;
			end if;
		end if;
	end process;
	
	o_switch <= r_state;

end architecture Behavior;