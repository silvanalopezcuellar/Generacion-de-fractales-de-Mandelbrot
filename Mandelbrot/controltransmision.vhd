LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY controltransmision IS
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  iniciotransmision	:	IN		STD_LOGIC;
				  conttrMaxTick      :	IN 	STD_LOGIC;
				  contbitsMaxTick		:	IN		STD_LOGIC;
				  countbits				:	IN		INTEGER := 0;
				  --salida					:	IN		STD_LOGIC;
				  syn_clr_tr			:	OUT	STD_LOGIC;
				  syn_clr_bits			:	OUT	STD_LOGIC;
				  ena_conttr			:	OUT	STD_LOGIC;
				  ena_contbits			:	OUT	STD_LOGIC;
				  ena_guardar			:	OUT	STD_LOGIC;
				  ena_desplazar		:  OUT	STD_LOGIC;
				  tx						:	OUT	STD_LOGIC
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE oneHot OF controltransmision IS

	TYPE state IS (uno, dos, tres, cuatro, cinco);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	

	combinational: PROCESS( rst, clk, pr_state, iniciotransmision, conttrMaxTick, contbitsMaxTick,	countbits)
	BEGIN
	
	IF (rst = '1') THEN
			pr_state	<=	uno;
		ELSIF (rising_edge(clk)) THEN
		
		CASE pr_state IS
			WHEN uno	=>
				syn_clr_tr <= '1';
				syn_clr_bits <= '1';
				ena_conttr <= '0';
				ena_contbits <= '0';
				ena_guardar <= '0';
				ena_desplazar <= '0';
				tx <= '0';
				IF (iniciotransmision = '1') THEN
				pr_state 			<= dos;
				ELSE
				pr_state 			<= uno;
				END IF;
				
			WHEN dos	=>
				syn_clr_tr <= '1';
				syn_clr_bits <= '1';
				ena_conttr <= '0';
				ena_contbits <= '0';
				ena_guardar <= '1';
				ena_desplazar <= '0';
				tx <= '0';
				pr_state 			<= tres;
				
			WHEN tres	=>
				syn_clr_tr <= '0';
				syn_clr_bits <= '1';
				ena_conttr <= '1';
				ena_contbits <= '0';
				tx <= '0';
				ena_guardar <= '0';
				ena_desplazar <= '0';
				IF (conttrMaxTick = '1') THEN
				pr_state 			<= cuatro;
				ELSE
				pr_state 			<= tres;
				END IF;
				
			WHEN cuatro	=>
				syn_clr_tr <= '1';
				syn_clr_bits <= '0';
				ena_conttr <= '0';
				ena_contbits <= '1';
				ena_guardar <= '0';
				ena_desplazar <= '1';
				tx <= '0';
				IF (countbits < 280) THEN
				pr_state 			<= tres;
				ELSE
				pr_state 			<= cinco;
				END IF;
				
			WHEN cinco	=>
				syn_clr_tr <= '0';
				syn_clr_bits <= '1';
				ena_conttr <= '1';
				ena_contbits <= '0';
				ena_guardar <= '0';
				ena_desplazar <= '0';
				tx <= '1';
				IF (conttrMaxTick = '1') THEN
				pr_state 			<= uno;
				ELSE
				pr_state 			<= cinco;
				END IF;
		END CASE;
	  END IF;
	END PROCESS combinational;
END ARCHITECTURE;