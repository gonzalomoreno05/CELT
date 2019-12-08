library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity refresco is
      Port ( CLK : in STD_LOGIC; -- entrada de reloj
             AN : out STD_LOGIC_VECTOR (3 downto 0); -- activación displays
             S : out STD_LOGIC_VECTOR (1 downto 0)); -- selección en el MUX
end refresco;

architecture a_refresco of refresco is

signal SS : STD_LOGIC_VECTOR (1 downto 0);
signal CLK_V : STD_LOGIC;
signal cont_V : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- contador 1
signal S_V : STD_LOGIC :='0';

begin
 
 process (CLK)
     begin
	  
	  if CLK'event and CLK='1' then
     cont_V <= cont_V + 1;

     if cont_V >= 25000 then -- división de frecuencia a 1KHz
     S_V <=not S_V;
     cont_V <=(others=>'0');
	  SS<=SS+1; -- genera la secuencia 00,01,10 y 11
     end if;
	  end if;
	  
     	  
 end process;
 
S<=SS;
AN<= "0111" when SS="00" else -- activa cada display en function del valor de SS
     "1011" when SS="01" else
     "1101" when SS="10" else
     "1110" when SS="11";

end a_refresco;

