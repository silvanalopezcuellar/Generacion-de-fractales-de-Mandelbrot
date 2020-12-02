LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY contv IS
	GENERIC	( Conv      		:			INTEGER  ;  
				  Nv					:			INTEGER	);
	PORT		( clk					:	IN		STD_LOGIC;
				  rst					:	IN 	STD_LOGIC;
				  syn_clr_contv	:	IN 	STD_LOGIC;
				  ena_contv		:	IN 	STD_LOGIC;
				  contvMaxTick	:	OUT 	STD_LOGIC;
				  count			:	OUT	STD_LOGIC_VECTOR(Nv-1 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE contvArch OF contv IS
	SIGNAL	count_s		:	INTEGER; --RANGE -1 to (Conv);
BEGIN
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER;--RANGE -1 to (Conv);
	BEGIN
		IF(rst = '1') THEN
			temp	:=	0;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_contv='1') THEN
				temp := (0);
			ELSE IF (ena_contv = '1') THEN
				IF (temp=(Conv)) THEN
					temp := (-1);
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		END IF;
		count <= STD_LOGIC_VECTOR(TO_UNSIGNED(temp,Nv));
		count_s	<=	temp;
	END PROCESS;
--
	contvMaxTick	<=	'1' WHEN (count_s) = (Conv) ELSE '0';
END ARCHITECTURE contvArch;