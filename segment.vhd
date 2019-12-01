library ieee;
use ieee.std_logic_1164.all;


entity segment is
	port(
		i_bin: in std_logic_vector(3 downto 0);
		o_bcd: out std_logic_vector(6 downto 0)
	);
end entity segment;

architecture Behavioral of segment is
begin

	with (i_bin) select
        --           abcdefg
		O_bcd <=    "1111110" when X"0",
					"0110000" when x"1",
					"1101101" when x"2",
					"1111001" when x"3",
					"0110011" when x"4",
					"1011011" when x"5",
					"1011111" when x"6",
					"1110000" when x"7",
					"1111111" when x"8",
					"1110011" when x"9",
                    "1110111" when x"A",
                    "0011111" when x"B",
                    "1001110" when x"C",
                    "0111101" when x"D",
                    "1001111" when x"E",
                    "1000111" when x"F",
				    "0000000" when others;
	
end architecture Behavioral;