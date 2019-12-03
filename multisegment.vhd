library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.segment_pkg.all;

entity multisegment is
    port(
        clk_16mhz: in std_logic;
        i_bin: in std_logic_vector(15 downto 0);
        address_output: out address_out
    );
end entity multisegment;

architecture rtl of multisegment is

    component segment is
        port(
            i_bin: in std_logic_vector(3 downto 0);
            o_bcd: out std_logic_vector(6 downto 0)
        );
    end component segment;

    type digit_select is (ONE, TWO, THREE, FOUR);
    signal digit_selector: digit_select := ONE;
    signal bcd: std_logic_vector(3 downto 0);
    signal dselector: std_logic_vector(3 downto 0) := "1110";
begin

    process (clk_16mhz) is
        variable position: integer := 0;
    begin
        if rising_edge(clk_16mhz) then
            position := digit_select'pos(digit_selector);
            
            bcd <= std_logic_vector(resize(unsigned(shift_right(unsigned(i_bin), (4 * position))), bcd'length));
            
            case digit_selector is
                
                when ONE =>
                    dselector <= "1110";
                    digit_selector <= TWO;
                when TWO =>
                    dselector <= "1101";
                    digit_selector <= THREE;
                when THREE =>
                    dselector <= "1011";
                    digit_selector <= FOUR;
                when FOUR =>
                    dselector <= "0111";
                    digit_selector <= ONE;
                when others =>
                    dselector <= (others => '1');
                    digit_selector <= ONE;
            end case;
        else
            bcd <= bcd;
        end if;
    end process;
    
    address_output.ds <= dselector;
    s1: segment port map(bcd, address_output.o_bcd);

    
end architecture;