LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------
ENTITY horizontal IS
   GENERIC	( Con1      		:			INTEGER  := 96;  
				  N1					:			INTEGER  := 7;
				  Con2      		:			INTEGER  := 1280;  
				  N2					:			INTEGER  := 11; 
				  Con3      		:			INTEGER  := 32;  
				  N3					:			INTEGER  := 6;
				  Con4      		:			INTEGER  := 192;  
				  N4					:			INTEGER  := 8;
				  Conh      		:			INTEGER  := 1597;  
				  Nh					:			INTEGER  := 11
				  );
	PORT(	clk						:	IN		STD_LOGIC;
			rst						:	IN		STD_LOGIC;
			h_video_on_out		   :	OUT	STD_LOGIC;
			hsync_out		 		:	OUT	STD_LOGIC;
			counth					:	OUT	STD_LOGIC_VECTOR(N2-1 DOWNTO 0);
			linea						:	OUT	STD_LOGIC;
			mtx						:	OUT	STD_LOGIC
	);
END ENTITY horizontal;
---------------------------------------------------------
ARCHITECTURE ARCH OF horizontal IS
	SIGNAL	MaxTick1				:	STD_LOGIC;
	SIGNAL	MaxTick2				:	STD_LOGIC;
	SIGNAL	MaxTick3		    	:	STD_LOGIC;
	SIGNAL	MaxTick4				:	STD_LOGIC;
	SIGNAL	MaxTickh				:  STD_LOGIC;
	SIGNAL	ena1			    	:	STD_LOGIC;
	SIGNAL	ena2			    	:	STD_LOGIC;
	SIGNAL	ena3			    	:	STD_LOGIC;
	SIGNAL	ena4			    	:	STD_LOGIC;
	SIGNAL 	enah					:	STD_LOGIC;
	SIGNAL	sync2			    	:	STD_LOGIC;
	SIGNAL	sync1			    	:	STD_LOGIC;
	SIGNAL	sync4			    	:	STD_LOGIC;
	SIGNAL	sync3			    	:	STD_LOGIC;
	SIGNAL 	synch					:	STD_LOGIC;
	SIGNAL	hsyncs				:	STD_LOGIC;
BEGIN

Hsync_out <= hsyncs;
	DUT: ENTITY work.controlhorizontal
	PORT MAP(  clk	               =>	clk,
				  rst	               =>	rst,
				  cont1MaxTick	      => MaxTick1,
				  cont2MaxTick	      => MaxTick2,
				  cont3MaxTick	      => MaxTick3,
				  cont4MaxTick	      => MaxTick4,
				  ena_cont1		      => ena1,
				  ena_cont2		      => ena2,
				  ena_cont3		      => ena3,
				  ena_cont4		      => ena4,
				  syn_clr_cont1	   => sync1,
				  syn_clr_cont2	   => sync2,
				  syn_clr_cont3	   => sync3,
				  syn_clr_cont4	   => sync4,
				  h_video_on	  	   => h_video_on_out,
				  hsync				   => hsyncs);
				  
	BIST: ENTITY work.cont
	GENERIC MAP( Con      		=> Con1, 
				  N					=>	N1)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=>	sync1,
				  ena_cont		   =>	ena1,
				  contMaxTick	   =>	MaxTick1);
			
	BIST2: ENTITY work.cont
	GENERIC MAP( Con      		=> Con2, 
				  N					=>	N2)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=>	sync2,
				  ena_cont		   =>	ena2,
				  contMaxTick	   =>	MaxTick2
				--  count				=> counth
				  );
				  
	BIST3: ENTITY work.cont
	GENERIC MAP( Con      		=> Con3, 
				  N					=>	N3)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=>	sync3,
				  ena_cont		   =>	ena3,
				  contMaxTick	   =>	MaxTick3);
					
	BIST4: ENTITY work.cont
	GENERIC MAP( Con      		=> Con4, 
				  N					=>	N4)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=>	sync4,
				  ena_cont		   =>	ena4,
				  contMaxTick	   =>	MaxTick4);
				  
	BISTH: ENTITY work.conth
	GENERIC MAP( Conh      		=> Conh, 
				  Nh					=>	Nh)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_conth	=>	synch,
				  ena_conth		   =>	enah,
				  conthMaxTick	   =>	MaxTickh,
				  count				=> counth);
	enah 	<= '1';
	linea <=MaxTick4;
	synch <= MaxTick1;
	mtx <= maxTick1;
END ARCHITECTURE;