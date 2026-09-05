library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_multiplier is
end tb_multiplier;

architecture Behavioral of tb_multiplier is

    signal clk    : STD_LOGIC := '0';
    signal rst    : STD_LOGIC := '1';
    signal A      : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal B      : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal start  : STD_LOGIC := '0';
    signal result : STD_LOGIC_VECTOR (15 downto 0);
    signal en     : STD_LOGIC;

begin

    UUT: entity work.MULTIPLIER
        port map (
            clk    => clk,
            rst    => rst,
            A      => A,
            B      => B,
            start  => start,
            result => result,
            en     => en
        );

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
        wait for 50 ns;

        A <= "00000111";
        B <= "00001111";
        wait for 50 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait until en = '1';
        wait for 100 ns;

        wait;
    end process;

end Behavioral;