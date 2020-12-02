LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.all;
-------------------------------
ENTITY Suma IS
	GENERIC	( decimal				:	INTEGER);
	PORT		( rst_cy					:	IN		STD_LOGIC;
				  rst_cx					:	IN		STD_LOGIC;
				  ena_cx					:	IN		STD_LOGIC;
				  ena_cy					:	IN		STD_LOGIC;
				  cxin					:	IN		SIGNED(decimal-1 DOWNTO 0);
				  cyin					:	IN		SIGNED(decimal-1 DOWNTO 0);
				  dxx						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  dyy						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  cxout					:	OUT	SIGNED(decimal-1 DOWNTO 0);
				  cyout					:	OUT	SIGNED(decimal-1 DOWNTO 0)
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE Opeope OF Suma IS

	
BEGIN

	PROCESS(ena_cx,rst_cx,rst_cy,ena_cy)
	BEGIN
	
		IF	(rst_cx='1')	THEN
		   cxout <= "11111000000000000000000000000000";
		ELSIF	(ena_cx='1') THEN
			cxout <= cxin + dxx;
		END IF;
		IF (rst_cy='1') THEN
			cyout <= "11111100000000000000000000000000";
		ELSIF (ena_cy='1') THEN
			cyout <= cyin + dyy;
		END IF;
	END PROCESS;

END ARCHITECTURE;