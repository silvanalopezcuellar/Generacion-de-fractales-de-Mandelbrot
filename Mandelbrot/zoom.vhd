LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
---------------------------------------------------------
ENTITY zoom IS
	GENERIC	( decimal				:				INTEGER	:=	32;
				  addr_width_c			:				INTEGER	:= 20;
				  addr_width_d			:				INTEGER	:= 2);
	PORT		( clk	               :	IN 		STD_LOGIC;
				  rst	               :	IN 		STD_LOGIC;
				  pulso					:	IN			STD_LOGIC;
				  restart				:	IN			STD_LOGIC;
				  cuadrante				:	IN			STD_LOGIC_VECTOR(2 DOWNTO 0);
				  Cx						:	OUT		SIGNED(decimal-1 DOWNTO 0);
				  Cy						:	OUT		SIGNED(decimal-1 DOWNTO 0);
				  dx						:	OUT		SIGNED(decimal-1 DOWNTO 0);
				  dy						:	OUT		SIGNED(decimal-1 DOWNTO 0)
				 );
END ENTITY;

--------------------------------
ARCHITECTURE zoomarch OF zoom IS

SIGNAL r_addr_d 	:	INTEGER;
SIGNAL r_addr_c	:	INTEGER;

BEGIN
	controlzoomm:	ENTITY work.controlzoom
		GENERIC MAP( decimal		=> decimal)
		PORT MAP(	clk				=>			clk,
						rst	        	=>			rst,
						pulso				=>			pulso,
						restart			=>			restart,
						cuadrante		=>			cuadrante,
						r_addr_d 		=>			r_addr_d,
						r_addr_c			=>			r_addr_c
					);
						
	dym: ENTITY work.register_dy
		GENERIC MAP( DATA_WIDTH		=> decimal,
						 ADDR_WIDTH		=> addr_width_d)
		PORT MAP(	clk				=>			clk,
						r_addr			=>			r_addr_d,
						r_data			=>			dy
					);

	dxm: ENTITY work.register_dx
		GENERIC MAP( DATA_WIDTH		=> decimal,
						 ADDR_WIDTH		=> addr_width_d)
		PORT MAP(	clk				=>			clk,
						r_addr			=>			r_addr_d,
						r_data			=>			dx
					);
						
	cxm: ENTITY work.register_cx0
		GENERIC MAP( DATA_WIDTH		=> decimal,
						 ADDR_WIDTH		=> addr_width_c)
		PORT MAP(	clk				=>			clk,
						r_addr			=>			r_addr_c,
						r_data			=>			cx
					);
						
	cym: ENTITY work.register_cy0
		GENERIC MAP( DATA_WIDTH		=> decimal,
						 ADDR_WIDTH		=> addr_width_c)
		PORT MAP(	clk				=>			clk,
						r_addr			=>			r_addr_c,
						r_data			=>			cy
					);
					
END ARCHITECTURE;