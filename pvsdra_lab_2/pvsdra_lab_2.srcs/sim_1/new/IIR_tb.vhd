library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IIR_tb is
end IIR_tb;

architecture Behavioral of IIR_tb is
    constant N : integer := 15;

    signal clk : STD_LOGIC := '0';
    signal start : STD_LOGIC := '0';
    signal x_in : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal y_out : STD_LOGIC_VECTOR(N-1 downto 0);
    signal ready : STD_LOGIC;
    

    constant clk_period : time := 8 ns;
    
begin
    uut : entity work.IIR
        generic map (
            N => N
        )
        Port map (
            clk => clk,
            start => start,
            x_in => x_in,
            y_out => y_out,
            ready => ready
        );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;


    stim_proc : process
    begin

        wait for clk_period;
        start <= '1';
        x_in <= std_logic_vector(to_signed(8192, N)); -- x[n] = 1 in Q2.13
        wait for clk_period;
        start <= '0';
        wait until ready = '1';
        
        wait for clk_period*2;
        start <= '1';
        x_in <= std_logic_vector(to_signed(0, N)); -- x[n] = 0 in Q2.13
        wait for clk_period;
        start <= '0';
        wait until ready = '1';
        
        for i in 0 to 8 loop
            wait for clk_period*2;
            start <= '1';
            wait for clk_period;
            start <= '0';
            wait until ready = '1';  
        end loop;
--        wait for clk_period*2;
--        start <= '1';
--        x_in <= std_logic_vector(to_signed(8192, N)); -- x[n] = 1 in Q2.13
--        wait for clk_period;
--        start <= '0';
--        wait until ready = '1';
    
--        wait for clk_period*2;
--        start <= '1';
--        x_in <= std_logic_vector(to_signed(4096, N)); -- x[n] = 0.5 in Q2.13";
--        wait for clk_period;
--        start <= '0';
--        wait until ready = '1';
        
--        wait for clk_period*2;
--        start <= '1';
--        x_in <= std_logic_vector(to_signed(-8192, N)); -- x[n] = -1 in Q2.13";
--        wait for clk_period;
--        start <= '0';
--        wait until ready = '1';
        
        wait for clk_period;
        wait;
    end process;

end Behavioral;