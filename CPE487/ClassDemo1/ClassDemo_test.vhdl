library IEEE;
use IEEE.std_logic_1164.all;

entity ClassDemo_test is
end ClassDemo_test;

architecture testbench of ClassDemo_test is
    signal A, B, C, Fout : std_logic;
begin
    uut: entity work.and3_gate
        port map (
            A    => A,
            B    => B,
            C    => C,
            Fout => Fout
        );

    process
    begin
        -- Test case 1: A = '0', B = '0', C = '0'
        A <= '0';
        B <= '0';
        C <= '0';
        wait for 10 ns;
        -- assert (Fout = '0') report "Test case 1 failed" severity error;

        -- Test case 2: A = '1', B = '1', C = '1'
        A <= '0';
        B <= '0';
        C <= '1';
        wait for 10 ns;

        -- 1,1,1
        A <= '1';
        B <= '1';
        C <= '1';
        wait for 10 ns;
        

        wait;
    end process;
end testbench;
