library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decod7s is
     Port ( D : in STD_LOGIC_VECTOR (3 downto 0);         -- Entrada de datos
            F : in STD_LOGIC_VECTOR (2 downto 0);         -- Entrada 2 de datos para el día de la semana
				LEDS : out STD_LOGIC_VECTOR (6 downto 0);     -- Salida de LEDS para marcar el día de la semana
				S : out STD_LOGIC_VECTOR (0 to 6));           -- salidas 7seg (abcdefg)
end decod7s;

architecture a_decod7s of decod7s is

begin

   with D select S <=
            "0000001" when "0000",
            "1001111" when "0001",
            "0010010" when "0010",
            "0000110" when "0011",
            "1001100" when "0100",
            "0100100" when "0101",
            "0100000" when "0110",
            "0001111" when "0111",
            "0000000" when "1000",
            "0001100" when "1001",
            "1111111" when others;
				
	with F select LEDS <= 
            "1000000" when "000",	
				"0100000" when "001",     -- Dependiendo de la combinación de bits en la entrada F se 
				"0010000" when "010",     -- selecciona un día de la semana
				"0001000" when "011",
				"0000100" when "100",
				"0000010" when "101",
				"0000001" when "110",
				"0000000" when others;
				

end a_decod7s; 

