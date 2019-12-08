library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity principal is
    Port ( CLK  : in STD_LOGIC;                           -- Entrada de reloj
           SIN  : in STD_LOGIC;                           -- Entrada de datos
           AN   : out STD_LOGIC_VECTOR (3 downto 0);      -- Control de displays
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0));     -- Segmentos de displays
end principal;

architecture a_principal of principal is

-- Constantes del circuito (umbrales de decisión)

constant UMBRAL1 : STD_LOGIC_VECTOR (5 downto 0) := "100010"; -- 34 (Umbral comparador 1)
constant UMBRAL2 : STD_LOGIC_VECTOR (5 downto 0) := "100110"; -- 38 (Umbral comparador 2)

signal CLK_OUT : STD_LOGIC;        -- Señal utilizada para las entradas que precisan la señal CLK_M de 40 Hz
signal NQ0 : STD_LOGIC_VECTOR (39 downto 0);  -- Señal que comunica la salida del registro de desplazamiento de 40 bits con el sumador.
signal NQ1 : STD_LOGIC_VECTOR (5 downto 0);   -- Señal que comnica la salida del sumador con las entradas de los dos comparadores.
signal PGTQ1 : STD_LOGIC;                     -- Salida P>Q del comparador 1, corresponde a la primera entrada de la puerta AND.
signal PLEQ1 : STD_LOGIC;                     -- Salida P<=Q del comparador 1, corresponde a la segunda condición del autómata (SUM = U1).
signal PGTQ2 : STD_LOGIC;                     -- Salida P>Q del comparador 2.
signal PLEQ2 : STD_LOGIC;                     -- Salida P<=Q del comparador 2, corresponde a la segunda entrada de la puerta AND.
signal NQ2 : STD_LOGIC;                       -- Salida de la puerta AND, corresponde a la primera condición del autómata(U1 < SUM = U2).
signal NQ3 : STD_LOGIC;                       -- Salida del autómata, corresponde al Dato a cargar en el registro de desplazamiento de 14 bits.
signal NQ4 : STD_LOGIC;                       -- Salida del autómata, corresponde al ENABLE del registro de desplazamiento de 14 bits.
signal NQ5 : STD_LOGIC;                       -- Salida del autómata, corresponde al ENABLE del registro de validación.
signal NQ6 : STD_LOGIC_VECTOR (13 downto 0);  -- Salida del registro de desplazamiento de 14 bits y entrada del registro de validación.
signal NQ7 : STD_LOGIC_VECTOR (13 downto 0);  -- Salida del registro de validación y entrada del módulo de visualización.
 

component gen_reloj
   Port ( CLK : in STD_LOGIC;         -- Reloj de la FPGA
          CLK_M : out STD_LOGIC);     -- Reloj de frecuencia dividida

end component;

component reg_desp40
   Port ( SIN : in STD_LOGIC;                          -- Datos de entrada serie
          CLK : in STD_LOGIC;                          -- Reloj de muestreo
          Q : out STD_LOGIC_VECTOR (39 downto 0));     -- Salida paralelo

end component;

component sumador40
   Port ( ENT : in STD_LOGIC_VECTOR (39 downto 0);
          SAL : out STD_LOGIC_VECTOR (5 downto 0));

end component;

component comparador
   Port ( P : in STD_LOGIC_VECTOR (5 downto 0);
          Q : in STD_LOGIC_VECTOR (5 downto 0);
          PGTQ : out STD_LOGIC;
          PLEQ : out STD_LOGIC);

end component;

component AND_2
   Port ( A : in STD_LOGIC;
          B : in STD_LOGIC;
          S : out STD_LOGIC);

end component;

component reg_desp
   Port ( SIN : in STD_LOGIC;                             -- Datos de entrada serie
          CLK : in STD_LOGIC;                             -- Reloj CLK_M
          EN : in STD_LOGIC;                              -- Enable
          Q : out STD_LOGIC_VECTOR (13 downto 0));        -- Salida paralelo

end component;
component registro
   Port ( ENTRADA : in STD_LOGIC_VECTOR (13 downto 0);
          SALIDA : out STD_LOGIC_VECTOR (13 downto 0);
          EN : in STD_LOGIC;                                   -- Enable
          RCLK : in STD_LOGIC);

end component;

component automata
   Port ( CLK : in STD_LOGIC;             -- Reloj del autómata
          C0 : in STD_LOGIC;              -- Condición de decision para "0"
          C1 : in STD_LOGIC;              -- Condición de decisión para "1"
          DATO : out STD_LOGIC;           -- Datos a cargar
          CAPTUR : out STD_LOGIC;         -- Enable del reg. de desplaz.
          VALID : out STD_LOGIC);         -- Activación registro

end component;

component visualizacion
   Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);       -- Entrada MUX 0
          E1 : in STD_LOGIC_VECTOR (3 downto 0);       -- Entrada MUX 1
          E2 : in STD_LOGIC_VECTOR (3 downto 0);       -- Entrada MUX 2
          E3 : in STD_LOGIC_VECTOR (3 downto 0);       -- Entrada MUX 3
          CLK : in STD_LOGIC;                          -- Entrada de reloj FPGA
          SEG7 : out STD_LOGIC_VECTOR (6 downto 0);    -- Salida para los displays
          AN : out STD_LOGIC_VECTOR (3 downto 0));     -- Activación individual

end component;

begin

U1 : gen_reloj  -- Generador de reloj
       port map (
		   CLK => CLK,
			CLK_M => CLK_OUT
			);
			
U2 : reg_desp40  -- Registro de desplazamiento de 40 bits
       port map (
		   SIN => SIN,
			CLK => CLK_OUT,
			Q => NQ0
			);
			
U3 : sumador40  -- Integrador (sumador)
       port map (
         ENT => NQ0,
         SAL => NQ1
         );			
			
U4 : comparador -- Comparador 1
       port map (
		   P => NQ1,
			Q => UMBRAL1,
			PGTQ => PGTQ1,
			PLEQ => PLEQ1
			);
			
U5 : comparador -- Comparador 2
       port map (
		   P => NQ1,
			Q => UMBRAL2,
			PGTQ => PGTQ2,
			PLEQ => PLEQ2
			);
			
U6 : AND_2 -- Puerta AND
       port map (
		   A => PGTQ1,
			B => PLEQ2,
			S => NQ2
			);
			
U7 : automata -- Automata de MOORE
       port map (
		   CLK => CLK_OUT,
			C0 => NQ2,
			C1 => PLEQ1,
			DATO => NQ3,
			CAPTUR => NQ4,
			VALID => NQ5
			);
			
U8 : reg_desp  -- Registro de desplazamiento
       port map (
		   SIN => NQ3,
		   CLK => CLK_OUT,
		   EN => NQ4,
		   Q => NQ6
		   );
		 
U9 : registro  -- Registro de validación
       port map (
		   ENTRADA => NQ6,
			SALIDA => NQ7,
			EN => NQ5,
			RCLK => CLK_OUT
			);
			
U10 : visualizacion   -- Módulo de visualización
       port map (
		   E3(0) => NQ7(11),
			E3(1) => NQ7(12),
			E3(2) => NQ7(13),
			E3(3) => '0',
			E2 => NQ7 (10 downto 7),
			E1(0) => NQ7(4),
			E1(1) => NQ7(5),
			E1(2) => NQ7(6),
			E1(3) => '0',
			E0 => NQ7 (3 downto 0),
			CLK => CLK,
			SEG7 => SEG7,
			AN => AN
			);
			

end a_principal;