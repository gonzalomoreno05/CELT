library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro is
    Port ( ENTRADA : in STD_LOGIC_VECTOR (14 downto 0);    -- Entradas 
           SALIDA : out STD_LOGIC_VECTOR (14 downto 0);    -- Salidas
           EN : in STD_LOGIC;                              -- Enable
           RCLK : in STD_LOGIC);                           -- Reloj
end registro;

-- Tanto la entrada como la salida tienen 15 bits ( 1 más que la señal original)

architecture a_registro of registro is
 
signal s1 : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";

begin
  process(RCLK,EN)
    begin
	   if (RCLK' event and RCLK='1') and EN='1' then  -- Con cada flanco activo se copia la entrada en la salida si EN = '1'
		  s1 <= ENTRADA;
		end if;
  end process;
  
SALIDA <= s1;  

end a_registro;