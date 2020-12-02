LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
-------------------------
ENTITY register_dy IS
	GENERIC( DATA_WIDTH		:	INTEGER:= 32;
				ADDR_WIDTH		:	INTEGER);
	PORT(		clk				:	IN		STD_LOGIC;
				r_addr			:	IN		INTEGER;
				r_data			:	OUT	SIGNED(DATA_WIDTH-1 DOWNTO 0)				
			);
END ENTITY;
--------------------------
ARCHITECTURE rtl OF register_dy IS
	TYPE mem_2d_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF SIGNED((DATA_WIDTH)-1 DOWNTO 0);
	SIGNAL array_reg: mem_2d_type;
	SIGNAL en	:	STD_LOGIC_VECTOR(2**ADDR_WIDTH-1 DOWNTO 0);
	signal cast : UNSIGNED(1 downto 0);
BEGIN
	--WRITE PROCESS
	array_reg(0)<= "00000000000001000100010100100011";
	array_reg(1)<= "00000000000000100010001000001011";
	array_reg(2)<= "00000000000000010001000100100111";
	
	--READ
	r_data <= array_reg(r_addr);
END ARCHITECTURE;