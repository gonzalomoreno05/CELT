library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX8x8 is
     Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 0.
            E1 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 1.
            E2 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 2.
            E3 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 3.
				E4 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 4.
            E5 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 5.
            E6 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 6.
            E7 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 7.
			   PULSADOR : in STD_LOGIC;                        -- Entrada pulsador.
            Y : out STD_LOGIC_VECTOR (3 downto 0);          -- Salida Y
            S : in STD_LOGIC_VECTOR (1 downto 0));          -- Entradas de control

end MUX8x8;

architecture a_MUX8x8 of MUX8x8 is

signal control : STD_LOGIC_VECTOR(2 downto 0); 

begin

control <= S & PULSADOR;  -- Hemos concatenado la entrada de control con el pulsador

Y <= E0 when control="001" else -- se selecciona la salida en función de las entradas
     E1 when control="011" else -- de control, las 4 primeras corresponden a las entradas 
     E2 when control="101" else -- con el pulsador no activo (HORA), las 4 ultimas con 
     E3 when control="111" else -- el pulsador activo (FECHA)
	  E4 when control="000" else 
     E5 when control="010" else 
     E6 when control="100" else
     E7 when control="110";
	  
end a_MUX8x8;

