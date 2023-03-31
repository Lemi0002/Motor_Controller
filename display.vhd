----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    display - behavioral 
-- Project Name:   motoroproject
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:      
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;

entity display is
    Port ( clk : in bit;
           reset : in bit;
           inp : in bit_VECTOR (7 downto 0);
           sseg : out bit_VECTOR (6 downto 0);
           sseg_an : out bit_VECTOR (2 downto 0));
end display;

architecture behavioral of display is

begin


end behavioral;

