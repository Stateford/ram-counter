library ieee;
use ieee.std_logic_1164.all;


entity segment is
	port(
		i_bin: in std_logic_vector(7 downto 0);
		o_bcd: out std_logic_vector(6 downto 0)
	);
end entity segment;

architecture Behavioral of segment is

begin

	with (i_bin) select
		O_bcd <= "1111110" when X"00",
					"0110000" when x"01",
					"1101101" when x"02",
					"1111001" when x"03",
					"0110011" when x"04",
					"1011011" when x"05",
					"1011111" when x"06",
					"1110000" when x"07",
					"1111111" when x"08",
					"1111011" when x"09",
				   "0000000" when others;
	
end architecture Behavioral;