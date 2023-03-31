----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    switchdisplay - behavioral
-- Project Name:   motoroproject
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:    
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity switchdisplay is
    port(
        clk    : in  bit;
        reset  : in  bit;
        button : in  bit;
        sel    : out bit_vector(1 downto 0)
    );
end entity switchdisplay;

architecture behavioral of switchdisplay is

begin

end architecture behavioral;
