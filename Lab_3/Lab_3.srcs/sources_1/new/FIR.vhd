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
type shift_reg is array(0 to Order-1) of STD_LOGIC_VECTOR(N-1 downto 0);
signal reg : shift_reg := (others => (others => '0'));

signal bit_idx : integer range 0 to N-1 := 0;
signal calc : STD_LOGIC := '0';

signal acc1, acc2 : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
signal acc1_prev, acc2_prev : STD_LOGIC_VECTOR(N+2 downto 0) := (others => '0');
begin

    bit_count : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                bit_idx <= 0;
            elsif calc <= '1' then
                bit_idx <= bit_idx + 3;
            else 
                bit_idx <= 0;
            end if;
        end if;
    end process;

end Behavioral;
