library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity add is
    Port (
    a, b : in  std_logic_vector(31 downto 0);
    c    : out std_logic_vector(31 downto 0)
);
end add;

architecture Behavioral of add is
begin
    
    c <= a + b;

end Behavioral;