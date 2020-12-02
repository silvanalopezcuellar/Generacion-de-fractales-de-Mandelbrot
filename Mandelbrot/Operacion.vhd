LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.all;
-------------------------------
ENTITY Operacion IS
	GENERIC	( Nv						:	INTEGER  := 11;
				  decimal				:	INTEGER	:=	32);
	PORT		( clk	               :	IN 	STD_LOGIC;
				  rst	               :	IN 	STD_LOGIC;
				  Xnn						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  Ynn						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  Cx						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  Cy						:	IN		SIGNED(decimal-1 DOWNTO 0);
				  Xout					:	OUT	SIGNED(decimal-1 DOWNTO 0);
				  Yout					:	OUT	SIGNED(decimal-1 DOWNTO 0)
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE Op OF Operacion IS

SIGNAL	XnnXnn	: SIGNED(decimal-1 DOWNTO 0);
SIGNAL	YnnYnn	: SIGNED(decimal-1 DOWNTO 0);
SIGNAL	XnnYnn	: SIGNED(decimal-1 DOWNTO 0);
SIGNAL	dosXY		: SIGNED(decimal-1 DOWNTO 0);
	
	
BEGIN
																	--xnn(2)=(xnn(1)^2)-(ynn(1)^2)+cx;
																	--ynn(2)=(2*(xnn(1)*ynn(1)))+cy;
	XnnXnn <= sfixmult(Xnn,Xnn,26);
	YnnYnn <= sfixmult(Ynn,Ynn,26);
	XnnYnn <= sfixmult(Xnn,Ynn,26);
	
	Xout	<=	XnnXnn - YnnYnn + Cx;
	Yout	<=	XnnYnn + XnnYnn + Cy;

END ARCHITECTURE;
