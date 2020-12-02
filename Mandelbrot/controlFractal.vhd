LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
-------------------------------
ENTITY controlFractal IS
	GENERIC	(	Confilas				:				INTEGER;
					Nfilas				:				INTEGER;
					Concolumnas			:				INTEGER;
					Ncolumnas			:				INTEGER;
					Coniteracion		:				INTEGER;
					Niteraciones		:				INTEGER;
					cuatro				: 				SIGNED(31 DOWNTO 0) := "00010000000000000000000000000000";
					ceros					:				SIGNED(31 DOWNTO 0) := "00000000000000000000000000000000"
					);
	PORT		( clk	               :	IN 		STD_LOGIC;
				  rst	               :	IN 		STD_LOGIC;
				  iniciofractal		: 	IN			STD_LOGIC;
				  contcolumnas			:	IN			INTEGER:=0;
				  contfilas		   	:	IN			INTEGER:=0;
				  contiteracion		:	IN 		INTEGER:=0;
				  escapein				: 	IN 		SIGNED(31 DOWNTO 0);
				  syn_clr_filas		:	OUT		STD_LOGIC;
				  syn_clr_columnas	:	OUT		STD_LOGIC;
				  syn_clr_iteracion	:	OUT		STD_LOGIC;
				  ena_cx					:	OUT		STD_LOGIC;
				  ena_cy					:	OUT		STD_LOGIC;
				  ena_contfilas      :	OUT		STD_LOGIC;
				  ena_contcolumnas	: 	OUT		STD_LOGIC;
				  ena_contiteracion	:	OUT		STD_LOGIC;
				  wr_ena	   			:	OUT		STD_LOGIC_VECTOR(1 DOWNTO 0);
				  wr_addr				:	OUT		STD_LOGIC;
				  rd_addr				:	OUT		STD_LOGIC;
				  ram_ena				:	OUT		STD_LOGIC;
				  ram_columnas_wr		:	OUT		INTEGER:=0;
				  ram_filas_wr			:	OUT		INTEGER:=0;
				  color					:	OUT		STD_LOGIC;
				  finaliza				: 	OUT 		STD_LOGIC;
				  ena_color				:	OUT		STD_LOGIC;
				  rst_cy					:	OUT		STD_LOGIC;
				  rst_cx					:	OUT		STD_LOGIC
				  ); 
END ENTITY;
------------------------------------------------------------------------------------------------------
ARCHITECTURE controlFractalARCH OF controlFractal IS

	TYPE state IS (inicio, inicializacion, filas,columnas, iteracion, operacion, escape, finalizacion);
	SIGNAL pr_state	:	state;
	
BEGIN

--	ram_columnas_wr <= contcolumnas WHEN pr_state= columnas ELSE 0;
--	ena_color<= '1' WHEN pr_state= escape OR pr_state= iteracion ELSE '0';
--	ram_ena <= '1' WHEN pr_state= columnas ELSE '0';
--	color <= '1' WHEN pr_state= escape ELSE '0';
	ram_columnas_wr	<= contcolumnas;
	ram_filas_wr		<= contfilas;

	ena_color 			<= '1' 	WHEN pr_state = iteracion 		 OR pr_state = escape 	ELSE '0'; 
	ena_contfilas		<= '1' 	WHEN pr_state = filas 											ELSE '0';
	ena_contcolumnas  <= '1' 	WHEN pr_state = columnas										ELSE '0';
	ena_contiteracion <= '1' 	WHEN pr_state = iteracion										ELSE '0';
	syn_clr_filas		<= '1' 	WHEN pr_state = inicializacion								ELSE '0';
	syn_clr_columnas	<= '1' 	WHEN pr_state = inicializacion OR pr_state = filas		ELSE '0';
	syn_clr_iteracion	<= '1' 	WHEN pr_state = inicializacion OR pr_state = columnas	ELSE '0';
	ram_ena				<= '1' 	WHEN pr_state = columnas										ELSE '0';
 	wr_ena				<= "01" 	WHEN pr_state = inicializacion OR pr_state = columnas ELSE 
								"10"	WHEN pr_state = operacion		 OR pr_state = escape	ELSE "00"; 
	wr_addr				<= '1' 	WHEN pr_state = operacion										ELSE '0';
	rd_addr				<= '1' 	WHEN pr_state = escape											ELSE '0';
	rst_cy 				<= '1'	WHEN pr_state = inicializacion OR pr_state = inicio  
										OR	  pr_state = finalizacion	 OR pr_state = filas		ELSE '0'; 
	rst_cx 				<= '1'	WHEN pr_state = inicializacion OR pr_state = inicio  
										OR	  pr_state = finalizacion	 								ELSE '0';
	ena_cx				<= '1' 	WHEN pr_state = filas 											ELSE '0';
	ena_cy				<= '1' 	WHEN pr_state = columnas										ELSE '0';
	color					<= '1' 	WHEN pr_state = escape											ELSE '0';
	finaliza				<= '1' 	WHEN pr_state = finalizacion									ELSE '0';
											  
	combinational: PROCESS(rst, clk, pr_state, iniciofractal, contcolumnas, contfilas)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	inicio;
		ELSIF (rising_edge(clk)) THEN
		CASE pr_state IS
				WHEN inicio	=>
				
--					ena_color			<= '0';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'0';
--					syn_clr_iteracion	<=	'0';
--					ram_ena				<=	'0';
--					ram_columnas_wr	<=	0;
--					ram_filas_wr		<=	0;
--					wr_ena				<=	"00";
--					wr_addr				<= '0';
--					rd_addr				<= '0';
--												----------------											
--					rst_cy				<= '1';
--					rst_cx				<= '1';
--					ena_cx				<= '0';
--					ena_cy				<= '0';
--												----------------
--					color					<=	'0';
--					finaliza				<= '0';
					
					IF (iniciofractal = '1') THEN
					pr_state 			<= inicializacion;
					ELSE
					pr_state				<= inicio;
					END IF;
				
				WHEN inicializacion =>
				

--					ena_color			<= '0';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'1';
--					syn_clr_columnas	<=	'1';
--					syn_clr_iteracion	<=	'1';
--					ram_ena				<=	'0';
--					ram_columnas_wr	<=	0;
--					ram_filas_wr		<=	0;
--					wr_ena				<=	"01";
--					wr_addr				<= '0';
--					rd_addr				<= '0';
--					------------------------------
--					rst_cy				<= '1';
--					rst_cx				<= '1';
--					ena_cx				<= '0';
--					ena_cy				<= '0';
--					------------------------------
--					color					<=	'0';
--					finaliza				<= '0';
--					
					pr_state				<= filas;
					
				WHEN filas =>
				
					
--					ena_color			<= '0';
--					ena_contfilas     <= '1';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'1';
--					syn_clr_iteracion	<=	'0';
--					ram_ena				<=	'0';
--					ram_columnas_wr	<=	0;
--					ram_filas_wr		<=	0;
--					wr_ena				<=	"00";
--					wr_addr				<= '0';
--					rd_addr				<= '0';
--					color					<=	'0';
--					finaliza				<= '0';
--					------------------------------
--					rst_cy				<= '1';
--					rst_cx				<= '0';
--					ena_cx				<= '1';
--					ena_cy				<= '0';
					------------------------------
					
					IF (contfilas < Confilas) THEN
					pr_state 			<= columnas;
					ELSE
					pr_state				<= finalizacion;
					END IF;
					
				WHEN columnas	=>
				

--					ena_color			<= '0';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'1';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'0';
--					syn_clr_iteracion	<=	'1';
--					ram_ena				<=	'1';
--					ram_columnas_wr	<=	contcolumnas;
--					ram_filas_wr		<=	contfilas;
--					wr_ena				<=	"01";
--					wr_addr				<= '0';
--					rd_addr				<= '0';						
--					color					<=	'0';
--					finaliza				<= '0';
--					---------------------------------------
--					rst_cy				<= '0';
--					rst_cx				<= '0';
--					ena_cx				<= '0';
--					ena_cy				<= '1';
				
					IF (contcolumnas < Concolumnas) THEN
					pr_state 			<= iteracion;
					ELSE
					pr_state				<= filas;
					END IF;

					
				WHEN iteracion =>
				

--					ena_color			<=	'1';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'1';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'0';
--					syn_clr_iteracion	<=	'0';
--					ram_ena				<=	'0';
--					ram_columnas_wr	<=	 0;
--					ram_filas_wr		<=	 0;
--					wr_ena				<=	"00";
--					wr_addr				<= '0';
--					rd_addr				<= '0';
--					color					<=	'0';
--					finaliza				<= '0';	
--				---------------------------------------------
--					rst_cy				<= '0';
--					rst_cx				<= '0';
--					ena_cx				<= '0';
--					ena_cy				<= '0';
				---------------------------------------------
					
					IF (contiteracion < Coniteracion) THEN
						pr_state 			<= operacion;
					ELSE
						pr_state				<= columnas;
					END IF;
					
				WHEN operacion =>

--					ena_color			<=	'0';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'0';
--					syn_clr_iteracion	<=	'0';
--					ram_ena				<=	'0';
--					wr_ena				<=	"10";
--					wr_addr				<= '1';
--					rd_addr				<= '0';
--					ram_columnas_wr	<=	 0;
--					ram_filas_wr		<=	 0;
--					color					<=	'0';
--					finaliza				<= '0';	
--				---------------------------------------------
--					rst_cy				<= '0';
--					rst_cx				<= '0';
--					ena_cx				<= '0';
--					ena_cy				<= '0';
				---------------------------------------------	
					
					pr_state 			<= escape;
						
				WHEN escape =>
				

--					ena_color			<=	'1';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'0';
--					syn_clr_iteracion	<=	'0';
--					ram_ena				<=	'0';
--					ram_columnas_wr	<=	0;
--					ram_filas_wr		<=	0;
--					wr_ena				<=	"10";
--					wr_addr				<= '0';
--					rd_addr				<= '1';
--					color					<=	'1';
--					finaliza				<= '0';	
--				---------------------------------------------
--					rst_cy				<= '0';
--					rst_cx				<= '0';
--					ena_cx				<= '0';
--					ena_cy				<= '0';
				---------------------------------------------	
				
					IF (escapein >= cuatro) THEN
					pr_state				<= columnas;
					ELSE
					pr_state 			<= iteracion;
					END IF;
					
				WHEN finalizacion =>
--					ena_color			<=	'0';
--					ena_contfilas     <= '0';
--					ena_contcolumnas	<=	'0';
--					ena_contiteracion	<=	'0';
--					syn_clr_filas		<=	'0';
--					syn_clr_columnas	<=	'0';
--					syn_clr_iteracion	<=	'0';
--					ram_ena				<=	'0';
--					ram_columnas_wr	<=	0;
--					ram_filas_wr		<=	0;
--					wr_ena				<=	"00";
--					wr_addr				<= '0';
--					rd_addr				<= '0';
--					color					<=	'0';
--					finaliza				<= '1';
--				---------------------------------------------
--					rst_cy				<= '1';
--					rst_cx				<= '1';
--					ena_cx				<= '0';
--					ena_cy				<= '0';
				---------------------------------------------
				
					pr_state 			<= inicio;
			
		  END CASE;
		END IF;		
	END PROCESS combinational;
END ARCHITECTURE;