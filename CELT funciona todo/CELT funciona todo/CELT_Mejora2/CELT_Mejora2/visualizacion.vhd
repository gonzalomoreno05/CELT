library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity visualizacion is
    Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 0.
           E1 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 1.
           E2 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 2.
           E3 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 3.
			  E4 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 4.
           E5 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 5.
           E6 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 6.
           E7 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 7.
			  PULSADOR : in STD_LOGIC;                        -- Entrada pulsador que activa el cambio Hora/Fecha
           CLK : in STD_LOGIC;                             -- Entrada de reloj.
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0);       -- Salida para los displays.
           AN : out STD_LOGIC_VECTOR (3 downto 0));        -- Activación individual.
end visualizacion;

architecture a_visualizacion of visualizacion is

signal N_Y  : STD_LOGIC_VECTOR (3 downto 0);    -- Señal de salida del multiplexor y entrada en el decodificador.
signal N_S  : STD_LOGIC_VECTOR (1 downto 0);    -- Señal de control.

component MUX8x8
    Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 0.
           E1 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 1.
           E2 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 2.
           E3 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 3.
			  E4 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 4.
           E5 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 5.
           E6 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 6.
           E7 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 7.
			  PULSADOR : in STD_LOGIC;                        -- Entrada pulsador que activa el cambio Hora/Fecha
           S  : in STD_LOGIC_VECTOR (1 downto 0);          -- Señal de control.
           Y  : out STD_LOGIC_VECTOR (3 downto 0));        -- Salida.
end component;

component decod7s
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);      -- Entrada BCD.
           S : out STD_LOGIC_VECTOR (6 downto 0));    -- Salida para excitar los displays.
end component;

component refresco
    Port ( CLK : in STD_LOGIC;                         -- Reloj.
           S   : out STD_LOGIC_VECTOR (1 downto 0);    -- Control para el mux.
           AN  : out STD_LOGIC_VECTOR (3 downto 0));   -- Control displays individuales.
end component;

begin

U1 : decod7s
       port map (
                 D=>N_Y,
                 S=>SEG7
                 );

U2 : MUX8x8
       port map (
                 E0=>E0,
                 E1=>E1,
                 E2=>E2,
                 E3=>E3,
					  E4=>E4,
                 E5=>E5,
                 E6=>E6,
                 E7=>E7,
					  PULSADOR=>PULSADOR,
                 Y=>N_Y,
                 S=>N_S
                 );
					  
					  
U3 : refresco
       port map (
                 CLK=>CLK,
                 AN=>AN,
                 S=>N_S
                 ); 

end a_visualizacion;