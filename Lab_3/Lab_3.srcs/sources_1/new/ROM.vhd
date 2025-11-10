library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Generic ( N : integer := 12);
    Port ( clk : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR(2 downto 0);
           coef : out STD_LOGIC_VECTOR (N-1 downto 0));
end ROM;

architecture Behavioral of ROM is
type memory is array(0 to 7) of signed(N-1 downto 0);

constant rom1 : memory := (
    to_signed(0, N), 
    to_signed(21, N),
    to_signed(241, N),
    to_signed(262, N),
    to_signed(762, N),
    to_signed(783, N),
    to_signed(1003, N),
    to_signed(1024, N));
constant rom2 : memory := (
    to_signed(0, N), 
    to_signed(762, N),
    to_signed(241, N),
    to_signed(1003, N),
    to_signed(21, N),
    to_signed(783, N),
    to_signed(262, N),
    to_signed(1024, N));
begin


end Behavioral;
