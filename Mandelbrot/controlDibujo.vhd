LIBRARY IEEE;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;
----------------------------------------------------------------------------------------------------
ENTITY controlDibujo IS
	GENERIC	( 	  Nv						:			INTEGER  := 11;
					  Nh						:			INTEGER  := 11;
					  ConP					:			INTEGER	:=	480;
					  decimal				:			INTEGER	:= 32;
					  Nfilas					:			INTEGER	:= 9;
					  itera					:			INTEGER	:=	2000);
	PORT		( 	  clk	               :	IN 	STD_LOGIC;
					  rst	               :	IN 	STD_LOGIC;
					  video_on				:	IN		STD_LOGIC;
					  iniciofractal		:	IN		STD_LOGIC:='0';
					  countv					:	IN		STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
					  counth					:	IN		STD_LOGIC_VECTOR(Nh-1 DOWNTO 0);
					  pulso					:	IN		STD_LOGIC;
					  restart				:	IN		STD_LOGIC;
					  zoom					:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
					  pixel					:	OUT	STD_LOGIC_VECTOR(11 DOWNTO 0);
					  finaliza				:  OUT	STD_LOGIC:='0';
					  variablex				:	OUT	STD_LOGIC;
					  conteos				:	OUT	STD_LOGIC_VECTOR(Nh-1 DOWNTO 0)
					  
				); 
	END ENTITY;
-----------------------------------------------------------------------------------------------------
ARCHITECTURE controlDibujoARCH OF controlDibujo IS

	TYPE state IS (black,white);
	
	SIGNAL pr_state, nx_state: state;
	
	SIGNAL LimCuadradoR 			: STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
	SIGNAL LimCuadradoL 			: STD_LOGIC_VECTOR(Nv-1 DOWNTO 0);
	SIGNAL PosicionColumna		: INTEGER;
	SIGNAL PosicionFila			: INTEGER;
	SIGNAL countpix				: STD_LOGIC_VECTOR(Nh-1 DOWNTO 0);
	SIGNAL pixelMatriz			: STD_LOGIC;
	SIGNAL numeropar				: STD_LOGIC;
	SIGNAL bool						: STD_LOGIC:='0';
	SIGNAL MaxTickh				: STD_LOGIC;
	SIGNAL synch					: STD_LOGIC;
	SIGNAL finalizaM				: STD_LOGIC:='0';
	SIGNAL Cx						: SIGNED(decimal-1 DOWNTO 0):= "11111000000000000000000000000000";
	SIGNAL Cy						: SIGNED(decimal-1 DOWNTO 0):= "11111100000000000000000000000000";
	SIGNAL dx						: SIGNED(decimal-1 DOWNTO 0):= "00000000000001100110011001100110";
	SIGNAL dy						: SIGNED(decimal-1 DOWNTO 0):= "00000000000001000100010001000100";
	
BEGIN
-----------------------------------------------------------------------------------------------------
	PROCESS(rst,clk)
	BEGIN
		IF	(rst='1') THEN
			pr_state <= black;
		ELSIF (rising_edge(clk)) THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	
	PROCESS(finalizaM)
	BEGIN	
		IF	(rst='1') THEN
			finaliza <= '0';
		ELSIF(rising_edge(clk)) THEN
			IF(finalizaM ='1') THEN
				finaliza <= '1';
			END IF;
		END IF;
	END PROCESS;

--	PROCESS(bool,clk)
--	BEGIN
--	IF(rising_edge(clk)) THEN
--		IF	(bool='0') THEN
--			iniciofractal <= '1';
--			bool	<='1';
--		ELSE 
--			iniciofractal	<='0';
--		END IF;
--	END IF;
--	END PROCESS;
	
PosicionFila			<=	TO_INTEGER(UNSIGNED(countv));
PosicionColumna		<= TO_INTEGER(UNSIGNED(countpix));
variablex				<=	numeropar;
--conteos				<=	PosicionColumna;

--=================================Bloque Calculadora--===========================================--

	Zoomm: ENTITY WORK.zoom 
		GENERIC MAP( decimal				=>   decimal,
					  addr_width_c			=>    20,
					  addr_width_d			=>    2)
		PORT	MAP( clk	               =>		clk,
					  rst	               =>		rst,
					  pulso					=>		pulso,
					  restart				=>		restart,
					  cuadrante				=>		zoom,
					  Cx						=>		Cx,
					  Cy						=>		Cy,
					  dx						=>		dx,
					  dy						=>		dy
					 );

	Matriz : Entity WORK.proof
	GENERIC	MAP ( 	Nv					=> Nv,
							decimal			=> decimal,
							Confilas			=> ConP,
							Nfilas			=> Nfilas,
							Concolumnas		=> ConP,
							Ncolumnas		=> Nfilas,
							Coniteracion	=> itera,
							Niteraciones	=> Nv)
	PORT		MAP ( 	clk	         => clk,
						  rst	            => rst,
						  iniciofractal	=> iniciofractal,
						  Cx					=> Cx,
						  Cy					=> Cy,
						  dx					=> dx,
						  dy					=> dy,
						  pixel				=> pixelMatriz,
						  finaliza			=> finalizaM,
						  row_rd_addr		=> PosicionColumna,
						  column_rd_addr	=>	PosicionFila
						  ); 
	
--	Matriz: ENTITY work.Matriz 
--	GENERIC	MAP( 	  Nv 						=> Nv)
--	PORT MAP	( 	 	  clk	               =>	clk,
--						  rst	               =>	rst,
--						  PosicionFila			=>	PosicionFila,
--						  PosicionColumna		=>	PosicionColumna,
--						  pixelMatriz  		=>	pixelMatriz
--					);
--=================================================================================================
					
	COLUMNAS: ENTITY work.conth
	GENERIC MAP( Conh      		=> Conp, 
				  Nh					=>	Nh)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_conth	=>	synch,
				  ena_conth		   =>	numeropar,
				  conthMaxTick	   =>	MaxTickh,
				  count				=> countpix);
					
	-----------------------------------------

	combinational: PROCESS(pr_state, counth, countv, pixelMatriz,	LimCuadradoL, LimCuadradoR)
	BEGIN
	---------------------------------------------------------------------------------------------------------------------------
	LimCuadradoR 		<= STD_LOGIC_VECTOR(TO_UNSIGNED(1120,Nv));
	LimCuadradoL 		<= STD_LOGIC_VECTOR(TO_UNSIGNED(160,Nv));

	---------------------------------------------------------------------------------------------------------------------------
	
		IF(video_on = '1' ) THEN
		
				IF((counth >= LimCuadradoL ) AND ( counth <= LimCuadradoR)) THEN
					numeropar	<= (NOT counth(0));
					synch<='0';
				ELSIF((counth < LimCuadradoL ) OR (counth > LimCuadradoR))THEN
					numeropar	<=	'0';
					synch<='1';
				END IF;
		
		CASE pr_state IS
		
			WHEN white	=>
					pixel				 	<=	"111111111111" ;
					IF 		(((counth >= LimCuadradoL ) AND ( counth <= LimCuadradoR)) AND (pixelMatriz = '1')) THEN
							nx_state 			<= white;
					ELSIF 	((counth < LimCuadradoL ) OR ( counth > LimCuadradoR) OR ((counth >= LimCuadradoL ) AND ( counth <= LimCuadradoR) AND (pixelMatriz = '0'))) THEN
							nx_state 			<= black;
					END IF;
				
					
			WHEN black	=>
					pixel				 	<=	"000000000000";
					IF 		((counth < LimCuadradoL ) OR ( counth > LimCuadradoR) OR ((counth >= LimCuadradoL ) AND ( counth <= LimCuadradoR) AND (pixelMatriz = '0'))) THEN
							nx_state 			<= black;
					ELSIF 	(((counth >= LimCuadradoL ) AND ( counth <= LimCuadradoR)) AND (pixelMatriz = '1')) THEN
							nx_state 			<= white;
					END IF;
					
				END CASE;
		END IF;	
	END PROCESS combinational;
END ARCHITECTURE;