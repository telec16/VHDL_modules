-----------------------------------------------------
--                  telec16 2020                   --
--    Creative Commons Attribution-ShareAlike      --
-- https://creativecommons.org/licenses/by-sa/4.0/ --
-----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY DIV2N IS

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

END DIV2N;

ARCHITECTURE Behavior OF DIV2N IS
	
	CONSTANT ADDR_LEN : NATURAL := NATURAL(ceil(log2(REAL(N))));
    
    SIGNAL count : UNSIGNED((ADDR_LEN-1) DOWNTO 0);
	
BEGIN

    PROCESS(clk_in)
    BEGIN
		IF clrn = '0' THEN
			count <= 0 + to_unsigned(DELAY, ADDR_LEN);
        ELSIF rising_edge(clk_in) THEN
		
			count <= count - 1;
			
        END IF;
    END PROCESS;
	
	clk_out <= count(ADDR_LEN-1);

END Behavior;
