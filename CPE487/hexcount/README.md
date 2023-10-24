# Lab 1 - Hex Counter

### By Ryan Potenza, Robert Plastina, and Matthew Raghunandan

![Successful Upload](images/successful_upload.png)

## Part 1 - Leddec

After the program was uploaded to the FPGA, the hex-digit '0' appeared on the first display.

- Switching switches 13, 14, and 15 swapped the display that the number was shown on.
- Switching switch 0, 1, 2, and 3 switched the number that was shown on the display.

## Part 2 - Hex Counter

The initial program displayed the initial number '0' on the first display and used a clock to increment the number by 1 every second. The number is displayed in hexadecimal (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F).

### Modifications

#### Decreasing the Clock Speed

We initially modified the program to run at half the speed by only changing the count every other clock cycle.

This is achieved with the following modification to the **counter.vhd** file:

```vhdl
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
```

As you can see, the counter is only incremented when the **change** signal is high. The **change** signal is toggled every rising edge of the clock, so the counter is only incremented every other clock cycle.

#### Swapping the display

For this modification we changed the program so that every odd number is displayed on the first display and every even number is displayed on the second display.

This is achieved with the following modification to the **leddec.vhd** file:

```vhdl
anode <= "11111110" WHEN data(0) = '1'
ELSE "11111101";
```
