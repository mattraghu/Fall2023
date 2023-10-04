library IEEE;
use IEEE.std_logic_1164.all;

entity and3_gate is
    port (
        A    : in std_logic;   -- Input A
        B    : in std_logic;   -- Input B
        C    : in std_logic;   -- Input C
        Fout : out std_logic  -- Output Fout
    );
end and3_gate;

architecture and3_logic of and3_gate is
    signal ABC : std_logic_vector(2 downto 0); -- Signal to hold the concatenation of A, B, and C
begin
    ABC <= A & B & C; -- Concatenate inputs A, B, and C

    process(ABC) is
    begin
        case ABC is
            when "001" =>
                Fout <= '1'; -- Output is '1' for input combinations "011" and "001"
            when "111" =>
                Fout <= '1';
            when others =>
                Fout <= '0'; -- Output is '0' for all other input combinations
        end case;
    end process;
end and3_logic;
