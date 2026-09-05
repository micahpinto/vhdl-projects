library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLOCK_DIVIDER is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        clk_div : out STD_LOGIC
    );
end CLOCK_DIVIDER;

architecture Behavioral of CLOCK_DIVIDER is
    signal counter : integer := 0;
    signal output : STD_LOGIC := '0';
    constant DIVIDE_BY : integer := 5;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            output <= '0';
        elsif rising_edge(clk) then
            if counter = DIVIDE_BY - 1 then
                counter <= 0;
                output <= not output;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_div <= output;
end Behavioral;
