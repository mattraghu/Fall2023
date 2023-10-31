-- Library and Use Clause
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for the FSM Test Bench
entity fsm_tb is
end fsm_tb;

architecture tb_arch of fsm_tb is
    -- Declare signals for inputs and outputs
    signal X, CLK, RESET: std_logic;
    signal Y : std_logic_vector(1 downto 0);
    signal Z : std_logic;
    signal STATE : std_logic_vector(2 downto 0);
    
    -- Instantiate the FSM design
    component fsm
        port (
            X, CLK, RESET: in std_logic;
            Y : out std_logic_vector(1 downto 0);
            Z : out std_logic;
            STATE : out std_logic_vector(2 downto 0)
        );
    end component;

   -- Shared variable to control clock generation
    shared variable stop_clock: boolean := false; 
begin
    -- Connect the signals to the FSM
    uut: fsm port map (X, CLK, RESET, Y, Z, STATE);
    
    -- Clock generation process
    process
    begin
        while (not stop_clock) loop
            CLK <= '0';
            wait for 10 ns; -- Adjust the clock period as needed
            CLK <= '1';
            wait for 10 ns;
        end loop;
       wait; 
    end process;

    -- Stimulus process
    process
    begin
        -- Reset the FSM
        RESET <= '1';
        wait for 10 ns;
        RESET <= '0';
        wait for 10 ns;

        -- Test different input patterns
        X <= '0';
        wait for 20 ns;
        
        X <= '1';
        wait for 20 ns;
        
        X <= '0';
        wait for 20 ns;

        -- Add test case for '11100'. This should be the only case where the state goes to F and Z is '1'
        for i in 1 to 3 loop
            X <= '1';
            wait for 20 ns;
        end loop;
        X <= '0';
        wait for 40 ns;

        wait for 20 ns;


        -- End simulation
        stop_clock := true;
        assert false report "End of simulation";
        wait;
    end process;
end tb_arch;
