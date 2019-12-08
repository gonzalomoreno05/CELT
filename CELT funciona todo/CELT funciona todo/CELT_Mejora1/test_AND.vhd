--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:17:19 11/08/2017
-- Design Name:   
-- Module Name:   C:/Users/alumno/Desktop/CELT/test_AND.vhd
-- Project Name:  CELT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AND_2
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_AND IS
END test_AND;
 
ARCHITECTURE behavior OF test_AND IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AND_2
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         S : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';

 	--Outputs
   signal S : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AND_2 PORT MAP (
          A => A,
          B => B,
          S => S
        );


a<= '1' after 20 ns,'0' after 40 ns,'1' after 60 ns;
b<= '1' after 40 ns;


END;
