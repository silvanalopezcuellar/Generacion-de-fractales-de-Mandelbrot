LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY cont IS
	GENERIC	( Con       		:			INTEGER  ;  
				  N					:			INTEGER	);
	PORT		( clk					:	IN		STD_LOGIC;
				  rst					:	IN 	STD_LOGIC;
				  syn_clr_cont	:	IN 	STD_LOGIC;
				  ena_cont		:	IN 	STD_LOGIC;
				  contMaxTick	:	OUT 	STD_LOGIC);
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE contArch OF cont IS
	SIGNAL	count_s		:	INTEGER RANGE -1 to (Con);
BEGIN
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER RANGE -1 to (Con);
	BEGIN
		IF(rst = '1') THEN
			temp	:=	0;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_cont='1') THEN
				temp := (0);
			ELSE IF (ena_cont = '1') THEN
				IF (temp=(Con)) THEN
					temp := (-1);
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		END IF;
		count_s	<=	temp;
	END PROCESS;
--
	contMaxTick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE contArch;