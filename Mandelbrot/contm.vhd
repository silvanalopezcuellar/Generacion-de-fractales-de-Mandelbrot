LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY contm IS
	GENERIC	( Con       		:			INTEGER := 480 ;  
				  N					:			INTEGER := 9 );
	PORT		( clk					:	IN		STD_LOGIC;
				  rst					:	IN 	STD_LOGIC;
				  syn_clr_cont	:	IN 	STD_LOGIC:='0';
				  ena_cont		:	IN 	STD_LOGIC;
				  contMaxTick	:	OUT 	STD_LOGIC;
				  count_sout	:	OUT	INTEGER); --RANGE -1 to (Con));
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE contmArch OF contm IS
	SIGNAL	count_s		:	INTEGER ;--RANGE -1 to (Con);
BEGIN
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER; --RANGE -1 to (Con);
	BEGIN
		IF(rst = '1') THEN
			temp	:=	0;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_cont = '1') THEN
				temp	:=	0;
			ELSIF (ena_cont = '1') THEN
				IF (temp=(Con)) THEN
					temp := (-1);
				END IF;
				temp := temp + 1;
			END IF;
		END IF;
		count_s	<=	temp;
	END PROCESS;
	count_sout <= count_s;
	contMaxTick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE contmArch;