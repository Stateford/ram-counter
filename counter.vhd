library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is
    port(
        clk: in std_logic;
        reset: in std_logic;
        next_address: in std_logic;
        previous_address: in std_logic;
        load_address: in std_logic;
        o_bin: out std_logic_vector(7 downto 0);
        o_hex: out std_logic_vector(6 downto 0)
    );
end entity counter;

architecture rtl of counter is

    component segment is
        port(
            i_bin: in std_logic_vector(7 downto 0);
            o_bcd: out std_logic_vector(6 downto 0)
        );
    end component segment;

    signal address: unsigned(12 downto 0);
    signal address7b: std_logic_vector(7 downto 0);
    
begin


    process (clk, reset, next_address, previous_address)
    begin
    
        if reset = '0' then
            address <= (others => '0');
        elsif rising_edge(clk) then
            if next_address = '0' then
                address <= address + 1;
            elsif previous_address ='0' then
                address <= address - 1;
            else
                address <= address;
            end if;
        end if;
    end process;
    
    address7b <= std_logic_vector(resize(signed(address), address7b'length));
    
    segment1: segment port map(address7b, o_hex);
    
    o_bin <= address7b;
    
end architecture;