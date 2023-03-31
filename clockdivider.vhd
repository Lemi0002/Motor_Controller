----------------------------------------------------------------------------------
-- Company:        OST 
-- Author:         Marius Baumann
--
-- Create Date:    25.01.2023 10:40
-- Module Name:    clockdivider - behavioral
-- Project Name:   motoroproject (P9)
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2021.1 / Sigasi  4.17.1
-- Description:    Wenn clk 100MHz ist, generiert dieser Block eine Flanke wenn  
--                 der interne Zähler den Wert ClkDivFaktor erreicht hat. 
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.vcomponents.all;

entity clockdivider is
    generic(
        ClkDivFaktor : integer := 100_000
    );
    port(
        clk     : in  bit;
        clkslow : out bit
    );
end clockdivider;

architecture behavioral of clockdivider is
    signal p_cnt, n_cnt : integer range 0 to ClkDivFaktor - 1 := 0;

    signal clkslow_stdlogic : std_logic;
    signal clk_en           : std_logic;
    signal clk_stdlogic     : std_logic;
begin
    output_logic : clkslow <= to_bit(clkslow_stdlogic);
    clk_stdlogic           <= std_logic(to_stdulogic(clk));

    -- generate 1kHz clock from 1Mhz clk with clock enable        
    BUFGCTRL_inst : BUFGCTRL
       generic map ( -- @suppress "Generic map uses default values. Missing optional actuals: CE_TYPE_CE0, CE_TYPE_CE1, IS_CE0_INVERTED, IS_CE1_INVERTED, IS_I0_INVERTED, IS_I1_INVERTED, IS_IGNORE0_INVERTED, IS_IGNORE1_INVERTED, IS_S0_INVERTED, IS_S1_INVERTED, STARTUP_SYNC"
          INIT_OUT => 0,         -- Initial value of BUFGCTRL output ($VALUES;)
          PRESELECT_I0 => TRUE, -- BUFGCTRL output uses I0 input ($VALUES;)
          PRESELECT_I1 => FALSE, -- BUFGCTRL output uses I1 input ($VALUES;)
          SIM_DEVICE => "7SERIES"
       )
       port map (
          O => clkslow_stdlogic,             -- 1-bit output: Clock output
          CE0 => clk_en,         -- 1-bit input: Clock enable input for I0
          CE1 => '0',         -- 1-bit input: Clock enable input for I1
          I0 => clk_stdlogic,           -- 1-bit input: Primary clock
          I1 => '1',           -- 1-bit input: Secondary clock
          IGNORE0 => '0', -- 1-bit input: Clock ignore input for I0
          IGNORE1 => '1', -- 1-bit input: Clock ignore input for I1
          S0 => '1',           -- 1-bit input: Clock select for I0
          S1 => '0'            -- 1-bit input: Clock select for I1
       );
        

    internal_signal : clk_en <= '1' when (p_cnt = 0) else '0';

    next_state_logic : n_cnt <= 0 when (p_cnt = ClkDivFaktor - 1) else p_cnt + 1;

    state_registers : process(clk)
    begin
        if clk'event and clk = '1' then
            p_cnt <= n_cnt;
        end if;
    end process;

end behavioral;
