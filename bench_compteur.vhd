library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.all;

ENTITY bench_compteur IS
END bench_compteur;

ARCHITECTURE bench OF bench_compteur IS

COMPONENT compteur
port (reset : in Std_Logic;
      clk   : in Std_Logic;
      up : in Std_Logic;
     output : out Std_Logic_vector(3 downto 0 )
      ) ;
end COMPONENT;

 signal resets,clks, ups : std_logic :='0';
 signal outputs: Std_Logic_vector(3 downto 0 );

begin

 cpt : compteur port map (resets,clks,ups, outputs);


compteur_sim : process
	begin
			resets <='0';
		    clks <='0';
		    ups <='0';
			
			WAIT FOR 10 ns;
			resets <='1';
		    clks <='0';
		    ups <='1';
		
			WAIT FOR 10 ns;
		    clks <='1';
		
		for i in 0 to 5 loop
			WAIT FOR 10 ns;
		    clks <='0';
			
			WAIT FOR 10 ns;
		    clks <='1';
		 end loop;
			
		   WAIT FOR 10 ns;
			resets <='0';
			clks <='0';
			ups <='0';
			
			WAIT FOR 5 ns;
			resets <='1';
			clks <='0';
			
			WAIT FOR 5 ns;
			resets <='1';
			clks <='1';
			
		for i in 0 to 3 loop
			WAIT FOR 10 ns;
		    clks <='0';
			
			WAIT FOR 10 ns;
		    clks <='1';
		 end loop;
		 	
	wait;
end process compteur_sim;

end bench;

configuration compteur_cfg of bench_compteur is

	for bench
		for cpt :compteur
			use entity work.compteur(comportementale);
		end for;
	end for;

end compteur_cfg;





library IEEE;

entity composent is
   port ( a : in bit;
         b : in bit;
         c : in bit;
	      x, y : out bit);
   end composent;

architecture comportementale of composent is
begin
   process(a,b,c)
    variable s : bit;
       begin
         if (a='1' and b='0') then x <= '0';
            else x <= '1';
         end if;
         s := a xor b;
         y <= s and c;
   end process;
end comportementale;library IEEE;
library work;
use work.all;

ENTITY bench_composent IS
END bench_composent;

ARCHITECTURE bench OF bench_composent IS

component composent
   port ( a : in bit;
         b : in bit;
         c : in bit;
	      x, y : out bit);
   end component;

 signal as, bs, cs, xs, ys : bit :='0';

begin

 c1 : composent port map (as, bs, cs, xs, ys);

process
	begin
			as <='0';
		   bs <='0';
		   cs <='0';
			WAIT FOR 10 ns;
			
			as <='0';
		   bs <='1';
		   cs <='0';
			WAIT FOR 10 ns;
			
			as <='1';
		   bs <='1';
		   cs <='0';
			WAIT FOR 10 ns;
			
			as <='1';
		   bs <='1';
		   cs <='1';
			WAIT FOR 10 ns;
			
	wait;
end process;

end bench;

configuration composent_cfg of bench_composent is

	for bench
		for c1 :composent
			use entity work.composent(comportementale);
		end for;
	end for;

end composent_cfg;





library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

entity C2 is
 port( A : in signed(7 downto 0);
	B 	: in signed(7 downto 0);
	Cd : in Std_Logic;	-- Signal de commande du tri-state
	Clk : in Std_Logic;	-- Signal d'horloge
	S	: out signed(15 downto 0)) ;
end C2;

architecture comportementale of C2 is
signal T0 : signed(7 downto 0);
	signal T1 : signed(7 downto 0);
	signal T3 : signed(15 downto 0);
	signal T4 : signed(15 downto 0);
	signal T5 : signed(15 downto 0);
begin
	sequentiel : process (clk)
	begin
		if clk'event and clk='1' then
			T0 <= A;
			T1 <= B;
			T3 <= T0 * T1;	-- Multiplication signée
			T4 <= T5;
		end if;
	end process sequentiel;
	
	T5 <= T3 + T4;	-- Addition signée
	
	combinatoire : process(Cd,T5)
	begin
			if Cd = '0' then
				S <= T5;
			else
				S <= (others=>'Z');
			end if;
	end process combinatoire;
end comportementale;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;
library work;
use work.all;

ENTITY bench_C2 IS
END bench_C2;

ARCHITECTURE bench OF bench_C2 IS

component C2
   port( A : in signed(7 downto 0);
	B 	: in signed(7 downto 0);
	Cd : in Std_Logic;	-- Signal de commande du tri-state
	Clk : in Std_Logic;	-- Signal d'horloge
	S	: out signed(15 downto 0)) ;
   end component;

 signal As, Bs : signed(7 downto 0);
 signal Cds, Clks : std_logic;
 signal Ss : signed(15 downto 0);

begin

 cC2 : C2 port map (As, Bs, Cds, Clks, Ss);

process
	begin
			As <= (others =>'0');
		   Bs <= (others =>'0');
		   Cds <='1';
		   Clks <= '0';
			WAIT FOR 10 ns;
			
			-- A vous de completer
			
			
			WAIT FOR 10 ns;
			As <= "00000011";
		   Bs <= "00000001";
		   Clks <= '1';
			WAIT FOR 10 ns;
			Clks <= '0';
			Cds <='0';
			WAIT FOR 10 ns;
			As <= "00000010";
			Bs <= "00000001";
		   Clks <= '1';
			WAIT FOR 10 ns;
			Clks <= '0';
			Cds <='0';
			WAIT FOR 10 ns;
			As <= "00000000";
			Bs <= "00000001";
		   Clks <= '1';
		   WAIT FOR 10 ns;
			Clks <= '0';
			Cds <='0';
			WAIT FOR 10 ns;
			As <= "00000011";
			Bs <= "00000001";
		   Clks <= '1';
			WAIT FOR 10 ns;
	wait;
end process;

end bench;

configuration C2_cfg of bench_C2 is

	for bench
		for cC2 :C2
			use entity work.C2(comportementale);
		end for;
	end for;

end C2_cfg;