-----------------------------------------------------
--                  telec16 2020                   --
--    Creative Commons Attribution-ShareAlike      --
-- https://creativecommons.org/licenses/by-sa/4.0/ --
-----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY DIVevenN IS

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

END DIVevenN;

ARCHITECTURE Behavior OF DIVevenN IS
	
	CONSTANT ADDR_LEN  : NATURAL  := NATURAL(ceil(log2(REAL(N))));
    CONSTANT THRESHOLD : UNSIGNED := to_unsigned(NATURAL(ceil(REAL(N)/2.0))-1, ADDR_LEN);
    CONSTANT STOP      : UNSIGNED := to_unsigned(N-1, ADDR_LEN);
    
    SIGNAL count : UNSIGNED((ADDR_LEN-1) DOWNTO 0);
	
BEGIN

    PROCESS(clk_in)
    BEGIN
		IF clrn = '0' THEN
			count <= STOP - to_unsigned(DELAY, ADDR_LEN);
			clk_out <= '0';
        ELSIF rising_edge(clk_in) THEN
		
			count <= count + 1;
			
            IF count = STOP THEN
				count <= (OTHERS => '0');
				clk_out <= '1';
			END IF;
			
			IF count = THRESHOLD THEN
				clk_out <= '0';
			END IF;
			
        END IF;
    END PROCESS;
	
END Behavior;
