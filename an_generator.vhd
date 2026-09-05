library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AN_GENERATOR is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        clk_div : in  STD_LOGIC;
        AN      : out STD_LOGIC_VECTOR (7 downto 0)
    );
end AN_GENERATOR;

architecture Behavioral of AN_GENERATOR is
    signal counter : integer range 0 to 3 := 0;
    signal clk_div_prev : STD_LOGIC := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            clk_div_prev <= '0';
        elsif rising_edge(clk) then
            clk_div_prev <= clk_div;
            
            if clk_div = '1' and clk_div_prev = '0' then
                if counter = 3 then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    process(counter)
    begin
        case counter is
            when 0 => AN <= "11111110";
            when 1 => AN <= "11111101";
            when 2 => AN <= "11111011";
            when 3 => AN <= "11110111";
            when others => AN <= "11111111";
        end case;
    end process;
end Behavioral;