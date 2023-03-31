----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    mux3x8 - conditional 
-- Project Name:   motoroproject
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:    
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity mux3x8 is
port(
        sel  : in  bit_vector(1 downto 0);
        inp0 : in  bit_vector(7 downto 0);
        inp1 : in  bit_vector(7 downto 0);
        inp2 : in  bit_vector(7 downto 0);
        oup  : out bit_vector(7 downto 0)
    );
end mux3x8;

architecture conditional of mux3x8 is
begin
    oup <= inp0 when sel = "00" else
        inp1 when sel = "01" else
        inp2 when sel = "10" else
        inp2;
end architecture conditional;

architecture selective of mux3x8 is
begin
    with sel select oup <=
        inp0 when "00",
        inp1 when "01",
        inp2 when "10",
        inp2 when others;
end architecture selective;

architecture process_case of mux3x8 is
begin
    p1 : process(sel, inp0, inp1, inp2)
    begin
        case sel is
            when "00" => oup <= inp0;
            when "01" => oup <= inp1;
            when "10" => oup <= inp2;
            when others => oup <= inp2;
        end case;
    end process;
end architecture process_case;

architecture process_if of mux3x8 is
begin
    p1 : process(sel, inp0, inp1, inp2)
    begin
        if (sel = "00") then
            oup <= inp0;
        elsif (sel = "01") then
            oup <= inp1;
        elsif (sel = "10") then
            oup <= inp2;
        else
            oup <= inp2;
        end if;
    end process;
end architecture process_if;
