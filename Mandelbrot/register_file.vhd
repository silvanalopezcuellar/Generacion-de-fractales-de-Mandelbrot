LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
-------------------------
ENTITY register_file IS
	GENERIC( DATA_WIDTH		:	INTEGER:= 32;
				ADDR_WIDTH		:	INTEGER:= 1);
	PORT(		clk				:	IN		STD_LOGIC;
				wr_en				:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				w_addr			:	IN		STD_LOGIC;
				r_addr			:	IN		STD_LOGIC;
				w_data			:	IN		SIGNED(DATA_WIDTH-1 DOWNTO 0);
				r_data			:	OUT	SIGNED(DATA_WIDTH-1 DOWNTO 0)				
			);
END ENTITY;
--------------------------
ARCHITECTURE rtl OF register_file IS
	TYPE mem_2d_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF SIGNED((DATA_WIDTH)-1 DOWNTO 0);
	SIGNAL array_reg: mem_2d_type;
	SIGNAL en	:	STD_LOGIC_VECTOR(2**ADDR_WIDTH-1 DOWNTO 0);
	signal cast : UNSIGNED(1 downto 0);
BEGIN
	--WRITE PROCESS
	write_process: PROCESS (clk)
	BEGIN
		IF(rising_edge(clk)) THEN
			IF(wr_en = "10")	THEN
				IF(w_addr = '1') THEN
					array_reg(1) <= w_data;
				ELSIF(w_addr ='0') THEN 
					array_reg(0)<= array_reg(1);
				END IF;
			ELSIF(wr_en = "01") THEN
				array_reg(0) <= (OTHERS => '0');
				array_reg(1) <= (OTHERS => '0');
			END IF;
		END IF;
	END PROCESS;
		
	--READ
	cast<= '0' & r_addr;
	r_data <= array_reg(to_integer(unsigned(cast)));
END ARCHITECTURE;