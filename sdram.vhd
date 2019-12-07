library ieee;
use ieee.std_logic_1164.all;
use work.sdram_pkg.all;

entity sdram is

    port(
        inputs:  in sdram_io;
        io_data: inout std_logic_vector(15 downto 0)
    );

end entity;

architecture rtl of sdram is
    signal data: std_logic_vector(15 downto 0) := (others => 'Z');
    signal rd: std_logic := '0';
begin

    process(inputs.clk)
    begin
    
        if(rising_edge(inputs.clk)) then
            rd <= inputs.write_enable_n;
            if(inputs.clk_en = '1') then
                if(inputs.write_enable_n = '0') then
                    data <= io_data;
                end if;
            end if;
        end if;
    end process;

    io_data <= data when rd else (others => 'Z');

end architecture;