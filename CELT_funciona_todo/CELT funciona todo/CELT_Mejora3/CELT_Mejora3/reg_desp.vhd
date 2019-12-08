library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_desp is
    Port ( SIN : in STD_LOGIC;                         -- Datos de entrada serie
           CLK : in STD_LOGIC;                         -- Reloj
           EN : in STD_LOGIC;                          -- Se�al ENABLE activa a nivel alto
           Q : out STD_LOGIC_VECTOR (30 downto 0));    -- Salida paralelo
end reg_desp;

architecture a_reg_desp of reg_desp is

signal QS : STD_LOGIC_VECTOR (30 downto 0) := "0000000000000000000000000000000";    -- Se�al que almacena el valor de Q
                                                                   -- Declaramos todos los bits a 0 para evitar se�ales indefinidas
-- Aumentamos la captura a 31 bits para la Mejora 3
begin
  process (CLK,EN)
    begin
     if (CLK' event and CLK='1') and EN='1' then               -- Con cada flanco activo se desplazan todas las salidas
  	     QS(0)<=SIN;
		  for i in 0 to 29 loop
		    QS(30-i)<=QS(30-(i+1));
		  end loop;
		 end if;
  end process;
Q<=QS;

end a_reg_desp;