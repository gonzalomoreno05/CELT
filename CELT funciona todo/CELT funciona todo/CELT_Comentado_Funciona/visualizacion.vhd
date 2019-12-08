library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity visualizacion is
    Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 0.
           E1 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 1.
           E2 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 2.
           E3 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 3.
           CLK : in STD_LOGIC;                             -- Entrada de reloj.
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0);       -- Salida para los displays.
           AN : out STD_LOGIC_VECTOR (3 downto 0));        -- Activación individual.
end visualizacion;

architecture a_visualizacion of visualizacion is

signal N_Y  : STD_LOGIC_VECTOR (3 downto 0);    -- Señal de salida del multiplexor y entrada en el decodificador.
signal N_S  : STD_LOGIC_VECTOR (1 downto 0);    -- Señal de control.

component MUX4x4
    Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 0.
           E1 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 1.
           E2 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 2.
           E3 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada 3.
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

U2 : MUX4x4
       port map (
                 E0=>E0,
                 E1=>E1,
                 E2=>E2,
                 E3=>E3,
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