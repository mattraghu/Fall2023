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
                -- reverse_clock <= NOT reverse_clock; -- reverse the clock
                reverse_clock <= '1'; -- reverse the clock
            END IF;

            IF reverse_clock = '0' THEN -- if the clock is not reversed
                cnt <= cnt + 1; -- increment the counter
                    
                -- count <= cnt (38 DOWNTO 23); -- 16 bits
            ELSE
                -- count <= (others => '1'); -- 15 zeros and one '1' for 16 bits
                cnt <= cnt - 1; -- decrement the counter
            END IF;
        END IF;
    END PROCESS;
 
	count <= cnt (38 DOWNTO 23); -- 16 bits
	mpx <= cnt (19 DOWNTO 17); -- 3 bits
END Behavioral;