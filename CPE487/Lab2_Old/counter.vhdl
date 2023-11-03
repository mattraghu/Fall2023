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
    COMPONENT fsm IS
        PORT (
            X, CLK, RESET: in std_logic;
            Z : out std_logic
        );
    END COMPONENT;

	SIGNAL cnt : STD_LOGIC_VECTOR (38 DOWNTO 0); -- 39-bit counter
    SIGNAL X_from_cnt : std_logic; -- will store a bit from cnt
    SIGNAL Z_from_fsm : std_logic; -- Monitors the output of the FSM '1' will reverse the counter
    SIGNAL reverse_clock : std_logic := '0'; -- will be used to reverse the clock
BEGIN
    X_from_cnt <= cnt(5); -- get the LSB from cnt

    fsm_0 : fsm PORT MAP (X_from_cnt, reverse_clock, '0', Z_from_fsm); -- FSM to reverse the clock

    --Process to reverse the clock
    PROCESS (clk, Z_from_fsm)
    BEGIN
        IF clk'EVENT AND clk = '1' THEN -- on rising edge of clock
            IF Z_from_fsm = '1' THEN -- if the FSM is in state 1
                reverse_clock <= NOT reverse_clock; -- reverse the clock
            END IF;
        END IF;
    END PROCESS;

	BEGIN
		IF clk'EVENT AND clk = '1' THEN -- on rising edge of clock
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