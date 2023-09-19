-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity multiplexer8 is
	port(
        -- d is a 8 bit input
        -- sel is a3 bit input
        -- y is a signel bit output

        d : in std_logic_vector(7 downto 0);
        sel : in std_logic_vector(2 downto 0);
        y : out std_logic -- Can also be std_logic_vector(0 downto 0)
    );
       
end multiplexer8;
-- architecture
architecture mux8 of multiplexer8 is
begin
    --Specify a process 
    m8: process(sel) is 
    begin 
        if sel = "000" then
            y <= d(0);
        elsif sel = "001" then
            y <= d(1);
        elsif sel = "010" then
            y <= d(2);
        elsif sel = "011" then
            y <= d(3);
        elsif sel = "100" then
            y <= d(4);
        elsif sel = "101" then
            y <= d(5);
        elsif sel = "110" then  
            y <= d(6);
        elsif sel = "111" then  
            y <= d(7);
        end if;

        end process m8; 
end mux8;
