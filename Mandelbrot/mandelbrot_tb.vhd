LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.all;
----------------------------------------------------------------------------------------------------
ENTITY mandelbrot_tb IS
	GENERIC	( Con5      		:			INTEGER  := 33;  
				  N5					:			INTEGER  := 6;
				  Con6      		:			INTEGER  := 48;   --  480
				  N6					:			INTEGER  := 9; 
				  Con7      		:			INTEGER  := 10;  
				  N7					:			INTEGER  := 4;
				  Con8      		:			INTEGER  := 2;  
				  N8					:			INTEGER  := 2;
				  Con1      		:			INTEGER  := 96;  
				  N1					:			INTEGER  := 7;
				  Con2      		:			INTEGER  := 1280;  
				  N2					:			INTEGER  := 11; 
				  Con3      		:			INTEGER  := 32;  
				  N3					:			INTEGER  := 6;
				  Con4      		:			INTEGER  := 192;  
				  N4					:			INTEGER  := 8;
				  Conh      		:			INTEGER  := 1600;  
				  Nh					:			INTEGER  := 11; 
				  Conv      		:			INTEGER  := 1048;  
				  Nv					:			INTEGER  := 11;
				  ConP				:			INTEGER	:=	48;   -- 480
				  decimal			:			INTEGER	:= 32;
				  Nfilas				:			INTEGER	:= 9;
				  itera				:			INTEGER	:=	20;   -- 2000
				  Cont1CR			:			INTEGER	:= 5000;   -- 5000000
				  Cont2CR			:			INTEGER 	:= 9;
				  N1CR				:			INTEGER  := 23;
				  N2CR				:			INTEGER  := 4;
				  N3CR				:			INTEGER  := 3;
				  Contransmision	:			INTEGER  := 868;  
				  Ntransmision		:			INTEGER  := 10;
				  Conbits     		:			INTEGER  := 280;  
				  Nbits				:			INTEGER  := 9;
				  MAX_WIDTH			:			INTEGER	:= 280;
				  Conad				:			INTEGER	:= 500;   -- 500000
				  Nad					:			INTEGER	:= 20
				 );
END ENTITY mandelbrot_tb;
----------------------------------
ARCHITECTURE testbench2 OF mandelbrot_tb IS
	
SIGNAL  clk	               :	STD_LOGIC;
SIGNAL  rst	               :	STD_LOGIC;
SIGNAL  zoom		         : 	STD_LOGIC_VECTOR(2 DOWNTO 0):="000";
SIGNAL  pulso					:	STD_LOGIC;
SIGNAL  restart				:	STD_LOGIC;
SIGNAL  pixel					:	STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL  h_video_on_out		: 	STD_LOGIC;
SIGNAL  v_video_on_out		:	STD_LOGIC;
SIGNAL  linea2					:  STD_LOGIC;
SIGNAL  vsync_out		 		:	STD_LOGIC;
SIGNAL  salidatiempo			:	STD_LOGIC;
SIGNAL  hsync_out				:	STD_LOGIC;
SIGNAL  iniciofractal		:	STD_LOGIC:='0';
SIGNAL  salidaSERIAL			:	STD_LOGIC_VECTOR(31 DOWNTO 0):="00000000000000000000000000000000";

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
	
--	inGeneration: PROCESS
--	BEGIN 
--		
--		iniciofractal 	<=  '1' AFTER 20 ns;
--
--		row_rd_addr		<= 6 AFTER 100 ns;
--		column_rd_addr	<=	6 AFTER 100 ns;
--	WAIT;
--	END PROCESS inGeneration;
	
	proofBLK_tb: ENTITY work.mandelbrot
	GENERIC	MAP( 	Con5      		=>		con5,
					  N5					=>		N5,
					  Con6      		=>		Con6,
					  N6					=>		N6,
					  Con7      		=>		Con7,
					  N7					=>		N7,
					  Con8      		=>		Con8,
					  N8					=>		N8,
					  Con1      		=>		Con1,
					  N1					=>		N1,
					  Con2      		=>		Con2,
					  N2					=>		N2,
					  Con3      		=>		Con3,
					  N3					=>		N3,
					  Con4      		=>		Con4,
					  N4					=>		N4,
					  Conh      		=>		Conh,
					  Nh					=>		Nh,
					  Conv      		=>		Conv,
					  Nv					=>		Nv,
					  ConP				=>		ConP,
					  decimal			=>		decimal,
					  Nfilas				=>		Nfilas,
					  itera				=>		itera,
					  Cont1CR			=>		Cont1CR,
					  Cont2CR			=>		Cont2CR,
					  N1CR				=>		N1CR,
					  N2CR				=>		N2CR,
					  N3CR				=>		N3CR,
					  Contransmision	=>		Contransmision,  
					  Ntransmision		=>		Ntransmision,
					  Conbits     		=>		Conbits,  
					  Nbits				=>		Nbits,
					  MAX_WIDTH			=>		MAX_WIDTH,
					  Conad				=>		Conad,
					  Nad					=>		Nad
				 )
	PORT	  MAP ( clk	               =>		clk,
					  rst	               =>		rst,
					  iniciofractal		=>		iniciofractal,
					  zoom		         =>		zoom,
					  pulso 					=>		pulso,
					  restart				=> 	restart,
					  pixel					=>		pixel,
					  h_video_on_out		=>		h_video_on_out,
					  v_video_on_out		=>		v_video_on_out,
					  linea2					=>		linea2,
					  vsync_out		 		=>		vsync_out,
					  hsync_out		 		=>		hsync_out,
					  salidatiempo			=>		salidatiempo
					  );

	--------------------------------------------------					  
END ARCHITECTURE testbench2;	