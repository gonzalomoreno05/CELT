library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_2 is
    Port ( A : in STD_LOGIC;      -- Entrada A
           B : in STD_LOGIC;      -- Entrada B
           S : out STD_LOGIC);    -- Salida
end AND_2;

architecture a_AND_2 of AND_2 is

begin
  process(A,B)
    begin
	   if A='1' and B='1' then     -- Si ambas entradas son '1' devuelve '1' a la salida, en el resto de casos devuelve '0'
		   S<='1';
		else
		   S<='0';
		end if;
  end process;	

end a_AND_2;