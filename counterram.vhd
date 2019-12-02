library ieee;
use ieee.std_logic_1164.all;
use work.segment_pkg.all;


entity counterram is
	port(
		clk: in std_logic;
		reset: in std_logic;
		load_value: in std_logic;
		next_address: in std_logic;
		previous_address: in std_logic;
        o_bin_led: out std_logic_vector(7 downto 0);
        o_hex_addr: out address_segment
	);
end entity counterram;

architecture rtl of counterram is
	signal s_load_value: std_logic;
	signal s_next_address: std_logic;
	signal s_previous_address: std_logic;
	
	component debounce is
		PORT(
			i_clk		: IN std_logic;
			i_switch	: IN std_logic;
			o_switch	: OUT std_logic
		);
	end component debounce;
    
    component counter is
        port(
            clk: in std_logic;
            reset: in std_logic;
            next_address: in std_logic;
            previous_address: in std_logic;
            load_address: in std_logic;
            o_bin: out std_logic_vector(7 downto 0);
            o_hex_addr: out address_segment
        );
    end component counter;
    
begin

	--d1: debounce port map(clk, load_value, s_load_value);
	--d2: debounce port map(clk, next_address, s_next_address);
	--d3: debounce port map(clk, previous_address, s_previous_address);

    
    c1: counter port map(clk, '1', next_address, previous_address, s_load_value, o_bin_led, o_hex_addr);
    
end architecture;