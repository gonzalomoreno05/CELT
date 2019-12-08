library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity reg_desp40 is
    Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
           CLK : in STD_LOGIC; -- Reloj de muestreo
           Q   : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
end reg_desp40;


architecture a_reg_desp40 of reg_desp40 is

signal QS : STD_LOGIC_VECTOR (39 downto 0) := "0000000000000000000000000000000000000000"; --señal que almacena el valor de Q
                                                                                          --declaramos todos los bits a 0 para evitar señales indefinidas

begin
  process (CLK)
    begin
     if (CLK' event and CLK='1') then -- con cada flanco activo se desplazan todas las salidas
  	     QS(0)<=SIN;
		  for i in 0 to 38 loop
		    QS(39-i)<=QS(39-(i+1));
		  end loop;
		 end if;
  end process;

Q<=QS;  

end a_reg_desp40;