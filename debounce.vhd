----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    debounce - behavioral 
-- Project Name:   motoroproject
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:      
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;

entity debounce is
	Port(clk   : in  bit;
	     reset : in  bit;
	     inp   : in  bit;
	     oup   : out bit);
end debounce;

architecture behavioral of debounce is

begin

end behavioral;

