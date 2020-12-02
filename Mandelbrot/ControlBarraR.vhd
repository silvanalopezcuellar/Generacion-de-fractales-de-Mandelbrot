LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY ControlBarraR IS
	GENERIC	(	Nv						:	INTEGER  := 11);
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  JoyStick2		      :	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				  LimSupBarraR			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimInfBarraR			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  BarraInfR		   	:	OUT	INTEGER:=190;
				  BarraSupR  		   :	OUT 	INTEGER:=290;
				  controlBarraRE		:	OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE bar OF ControlBarraR IS

	TYPE state IS (up, stay, down);
	SIGNAL pr_state	:	state;
	SIGNAL SupR	: INTEGER:=290;
	SIGNAL InfR	: INTEGER:=190;
BEGIN
	
	BarraSupR	<= SupR;
	BarraInfR	<= InfR;	
	 
	
	combinational: PROCESS(rst, clk, pr_state, JoyStick2, LimInfBarraR, LimSupBarraR)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	stay;
		ELSIF (rising_edge(clk)) THEN
		CASE pr_state IS
			WHEN up	=>
					SupR	<=	SupR + 2;
					InfR 	<= InfR + 2;
					controlBarraRE(0) <= '1';
					controlBarraRE(1) <= '0';
					controlBarraRE(2) <= '0';
					IF ((LimInfBarraR >= "00000000000") AND (LimSupBarraR < "00111011011") AND (JoyStick2="00")) THEN
					pr_state 			<= up;
					ELSIF ((LimInfBarraR > "00000000010") AND (LimSupBarraR <= "00111011111") AND (JoyStick2="11")) THEN
					pr_state				<= down;
					ELSE 
					pr_state 			<= stay;
					END IF;
				
				WHEN stay	=>
					SupR	<=	SupR;
					InfR 	<= InfR;
					controlBarraRE(0) <= '0';
					controlBarraRE(1) <= '1';
					controlBarraRE(2) <= '0';
					IF ((LimInfBarraR >= "00000000000") AND (LimSupBarraR < "00111011011") AND (JoyStick2="00")) THEN
					pr_state 			<= up;
					ELSIF ((LimInfBarraR > "00000000010") AND (LimSupBarraR <= "00111011111") AND (JoyStick2="11")) THEN
					pr_state				<= down;
					ELSE 
					pr_state 			<= stay;
					END IF;
					
				WHEN down	=>
					SupR	<=	SupR - 2;
					InfR 	<= InfR - 2;
					controlBarraRE(0) <= '0';
					controlBarraRE(1) <= '0';
					controlBarraRE(2) <= '1';
					IF ((LimInfBarraR >= "00000000000") AND (LimSupBarraR < "00111011011") AND (JoyStick2="00")) THEN
					pr_state 			<= up;
					ELSIF ((LimInfBarraR > "00000000010") AND (LimSupBarraR <= "00111011111") AND (JoyStick2="11")) THEN
					pr_state				<= down;
					ELSE 
					pr_state 			<= stay;
					END IF;
		  END CASE;
		END IF;		
	END PROCESS combinational;
END ARCHITECTURE;