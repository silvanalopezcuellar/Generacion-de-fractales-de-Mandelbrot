LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY cronometro IS
	GENERIC	( Cont1			:			INTEGER	:= 5000000;
				  Cont2			:			INTEGER 	:= 9;
				  N1				:			INTEGER  := 23;
				  N2				:			INTEGER  := 4;
				  N3				:			INTEGER  := 3;
				  Conad			:			INTEGER	:= 5000000;
				  Nad				:			INTEGER	:= 20);
				  
	PORT		( clk				:	IN		STD_LOGIC;
				  rst	      	:	IN 	STD_LOGIC;
				  syn_clr		:	IN 	STD_LOGIC:='0';
				  enable			:	IN 	STD_LOGIC;
				  go				:	IN 	STD_LOGIC;
				  salidaSERIAL	:  OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 
ARCHITECTURE cronometroArch OF cronometro IS

	SIGNAL	digi00,digi0,digi1,digi2								:  STD_LOGIC_VECTOR(N2-1 DOWNTO 0);
	SIGNAL 	sdig00,sdig0,sdig1,sdig2								:  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL   ena0, ena1, ena2, ena3, ena4, ena5, enadri		:  STD_LOGIC;
	SIGNAL	max_tick2, max_tick3, ignore							:	STD_LOGIC;
	SIGNAL   anillo 														:	STD_LOGIC_VECTOR(N3-1 DOWNTO 0);
	SIGNAL   count0_vector,count1_vector,count2_vector			:	STD_LOGIC_VECTOR(31 DOWNTO 0):= "00000000000000000000000000000000" ;
	
	
BEGIN

	ena5 		<= enable;
	ena1 		<= enable AND go;
	ena3 		<= max_tick2 AND ena2;
	ena4 		<= max_tick3 AND ena3;
	salidaSERIAL <= sdig2&sdig1&sdig0&sdig00;

	contModule_0: ENTITY work.cron1
	GENERIC MAP( Con => 50000,
					 N	  => 16 )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => ena5,
				 max_tick => ena0);
												-- Contador para pruebas
	contModule_base: ENTITY work.cron1
	GENERIC MAP( Con => Conad,
					 N	  => Nad )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => ena1,
				 max_tick => enadri);
				 
	contModule_00: ENTITY work.cron1
	GENERIC MAP( Con => Cont2,
					 N	  => N2 )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => enadri,
				 max_tick => ignore,
				 count	 => digi00); 
													-- Contador cada 10 ms
	contModule_1: ENTITY work.cron1
	GENERIC MAP( Con => Cont1,
					 N	  => N1 )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => ena1,
				 max_tick => ena2);	
													-- Contador de cada 100 ms
	contModule_2: ENTITY work.cron1
	GENERIC MAP( Con => Cont2,
					 N	  => N2 )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => ena2,
				 max_tick => max_tick2,
				 count 	 => digi0);
												-- Contador de 0 a 900 ms
	contModule_3: ENTITY work.cron1
	GENERIC MAP( Con => Cont2,
					 N	  => N2 )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => ena3,
				 max_tick => max_tick3,
				 count    => digi1);
												-- contador de 0 a 9 s
	contModule_4: ENTITY work.cron1
	GENERIC MAP( Con => Cont2,
					 N	  => N2 )
	PORT MAP (clk  	 => clk,
				 rst  	 => rst,
				 syn_clr	 => syn_clr,
				 ena  	 => ena4,
				 count    => digi2);
												-- contador de 0 a 9 décimas de segundo
-------------------------------------------------------------

	bcdModule_0: ENTITY work.bin_to_sseg
	PORT MAP( bin		 =>	digi00,
				 sseg		 =>	sdig00	);
	
	bcdModule_1: ENTITY work.bin_to_sseg
	PORT MAP( bin		 =>	digi0,
				 sseg		 =>	sdig0	);
				 
	bcdModule_2: ENTITY work.bin_to_sseg
	PORT MAP( bin		 =>	digi1,
				 sseg		 =>	sdig1	);
	
	bcdModule_3: ENTITY work.bin_to_sseg
	PORT MAP( bin		 =>	digi2,
				 sseg		 =>	sdig2	);
				 
		
END ARCHITECTURE cronometroArch;