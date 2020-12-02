LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.all;
----------------------------------------------------------------------------------------------------
ENTITY proof_tb IS
	GENERIC	( 	Nv						:				INTEGER  := 11;
					decimal				:				INTEGER	:=	32;
					Confilas				:				INTEGER 	:= 10;
					Nfilas				:				INTEGER  := 4;
					Concolumnas			:				INTEGER 	:= 10;
					Ncolumnas			:				INTEGER  := 4;
					Coniteracion		:				INTEGER	:=	10;
					Niteraciones		:				INTEGER	:= 4
				 );
END ENTITY proof_tb;
----------------------------------
ARCHITECTURE testbench2 OF proof_tb IS
	
SIGNAL  clk		            : 	STD_LOGIC;
SIGNAL  rst	               : 	STD_LOGIC;
SIGNAL  iniciofractal		:	STD_LOGIC;
SIGNAL  Cx						:	SIGNED(decimal-1 DOWNTO 0):="11111000000000000000000000000000";
SIGNAL  Cy						:	SIGNED(decimal-1 DOWNTO 0):="11111100000000000000000000000000";
SIGNAL  dx						:	SIGNED(decimal-1 DOWNTO 0):="00000001001100110011001100110011";
SIGNAL  dy						:	SIGNED(decimal-1 DOWNTO 0):="00000000110011001100110011001100";
SIGNAL  pixel					:	STD_LOGIC;
SIGNAL  finaliza				:	STD_LOGIC;
SIGNAL  row_rd_addr			:	INTEGER:= 0;
SIGNAL  column_rd_addr		:	INTEGER:= 0;

BEGIN
	-------------- CLK GENERATION-------------------
	ClkGeneration: PROCESS
	BEGIN
		clk <= '0'; 
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
	END PROCESS ClkGeneration;
	------------------------------------------------
	
	rstGeneration: PROCESS
	BEGIN		
		------- RESET GENERATION
		rst		<= '1' AFTER 10 ns,
						'0' AFTER 30 ns;
		WAIT FOR 100000 ms;
	END PROCESS rstGeneration;
	
	inGeneration: PROCESS
	BEGIN 
		
		iniciofractal 	<=  '1' AFTER 20 ns;

		row_rd_addr		<= 6 AFTER 100 ns;
		column_rd_addr	<=	6 AFTER 100 ns;
	WAIT;
	END PROCESS inGeneration;
	
	proofBLK_tb: ENTITY work.proof
	GENERIC	MAP( 	Nv						=>		Nv,
						decimal				=>		decimal,
						Confilas				=>		Confilas,
						Nfilas				=>		Nfilas,
						Concolumnas			=>		Concolumnas,
						Ncolumnas			=>		Ncolumnas,
						Coniteracion		=>		Coniteracion,
						Niteraciones		=>		Niteraciones
				 )
	PORT	  MAP ( clk	               =>		clk,
					  rst	               =>		rst,
					  iniciofractal		=>		iniciofractal,
					  Cx						=>		Cx,
					  Cy						=>		Cy,
					  dx						=>		dx,
					  dy						=>		dy,
					  pixel					=>		pixel,
					  finaliza				=>		finaliza,
					  row_rd_addr			=>		row_rd_addr,
					  column_rd_addr		=>		column_rd_addr
				  );

	--------------------------------------------------					  
END ARCHITECTURE testbench2;	