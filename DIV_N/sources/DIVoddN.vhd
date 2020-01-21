-----------------------------------------------------
--                  telec16 2020                   --
--    Creative Commons Attribution-ShareAlike      --
-- https://creativecommons.org/licenses/by-sa/4.0/ --
-----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY DIVoddN IS

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

END DIVoddN;

ARCHITECTURE Behavior OF DIVoddN IS

	CONSTANT ADDR_LEN  : NATURAL  := NATURAL(ceil(log2(REAL(N))));
    CONSTANT THRESHOLD : UNSIGNED := to_unsigned(NATURAL(ceil(REAL(N)/2.0))-2, ADDR_LEN);
    CONSTANT STOP      : UNSIGNED := to_unsigned(N-1, ADDR_LEN);
    
    SIGNAL count_R : UNSIGNED((ADDR_LEN-1) DOWNTO 0);
    SIGNAL count_F : UNSIGNED((ADDR_LEN-1) DOWNTO 0);
	SIGNAL clk_R   : STD_LOGIC;
	SIGNAL clk_F   : STD_LOGIC;
	
BEGIN

    PROCESS(clk_in)
    BEGIN
		IF clrn = '0' THEN
			count_R <= STOP - to_unsigned(DELAY, ADDR_LEN);
			count_F <= STOP - to_unsigned(DELAY, ADDR_LEN);
            clk_R <= '0';
            clk_F <= '0';
            
        ELSIF rising_edge(clk_in) THEN
		
			count_R <= count_R + 1;
            
            IF count_R = STOP THEN
				count_R <= (OTHERS => '0');
				clk_R <= '1';
			END IF;
			
			IF count_R = THRESHOLD THEN
				clk_R <= '0';
			END IF;
			
        ELSIF falling_edge(clk_in) THEN
		
			count_F <= count_F + 1;
            
            IF count_F = STOP THEN
				count_F <= (OTHERS => '0');
				clk_F <= '1';
			END IF;
			
			IF count_F = THRESHOLD THEN
				clk_F <= '0';
			END IF;
			
        END IF;
    END PROCESS;
	
	clk_out <= clk_F OR clk_R;

END Behavior;