library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.std_logic_unsigned.all;

entity mult is 
Port (  clk : in STD_LOGIC; 
        rst : in STD_LOGIC; 
        start : in STD_LOGIC; 
        A : in std_logic_vector (15 downto 0); 
        B : in std_logic_vector (15 downto 0); 
        P : out std_logic_vector (31 downto 0); 
        ready : out STD_LOGIC); 
end mult; 

architecture Behavioral of mult is 
    signal mt: std_logic_vector(15 downto 0); -- множитель 
    signal mn: std_logic_vector(15 downto 0); -- множимое
    signal sum: std_logic_vector(31 downto 0); -- сумма частичных произведений 
    
    signal count: integer range 0 to 16; 
    signal busy: std_logic := '0';   
begin 
    process(clk, rst) 
    begin
         if rst = '1' then
            mt <= (others => '0');
            mn <= (others => '0');
            sum <= (others => '0');
            count <= 0;
            busy <= '0';
            ready <= '0';
            P <= (others => '0');
         elsif rising_edge(clk) then
            if start = '1' and busy = '0' then
                mt <= A;
                mn <= B;
                sum <= (others => '0');
                ready <= '0';
                count <= 0;
                busy <= '1';
            elsif busy = '1' then                  
                if count = 16 then 
                    if A(15) = '1' then
                        sum <= sum - (mn & "0000000000000000");
                    end if;
                    busy <= '0';
                    ready <= '1';
                else
                    if mt(0) = '1' then
                        sum <= mn(15) & (sum(31 downto 16) + mn) & sum(15 downto 1);
                    else
                        sum <= sum(31) & sum(31 downto 1);
                    end if;
                                                             
                    mt <= '0' & mt(15 downto 1);
                    count <= count + 1;
                end if;    
            end if;         
         end if;
        P <= sum;
    end process; 
end Behavioral;