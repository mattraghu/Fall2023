# Lab 2

## Successful Upload

## Lab 1 vs 2

After the program was uploaded to the board, like in lab 1 the program starts at 0 and counts up in hexa decimal.

The difference is that the count is now a 16 bit number (opposed to 4 bits) and is displayed on multiple 7 segment displays.

## Finite State Machine

We created this Moore Machine that would only output a '1' if the input given is `11100`

In choosing the sequence we could only choose a sequence that switches from '1' to '0' once. This is because as we add to the count, it's binary number will change. We know that binary numbers will cary when it gets big enough. For example, if we had the sequence `100` we know that the third digit will remain a 1 for a total of 4 clock cycles, then it will change to a 0 for > 2 cycles which would cause our fsm to output a **1**.

The following is the output of our test bench where we monitor the state and output based on our input:

## Code

The following shows the modification to the **counter.vhd** file:

```vhdl
-- counter.vhd --

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter IS
	PORT (
		clk : IN STD_LOGIC;
		count : OUT STD_LOGIC_VECTOR (15 DOWNTO 0); -- NEED REVISE! 16 bits
		mpx : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        ); -- NEW ONE ADD! send signal to select displays
END counter;

ARCHITECTURE Behavioral OF counter IS
	SIGNAL cnt : STD_LOGIC_VECTOR (38 DOWNTO 0); -- 39-bit counter
    SIGNAL X : std_logic; -- will store a bit from cnt
    SIGNAL Z : std_logic; -- Monitors the output of the FSM '1' will reverse the counter
    SIGNAL reverse_clock : std_logic := '0'; -- will be used to reverse the clock

    SIGNAL clk2 : std_logic; -- clock for the FSM

    type state_type is (A, B, C, D, E, F);
    signal PS, NS : state_type;
BEGIN
    X <= cnt(29);

    PROCESS (clk)
	BEGIN
		IF clk'event and clk = '1' THEN -- on rising edge of clock
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
            PS <= NS;

            IF Z = '1' THEN -- if the FSM is in state 1
                reverse_clock <= NOT reverse_clock; -- reverse the clock
            END IF;

            IF reverse_clock = '0' THEN -- if the clock is not reversed
                cnt <= cnt + 1; -- increment the counter
            ELSE
                cnt <= cnt - 1; -- decrement the counter
            END IF;
        END IF;
    END PROCESS;

	count <= cnt (38 DOWNTO 23); -- 16 bits
	mpx <= cnt (19 DOWNTO 17); -- 3 bits
END Behavioral;
```
