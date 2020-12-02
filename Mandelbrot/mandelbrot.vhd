LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------------------------------------------------------------------------
ENTITY mandelbrot IS
	GENERIC	( Con5      		:			INTEGER  := 33;  
				  N5					:			INTEGER  := 6;
				  Con6      		:			INTEGER  := 480;   --  480
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
				  ConP				:			INTEGER	:=	480;   -- 480
				  decimal			:			INTEGER	:= 32;
				  Nfilas				:			INTEGER	:= 9;
				  itera				:			INTEGER	:=	2000;   -- 2000
				  Cont1CR			:			INTEGER	:= 5000000;   -- 5000000
				  Cont2CR			:			INTEGER 	:= 9;
				  N1CR				:			INTEGER  := 23;
				  N2CR				:			INTEGER  := 4;
				  N3CR				:			INTEGER  := 3;
				  Contransmision	:			INTEGER  := 868;  
				  Ntransmision		:			INTEGER  := 10;
				  Conbits     		:			INTEGER  := 280;  
				  Nbits				:			INTEGER  := 9;
				  MAX_WIDTH			:			INTEGER	:= 280;
				  Conad				:			INTEGER	:= 500000;   -- 500000
				  Nad					:			INTEGER	:= 20
				  );
				  
	PORT		(	  clk	               :	IN 	STD_LOGIC;
					  rst	               :	IN 	STD_LOGIC;
					  iniciofractal		:	IN		STD_LOGIC:='0';
					  zoom		         :	IN 	STD_LOGIC_VECTOR(2 DOWNTO 0):="000";
					  pulso					:	IN		STD_LOGIC;
					  restart				:	IN		STD_LOGIC;
					  pixel					:	OUT	STD_LOGIC_VECTOR(11 DOWNTO 0);
					  h_video_on_out		:	OUT 	STD_LOGIC;
					  v_video_on_out		:  OUT	STD_LOGIC;
					  linea2					:	BUFFER STD_LOGIC;
					  vsync_out		 		:	OUT	STD_LOGIC;
					  hsync_out		 		:	OUT	STD_LOGIC;
  					  salidatiempo			:	OUT 	STD_LOGIC
					  
				); 

	END ENTITY;
-----------------------------------------------------------------------------------------------------
ARCHITECTURE mandelbrotARCH OF mandelbrot IS
	
SIGNAL countv													:	STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);	
SIGNAL counth,pixelh											:	STD_LOGIC_VECTOR(Nh-1 DOWNTO 0);
SIGNAL reloj 													:  STD_LOGIC;
SIGNAL video_on, vh, vv, MaxTickFrame,mxt				:	STD_LOGIC;
SIGNAL Pplayer1, Pplayer2									:  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL syn_clr, go											:	STD_LOGIC:='0';
SIGNAL enable													:	STD_LOGIC:='1';
SIGNAL salidaSERIAL											: 	STD_LOGIC_VECTOR(31 DOWNTO 0):="00000000000000000000000000000000";
SIGNAL finaliza												:	STD_LOGIC:='0';
SIGNAL tx														:	STD_LOGIC;
SIGNAL linea 													:  STD_LOGIC;

BEGIN
-----------------------------------------------------------------------------------------------------

reloj <= linea2;
video_on <=  vh AND vv;
h_video_on_out <= vh;
v_video_on_out <= vv;

nn:PROCESS (iniciofractal)
	BEGIN
	IF (iniciofractal='1') THEN
	go <= '1';
	END IF;
	END PROCESS;


controlDibujoBLK: ENTITY work.controlDibujo 
	GENERIC MAP	( 	  Nv => Nv,
						  Nh => Nh,
						  ConP	=>ConP,
						  decimal=>decimal,
						  Nfilas	=>Nfilas,
						  itera	=>itera)
	PORT	  MAP ( 	  clk => clk,
						  rst => rst,
						  video_on => video_on,
						  iniciofractal => iniciofractal,
						  countv => countv,
						  counth => counth,
						  pulso  =>	pulso,
						  restart => restart,
						  zoom   =>	zoom,
						  pixel  => pixel,
						  finaliza => finaliza);

horizontalBLK : ENTITY work.horizontal
	GENERIC	MAP( 	 	Con1 => Con1,
						N1 => N1,
						Con2 => Con2,
						N2 => N2,
						Con3 => Con3,
						N3 => N3,
						Con4 => Con4,
						N4 => N4,
						Conh => Conh,
						Nh	 => Nh)
	 PORT		MAP(	clk => clk,
						rst => rst,
						h_video_on_out => vh,
						hsync_out => hsync_out,
						counth => counth,
						linea => linea2
					);
					
verticalBLK : ENTITY work.vertical
	GENERIC	MAP( 	Con5 => Con5,
							N5 => N5,
							Con6 => Con6,
							N6 => N6,
							Con7 => Con7,
							N7 => N7,
							Con8 => Con8,
							N8 => N8,
							Conv => Conv,
						   Nv	 => Nv)
	PORT	 MAP	(	clk => reloj,
							rst => rst,
							v_video_on_out => vv,
							vsync_out => vsync_out,
							countv => countv,
							MaxTickFrame => MaxTickFrame
						);
						
cronometrotiempo: ENTITY work.cronometro
	GENERIC	MAP( Cont1			=> Cont1CR,
				  Cont2			=> Cont2CR,
				  N1				=> N1CR,
				  N2				=> N2CR,
				  N3				=> N3CR,
				  Conad			=> Conad,
				  Nad				=> Nad)
	PORT	MAP( clk				=> clk,
				  rst	      	=> rst,
				  syn_clr		=> syn_clr,
				  enable			=> enable,
				   go				=>	go,
				  salidaSERIAL	=> salidaSERIAL);

serial:	ENTITY work.comunicacion 
	GENERIC	MAP( Contransmision	=>  Contransmision, 
				  Ntransmision			=>  Ntransmision,
				  Conbits     			=>  Conbits,
				  Nbits					=>  Nbits,
				  MAX_WIDTH				=>  MAX_WIDTH
				  )
	PORT		MAP( clk	               => clk,
					  rst	               => rst,
					  iniciotransmision	=> finaliza,
					  transmitir         => salidaSERIAL,
					  tx						=> tx,
					  salida					=> salidatiempo
				); 
				  

END ARCHITECTURE;