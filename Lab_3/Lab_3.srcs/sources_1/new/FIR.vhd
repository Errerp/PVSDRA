library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIR is
    Generic ( N : integer := 12;
              Order : integer := 6);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR(N-1 downto 0);
           y : out STD_LOGIC_VECTOR(N-1 downto 0);
           ready : out STD_LOGIC);
end FIR;

architecture Behavioral of FIR is
type shift_reg is array(0 to Order-1) of signed(N-1 downto 0);
signal reg : shift_reg := (others => (others => '0'));
begin


end Behavioral;
