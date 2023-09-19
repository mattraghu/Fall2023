-- library declaration
library IEEE;
use IEEE.std_logic_1164.all; -- basic IEEE library

-- entity
entity quiz1_test_2 is
end quiz1_test_2;

-- architecture
architecture tb of quiz1_test_2 is
   -- Component declaration for the quiz1 module
   component quiz1
      port(
          B, C, D: in std_logic;
          Y: out std_logic
      );
   end component;

   -- Signals for the testbench
   signal B, C, D, Y: std_logic;

   -- Test vector data structure
   type test_vector_record is record
      B_val, C_val, D_val: std_logic;
      description: string(1 to 100);
   end record;

   -- Array of test vectors (initialized in a process)
   constant test_vectors: array(0 to 1) of test_vector_record;

begin
   -- Initialize the test_vectors array in a process
   process
   begin
      test_vectors(0) := ('0', '0', '0', "Test Vector 1");
      test_vectors(1) := ('1', '1', '0', "Test Vector 2");

      wait;
   end process;

   -- Instantiate the quiz1 module
   quiz1tb: quiz1 port map (B => B, C => C, D => D, Y => Y);

   -- Test process
   process
   begin
      for i in test_vectors'range loop
         -- Apply the test vector values
         B <= test_vectors(i).B_val;
         C <= test_vectors(i).C_val;
         D <= test_vectors(i).D_val;
         wait for 1 ns;

         -- Print the description and the value of Y
         report test_vectors(i).description & ": Y = " & std_logic'image(Y);
      end loop;

      -- Assertion for the end of the test
      assert false report "End of test" severity failure;
      wait;
   end process;

end tb;
