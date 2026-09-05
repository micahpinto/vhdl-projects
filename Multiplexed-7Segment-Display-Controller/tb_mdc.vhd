library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mdc is
end tb_mdc;

architecture Behavioral of tb_mdc is
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '1';
    signal digit0 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    signal digit1 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    signal digit2 : STD_LOGIC_VECTOR (3 downto 0) := "0011";
    signal digit3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    signal dp_vector : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    signal AN : STD_LOGIC_VECTOR (7 downto 0);
    signal segments : STD_LOGIC_VECTOR (7 downto 0);
    
    component TOP_MODULE is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            digit0 : in STD_LOGIC_VECTOR (3 downto 0);
            digit1 : in STD_LOGIC_VECTOR (3 downto 0);
            digit2 : in STD_LOGIC_VECTOR (3 downto 0);
            digit3 : in STD_LOGIC_VECTOR (3 downto 0);
            dp_vector : in STD_LOGIC_VECTOR (3 downto 0);
            AN : out STD_LOGIC_VECTOR (7 downto 0);
            segments : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

begin
    UUT: TOP_MODULE
        port map(clk => clk, rst => rst, digit0 => digit0, digit1 => digit1,
                 digit2 => digit2, digit3 => digit3, dp_vector => dp_vector,
                 AN => AN, segments => segments);
    
    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        
        wait for 1 us;
        
        digit0 <= "0101";
        digit1 <= "0110";
        digit2 <= "0111";
        digit3 <= "1000";
        
        wait for 1 us;
        
        digit0 <= "1001";
        digit1 <= "0000";
        digit2 <= "0001";
        digit3 <= "0010";
        
        wait for 1 us;
        wait;
    end process;

end Behavioral;
