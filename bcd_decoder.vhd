library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_DECODER is
    Port (
        data : in  STD_LOGIC_VECTOR (3 downto 0);
        dp_int : in  STD_LOGIC;
        segments : out STD_LOGIC_VECTOR (7 downto 0)
    );
end BCD_DECODER;

architecture Behavioral of BCD_DECODER is
begin
    process(data, dp_int)
    begin
        case data is
            when "0000" => segments(6 downto 0) <= "0000001";
            when "0001" => segments(6 downto 0) <= "1001111";
            when "0010" => segments(6 downto 0) <= "0010010";
            when "0011" => segments(6 downto 0) <= "0000110";
            when "0100" => segments(6 downto 0) <= "1001100";
            when "0101" => segments(6 downto 0) <= "0100100";
            when "0110" => segments(6 downto 0) <= "0100000";
            when "0111" => segments(6 downto 0) <= "0001111";
            when "1000" => segments(6 downto 0) <= "0000000";
            when "1001" => segments(6 downto 0) <= "0000100";
            when others => segments(6 downto 0) <= "1111111";
        end case;
        
        segments(7) <= dp_int;
    end process;
end Behavioral;