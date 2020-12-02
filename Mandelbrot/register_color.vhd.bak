LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
-------------------------
ENTITY register_color IS
	PORT(		clk				:	IN		STD_LOGIC;
				en					:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				c					:	IN		STD_LOGIC;
				d					:	IN		STD_LOGIC;
				q					:	OUT	STD_LOGIC				
			);
END ENTITY;
--------------------------
ARCHITECTURE register_color_arch OF register_color IS
	SIGNAL cast : UNSIGNED(1 downto 0);
BEGIN
	--WRITE PROCESS
	dff: PROCESS (clk, rst, d)
	BEGIN
		IF(rst = '1') THEN
			q <= '0';
		ELSIF(rising_edge(clk)) THEN
			IF(en = '1') THEN
				q <= d;
			END IF;
		END IF;
	END PROCESS;
		
END ARCHITECTURE;