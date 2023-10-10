library IEEE;
use IEEE.std_logic_1164.all;

entity MealyMoore is
    port (
        -- Input ports X,CLK,RESET
        -- Output ports Y (2 bits),Z1,Z2
        X : in std_logic; -- Input X 
        CLK : in std_logic; -- Clock - A rising edge triggers the state machine
        RESET : in std_logic; -- Reset - A high value resets the state machine
        Y : out std_logic_vector(1 downto 0); -- Output Y (The Top Number)
        Z1 : out std_logic; -- Output Z1 (The Bottom Number)
        Z2 : out std_logic -- Output Z2 (The Output Of The State Machine (new input/ new Z2)

    );
end MealyMoore;

architecture Exercise1 of MealyMoore is
    -- Define the State Types up to ST3
    type StateType is (ST0,ST1,ST2,ST3);

    -- Keep Track of the Current State (Default to ST0)
    signal CurrentState : StateType := ST0;
    -- Keep Track of the Next State 
    signal NextState : StateType;

    begin -- Start of the architecture

    -- Create a process to for the reset and clock
    process (CLK,RESET) begin
        -- If the reset is high then reset the state machine
        if RESET = '1' then
            CurrentState <= ST0;
        -- If the clock is rising edge then update the state machine
        elsif rising_edge(CLK) and CLK = '1' then -- The rising_edge() function is a standard function in VHDL
            CurrentState <= NextState;
        end if;
    end process;

    -- Create a process to update the next state based on certain logic 
    process (CurrentState,X) begin
        -- A: 1/0 -> ST1, 0/0 -> ST0
        if CurrentState = ST0 then 
            if X = '0' then
                Z1 <= '0';
                NextState <= ST0;
            else
                Z1 <= '0';
                NextState <= ST1;
            end if;
        end if;

        -- B: 1/0 -> ST2, 0/0 -> ST0
        if CurrentState = ST1 then 
            if X = '0' then
                Z1 <= '0';
                NextState <= ST0;
            else
                Z1 <= '0';
                NextState <= ST2;
            end if;
        end if;
        
        -- C: 1/0 -> ST2, 0/0 -> ST3
        if CurrentState = ST2 then 
            if X = '0' then
                Z1 <= '0';
                NextState <= ST3;
            else
                Z1 <= '0';
                NextState <= ST2;
            end if;
        end if;

        -- D: 1/1 -> ST1, 0/0 -> ST0
        if CurrentState = ST3 then 
            if X = '0' then
                Z1 <= '0';
                NextState <= ST0;
            else
                Z1 <= '1';
                NextState <= ST1;
            end if;
        end if;
    end process;

    with CurrentState select
        -- Output Y based on the current state
        Y <= "00" when ST0,
             "01" when ST1,
             "10" when ST2,
             "11" when ST3,
             "00" when others;
end Exercise1;
