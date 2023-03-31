##---------------------------------------------------------------------------------
## Company:        HSR
## Author:         Roman Willi
##
## Create Date:    17.12.2018; 14:32:54
## Module Name:    glue_logic.xdc
## Project Name:   P4
## Target Devices: Zedboard
## Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
## Description:    XDC configuration file for glue_logic
##
## Revision:
## Revision        01 - File Created
##---------------------------------------------------------------------------------
## INPUTS
set_property PACKAGE_PIN F22 [get_ports {in0}]
set_property IOSTANDARD LVCMOS33 [get_ports {in0}]
set_property PACKAGE_PIN G22 [get_ports {in1}]
set_property IOSTANDARD LVCMOS33 [get_ports {in1}]

## OUTPUTS
set_property PACKAGE_PIN T22 [get_ports {led_time}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_time}]
set_property PACKAGE_PIN T21 [get_ports {led_distance}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_distance}]
set_property PACKAGE_PIN U22 [get_ports {led_velocity}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_velocity}]

## VOLTAGE Settings
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

## Create virtual clocks
## where input_delay_value + maximum feedthrough path delay + output_delay_value = virtclk period

create_clock -period 100.000 -name virtclk

## Set input and output delay
set_input_delay -clock [get_clocks virtclk] -max 30.000 [get_ports in0]
set_input_delay -clock [get_clocks virtclk] -max 30.000 [get_ports in1]
set_output_delay -clock [get_clocks virtclk] -max 30.000 [get_ports led_time]
set_output_delay -clock [get_clocks virtclk] -max 30.000 [get_ports led_distance]
set_output_delay -clock [get_clocks virtclk] -max 30.000 [get_ports led_velocity]