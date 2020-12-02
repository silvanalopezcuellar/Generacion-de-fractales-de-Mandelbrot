LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY ControlBarraL IS
	GENERIC	(	Nv						:	INTEGER  := 11);
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  JoyStick1		      :	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				  LimSupBarraL			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  LimInfBarraL			:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
				  BarraInfL		   	:	OUT	INTEGER:=190;
				  BarraSupL  		   :	OUT 	INTEGER:=290
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE bar OF ControlBarraL IS

	TYPE state IS (up, down, stay);
	SIGNAL pr_state	:	state;
	SIGNAL SupL	: INTEGER:=290;
	SIGNAL InfL	: INTEGER:=190;
	
BEGIN
	BarraSupL	<= SupL;
	BarraInfL	<= InfL;
	
	combinational: PROCESS(clk, rst, pr_state, JoyStick1, LimInfBarraL, LimSupBarraL)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	stay;
		ELSIF (rising_edge(clk)) THEN
			CASE pr_state IS
				WHEN up	=>
					SupL	<=	SupL + 2;
					InfL 	<= InfL + 2;
					IF ((LimInfBarraL >= "00000000000") AND (LimSupBarraL < "00111011011") AND (JoyStick1="00")) THEN
					pr_state 			<= up;
					ELSIF ((LimInfBarraL > "00000000010") AND (LimSupBarraL <= "00111011111") AND (JoyStick1="11")) THEN
					pr_state				<= down;
					ELSE 
					pr_state 			<= stay;
					END IF;
				
				WHEN stay	=>
					SupL	<=	SupL;
					InfL 	<= InfL;
					IF ((LimInfBarraL >= "00000000000") AND (LimSupBarraL < "00111011011") AND (JoyStick1="00")) THEN
					pr_state 			<= up;
					ELSIF ((LimInfBarraL > "00000000010") AND (LimSupBarraL <= "00111011111") AND (JoyStick1="11")) THEN
					pr_state				<= down;
					ELSE 
					pr_state 			<= stay;
					END IF;
					
				WHEN down	=>
					SupL	<=	SupL - 2;
					InfL 	<= InfL - 2;
					IF ((LimInfBarraL >= "00000000000") AND (LimSupBarraL < "00111011011") AND (JoyStick1="00")) THEN
					pr_state 			<= up;
					ELSIF ((LimInfBarraL > "00000000010") AND (LimSupBarraL <= "00111011111") AND (JoyStick1="11")) THEN
					pr_state				<= down;
					ELSE 
					pr_state 			<= stay;
					END IF;
			END CASE;
		END IF;
	END PROCESS combinational;
END ARCHITECTURE;