-- Library Statements
library ieee ;
	use ieee.std_logic_1164.all ;

-- Entity Definition
entity buzzer is
  port (
	in_buzzers : in std_logic_vector(2 downto 0);
	out_buzzers : in std_logic_vector(2 downto 0);
	result : out std_logic
  ) ;
end entity ;

-- Architecture Definition
architecture buzzer_architecture of buzzer is

begin
	process (in_buzzers(2), in_buzzers(1), in_buzzers(0), out_buzzers(2), out_buzzers(1), out_buzzers(0)) is
	begin
		result <= ((in_buzzers(2) or in_buzzers(1) or in_buzzers(0)) and (out_buzzers(2) or out_buzzers(1) or out_buzzers(0)));
	end process;
end architecture ;