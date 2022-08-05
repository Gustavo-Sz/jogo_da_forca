-- Palavra : 711650
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 
entity forca is
    Port ( 
        
        CLOCK : in std_logic;
		  SW      : in std_logic_vector(3 downto 0);
        nd1,nd2,nd3,nd4,nd5,w,l: out std_logic;
		  vida: out std_logic_vector(2 downto 0)
        
    );
			
end forca;

architecture Behavioral of forca is

	signal chute    : std_logic_vector (2 downto 0) := (others => '0'); -- receber o chute
    --signal ult_cht  : std_logic_vector (2 downto 0) := (others => '1'); -- guardar último chute
    signal vi       : std_logic_vector (0 to 2) := (others => '1');   -- vida
    signal ac       : std_logic_vector (0 to 2) := (others => '0');    -- contagem de acertos
    signal d1_c,d2_c,d3_c,d4_c,d5_c,d6_c: std_logic := '0';
    signal win,lose : std_logic                     := '0';
    signal n0,n1,n2,n3,n4,n5,n6,n7: std_logic       := '0';
	 --signal w,l	: std_logic;

    -- Definição da palavra --
    constant d1 : std_logic_vector(2 downto 0)  := "000"; -- Letra 0 da palavra
    constant d2 : std_logic_vector(2 downto 0)  := "001"; -- Letra 1 da palavra
    constant d3 : std_logic_vector(2 downto 0)  := "101"; -- Letra 5 da palavra
    constant d4 : std_logic_vector(2 downto 0)  := "110"; -- Letra 6 da palavra
    constant d5 : std_logic_vector(2 downto 0)  := "111"; -- Letra 7 da palavra
    signal run: std_logic:='0';
   
    begin
        
        chute <= SW(2 downto 0);
        --run <= CLOCK(0) and CLOCK(1);
        iter: process(SW) -- SW(3)                    
        begin
            --if (CLOCK'event and CLOCK='1') then
                if (vi/="000" and ac/="101" and SW(3)='1') then
                    case chute is
                        when d1 => -- 0
                            if n0/='0' then
                                n0 <= '1';
                                d1_c <= '1';
                                ac <= std_logic_vector(unsigned(ac) + 1);
                            end if;
                        when d2 => -- 1
                            if n1/='0' then
                                n1 <= '1';
                                d2_c <= '1';
                                d3_c <= '1';
                                ac <= std_logic_vector(unsigned(ac) + 1);
                            end if;
                        when d3 => -- 5
                            if n5/='0' then
                                n5 <= '1';
                                d4_c <= '1';
                                ac <= std_logic_vector(unsigned(ac) + 1);
                            end if;
                        when d4 => -- 6
                            if n6/='0' then
                                n6 <= '1';
                                d5_c <= '1';
                                    ac <= std_logic_vector(unsigned(ac) + 1);
                            end if;
                        when d5 => -- 7
                            if n7/='0' then
                                n7 <= '1';
                                d6_c <= '1';
                                ac <= std_logic_vector(unsigned(ac) + 1);
                            end if;
                        when "010" => -- 2 ERRADO
                            if n2/='0' then
                                n2 <= '1';
                                vi <= std_logic_vector(unsigned(vi) - 1);
                            end if;
                        when "011" => -- 3 ERRADO
                            if n3/='0' then
                                n3 <= '1';
                               vi <= std_logic_vector(unsigned(vi) - 1);
                            end if;
                        when "100" => -- 4 ERRADO
                            if n4/='0' then
                                n4 <= '1';
                                vi <= std_logic_vector(unsigned(vi) - 1);
                            end if;
								when others => null;
									
                    end case;
                elsif(vi="000") then
                    d1_c <= '0';
                    d2_c <= '0';
                    d3_c <= '0';
                    d4_c <= '0';
                    d5_c <= '0';
                    d6_c <= '0';
						  win<='0';
						  lose<='1';
                    vi <= "011";
                    ac <= "000";
                elsif (ac="101") then
                    d1_c <= '1';
                    d2_c <= '1';
                    d3_c <= '1';
                    d4_c <= '1';
                    d5_c <= '1';
                    d6_c <= '1';
                    win<='1';
						  lose<='0';
                    vi <= "011";
                    ac <= "000";
                end if;
           -- end if;
        end process;

    nd1 <= d1_c; -- 0
    nd2 <= d2_c; -- 1
    nd3 <= d3_c; -- 5
    nd4 <= d4_c; -- 6
    nd5 <= d5_c; -- 7
		w <= win;
		l <= lose;
		vida <= vi;
end Behavioral;

