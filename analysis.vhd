----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    analysis - behavioral
-- Project Name:   motoroproject
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:      
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;

entity analysis is
	Port(
		clk       : in  bit;
		reset     : in  bit;
		lb        : in  bit_vector(1 downto 0);
		dir_left  : out bit;
		dir_right : out bit;
		pulse     : out bit;
		time      : out bit_vector(7 downto 0);
		distance  : out bit_vector(7 downto 0);
		velocity  : out bit_vector(7 downto 0));
end analysis;

architecture behavioral of analysis is

begin

end behavioral;

