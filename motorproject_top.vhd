----------------------------------------------------------------------------------
-- Company:        HSR 
-- Author:         ?
--
-- Create Date:    ?
-- Module Name:    motorproject_top
-- Project Name:   motorproject
-- Target Devices: Zedboard
-- Tool Versions:  Xilinx Vivado 2019.2 / Sigasi 4.6.0
-- Description:    Dieser Block beschreibt die hierarchische Schaltung des Tops.
-- Die Led Ausgabe für led_time, led_distance und led_velocity werden
-- rein kombinatorisch aus dem int_sel Signal erzeugt.   
--
-- Revision: 
-- Revision        01 - File Created
----------------------------------------------------------------------------------
library ieee;

-- Hier sind die Ein- und Ausgänge des motorproject_top definiert:
entity motorproject_top is
	port(
		clk          : in  bit;
		reset        : in  bit;
		lb0          : in  bit;
		lb1          : in  bit;
		bt_select    : in  bit;
		led_left     : out bit;
		led_right    : out bit;
		led_pulse    : out bit;
		led_time     : out bit;
		led_distance : out bit;
		led_velocity : out bit;
		sseg         : out bit_vector(6 downto 0);
		sseg_an      : out bit_vector(2 downto 0)
	);
end motorproject_top;

architecture structural of motorproject_top is
	signal clkslow_int : bit;
	signal lb_int : bit_vector(1 downto 0);
	signal time_int : bit_vector(7 downto 0);
	signal distance_int : bit_vector(7 downto 0);
	signal velocity_int : bit_vector(7 downto 0);
	signal sel_int : bit_vector(1 downto 0);
	signal binary_int : bit_vector(7 downto 0);
	signal button_int : bit;

	component analysis
	    port(
	        clk       : in  bit;
	        reset     : in  bit;
	        lb        : in  bit_vector(1 downto 0);
	        dir_left  : out bit;
	        dir_right : out bit;
	        pulse     : out bit;
	        time      : out bit_vector(7 downto 0);
	        distance  : out bit_vector(7 downto 0);
	        velocity  : out bit_vector(7 downto 0)
	    );
	end component analysis;

    component debounce
        port(
            clk   : in  bit;
            reset : in  bit;
            inp   : in  bit;
            oup   : out bit
        );
    end component debounce;
   
   component clockdivider
       generic(ClkDivFaktor : integer := 100_000);
       port(
           clk     : in  bit;
           clkslow : out bit
       );
   end component clockdivider;
    
    component switchdisplay
        port(
            clk    : in  bit;
            reset  : in  bit;
            button : in  bit;
            sel    : out bit_vector(1 downto 0)
        );
    end component switchdisplay;
    
    component glue_logic
        port(
            in0          : in  bit;
            in1          : in  bit;
            led_time     : out bit;
            led_distance : out bit;
            led_velocity : out bit
        );
    end component glue_logic;
    
    component display
        port(
            clk     : in  bit;
            reset   : in  bit;
            inp     : in  bit_VECTOR (7 downto 0);
            sseg    : out bit_VECTOR (6 downto 0);
            sseg_an : out bit_VECTOR (2 downto 0)
        );
    end component display;
    
    component mux3x8
        port(
            sel  : in  bit_vector(1 downto 0);
            inp0 : in  bit_vector(7 downto 0);
            inp1 : in  bit_vector(7 downto 0);
            inp2 : in  bit_vector(7 downto 0);
            oup  : out bit_vector(7 downto 0)
        );
    end component mux3x8;

	
begin
    lb_int <= lb1 & lb0;
    
    analysis_1 : component analysis
        port map(
            clk       => clkslow_int,
            reset     => reset,
            lb        => lb_int,
            dir_left  => led_left,
            dir_right => led_right,
            pulse     => led_pulse,
            time      => time_int,
            distance  => distance_int,
            velocity  => velocity_int
        );
    
    debounce_1 : component debounce
        port map(
            clk   => clkslow_int,
            reset => reset,
            inp   => bt_select,
            oup   => button_int
        );
        
    clockdivider_1 : component clockdivider
        generic map(
            ClkDivFaktor => 100000
        )
        port map(
            clk     => clk,
            clkslow => clkslow_int
        );
    
    switchdisplay_1 : component switchdisplay
        port map(
            clk    => clkslow_int,
            reset  => reset,
            button => button_int,
            sel    => sel_int
        );
        
    mux3x8_1 : component mux3x8
        port map(
            sel  => sel_int,
            inp0 => time_int,
            inp1 => distance_int,
            inp2 => velocity_int,
            oup  => binary_int
        );
    
    display_1 : component display
        port map(
            clk     => clkslow_int,
            reset   => reset,
            inp     => binary_int,
            sseg    => sseg,
            sseg_an => sseg_an
        );
    
    glue_logic_1 : component glue_logic
        port map(
            in0          => sel_int(0),
            in1          => sel_int(1),
            led_time     => led_time,
            led_distance => led_distance,
            led_velocity => led_velocity
        );
end architecture structural;