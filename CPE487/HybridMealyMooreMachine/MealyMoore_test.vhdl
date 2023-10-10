library IEEE;
use IEEE.std_logic_1164.all;

entity MealyMoore_test is
end MealyMoore_test;

architecture testbench of MealyMoore_test is
    -- Declare signals for connecting to the MealyMoore entity
    signal X : std_logic := '0';  -- Input X
    signal CLK : std_logic := '0';  -- Clock signal
    signal RESET : std_logic := '0';  -- Reset signal
    signal Y : std_logic_vector(1 downto 0);  -- Output Y
    signal Z1 : std_logic;  -- Output Z1
    signal Z2 : std_logic;  -- Output Z2

    -- Instantiate the MealyMoore entity
    component MealyMoore
        port (
            X : in std_logic;
            CLK : in std_logic;
            RESET : in std_logic;
            Y : out std_logic_vector(1 downto 0);
            Z1 : out std_logic;
            Z2 : out std_logic
        );
    end component;

begin
    -- Instantiate the MealyMoore entity
    UUT: MealyMoore
        port map (
            X => X,
            CLK => CLK,
            RESET => RESET,
            Y => Y,
            Z1 => Z1,
            Z2 => Z2
        );

    -- Clock generation process
    process
    begin
        while now < 100 ns loop  -- Simulate for 100 ns
            CLK <= '0';
            wait for 5 ns;  -- 10 ns clock period
            CLK <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Test case process
    process
    begin
        -- Initialize/reset the MealyMoore state machine
        RESET <= '1';
        wait for 10 ns;
        RESET <= '0';

        -- Test case 1
        X <= '1';  -- Input X for case A
        wait for 20 ns;

        -- Test case 2
        X <= '0';  -- Input X for case B
        wait for 20 ns;

        -- Test case 3
        X <= '1';  -- Input X for case C
        wait for 20 ns;

        -- Test case 4
        X <= '1';  -- Input X for case D
        wait for 20 ns;

        -- Add more test cases as needed

        -- End simulation
        wait;
    end process;
end testbench;
