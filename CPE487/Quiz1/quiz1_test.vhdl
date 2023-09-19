-- library declaration
library IEEE;
use IEEE.std_logic_1164.all; -- basic IEEE library
-- entity
entity quiz1_test is
	
    
end quiz1_test; 
-- architecture
architecture tb of quiz1_test is
	component quiz1
      port(
          B,C,D : in std_logic;
          Y : out std_logic
      );
     end component;
     
     signal B,C,D,Y : std_logic;
begin
	quiz1tb: quiz1 port map (B => B, C => C, D => D, Y => Y);
    process begin
    	B <= 'X';
        C <= 'X';
        D <= 'X';
        wait for 1 ns;
        
        
        B <= '0';
        C <= '0';
        D <= '0';
        wait for 1 ns;
        report "When B = 0, C = 0, D = 0: Y = " & std_logic'image(Y);
        
        C <= '1';
        wait for 1 ns;
        report "When B = 0, C = 1, D = 0: Y = " & std_logic'image(Y);
        
        assert false report "End of test";
        wait;
     end process;
        
end tb;
