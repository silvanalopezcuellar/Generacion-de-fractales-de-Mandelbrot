LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
-------------------------------
ENTITY controlzoom IS
	GENERIC	( decimal				:				INTEGER	:=	32);
	PORT		( clk	               :	IN 		STD_LOGIC;
				  rst	               :	IN 		STD_LOGIC;
				  pulso					:	IN			STD_LOGIC;
				  restart				:	IN			STD_LOGIC;
				  cuadrante				:	IN			STD_LOGIC_VECTOR(2 DOWNTO 0);
				  r_addr_d 				:	OUT 		INTEGER;
				  r_addr_c				:	OUT		INTEGER
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE controlzoomARCH OF controlzoom IS

	TYPE state IS (cero, uno, dos, tres, cuatro,
						uno1, uno2, uno3, uno4, 
						dos1, dos2, dos3, dos4,
						tres1, tres2, tres3, tres4, 
						cuatro1, cuatro2, cuatro3, cuatro4,
						rbt0, rbt1, rbT2, rbt3, rbt4,
						rbt11, rbt12, rbt13, rbt14,
						rbt21, rbt22, rbt23, rbt24,
						rbt31, rbt32, rbt33, rbt34,
						rbt41, rbt42, rbt43, rbt44);
						
	SIGNAL pr_state	:	state;
	
BEGIN

--	ram_columnas_wr <= contcolumnas WHEN pr_state= columnas ELSE 0;
--	ena_color<= '1' WHEN pr_state= escape OR pr_state= iteracion ELSE '0';
--	ram_ena <= '1' WHEN pr_state= columnas ELSE '0';
--	color <= '1' WHEN pr_state= escape ELSE '0';
	
	
	combinational: PROCESS(rst, clk, pr_state, pulso, restart)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	cero;
		ELSIF (rising_edge(clk)) THEN
		CASE pr_state IS
				
				WHEN rbt0 =>
				
					r_addr_d	<= 0;
					r_addr_c <= 0; 
					
					IF (pulso = '1') THEN
					pr_state 			<= cero;
					ELSE
					pr_state				<= rbt0;
					END IF;
		
				WHEN cero	=>
					
					r_addr_d	<= 0;
					r_addr_c <= 0; 
					
					IF (pulso = '0' AND cuadrante = "000") THEN
					pr_state 			<= rbt1;
					ELSIF (pulso = '0' AND cuadrante = "001") THEN
					pr_state 			<= rbt2;
					ELSIF (pulso = '0' AND cuadrante = "010") THEN
					pr_state 			<= rbt3;
					ELSIF (pulso = '0' AND cuadrante = "011") THEN
					pr_state 			<= rbt4;
					ELSE
					pr_state				<= cero;
					END IF;
				
	---------------------------------------------------------------------------------------------------------			
				
				WHEN rbt1 =>
				
					r_addr_d	<= 1;
					r_addr_c <= 1; 
					
					IF (pulso = '1') THEN
					pr_state 			<= uno;
					ELSE
					pr_state				<= rbt1;
					END IF;
					
				WHEN uno	=>
					
					r_addr_d	<= 1;
					r_addr_c <= 1;
					
					IF (pulso = '0' AND cuadrante = "000") THEN
					pr_state 			<= rbt11;
					ELSIF (pulso = '0' AND cuadrante = "001") THEN
					pr_state 			<= rbt12;
					ELSIF (pulso = '0' AND cuadrante = "010") THEN
					pr_state 			<= rbt13;
					ELSIF (pulso = '0' AND cuadrante = "011") THEN
					pr_state 			<= rbt14;
					ELSE
					pr_state				<= uno;
					END IF;
					
				WHEN rbt11 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 5; 
					
					IF (pulso = '1') THEN
					pr_state 			<= uno1;
					ELSE
					pr_state				<= rbt11;
					END IF;	
					
				WHEN uno1	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 5;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= uno1;
					END IF;
					
				WHEN rbt12 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 6; 
					
					IF (pulso = '1') THEN
					pr_state 			<= uno2;
					ELSE
					pr_state				<= rbt12;
					END IF;		
					
				WHEN uno2	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 6;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= uno2;
					END IF;
					
				WHEN rbt13 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 7; 
					
					IF (pulso = '1') THEN
					pr_state 			<= uno3;
					ELSE
					pr_state				<= rbt13;
					END IF;	
					
				WHEN uno3	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 7;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= uno3;
					END IF;
					
				WHEN rbt14 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 8; 
					
					IF (pulso = '1') THEN
					pr_state 			<= uno4;
					ELSE
					pr_state				<= rbt14;
					END IF;		
					
				WHEN uno4	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 8;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= uno4;
					END IF;
					
------------------------------------------------------------------------------
					
				WHEN rbt2 =>
				
					r_addr_d	<= 1;
					r_addr_c <= 2; 
					
					IF (pulso = '1') THEN
					pr_state 			<= dos;
					ELSE
					pr_state				<= rbt2;
					END IF;
					
				WHEN dos	=>
					
					r_addr_d	<= 1;
					r_addr_c <= 2;
					
					IF (pulso = '0' AND cuadrante = "000") THEN
					pr_state 			<= rbt21;
					ELSIF (pulso = '0' AND cuadrante = "001") THEN
					pr_state 			<= rbt22;
					ELSIF (pulso = '0' AND cuadrante = "010") THEN
					pr_state 			<= rbt23;
					ELSIF (pulso = '0' AND cuadrante = "011") THEN
					pr_state 			<= rbt24;
					ELSE
					pr_state				<= dos;
					END IF;
					
				WHEN rbt21 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 9; 
					
					IF (pulso = '1') THEN
					pr_state 			<= dos1;
					ELSE
					pr_state				<= rbt21;
					END IF;	
					
				WHEN dos1	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 9;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= dos1;
					END IF;
					
				WHEN rbt22 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 10; 
					
					IF (pulso = '1') THEN
					pr_state 			<= dos2;
					ELSE
					pr_state				<= rbt22;
					END IF;		
					
				WHEN dos2	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 10;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= dos2;
					END IF;
					
				WHEN rbt23 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 11; 
					
					IF (pulso = '1') THEN
					pr_state 			<= dos3;
					ELSE
					pr_state				<= rbt23;
					END IF;	
					
				WHEN dos3	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 11;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= dos3;
					END IF;
					
				WHEN rbt24 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 12; 
					
					IF (pulso = '1') THEN
					pr_state 			<= dos4;
					ELSE
					pr_state				<= rbt24;
					END IF;		
					
				WHEN dos4	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 12;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= dos4;
					END IF;
					
----------------------------------------------------------------------------
					
				WHEN rbt3 =>
				
					r_addr_d	<= 1;
					r_addr_c <= 3; 
					
					IF (pulso = '1') THEN
					pr_state 			<= tres;
					ELSE
					pr_state				<= rbt3;
					END IF;
					
				WHEN tres	=>
					
					r_addr_d	<= 1;
					r_addr_c <= 3;
					
					IF (pulso = '0' AND cuadrante = "000") THEN
					pr_state 			<= rbt31;
					ELSIF (pulso = '0' AND cuadrante = "001") THEN
					pr_state 			<= rbt32;
					ELSIF (pulso = '0' AND cuadrante = "010") THEN
					pr_state 			<= rbt33;
					ELSIF (pulso = '0' AND cuadrante = "011") THEN
					pr_state 			<= rbt34;
					ELSE
					pr_state				<= tres;
					END IF;
					
				WHEN rbt31 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 13; 
					
					IF (pulso = '1') THEN
					pr_state 			<= tres1;
					ELSE
					pr_state				<= rbt31;
					END IF;	
					
				WHEN tres1	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 13;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= tres1;
					END IF;
					
				WHEN rbt32 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 14; 
					
					IF (pulso = '1') THEN
					pr_state 			<= tres2;
					ELSE
					pr_state				<= rbt32;
					END IF;		
					
				WHEN tres2	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 14;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= tres2;
					END IF;
					
				WHEN rbt33 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 15; 
					
					IF (pulso = '1') THEN
					pr_state 			<= tres3;
					ELSE
					pr_state				<= rbt33;
					END IF;	
					
				WHEN tres3	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 15;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= tres3;
					END IF;
					
				WHEN rbt34 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 16; 
					
					IF (pulso = '1') THEN
					pr_state 			<= tres4;
					ELSE
					pr_state				<= rbt34;
					END IF;		
					
				WHEN tres4	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 16;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= tres4;
					END IF;
					
------------------------------------------------------------------------
			
				WHEN rbt4 =>
				
					r_addr_d	<= 1;
					r_addr_c <= 4; 
					
					IF (pulso = '1') THEN
					pr_state 			<= cuatro;
					ELSE
					pr_state				<= rbt4;
					END IF;
					
				WHEN cuatro	=>
					
					r_addr_d	<= 1;
					r_addr_c <= 4;
					
					IF (pulso = '0' AND cuadrante = "000") THEN
					pr_state 			<= rbt41;
					ELSIF (pulso = '0' AND cuadrante = "001") THEN
					pr_state 			<= rbt42;
					ELSIF (pulso = '0' AND cuadrante = "010") THEN
					pr_state 			<= rbt43;
					ELSIF (pulso = '0' AND cuadrante = "011") THEN
					pr_state 			<= rbt44;
					ELSE
					pr_state				<= cuatro;
					END IF;
					
				WHEN rbt41 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 17; 
					
					IF (pulso = '1') THEN
					pr_state 			<= cuatro1;
					ELSE
					pr_state				<= rbt41;
					END IF;	
					
				WHEN cuatro1	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 17;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= cuatro1;
					END IF;
					
				WHEN rbt42 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 18; 
					
					IF (pulso = '1') THEN
					pr_state 			<= cuatro2;
					ELSE
					pr_state				<= rbt42;
					END IF;		
					
				WHEN cuatro2	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 18;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= cuatro2;
					END IF;
					
				WHEN rbt43 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 19; 
					
					IF (pulso = '1') THEN
					pr_state 			<= cuatro3;
					ELSE
					pr_state				<= rbt43;
					END IF;	
					
				WHEN cuatro3	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 19;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= cuatro3;
					END IF;
					
				WHEN rbt44 =>
				
					r_addr_d	<= 2;
					r_addr_c <= 20; 
					
					IF (pulso = '1') THEN
					pr_state 			<= cuatro4;
					ELSE
					pr_state				<= rbt44;
					END IF;		
					
				WHEN cuatro4	=>
					
					r_addr_d	<= 2;
					r_addr_c <= 20;
					
					IF (restart = '0') THEN
					pr_state 			<= rbt0;
					ELSE
					pr_state				<= cuatro4;
					END IF;
			
		  END CASE;
		END IF;		
	END PROCESS combinational;
END ARCHITECTURE;