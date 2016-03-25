-- Library Statements
library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

-- Entity Definition
entity buzzer_tb is
  constant MAX_COMB: integer := 64;
  constant DELAY: time := 10 ns;
end entity ;

-- Architecture Definition
architecture tb of buzzer_tb is
	signal in_buzzers : std_logic_vector(2 downto 0);
	signal out_buzzers : std_logic_vector(2 downto 0);
	signal result : std_logic;

	component buzzer is
		port (
			in_buzzers : in std_logic_vector(2 downto 0);
			out_buzzers : in std_logic_vector(2 downto 0);
			result : out std_logic
		) ;
	end component;
begin
	UUT: component buzzer port map(in_buzzers, out_buzzers, result);

	main: process is
		variable temp: unsigned(5 downto 0);
		variable expected_result: std_logic;
		variable error_count: integer := 0;

	begin
		report "Start simulation.";

		for count in 0 to MAX_COMB-1 loop
			temp := TO_UNSIGNED(count, 6);
			in_buzzers(2) 	<= std_logic(temp(5));
			in_buzzers(1) 	<= std_logic(temp(4));
			in_buzzers(0) 	<= std_logic(temp(3));
			out_buzzers(2) 	<= std_logic(temp(2));
			out_buzzers(1) 	<= std_logic(temp(1));
			out_buzzers(0) 	<= std_logic(temp(0));

			if ((temp(5) = '1' or temp(4) = '1' or temp(3) = '1') and (temp(2) = '1' or temp(1) = '1' or temp(0) = '1')) then
				expected_result := '1';
			else
				expected_result := '0';
			end if;

			wait for DELAY;

			assert (expected_result = result)
				report "ERROR: Expected result " &
					std_logic'image(expected_result) &
					" at time " & time'image(now);
			
			if (expected_result /= result)
				then error_count := error_count + 1;
			end if;
		end loop;

		wait for DELAY;

		assert (error_count = 0)
			report "ERROR: There were " & integer'image(error_count) & " errors!";

		if (error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;

		wait;
	end process;
end architecture ;