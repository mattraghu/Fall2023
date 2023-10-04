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
        d_input <= "10000000";

        -- Test case 1: sel = "111"
        sel_input <= "111";
        wait for 10 ns;

        -- Test case 2: sel = "110"
        sel_input <= "110";
        wait for 10 ns;

        -- Test case 3: sel = "101"
        sel_input <= "101";
        wait for 10 ns;



        -- Finish simulation
        wait;
    end process stimulus_process;

end tb_arch;
