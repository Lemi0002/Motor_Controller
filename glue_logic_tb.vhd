----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         Roman Willi
--
-- Create Date:    17.12.2018; 14:32:54
-- Module Name:    glue_logic_tb
-- Project Name:   motoroproject (P4)
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:    Testbench for glue_logic
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;

entity glue_logic_tb is
end;

architecture tb of glue_logic_tb is

	component glue_logic
		port(
			in0          : in  bit;
			in1          : in  bit;
			led_time     : out bit;
			led_distance : out bit;
			led_velocity : out bit
		);
	end component glue_logic;

	-- Mögliche Archidekturen der glue_logic:
	-- behavioral
	for all : glue_logic use entity work.glue_logic(behavioral);

	constant SIM_CYC : time := 100 ns;

	signal tb_in0, tb_in1  : bit;
	signal tb_led_time     : bit;
	signal tb_led_distance : bit;
	signal tb_led_velocity : bit;

begin

	dut : component glue_logic
		port map(
			in0          => tb_in0,
			in1          => tb_in1,
			led_time     => tb_led_time,
			led_distance => tb_led_distance,
			led_velocity => tb_led_velocity
		);

	a_b_stimuli : process
	begin
		tb_in0 <= '0';
		tb_in1 <= '0';
		wait for SIM_CYC;
		tb_in0 <= '1';
		tb_in1 <= '0';
		wait for SIM_CYC;
		tb_in0 <= '0';
		tb_in1 <= '1';
		wait for SIM_CYC;
		tb_in0 <= '1';
		tb_in1 <= '1';
		wait for SIM_CYC;
		tb_in0 <= '0';
		tb_in1 <= '0';
		wait;
	end process;

	led_time_assert : process
	begin
		wait for (SIM_CYC - 1 ns);
		assert (tb_led_time = '1') report "led_time error at input 00" severity error;
		wait for SIM_CYC;
		assert (tb_led_time = '0') report "led_time error at input 01" severity error;
		wait for SIM_CYC;
		assert (tb_led_time = '0') report "led_time error at input 10" severity error;
		wait for SIM_CYC;
		assert (tb_led_time = '0') report "led_time error at input 11" severity error;
		wait for SIM_CYC;
		assert (tb_led_time = '1') report "led_time error at input 00" severity error;
		wait;
	end process;

	led_distance_assert : process
	begin
		wait for (SIM_CYC - 1 ns);
		assert (tb_led_distance = '0') report "led_distance error at input 00" severity error;
		wait for SIM_CYC;
		assert (tb_led_distance = '1') report "led_distance error at input 01" severity error;
		wait for SIM_CYC;
		assert (tb_led_distance = '0') report "led_distance error at input 10" severity error;
		wait for SIM_CYC;
		assert (tb_led_distance = '0') report "led_distance error at input 11" severity error;
		wait for SIM_CYC;
		assert (tb_led_distance = '0') report "led_distance error at input 00" severity error;
		wait;
	end process;

	led_velocity_assert : process
	begin
		wait for (SIM_CYC - 1 ns);
		assert (tb_led_velocity = '0') report "led_velocity error at input 00" severity error;
		wait for SIM_CYC;
		assert (tb_led_velocity = '0') report "led_velocity error at input 01" severity error;
		wait for SIM_CYC;
		assert (tb_led_velocity = '1') report "led_velocity error at input 10" severity error;
		wait for SIM_CYC;
		assert (tb_led_velocity = '0') report "led_velocity error at input 11" severity error;
		wait for SIM_CYC;
		assert (tb_led_velocity = '0') report "led_velocity error at input 00" severity error;
		wait;
	end process;
end tb;

