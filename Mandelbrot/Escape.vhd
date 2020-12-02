LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.all;
-------------------------------
ENTITY Escape IS
	GENERIC	( Nv						:	INTEGER  := 11;
				  decimal				:	INTEGER	:=	32);
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  Xnn						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  Ynn						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  escapein					:	OUT	SIGNED(decimal-1 DOWNTO 0)
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE Op OF Escape IS

SIGNAL	XnnXnn	: SIGNED(decimal-1 DOWNTO 0);
SIGNAL	YnnYnn	: SIGNED(decimal-1 DOWNTO 0);

	
BEGIN

	XnnXnn <= sfixmult(Xnn,Xnn,26);
	YnnYnn <= sfixmult(Ynn,Ynn,26);
	
	escapein	<=	XnnXnn + YnnYnn;

END ARCHITECTURE;