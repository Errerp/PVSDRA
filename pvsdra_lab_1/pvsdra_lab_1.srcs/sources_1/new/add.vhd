library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity add is
generic(
        N : integer := 16
    );
   Port (
    a : in  std_logic_vector(2*N-1 downto 0);
    b : in  std_logic_vector(N-1 downto 0);
    subadd: in std_logic;
    c    : out std_logic_vector(2*N-1 downto 0)
);
end add;

architecture Behavioral of add is
    constant zeros: std_logic_vector(N-1 downto 0):=(others => '0');
begin
    process(a, b, subadd)
    begin
        if subadd = '0' then
            c <= a + (b & zeros);
        else 
            c <= a - (b & zeros);
        end if;
    end process;
end Behavioral;