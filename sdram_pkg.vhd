library ieee;
use ieee.std_logic_1164.all;

package sdram_pkg is

    type sdram_io is record
        clk:                std_logic;
        clk_en:             std_logic;
        write_enable_n:     std_logic;
        cas_n:              std_logic;
        ras_n:              std_logic;
        cs_n:               std_logic;
        bank_address:       std_logic_vector(1 downto 0);
        byte_data_mask:     std_logic_vector(1 downto 0);
        address:            std_logic_vector(12 downto 0);
    end record;

    function r_sdram_init(
        clk:                std_logic;
        clk_en:             std_logic;
        write_enable_n:     std_logic;
        address:            std_logic_vector(12 downto 0)
    ) return sdram_io;
end package;

package body sdram_pkg is
        
    function r_sdram_init(
        clk:                std_logic;
        clk_en:             std_logic;
        write_enable_n:     std_logic;
        address:            std_logic_vector(12 downto 0)
    ) return sdram_io is
        variable result: sdram_io;
    begin
        
        result.clk := clk;
        result.clk_en := clk_en;
        result.write_enable_n := write_enable_n;
        result.cas_n := '1';
        result.ras_n := '1';
        result.cs_n := '0';
        result.bank_address := "00";
        result.byte_data_mask := "00";
        result.address := address;
        
        return result;
    end function;

end package body;