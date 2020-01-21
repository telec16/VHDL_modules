-----------------------------------------------------
--                  telec16 2020                   --
--    Creative Commons Attribution-ShareAlike      --
-- https://creativecommons.org/licenses/by-sa/4.0/ --
-----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity DIV_N_tb is
    PORT
    ( 
        clk_2   : out STD_LOGIC;
        clk_3   : out STD_LOGIC;
        clk_5   : out STD_LOGIC;
        clk_6   : out STD_LOGIC;
        clk_2_d : out STD_LOGIC;
        clk_3_d : out STD_LOGIC;
        clk_5_d : out STD_LOGIC;
        clk_6_d : out STD_LOGIC
    );
end DIV_N_tb;

architecture Behavior of DIV_N_tb is

	COMPONENT DIV_N IS
        GENERIC
        (
            N     : NATURAL;
            DELAY : NATURAL := 0
        );
        PORT
        (
            clrn    : IN  STD_LOGIC;
            clk_in  : IN  STD_LOGIC;
            clk_out : OUT STD_LOGIC
        );
    END COMPONENT;
    
    constant clk_period : time := 1 us;
    
    SIGNAL sig_clk : STD_LOGIC := '0';
    SIGNAL sig_clrn : STD_LOGIC := '0';
    
begin
    
    clk_2_c : DIV_N
    GENERIC MAP
    (
        N     => 2,
        DELAY => 0
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_2
    );
    clk_2_d_c : DIV_N
    GENERIC MAP
    (
        N     => 2,
        DELAY => 1
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_2_d
    );
    
    clk_3_c : DIV_N
    GENERIC MAP
    (
        N     => 3,
        DELAY => 0
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_3
    );
    clk_3_d_c : DIV_N
    GENERIC MAP
    (
        N     => 3,
        DELAY => 1
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_3_d
    );
    
    clk_5_c : DIV_N
    GENERIC MAP
    (
        N     => 5,
        DELAY => 0
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_5
    );
    clk_5_d_c : DIV_N
    GENERIC MAP
    (
        N     => 5,
        DELAY => 1
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_5_d
    );
    
    clk_6_c : DIV_N
    GENERIC MAP
    (
        N     => 6,
        DELAY => 0
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_6
    );
    clk_6_d_c : DIV_N
    GENERIC MAP
    (
        N     => 6,
        DELAY => 1
    )
    PORT MAP
    (
        clrn    => sig_clrn,
        clk_in  => sig_clk,
        clk_out => clk_6_d
    );
    

    clk_process: process
    begin
        sig_clk <= '0';
        wait for clk_period/2;
        sig_clk <= '1';
        wait for clk_period/2;
    end process;
  
    sig_clrn <= '1' after 1.25 us;
    
    end_test : process
    begin
        wait for 100 us;
        assert false report "end of test" severity note;
    end process;
  

end Behavior;
