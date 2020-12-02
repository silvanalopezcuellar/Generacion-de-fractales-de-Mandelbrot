LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY controlvertical IS
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  cont5MaxTick	      :	IN 	STD_LOGIC;
				  cont6MaxTick	      :	IN 	STD_LOGIC;
				  cont7MaxTick	      :	IN 	STD_LOGIC;
				  cont8MaxTick	      :	IN 	STD_LOGIC;
				  ena_cont5 	      :	OUT	STD_LOGIC;
				  ena_cont6 	      :	OUT	STD_LOGIC;
				  ena_cont7 	      :	OUT	STD_LOGIC;
				  ena_cont8 	      :	OUT	STD_LOGIC;
				  syn_clr_cont5	   :	OUT	STD_LOGIC;
				  syn_clr_cont6	   :	OUT	STD_LOGIC;
				  syn_clr_cont7	   :	OUT	STD_LOGIC;
				  syn_clr_cont8	   :	OUT	STD_LOGIC;
				  v_video_on	   	:	OUT	STD_LOGIC;
				  vsync   			   :	OUT 	STD_LOGIC
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE oneHot OF controlvertical IS

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

	combinational: PROCESS(pr_state, cont5MaxTick, cont6MaxTick, cont7MaxTick, cont8MaxTick)
	BEGIN
		CASE pr_state IS
			WHEN uno	=>
				ena_cont5	  		<=	'1';
				ena_cont6	   	<=	'0';
				ena_cont7	   	<=	'0';
				ena_cont8	   	<=	'0';
				syn_clr_cont5	  	<=	'0';
				syn_clr_cont6	   <=	'1';
				syn_clr_cont7	  	<=	'1';
				syn_clr_cont8	 	<=	'1';
				v_video_on 		  	<=	'0';
				vsync				 	<=	'1';
				IF (cont5MaxTick = '0') THEN
				nx_state 			<= uno;
				ELSIF (cont5MaxTick = '1') THEN
				nx_state 			<= dos;
				END IF;
			WHEN dos	=>
				ena_cont5	  		<=	'0';
				ena_cont6	   	<=	'1';
				ena_cont7	   	<=	'0';
				ena_cont8	   	<=	'0';
				syn_clr_cont5	  	<=	'1';
				syn_clr_cont6	   <=	'0';
				syn_clr_cont7	  	<=	'1';
				syn_clr_cont8	 	<=	'1';
				v_video_on 		  	<=	'1';
				vsync				 	<=	'1';
				IF (cont6MaxTick = '0') THEN
				nx_state 			<= dos;
				ELSIF (cont6MaxTick = '1') THEN
				nx_state 			<= tres;
				END IF;
			WHEN tres	=>
				ena_cont5	  		<=	'0';
				ena_cont6	   	<=	'0';
				ena_cont7	   	<=	'1';
				ena_cont8	   	<=	'0';
				syn_clr_cont5	  	<=	'1';
				syn_clr_cont6	   <=	'1';
				syn_clr_cont7	  	<=	'0';
				syn_clr_cont8	 	<=	'1';
				v_video_on 		  	<=	'0';
				vsync				 	<=	'1';
				IF (cont7MaxTick = '0') THEN
				nx_state 			<= tres;
				ELSIF (cont7MaxTick = '1') THEN
				nx_state 			<= cuatro;
				END IF;
			WHEN cuatro	=>
				ena_cont5	  		<=	'0';
				ena_cont6	   	<=	'0';
				ena_cont7	   	<=	'0';
				ena_cont8	   	<=	'1';
				syn_clr_cont5	  	<=	'1';
				syn_clr_cont6	   <=	'1';
				syn_clr_cont7	  	<=	'1';
				syn_clr_cont8	 	<=	'0';
				v_video_on 		  	<=	'0';
				vsync				 	<=	'0';
				IF (cont8MaxTick = '0') THEN
				nx_state 			<= cuatro;
				ELSIF (cont8MaxTick = '1') THEN
				nx_state 			<= uno;
				END IF;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE;