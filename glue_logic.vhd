----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    glue_logic - behavioral
-- Project Name:   motoroproject)
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:    The following table describes this block:
--
-- in1 	in0		led_timer	led_distance	led_velocity
-- 0	0		1			0				0
-- 0	1		0			1				0
-- 1	0		0			0				1
-- 1	1		0			0				0 
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;

entity glue_logic is
	port(
		in0          : in  bit;
		in1          : in  bit;
		led_time     : out bit;
		led_distance : out bit;
		led_velocity : out bit
	);
end entity glue_logic;

architecture behavioral of glue_logic is

begin
    led_time <= (not in1) and (not in0);
    led_distance <= (not in1) and in0;
    led_velocity <= in1 and (not in0);
end architecture behavioral;

