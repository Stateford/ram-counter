library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.segment_pkg.all;
use work.sdram_pkg.all;


entity counter is
    port(
        clk:                in std_logic;
        reset:              in std_logic;
        next_address:       in std_logic;
        previous_address:   in std_logic;
        load_address:       in std_logic;
        data_in:            in std_logic_vector(7 downto 0);
        o_bin:              out std_logic_vector(7 downto 0);
        o_hex_addr:         out address_segment;
        o_hex_addr_out:     out address_out;
        sdram_data:         inout std_logic_vector(15 downto 0)
    );
end entity counter;

architecture rtl of counter is

    component segment is
        port(
            i_bin: in std_logic_vector(3 downto 0);
            o_bcd: out std_logic_vector(6 downto 0)
        );
    end component segment;
    
    
    component pll_clk_16mhz is
        port(
            inclk0: in std_logic := '0';
            c0:     out std_logic
        );
    end component pll_clk_16mhz;
    
    component multisegment is
        port(
            clk_16mhz:          in std_logic;
            i_bin:              in std_logic_vector(15 downto 0);
            address_output:     out address_out
        );
    end component multisegment;
    
    component sdram is
        port(
            inputs:  in sdram_io;
            io_data: inout std_logic_vector(15 downto 0)
        );
    end component sdram;
    
    
    type button_state is (UP, DOWN);
    
    signal address: unsigned(15 downto 0) := (others => '0');
    signal address7b: std_logic_vector(7 downto 0) := (others => '0');
    signal segment_display1: std_logic_vector(3 downto 0) := (others => '0');
    signal segment_display2: std_logic_vector(3 downto 0) := (others => '0');
    signal current_state: button_state := UP;
    
    signal clk_16mhz: std_logic := '0';
    
    signal write_enable: std_logic := '1';
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
    
    process(load_address)
    variable data: std_logic_vector(15 downto 0) := (others => 'Z');
    begin
    
        if(load_address = '0') then
            write_enable <= '1';
            -- TODO: add sdram data here
        else
            write_enable <= '0';
            sdram_data <= data;
        end if;
    end process;
    
    
    address7b <= std_logic_vector(resize(unsigned(address), address7b'length));
    
    clk16: pll_clk_16mhz port map(clk, clk_16mhz);
    mseg: multisegment port map(clk_16mhz, std_logic_vector(address), o_hex_addr_out);
    
    sdram1: sdram port map(r_sdram_init(clk, load_address, write_enable, std_logic_vector(unsigned(resize(address, 13)))), sdram_data);
    
    segment_display1 <= segmentmask(unsigned(sdram_data));
    segment_display2 <= segmentmask(shift_right(unsigned(sdram_data), 4));
    segment1: segment port map(segment_display1, o_hex_addr.lobyte);
    segment2: segment port map(segment_display2, o_hex_addr.hibyte);
    
    o_bin <= address7b;
    
end architecture;