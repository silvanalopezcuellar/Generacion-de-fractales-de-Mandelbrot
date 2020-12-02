LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
-------------------------
ENTITY register_c IS
	GENERIC( MAX_WIDTH		:	INTEGER);
	PORT(		clk				:	IN		STD_LOGIC;
				en					:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				c					:	IN		SIGNED(MAX_WIDTH-1 DOWNTO 0);
				d					:	IN		SIGNED(MAX_WIDTH-1 DOWNTO 0);
				q					:	OUT	SIGNED(MAX_WIDTH-1 DOWNTO 0)				
			);
END ENTITY;
--------------------------
ARCHITECTURE register_c_arch OF register_c IS
	SIGNAL cast : UNSIGNED(1 downto 0);
BEGIN
	--WRITE PROCESS
	dff: PROCESS (clk, rst, d)
	BEGIN
		IF(rst = '1') THEN
			q <= c;
		ELSIF(rising_edge(clk)) THEN
			IF(en = '1') THEN
				q <= d;
			END IF;
		END IF;
	END PROCESS;
		
END ARCHITECTURE;