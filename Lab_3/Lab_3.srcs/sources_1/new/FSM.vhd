library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Generic ( N : integer := 12);
    Port (  clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            bit_idx : in integer);
end FSM;

architecture Behavioral of FSM is
type state_type is (IDLE, SHIFT, CALCULATE, DONE);
signal state : state_type := IDLE;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then 
                state <= IDLE;
            end if;
            
            case state is 
                when IDLE =>
                    state <= SHIFT;
                when SHIFT =>
                    if bit_idx >= N-3 then
                        state <= CALCULATE;
                    end if;
                when CALCULATE =>
                    state <= DONE;
                when DONE =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;
