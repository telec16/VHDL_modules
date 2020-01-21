-----------------------------------------------------
--                  telec16 2020                   --
--    Creative Commons Attribution-ShareAlike      --
-- https://creativecommons.org/licenses/by-sa/4.0/ --
-----------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY DIV_N IS

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

END DIV_N;

ARCHITECTURE Behavior OF DIV_N IS
	
	COMPONENT DIVevenN IS
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
    
    COMPONENT DIVoddN IS
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
	
	COMPONENT DIV2N IS
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
	
    
    TYPE state_t IS (N_EVEN, N_ODD, N_POW2);
    
    FUNCTION state(N : NATURAL) 
        RETURN state_t IS
    BEGIN
        IF (ceil(log2(REAL(N))) = log2(REAL(N))) THEN
            RETURN N_POW2;
        ELSIF ((N MOD 2) = 0) THEN
            RETURN N_EVEN;
        ELSE
            RETURN N_ODD;
        END IF;
    END FUNCTION;
    
BEGIN

    POW2 : IF state(N) = N_POW2 GENERATE
    
        DIV2N_c : DIV2N
		GENERIC MAP
		(
			N     => N,
            DELAY => DELAY
		)
		PORT MAP
		(
			clrn    => clrn,
			clk_in  => clk_in,
			clk_out => clk_out
		);
        
    END GENERATE POW2;


    EVEN : IF state(N) = N_EVEN GENERATE
    
        DIVevenN_c : DIVevenN
		GENERIC MAP
		(
			N     => N,
            DELAY => DELAY
		)
		PORT MAP
		(
			clrn    => clrn,
			clk_in  => clk_in,
			clk_out => clk_out
		);
        
    END GENERATE EVEN;
    
    
    ODD : IF state(N) = N_ODD GENERATE
    
        DIVoddN_c : DIVoddN
		GENERIC MAP
		(
			N     => N,
            DELAY => DELAY
		)
		PORT MAP
		(
			clrn    => clrn,
			clk_in  => clk_in,
			clk_out => clk_out
		);
        
    END GENERATE ODD;
    
    
END Behavior;
