library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity tb_mac is
end tb_mac;

architecture sim of tb_mac is
    constant  N: integer := 16;
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal start    : std_logic := '0';
    signal A, B     : std_logic_vector(N-1 downto 0) := (others => '0');
    signal S        : std_logic_vector(N-1 downto 0);
    signal ready_mac: std_logic;
    
    constant clk_period : time := 8 ns;
    
begin

    uut: entity work.mac
         generic map (
            N => N
         )
         port map (
            clk => clk,
            rst => rst,
            start => start,
            A => A,
            B => B,
            S => S,
            ready_mac => ready_mac
        );

    clk_process: process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;

    stim_proc: process
    begin
        wait for clk_period / 2;
        rst <= '1';
        wait for clk_period * 0.75;
        rst <= '0';
        wait for clk_period * 2;
        
        A <= x"0006";   -- 0.00018
        B <= x"2500";   -- 0.289
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready_mac = '1';
        wait for clk_period;
       
        A <= x"ffff";   -- -0.00003
        B <= x"0003";   -- 0.00009
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready_mac = '1';
        wait for clk_period;
       
        A <= x"fffa";   -- -0.00018
        B <= x"fffb";   -- -0.00015
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready_mac = '1';
        wait for clk_period;
        
        A <= x"0003";   -- 0.00009
        B <= x"ffb1";   -- -0.0024
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready_mac = '1';
        wait for clk_period;
        
        A <= x"fff9";   -- -0.00021
        B <= x"000a";   -- 0.0003
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until ready_mac = '1';
        wait for clk_period;
        wait;
    end process;

end sim;
