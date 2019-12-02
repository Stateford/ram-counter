library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.segment_pkg.all;


entity counter is
    port(
        clk: in std_logic;
        reset: in std_logic;
        next_address: in std_logic;
        previous_address: in std_logic;
        load_address: in std_logic;
        o_bin: out std_logic_vector(7 downto 0);
        o_hex_addr: out address_segment
    );
end entity counter;

architecture rtl of counter is

    component segment is
        port(
            i_bin: in std_logic_vector(3 downto 0);
            o_bcd: out std_logic_vector(6 downto 0)
        );
    end component segment;

    type button_state is (UP, DOWN);
    
    signal address: unsigned(12 downto 0) := (others => '0');
    signal address7b: std_logic_vector(7 downto 0) := (others => '0');
    signal temp_address: unsigned(12 downto 0) := (others => '0');
    signal temp_address2: unsigned(12 downto 0) := (others => '0');
    signal segment_display1: std_logic_vector(3 downto 0) := (others => '0');
    signal segment_display2: std_logic_vector(3 downto 0) := (others => '0');
    signal current_state: button_state := UP;

    
    constant segment1_mask: unsigned(12 downto 0) := "0000000001111";
begin

    process (clk, reset)
    begin
    
        if reset = '0' then
            address <= (others => '0');
        elsif rising_edge(clk) then
            if (next_address = '0') and (current_state = UP) then
                address <= address + 1;
                current_state <= DOWN;
            elsif (previous_address ='0' ) and (current_state = UP) then
                address <= address - 1;
                current_state <= DOWN;
            elsif (previous_address = '1') and (next_address = '1') then
                current_state <= UP;
            else
                address <= address;
            end if;
        end if;
    end process;
    
    
    address7b <= std_logic_vector(resize(unsigned(address), address7b'length));
    --temp_address <= address and segment1_mask;
    --segment_display1 <= std_logic_vector(resize(unsigned(temp_address), segment_display1'length));

    --temp_address2 <= shift_right(address, 4) and segment1_mask;
    --segment_display2 <= std_logic_vector(resize(unsigned(temp_address2), segment_display2'length));
    
    segment_display1 <= segmentmask(address);
    segment_display2 <= segmentmask(shift_right(address, 4));
    segment1: segment port map(segment_display1, o_hex_addr.lobyte);
    segment2: segment port map(segment_display2, o_hex_addr.hibyte);
    
    o_bin <= address7b;
    
end architecture;