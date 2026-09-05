library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_MODULE is
    Port (
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        digit0 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit1 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit2 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit3 : in  STD_LOGIC_VECTOR (3 downto 0);
        dp_vector : in  STD_LOGIC_VECTOR (3 downto 0);
        AN     : out STD_LOGIC_VECTOR (7 downto 0);
        segments : out STD_LOGIC_VECTOR (7 downto 0)
    );
end TOP_MODULE;

architecture Structural of TOP_MODULE is
    signal clk_div_sig : STD_LOGIC;
    signal AN_sig : STD_LOGIC_VECTOR (7 downto 0);
    signal data_sig : STD_LOGIC_VECTOR (3 downto 0);
    signal dp_sig : STD_LOGIC;
    
    component CLOCK_DIVIDER is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            clk_div : out STD_LOGIC
        );
    end component;
    
    component AN_GENERATOR is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            clk_div : in STD_LOGIC;
            AN : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    component DATA_CONTROLLER is
        Port (
            digit0 : in STD_LOGIC_VECTOR (3 downto 0);
            digit1 : in STD_LOGIC_VECTOR (3 downto 0);
            digit2 : in STD_LOGIC_VECTOR (3 downto 0);
            digit3 : in STD_LOGIC_VECTOR (3 downto 0);
            dp_vector : in STD_LOGIC_VECTOR (3 downto 0);
            AN : in STD_LOGIC_VECTOR (7 downto 0);
            data : out STD_LOGIC_VECTOR (3 downto 0);
            dp_out : out STD_LOGIC
        );
    end component;
    
    component BCD_DECODER is
        Port (
            data : in STD_LOGIC_VECTOR (3 downto 0);
            dp_int : in STD_LOGIC;
            segments : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

begin
    U1: CLOCK_DIVIDER
        port map(
            clk => clk,
            rst => rst,
            clk_div => clk_div_sig
        );
    
    U2: AN_GENERATOR
        port map(
            clk => clk,
            rst => rst,
            clk_div => clk_div_sig,
            AN => AN_sig
        );
    
    U3: DATA_CONTROLLER
        port map(
            digit0 => digit0,
            digit1 => digit1,
            digit2 => digit2,
            digit3 => digit3,
            dp_vector => dp_vector,
            AN => AN_sig,
            data => data_sig,
            dp_out => dp_sig
        );
    
    U4: BCD_DECODER
        port map(
            data => data_sig,
            dp_int => dp_sig,
            segments => segments
        );
    
    AN <= AN_sig;

end Structural;