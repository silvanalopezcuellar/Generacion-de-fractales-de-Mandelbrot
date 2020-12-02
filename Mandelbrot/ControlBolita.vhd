LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;
-------------------------------
ENTITY ControlBolita IS
	GENERIC	( Nv						:	INTEGER  := 11);
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  InicioBolita			:  IN		STD_LOGIC;
				  LimSupBarraR			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimInfBarraR			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimSupBarraL			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimInfBarraL			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimiteBolaUp			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimiteBolaDown		:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimiteBolaRight		:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimiteBolaLeft		:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  Bup		   			:	OUT	INTEGER:=245;
				  Bdown  		   	:	OUT 	INTEGER:=235;
				  Bright					:	OUT 	INTEGER:=648;
				  Bleft					:	OUT 	INTEGER:=632;
				  Pplayer1				:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				  Pplayer2				:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				  controlBolitaE		:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE bola OF ControlBolita IS

	TYPE state IS (inicio, normal, lbar, rbar, limsup, liminf, lose);
	SIGNAL pr_state	:	state;
	SIGNAL SupB	: INTEGER:=245;
	SIGNAL InfB	: INTEGER:=235;
	SIGNAL DerB	: INTEGER:=648;
	SIGNAL IzqB	: INTEGER:=632;
	SIGNAL player1	:  INTEGER:=0;
	SIGNAL player2	:  INTEGER:=0;
	SIGNAL rise			: STD_LOGIC:='1';
	SIGNAL LeftRight	: STD_LOGIC:='1';
	
BEGIN

	Bup	<= SupB;
	Bdown	<= InfB;
	Bright	<= DerB;
	Bleft		<= IzqB;
	Pplayer1	<= STD_LOGIC_VECTOR(TO_UNSIGNED( player1 ,4 ));
	Pplayer2	<= STD_LOGIC_VECTOR(TO_UNSIGNED( player2 ,4 ));


	combinational: PROCESS(clk, rst, pr_state, LimiteBolaUp, LimiteBolaDown, LimiteBolaRight, LimiteBolaLeft, LimSupBarraR, LimInfBarraR, LimSupBarraL, LimInfBarraL, LeftRight, rise, InicioBolita)
	BEGIN
		
		IF (rst = '1') THEN
			pr_state	<=	inicio;
		ELSIF (rising_edge(clk)) THEN
			
			
			CASE pr_state IS
			
				WHEN inicio	=>
					
					rise <= '1';
					LeftRight <= '1';
					
					SupB	<= 245;
					InfB	<= 235;
					DerB	<= 648;
					IzqB	<= 632;
					
					controlBolitaE(0)<='1';
					controlBolitaE(1)<='0';
					controlBolitaE(2)<='0';
					controlBolitaE(3)<='0';
					controlBolitaE(4)<='0';
					controlBolitaE(5)<='0';
					controlBolitaE(6)<='0';
					
					IF ( InicioBolita = '1' ) THEN
					pr_state 			<= normal;
					ELSE 
					pr_state 			<= inicio;
					END IF;
				
				WHEN normal	=>
				
					controlBolitaE(0)<='0';
					controlBolitaE(1)<='1';
					controlBolitaE(2)<='0';
					controlBolitaE(3)<='0';
					controlBolitaE(4)<='0';
					controlBolitaE(5)<='0';
					controlBolitaE(6)<='0';
					
								IF( rise = '1' ) THEN
									SupB	<= SupB + 3;
									InfB	<= InfB + 3;
								ELSIF( rise = '0' ) THEN
									SupB	<= SupB - 3;
									InfB	<= InfB - 3;
								END IF;
								IF( LeftRight = '1' ) THEN
									DerB	<= DerB + 3;
									IzqB	<= IzqB + 3;
								ELSIF( LeftRight = '0' ) THEN
									DerB	<= DerB - 3;
									IzqB	<= IzqB - 3;
								END IF;
				
					IF ((LimiteBolaUp < "00111011100") AND (LimiteBolaDown > "00000000011") AND (LimiteBolaLeft > "00000011011") AND (LimiteBolaRight > "10011100110")) THEN
					pr_state 			<= normal;
					ELSIF ((LimiteBolaLeft <= "00000011011") AND (LimiteBolaUp >= LimInfBarraL) AND (LimiteBolaDown <= LimSupBarraL)) THEN
					pr_state				<= lbar;
					ELSIF ((LimiteBolaRight >= "10011100110") AND (LimiteBolaUp >= LimInfBarraR) AND (LimiteBolaDown <= LimSupBarraR)) THEN 
					pr_state 			<= rbar;
					ELSIF (LimiteBolaUp >= "00111011100") THEN 
					pr_state 			<= limsup;
					ELSIF (LimiteBolaDown <= "00000000011") THEN
					pr_state 			<= liminf;
					ELSIF (((LimiteBolaLeft <= "00000011011") AND NOT ((LimiteBolaUp >= LimInfBarraL) AND (LimiteBolaDown <= LimSupBarraL))) OR ((LimiteBolaRight >= "10011100110") AND NOT ((LimiteBolaUp >= LimInfBarraR) AND (LimiteBolaDown <= LimSupBarraR)))) THEN
					pr_state				<= lose;
					END IF;
					
				WHEN lbar	=>
				
				   controlBolitaE(0)<='0';
					controlBolitaE(1)<='0';
					controlBolitaE(2)<='1';
					controlBolitaE(3)<='0';
					controlBolitaE(4)<='0';
					controlBolitaE(5)<='0';
					controlBolitaE(6)<='0';
				
					LeftRight	<=	'1';
					pr_state 			<= normal;
				
				WHEN rbar	=>
				
				   controlBolitaE(0)<='0';
					controlBolitaE(1)<='0';
					controlBolitaE(2)<='0';
					controlBolitaE(3)<='1';
					controlBolitaE(4)<='0';
					controlBolitaE(5)<='0';
					controlBolitaE(6)<='0';
					
					LeftRight	<=	'0';
					pr_state 			<= normal;
				
				WHEN limsup	=>
				
				   controlBolitaE(0)<='0';
					controlBolitaE(1)<='0';
					controlBolitaE(2)<='0';
					controlBolitaE(3)<='0';
					controlBolitaE(4)<='1';
					controlBolitaE(5)<='0';
					controlBolitaE(6)<='0';
					
					rise	<=	'0';
					pr_state 			<= normal;
				
				WHEN liminf	=>
				
				   controlBolitaE(0)<='0';
					controlBolitaE(1)<='0';
					controlBolitaE(2)<='0';
					controlBolitaE(3)<='0';
					controlBolitaE(4)<='0';
					controlBolitaE(5)<='1';
					controlBolitaE(6)<='0';
					
					rise	<=	'1';
					pr_state 			<= normal;	
				
				WHEN lose	=>
				
				   controlBolitaE(0)<='0';
					controlBolitaE(1)<='1';
					controlBolitaE(2)<='0';
					controlBolitaE(3)<='0';
					controlBolitaE(4)<='0';
					controlBolitaE(5)<='0';
					controlBolitaE(6)<='1';
					
					IF ( LimiteBolaLeft <= "00000011011") THEN
					player1 <= player1 + 1;
					ELSIF (LimiteBolaRight >= "10011100101") THEN
					player2 <= player2 + 1;
					END IF;
					IF ((player1 = 9) OR (player2 = 9)) THEN
					player1 <= 0;
					player2 <= 0;
					END IF;
					pr_state 			<= inicio;
				
			END CASE;
		END IF;
	END PROCESS combinational;
END ARCHITECTURE;