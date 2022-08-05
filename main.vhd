library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity main is
port(
    
    CLOCK_50    : in std_logic; ---clock do contador
    SW        : in std_logic_vector (3 downto 0); ----- switches da placa
	 LED         : out std_logic_vector (7 downto 0) := (others => '0') ------ leds 
    );
end main;


architecture hardware of main is
    signal clk: std_logic_vector(7 downto 0);
    signal nm1,nm2,nm3,nm4,nm5,w,l: std_logic;
    signal vida: std_logic_vector(2 downto 0);
    
    component counter_seconds is
        port(CLOCK_50: in std_logic; 
        counter_out: out std_logic_vector(7 downto 0) := "00000000"
    );
	end component;
    component forca is
        Port ( 
            --CLOCK   : in std_logic_vector (7 downto 0);
            CLOCK : in std_logic;
				SW      : in std_logic_vector(3 downto 0);
            nd1,nd2,nd3,nd4,nd5,w,l: out std_logic;
				vida: out std_logic_vector(2 downto 0)
         
        );
    end component;
	
    begin
        clk_map: counter_seconds port map(CLOCK_50, clk);
		  forca_map: forca port map(CLOCK_50,SW,nm1,nm2,nm3,nm4,nm5,w,l,vida);
        
		  LED(7) <= nm1;
		  LED(6) <= nm4;
		  LED(5) <= nm3;
		  LED(4) <= nm2;
		  LED(3) <= nm2;
		  LED(2) <= nm5;
		  LED(1) <= vida(0);
		  LED(0) <= vida(1);
		  
  end hardware;