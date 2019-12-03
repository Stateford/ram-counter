library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package segment_pkg is

    type segment_type is (COMMON_CATHODE, COMMON_ANNODE);

    type address_segment is record
        hibyte: std_logic_vector(6 downto 0);
        lobyte: std_logic_vector(6 downto 0);
    end record;
    
    type address_out is record
        ds: std_logic_vector(3 downto 0);
        o_bcd: std_logic_vector(6 downto 0);
    end record;
    
    function segmentmask(address: unsigned(15 downto 0)) return std_logic_vector;
    
    constant SEGMENT_MASK: unsigned(12 downto 0) := "0000000001111";
end package;

package body segment_pkg is
    
    function segmentmask(address: unsigned(15 downto 0)) return std_logic_vector is
        constant ADDRESS_MASK: unsigned(15 downto 0) := "0001111111111111";
        variable temp_address: unsigned(12 downto 0) := (others => '0');
        variable result: std_logic_vector(3 downto 0) := (others => '0');
    begin
        temp_address := unsigned(resize(((address and ADDRESS_MASK) and SEGMENT_MASK), temp_address'length));
        result := std_logic_vector(resize(unsigned(temp_address), result'length));
        return result;
    end;
    
end package body;