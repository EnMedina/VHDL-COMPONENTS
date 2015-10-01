----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:23:00 10/01/2015 
-- Design Name: 
-- Module Name:    OneSecond - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OneSecond is
    Port ( CLK : 			  in  STD_LOGIC;	--Input from the Crystal
				testLed:		  out STD_LOGIC;	--Shows the second is working
           second : out STD_LOGIC); 		--This signal is used if you want your process to be checked every second
end OneSecond;

architecture Behavioral of OneSecond is
signal temp:				STD_LOGIC_VECTOR(25 downto 0) :="00000000000000000000000000";
signal ledCtrl		:		STD_LOGIC;
signal secondPassed:		STD_LOGIC;
constant limiteSec: 		STD_LOGIC_VECTOR(25 downto 0) :="10111110101111000010000000";--Number of cycles which will need to be run at 50MHz

begin
process(CLK)
	begin
		if(CLK'event and CLK='1')then
			if (temp=limiteSec)then
			   temp<=(others=>'0');
				secondPassed<='1';
			else
				temp<=temp+1;
				secondPassed<='0';
			end if;
		end if;	
end process;
process(secondPassed)
	begin
		if(secondPassed'event and secondPassed='1')then
			ledCtrl<=not ledCtrl;
		end if;
end process;
testLed<=ledCtrl;
second<=secondPassed;		
end Behavioral;

