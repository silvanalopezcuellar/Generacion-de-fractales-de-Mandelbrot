LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY conth IS
	GENERIC	( Conh      		:			INTEGER  ;  
				  Nh					:			INTEGER	);
	PORT		( clk					:	IN		STD_LOGIC;
				  rst					:	IN 	STD_LOGIC;
				  syn_clr_conth	:	IN 	STD_LOGIC;
				  ena_conth		:	IN 	STD_LOGIC;
				  conthMaxTick	:	OUT 	STD_LOGIC;
				  count			:	OUT	STD_LOGIC_VECTOR(Nh-1 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE conthArch OF conth IS
	SIGNAL	count_s		:	INTEGER; --RANGE -1 to (Conh);
BEGIN
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER; --RANGE -1 to (Conh);
	BEGIN
		IF(rst = '1') THEN
			temp	:=	0;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_conth='1') THEN
				temp := 0;
			ELSE IF (ena_conth = '1') THEN
				IF (temp=(Conh)) THEN
					temp := (-1);
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		END IF;
		count <= STD_LOGIC_VECTOR(TO_UNSIGNED(temp,Nh));
		count_s	<=	temp;
	END PROCESS;
--
	conthMaxTick	<=	'1' WHEN (count_s) = (Conh) ELSE '0';
END ARCHITECTURE conthArch;