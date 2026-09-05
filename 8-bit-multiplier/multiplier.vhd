library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MULTIPLIER is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        A       : in  STD_LOGIC_VECTOR (7 downto 0);
        B       : in  STD_LOGIC_VECTOR (7 downto 0);
        start   : in  STD_LOGIC;
        result  : out STD_LOGIC_VECTOR (15 downto 0);
        en      : out STD_LOGIC
    );
end MULTIPLIER;

architecture Behavioral of MULTIPLIER is
    
    type state_type is (IDLE, LOAD, ADD, SHIFT, COMPARE, FINISH);
    signal current_state : state_type;
    signal next_state    : state_type;
    
    signal A_reg         : UNSIGNED (15 downto 0);
    signal B_reg         : UNSIGNED (7 downto 0);
    signal sum           : UNSIGNED (15 downto 0);
    signal counter       : integer range 0 to 8;
    
begin
    
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, start, counter)
    begin
        case current_state is
            
            when IDLE =>
                if start = '1' then
                    next_state <= LOAD;
                else
                    next_state <= IDLE;
                end if;
            
            when LOAD =>
                next_state <= ADD;
            
            when ADD =>
                next_state <= SHIFT;
            
            when SHIFT =>
                next_state <= COMPARE;
            
            when COMPARE =>
                if counter = 8 then
                    next_state <= FINISH;
                else
                    next_state <= ADD;
                end if;
            
            when FINISH =>
                if start = '0' then
                    next_state <= IDLE;
                else
                    next_state <= FINISH;
                end if;
            
            when others =>
                next_state <= IDLE;
        end case;
    end process;
    
    process(clk, rst)
    begin
        if rst = '1' then
            A_reg   <= (others => '0');
            B_reg   <= (others => '0');
            sum     <= (others => '0');
            counter <= 0;
        elsif rising_edge(clk) then
            case current_state is
                
                when LOAD =>
                    A_reg   <= UNSIGNED("00000000" & A);
                    B_reg   <= UNSIGNED(B);
                    sum     <= (others => '0');
                    counter <= 0;
                
                when ADD =>
                    if B_reg(0) = '1' then
                        sum <= sum + A_reg;
                    end if;
                    B_reg <= '0' & B_reg(7 downto 1);
                    counter <= counter + 1;
                
                when SHIFT =>
                    A_reg <= A_reg(14 downto 0) & '0';
                
                when others =>
                    null;
            end case;
        end if;
    end process;
    
    result <= STD_LOGIC_VECTOR(sum);
    en <= '1' when current_state = FINISH else '0';
    
end Behavioral;
