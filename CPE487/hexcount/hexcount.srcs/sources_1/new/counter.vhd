LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter IS
	PORT (
		clk : IN STD_LOGIC;
		count : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
END counter;

ARCHITECTURE Behavioral OF counter IS
	SIGNAL cnt : STD_LOGIC_VECTOR (28 DOWNTO 0); -- 29 bit counter
    SIGNAL change : STD_LOGIC := '0';  -- Whether to change on rising edge
BEGIN
	PROCESS (clk)
	BEGIN
		IF clk'EVENT AND clk = '1' THEN -- on rising edge of clock
	   	   IF change = '1' THEN
			 cnt <= cnt + 1; -- increment counter
		   END IF;
		   change <= NOT change;  -- Toggle control on every rising edge
		END IF;
	END PROCESS;
	count <= cnt (28 DOWNTO 25);
END Behavioral;