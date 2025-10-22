library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IIR is
    generic ( 
        N : integer := 15);
    Port ( 
        clk : in STD_LOGIC;
        start : in STD_LOGIC;
        x_in : in STD_LOGIC_VECTOR(N-1 downto 0);
        y_out : out STD_LOGIC_VECTOR(N-1 downto 0);
        ready : out STD_LOGIC);
end IIR;

architecture Behavioral of IIR is
    signal rst, mac_ready, req, wr_x, wr_y, ready_filt : STD_LOGIC; 
    signal addr : STD_LOGIC_VECTOR(2 downto 0);   
    signal coef : STD_LOGIC_VECTOR(N-1 downto 0);  
    signal mac_result : STD_LOGIC_VECTOR(N-1 downto 0); 
    signal mac_done : STD_LOGIC;              
    signal x_buf_0, x_buf_1, x_buf_2, x_buf_3 : STD_LOGIC_VECTOR(N-1 downto 0):= (others => '0');
    signal y_buf_1, y_buf_2, y_buf_3 : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); 
    signal mac_in_x : STD_LOGIC_VECTOR(N-1 downto 0); 
begin

    control_inst : entity work.control
    Port map (
        clk => clk,
        start => start,
        mac_ready => mac_done,
        addr => addr,
        req => req,
        wr_x => wr_x,
        wr_y => wr_y,
        ready => ready_filt,
        rst => rst
    );


    coeff_ROM_inst : entity work.ROM
    generic map (N => N)
    Port map (
        clk => clk,
        addr => addr,
        coef => coef
    );

    mac_inst : entity work.mac
    generic map (N => N)
    Port map (
        clk => clk,
        rst => rst,
        start => req,
        A => coef,
        B => mac_in_x,
        S => mac_result,
        ready_mac => mac_done
    );

    io_logic : process(clk)
    begin
        if rising_edge(clk) then
            if wr_x = '1' then
                x_buf_3 <= x_buf_2;
                x_buf_2 <= x_buf_1;
                x_buf_1 <= x_buf_0;
                x_buf_0 <= x_in;
            end if;
            if wr_y = '1' then
                y_buf_3 <= y_buf_2;
                y_buf_2 <= y_buf_1;
                y_buf_1 <= mac_result;
            end if;
        end if;
    end process io_logic;

    mac_in_x <= x_buf_0 when addr = "000" else  -- x[n]
                x_buf_1 when addr = "001" else  -- x[n-1]
                x_buf_2 when addr = "010" else  -- x[n-2]
                x_buf_3 when addr = "011" else  -- x[n-3]
                y_buf_1 when addr = "100" else  -- y[n-1]
                y_buf_2 when addr = "101" else  -- y[n-2]
                y_buf_3 when addr = "110" else  -- y[n-3]
                (others => '0');              

    y_out <= mac_result when (ready_filt = '1');
    ready <= ready_filt;
end Behavioral;