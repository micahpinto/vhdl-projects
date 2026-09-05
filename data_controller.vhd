library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATA_CONTROLLER is
    Port (
        digit0 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit1 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit2 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit3 : in  STD_LOGIC_VECTOR (3 downto 0);
        dp_vector : in  STD_LOGIC_VECTOR (3 downto 0);
        AN     : in  STD_LOGIC_VECTOR (7 downto 0);
        data   : out STD_LOGIC_VECTOR (3 downto 0);
        dp_out : out STD_LOGIC
    );
end DATA_CONTROLLER;

architecture Behavioral of DATA_CONTROLLER is
begin
    process(AN, digit0, digit1, digit2, digit3, dp_vector)
    begin
        case AN is
            when "11111110" => 
                data <= digit0;
                dp_out <= dp_vector(0);
            when "11111101" => 
                data <= digit1;
                dp_out <= dp_vector(1);
            when "11111011" => 
                data <= digit2;
                dp_out <= dp_vector(2);
            when "11110111" => 
                data <= digit3;
                dp_out <= dp_vector(3);
            when others => 
                data <= "0000";
                dp_out <= '0';
        end case;
    end process;
end Behavioral;