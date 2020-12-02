LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY controlhorizontal IS
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  cont1MaxTick	      :	IN 	STD_LOGIC;
				  cont2MaxTick	      :	IN 	STD_LOGIC;
				  cont3MaxTick	      :	IN 	STD_LOGIC;
				  cont4MaxTick	      :	IN 	STD_LOGIC;
				  ena_cont1 	      :	OUT	STD_LOGIC;
				  ena_cont2 	      :	OUT	STD_LOGIC;
				  ena_cont3 	      :	OUT	STD_LOGIC;
				  ena_cont4 	      :	OUT	STD_LOGIC;
				  syn_clr_cont1	   :	OUT	STD_LOGIC;
				  syn_clr_cont2	   :	OUT	STD_LOGIC;
				  syn_clr_cont3	   :	OUT	STD_LOGIC;
				  syn_clr_cont4	   :	OUT	STD_LOGIC;
				  h_video_on	   	:	OUT	STD_LOGIC;
				  hsync   			   :	OUT 	STD_LOGIC
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE oneHot OF controlhorizontal IS

	TYPE state IS (uno, dos, tres, cuatro);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	sequential: PROCESS(rst, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	uno;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;

	combinational: PROCESS(pr_state, cont1MaxTick, cont2MaxTick, cont3MaxTick, cont4MaxTick)
	BEGIN
		CASE pr_state IS
			WHEN uno	=>
				ena_cont1	  		<=	'1';
				ena_cont2	   	<=	'0';
				ena_cont3	   	<=	'0';
				ena_cont4	   	<=	'0';
				syn_clr_cont1	  	<=	'0';
				syn_clr_cont2	   <=	'1';
				syn_clr_cont3	  	<=	'1';
				syn_clr_cont4	 	<=	'1';
				h_video_on 		  	<=	'0';
				hsync				 	<=	'1';
				IF (cont1MaxTick = '0') THEN
				nx_state 			<= uno;
				ELSIF (cont1MaxTick = '1') THEN
				nx_state 			<= dos;
				END IF;
			WHEN dos	=>
				ena_cont1	  		<=	'0';
				ena_cont2	   	<=	'1';
				ena_cont3	   	<=	'0';
				ena_cont4	   	<=	'0';
				syn_clr_cont1	  	<=	'1';
				syn_clr_cont2	   <=	'0';
				syn_clr_cont3	  	<=	'1';
				syn_clr_cont4	 	<=	'1';
				h_video_on 		  	<=	'1';
				hsync				 	<=	'1';
				IF (cont2MaxTick = '0') THEN
				nx_state 			<= dos;
				ELSIF (cont2MaxTick = '1') THEN
				nx_state 			<= tres;
				END IF;
			WHEN tres	=>
				ena_cont1	  		<=	'0';
				ena_cont2	   	<=	'0';
				ena_cont3	   	<=	'1';
				ena_cont4	   	<=	'0';
				syn_clr_cont1	  	<=	'1';
				syn_clr_cont2	   <=	'1';
				syn_clr_cont3	  	<=	'0';
				syn_clr_cont4	 	<=	'1';
				h_video_on 		  	<=	'0';
				hsync				 	<=	'1';
				IF (cont3MaxTick = '0') THEN
				nx_state 			<= tres;
				ELSIF (cont3MaxTick = '1') THEN
				nx_state 			<= cuatro;
				END IF;
			WHEN cuatro	=>
				ena_cont1	  		<=	'0';
				ena_cont2	   	<=	'0';
				ena_cont3	   	<=	'0';
				ena_cont4	   	<=	'1';
				syn_clr_cont1	  	<=	'1';
				syn_clr_cont2	   <=	'1';
				syn_clr_cont3	  	<=	'1';
				syn_clr_cont4	 	<=	'0';
				h_video_on 		  	<=	'0';
				hsync				 	<=	'0';
				IF (cont4MaxTick = '0') THEN
				nx_state 			<= cuatro;
				ELSIF (cont4MaxTick = '1') THEN
				nx_state 			<= uno;
				END IF;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE;