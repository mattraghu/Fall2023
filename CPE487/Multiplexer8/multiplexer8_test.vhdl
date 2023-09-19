-- Library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity
entity multiplexer8_test is
end multiplexer8_test;

-- Architecture
architecture tb_arch of multiplexer8_test is
    -- Component declaration for the multiplexer8
    component multiplexer8
        port (
            d   : in  std_logic_vector(7 downto 0); -- 8-bit input data
            sel : in  std_logic_vector(2 downto 0); -- 3-bit select line
            y   : out std_logic -- Single-bit output
        );
    end component;

    -- Signals for connecting the testbench to the multiplexer
    signal d_input : std_logic_vector(7 downto 0);   -- Input data signal
    signal sel_input : std_logic_vector(2 downto 0); -- Select line signal
    signal y_output : std_logic;                    -- Output signal

begin
    -- Instantiate the multiplexer8 entity
    uut: multiplexer8 port map (d_input, sel_input, y_output);

    -- Stimulus process
    stimulus_process: process
    begin
        -- Test case 1: sel = "000"
        d_input <= "11111111"; -- Input data
        sel_input <= "000";   -- Select line
        wait for 10 ns;
        
        -- Check if the output is as expected
        assert y_output = '1' report "Test case 1 failed" severity error;

        -- Test case 2: sel = "010"
        d_input <= "00001111"; -- Input data
        sel_input <= "010";   -- Select line
        wait for 10 ns;

        -- Check if the output is as expected
        assert y_output = '0' report "Test case 2 failed" severity error;

        -- Add more test cases here

        -- Finish simulation
        wait;
    end process stimulus_process;

end tb_arch;
