library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           mac_ready : in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR(2 downto 0);
           req : out STD_LOGIC;
           wr_x : out STD_LOGIC;
           wr_y : out STD_LOGIC;
           ready : out STD_LOGIC;
           rst : out STD_LOGIC);
end control;

architecture Behavioral of control is
    type state_type is (IDLE, X_LOAD, CF_LOAD, REQ_PULSE, ON_MAC, Y_WRITE, DONE);
    signal state : state_type := IDLE;
    signal count : integer := 0;
    signal write_x : STD_LOGIC := '0';
    signal write_y : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is 
                when IDLE => 
                    if start = '1' then
                        rst <= '1';
                        ready <= '0';
                        state <= X_LOAD;
                    else 
                        rst <= '0';
                        ready <= '1';
                    end if;
                    
                when X_LOAD =>
                    rst <= '0';
                    write_x <= '1';
                    state <= CF_LOAD;
                    
                when CF_LOAD =>
                    write_x <= '0';
                    if count = 0 then
                        addr <= "000";
                    elsif count = 1 then
                        addr <= "001";
                    elsif count = 2 then
                        addr <= "010";
                    elsif count = 3 then
                        addr <= "011"; 
                    elsif count = 4 then
                        addr <= "100";   
                    elsif count = 5 then
                        addr <= "101";
                    elsif count = 6 then
                        addr <= "110";                                                                        
                    end if;
                    state <= REQ_PULSE;
                
                when REQ_PULSE =>
                    req <= '1';
                    state <= ON_MAC;
                    
                when ON_MAC =>
                    req <= '0';
                    if mac_ready = '1' then
                        if count = 6 then
                            count <= 0;
                            state <= Y_WRITE;
                        else 
                            count <= count + 1;
                            state <= CF_LOAD;
                        end if;
                    end if;
                
                when Y_WRITE =>
                    write_y <= '1';
                    state <= DONE;
                
                when DONE =>
                    write_y <= '0';
                    ready <= '1';
                    state <= IDLE;
                
            end case;
        end if;
    end process;
    wr_x <= write_x;
    wr_y <= write_y;
end Behavioral;
