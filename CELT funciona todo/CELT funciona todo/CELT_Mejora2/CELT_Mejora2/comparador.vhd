library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparador is
    Port ( P : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada P
           Q : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada Q
           PGTQ : out STD_LOGIC; -- Salida P>Q
           PLEQ : out STD_LOGIC); -- Salida P<=Q
end comparador;

architecture a_comparador of comparador is

begin

PGTQ<= '1' when (P>Q)else '0';     -- Condición P>Q
PLEQ<= '1' when (P<=Q)else '0';    -- Condición P<=Q

end a_comparador;