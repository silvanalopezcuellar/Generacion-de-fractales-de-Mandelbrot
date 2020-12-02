LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------
ENTITY vertical IS
   GENERIC	( Con5      		:			INTEGER  := 32;  
				  N5					:			INTEGER  := 6;
				  Con6      		:			INTEGER  := 479;  
				  N6					:			INTEGER  := 9; 
				  Con7      		:			INTEGER  := 9;  
				  N7					:			INTEGER  := 4;
				  Con8      		:			INTEGER  := 1;  
				  N8					:			INTEGER  := 2;
				  Conv      		:			INTEGER  := 524;  
				  Nv					:			INTEGER  := 10);
	PORT(	clk						:	IN		STD_LOGIC;
			rst						:	IN		STD_LOGIC;
			v_video_on_out		   :	OUT	STD_LOGIC;
			vsync_out		 		:	OUT	STD_LOGIC;
			countv					:	OUT	STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
			MaxTickFrame			:	OUT	STD_LOGIC
	);
END ENTITY vertical;
---------------------------------------------------------
ARCHITECTURE ARCH OF vertical IS
	SIGNAL	MaxTick5				:	STD_LOGIC;
	SIGNAL	MaxTick6				:	STD_LOGIC;
	SIGNAL	MaxTick7				:	STD_LOGIC;
	SIGNAL	MaxTick8				:	STD_LOGIC;
	SIGNAL	MaxTickv				:	STD_LOGIC;
	SIGNAL	ena5			    	:	STD_LOGIC;
	SIGNAL	ena6			    	:	STD_LOGIC;
	SIGNAL	ena7			    	:	STD_LOGIC;
	SIGNAL	ena8			    	:	STD_LOGIC;
	SIGNAL	enav			    	:	STD_LOGIC;
	SIGNAL	sync5			    	:	STD_LOGIC;
	SIGNAL	sync6			    	:	STD_LOGIC;
	SIGNAL	sync7			    	:	STD_LOGIC;
	SIGNAL	sync8			    	:	STD_LOGIC;
	SIGNAL	syncv			    	:	STD_LOGIC;
BEGIN

	MaxTickFrame<= MaxTick6;
	DUT: ENTITY work.controlvertical
	PORT MAP(  clk	               =>	clk,
				  rst	               =>	rst,
				  cont5MaxTick	      => MaxTick5,
				  cont6MaxTick	      => MaxTick6,
				  cont7MaxTick	      => MaxTick7,
				  cont8MaxTick	      => MaxTick8,
				  ena_cont5		      => ena5,
				  ena_cont6		      => ena6,
				  ena_cont7		      => ena7,
				  ena_cont8		      => ena8,
				  syn_clr_cont5	   => sync5,
				  syn_clr_cont6	   => sync6,
				  syn_clr_cont7	   => sync7,
				  syn_clr_cont8	   => sync8,
				  v_video_on	  	   => v_video_on_out,
				  vsync				   => vsync_out);
				  
	BIST: ENTITY work.cont
	GENERIC MAP( Con      		=> Con5, 
				  N					=>	N5)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont	=>	sync5,
				  ena_cont		   =>	ena5,
				  contMaxTick	   =>	MaxTick5);
			
	BIST2: ENTITY work.cont
	GENERIC MAP( Con      		=> Con6, 
				  N					=>	N6)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont  	=>	sync6,
				  ena_cont		   =>	ena6,
				  contMaxTick	   =>	MaxTick6
				--  count 				=> countv
				  );
				  
	BIST3: ENTITY work.cont
	GENERIC MAP( Con      		=> Con7, 
				  N					=>	N7)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=>	sync7,
				  ena_cont		   =>	ena7,
				  contMaxTick	   =>	MaxTick7);
					
	BIST4: ENTITY work.cont
	GENERIC MAP( Con      		=> Con8, 
				  N					=>	N8)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=>	sync8,
				  ena_cont		   =>	ena8,
				  contMaxTick	   =>	MaxTick8);

	BISTV: ENTITY work.contv
	GENERIC MAP( Conv      		=> Conv, 
				  Nv					=>	Nv)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_contv	=>	syncv,
				  ena_contv		   =>	enav,
				  contvMaxTick	   =>	MaxTickv,
				  count				=> countv);
	enav 	<= '1';
	syncv <= MaxTick5;

END ARCHITECTURE;