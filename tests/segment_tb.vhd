library ieee;
library std;
use ieee.std_logic_1164.all;
use std.env.all;
--use std.textio.all;
--use ieee.std_logic_textio.all;


entity segment_tb is
end;

architecture testbench of segment_tb is
	signal i_bin: std_logic_vector(7 downto 0);
	signal o_bcd: std_logic_vector(6 downto 0);
    
    type t_response is record
        bin: std_logic_vector(7 downto 0);
        output: std_logic_vector(6 downto 0);
    
    end record;
    
    type t_response_array is array(natural range <>) of t_response;
    
    constant TEST_DATA: t_response_array := (
        (x"00", "1111110"),
        (x"01", "0110000"),
        (x"02", "1101101"),
        (x"03", "1111001"),
        (x"04", "0110011"),
        (x"05", "1011011"),
        (x"06", "1011111"),
        (x"07", "1110000"),
        (x"08", "1111111"),
        (x"09", "1110011"),
        (x"0A", "1110111"),
        (x"0B", "0011111"),
        (x"0C", "1001110"),
        (x"0D", "0111101"),
        (x"0E", "1001111"),
        (x"0F", "1000111")
    );
    
    constant TEST_PERIOD: time := 20ns;

begin

    duv: entity work.segment
        port map(i_bin, o_bcd);
        
    test: process
    begin
        report "segment test bench running...";
        
        
        for i in TEST_DATA'range loop
            report "testing with input";
            
            i_bin <= TEST_DATA(i).bin;
            wait for TEST_PERIOD;
            
            assert o_bcd = TEST_DATA(i).output
                report "Error: output was not correct"
                severity failure;
            
        end loop;
        
        
        report "End of testbench.";
        std.env.stop(0);
    end process;

end;
