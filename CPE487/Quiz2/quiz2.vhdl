--PS,X,NS,Z1
--00,1,10,0
--00,0,00,0
--01,1,11,1
--01,0,01,1
--10,1,00,0
--10,0,10,0
--11,1,01,1
--11,0,11,1

--00 : ST0
--01 : ST1
--10 : ST2
--11 : ST3

-- Moore output: Z1 This is the output of the state machine 
-- This means that the output is only dependent on the current state

comb_proc: process(PS,X)
begin
-- Z1: the Moore output; Z2: the Mealy output
Z1 <= '0';  -- pre-assign the outputs
case PS is
when ST0 => -- items regarding state ST0
Z1 <= '0'; -- Moore output
if X = '1' then NS <= ST1;
else NS <= ST0;
end if;
when ST1 => -- items regarding state ST1
Z1 <= '1'; -- Moore output
if X = '1' then NS <= ST3;
else NS <= ST2;
end if;
when ST2 => -- items regarding state ST2
Z1 <= '0'; -- Moore output
if X = '1' then NS <= ST0;
else NS <= ST1;
end if;
when ST3 => -- items regarding state ST3
Z1 <= '1'; -- Moore output
if X = '1' then NS <= ST2;
else NS <= ST3;
end if;
when others =>
NS <= ST0;
Z1 <= '0';
end case;
end process comb_proc;