LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY Matriz IS
	GENERIC( 	  Nv 						:	INTEGER);
	PORT	( 	 	  clk	               :	IN	STD_LOGIC;
					  rst	               :	IN	STD_LOGIC;
					  PosicionFila			:	IN INTEGER;
					  PosicionColumna		:	IN INTEGER;
					  pixelMatriz  		:	OUT STD_LOGIC
				);
END ENTITY;
ARCHITECTURE calculador OF Matriz IS

--SIGNAL		: 
--SIGNAL		: 

	
BEGIN

PROCESS(PosicionFila, PosicionColumna)

	BEGIN
--		IF	(((PosicionFila > 160) AND (PosicionFila < 320)) OR ((PosicionColumna > 160) AND (PosicionColumna < 320))) THEN
		IF	(PosicionColumna = 240 OR PosicionColumna = 0 OR PosicionColumna = 480 OR PosicionFila=0 OR PosicionFila=476 OR PosicionFila=240) THEN
--		IF	(((PosicionFila < 160) AND (PosicionColumna < 280)) OR ((PosicionFila >= 160) AND (PosicionColumna >= 280))) THEN

			pixelMatriz <= '1';
		ELSE 
			pixelMatriz <= '0';
		END IF;
	END PROCESS;


END ARCHITECTURE;
--	BEGIN
--		
--		IF	(PosicionColumna(0)='1') THEN
--		IF	(((PosicionFila > "00010100000") AND (PosicionFila < "00101000000")) OR ((PosicionColumna > "00010100000") AND (PosicionColumna < "00101000000"))) THEN
--		IF	(((PosicionFila < "00011110000") AND (PosicionColumna < "00011110000")) OR ((PosicionFila >= "00011110000") AND (PosicionColumna >= "00011110000"))) THEN
--			pixelMatriz <= '1';
--		ELSE 
--			pixelMatriz <= '0';
--		END IF;
--	END PROCESS;
