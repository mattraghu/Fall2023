-- Library and Use Clause
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Include numeric_std for to_unsigned function

-- Reset signal to state A
entity fsm is
    port (
        X, CLK, RESET: in std_logic;
        Y : out std_logic_vector(1 downto 0);
        Z : out std_logic;
        STATE : out std_logic_vector(2 downto 0) -- For simulation only 
    );
end fsm;

architecture fsmMoore11100 of fsm is
    -- Define the enumeration type for states
    type state_type is (A, B, C, D, E, F);
    
    -- Declare signals for present state (PS) and next state (NS)
    signal PS, NS : state_type;
begin 
    -- Clock and Reset Process
    clockAndReset: process(CLK, RESET)
    begin
        -- Initialize the present state (PS) to A when RESET is asserted
        if (RESET = '1') then
            PS <= A;
        elsif (rising_edge(CLK)) then
            -- Update the present state (PS) on a rising clock edge
            PS <= NS;
        end if;

        -- Set the STATE output port based on the current state (PS)
        case PS is
            when A =>
                STATE <= "000";
            when B =>
                STATE <= "001";
            when C =>
                STATE <= "010";
            when D =>
                STATE <= "011";
            when E =>
                STATE <= "100";
            when F =>
                STATE <= "101";
        end case;


    end process clockAndReset;

    -- State and Output Logic Process
    stateAndOutputLogic : process(PS, X)
    begin
        -- Initialize the Z output to '0'
        Z <= '0';

        -- State transition and output logic
        case PS is
            when A =>
                if (X = '1') then
                    NS <= B;
                else
                    NS <= A;
                end if;
            when B =>
                if (X = '1') then
                    NS <= C;
                else
                    NS <= A;
                end if;
            when C =>
                if (X = '1') then
                    NS <= D;
                else
                    NS <= A;
                end if;
            when D =>
                if (X = '0') then
                    NS <= E;
                else
                    NS <= D;
                end if;
            when E =>
                if (X = '0') then
                    NS <= F;
                else
                    NS <= B;
                end if;
            when F =>
                Z <= '1';
                if (X = '0') then
                    NS <= A;
                else
                    NS <= B;
                end if;
        end case;
    end process stateAndOutputLogic;
end fsmMoore11100;
