library ieee;
use ieee.std_logic_1164.all;

entity multisegment is
	port(
		i_bin: in std_logic_vector(7 downto 0);
		ds1, ds2, ds3, ds4: out std_logic;
		o_bcd: out std_logic_vector(6 downto 0)
	);
end entity multisegment;

architecture rtl of multisegment is

	component segment is
		port(
			i_bin: in std_logic_vector(7 downto 0);
			o_bcd: out std_logic_vector(6 downto 0)
		);
	end component segment;
	
	type digit_select is (ONE, TWO, THREE, FOUR);
	signal digit_selector: digit_select;
begin

	-- TODO: set segments for four digit display

	s1: segment port map(i_bin, o_bcd);

end architecture;