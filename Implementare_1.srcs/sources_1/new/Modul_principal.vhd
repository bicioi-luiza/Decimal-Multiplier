----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 10:09:03 PM
-- Design Name: 
-- Module Name: Modul_principal - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.myPackage.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Modul_principal is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    StepStart: IN std_logic;
    sw: IN std_logic_vector(15 downto 0);
    An: out STD_LOGIC_VECTOR(7 downto 0);
    Seg: out STD_LOGIC_VECTOR(7 downto 0);
    led: out STD_LOGIC_VECTOR(14 downto 0);
    Term: out STD_LOGIC );
end Modul_principal;

architecture Behavioral of Modul_principal is
--delcarare numerele pe care le vom insera
signal X, Y: number_type(0 to 3);
--declarare semnele ( + sau -) ale numerelor introuduse
signal signX, signY: std_logic;
--sw de tip array
signal sw_copie: number_type(0 to 3):= (sw(3 downto 0),
                                        sw(7 downto 4),
                                        sw(11 downto 8),
                                        others => sw(15 downto 12));
--semnal care iasa din debounceer , el ne va spune daca s-a apasat butonul
signal StepStartSignal: std_logic;
--stare data de outputul unitatii principale 
signal whichState: std_logic_vector(7 downto 0);
signal TermOp, Term1, Term2: std_logic;
--declarare metoda 
signal metoda: std_logic;
--enable uri
signal enableXReg, enableSignXReg, enableYReg, enableSignYReg, enableMetodaRegistru: std_logic;
--semnale suplimentare 
signal StartT1, StartT2: std_logic;
signal P, P1, P2: number_type(0 to 7);
signal sign, sign1, sign2 : std_logic;
signal Data: std_logic_vector(31 downto 0);
signal error, errorX, errorY: std_logic:='0';


begin
TermOp <= Term1 or Term2;
Term <= whichState(0);
sign <= sign1 or sign2;
--stabilire enable
enableXReg <= whichState(4) and StepStartSignal;
enableSignXReg <= whichState(5) and StepStartSignal;
enableYReg <= whichState(2) and StepStartSIgnal;
enableSignYReg <= whichState(3) and StepStartSignal;
enableMetodaRegistru <= whichState(6) and StepStartSignal;
--stabilire eroare , daca exista 
error <= errorX or errorY;

debouncer_buton: entity WORK.Debouncer port map (Clk => Clk, Rst => Rst, D_IN => StepStart, Q_OUT => StepStartSignal);
UC_P: entity WORK.UC_Principala port map (Clk => Clk, Rst => Rst, Step => StepStartSignal, Error => error, TermOp => TermOp, whichState => whichState);

RegistruX: entity WORK.bistabil_retine_numar generic map (n => 3) port map (Clk => Clk, Rst => Rst, CE => enableXReg , D => sw_copie, Q => X);
RegistruY: entity WORK.bistabil_retine_numar generic map (n => 3) port map (Clk => Clk, Rst => Rst, CE => enableYReg, D => sw_copie, Q => Y);

bistabilSemnX: entity WORK.bistabil_semn port map (Clk => Clk, Rst => Rst, CE => enableSignXReg , D =>sw(15), Q => signX );
bistabilSemnY: entity WORK.bistabil_semn port map (Clk => Clk, Rst => Rst, CE => enableSignYReg , D =>sw(15), Q => signY );

RegistruMetoda: entity WORK.bistabil_semn port map (Clk => Clk, Rst => Rst, CE => enableMetodaRegistru , D =>sw(15), Q => metoda );

Inmultire_1: entity WORK.Metoda1_inmultire port map (Clk => Clk, signX => signX, X => X, signY => signY, Y => Y, Rst => Rst, Start => StartT1, P => P1, sign => sign1, Term => Term1);
Inmultire_2: entity WORK.Metoda2_inmultire port map (Clk => Clk, signX => signX, X => X, signY => signY, Y => Y, Rst => Rst, Start => StartT2, P => P2, sign => sign2, Term => Term2);


proces_start: process(Clk)
begin
if(rising_edge(Clk)) then
    if(whichState(2) = '1') then
        if(StepStartSignal = '1') then
        case metoda is
            when '0' => StartT1 <= '1';
                         StartT2 <= '0';
            when others => StartT1 <= '0';
                         StartT2 <= '1';
        end case;
    end if;
    end if;
end if;
end process;

display: entity WORK.display7segments port map (Clk => Clk, Rst => Rst, Data => Data, An => An, Seg => Seg);
P <= P1 when metoda='0' else P2 when metoda='1' else (others => "0000");

proces_date_ssd: process(Clk)
begin
    if(error = '1') then
        Data <= x"EEEE0000";
    else
        if (whichState(0) = '1') then
            if(sw(0) = '0') then
                Data(31 downto 28) <= P(7);
                Data(27 downto 24) <= P(6);
                Data(23 downto 20) <= P(5);
                Data(19 downto 16) <= P(4);
                Data(15 downto 12) <= P(3);
                Data(11 downto 8) <= P(2);
                Data(7 downto 4) <= P(1);
                Data(3 downto 0) <= P(0);
                
            else
                --Data <= X & Y;
                Data(31 downto 28) <= X(3);
                Data(27 downto 24) <= X(2);
                Data(23 downto 20) <= X(1);
                Data(19 downto 16) <= X(0);
                Data(15 downto 12) <= Y(3);
                Data(11 downto 8) <= Y(2);
                Data(7 downto 4) <= Y(1);
                Data(3 downto 0) <= Y(0);
            end if;
        else
            case whichState is
                when "01000000" => Data <= "00" & sw(15 downto 14)  & x"0000000";
                when "00010000" => Data(31 downto 16) <= sw;
                                Data(15 downto 12) <= Y(3);
                                Data(11 downto 8) <= Y(2);
                                Data(7 downto 4) <= Y(1);
                                Data(3 downto 0) <= Y(0); 
                when "00000100" => Data(15 downto 0) <=  sw;
                                Data(31 downto 28) <= X(3);
                                Data(27 downto 24) <= X(2);
                                Data(23 downto 20) <= X(1);
                                Data(19 downto 16) <= X(0);
                when others => Data(31 downto 28) <= X(3);
                               Data(27 downto 24) <= X(2);
                               Data(23 downto 20) <= X(1);
                               Data(19 downto 16) <= X(0);
                               Data(15 downto 12) <= Y(3);
                               Data(11 downto 8) <= Y(2);
                               Data(7 downto 4) <= Y(1);
                               Data(3 downto 0) <= Y(0);
            end case;
        end if;
       end if;
end process;

errorX <= '1' when X(3)>"1001" or X(2)>"1001" or X(1)>"1001" or X(0)>"1001" else '0';
errorY <= '1' when Y(3)>"1001" or Y(2)>"1001" or Y(1)>"1001" or Y(0)>"1001" else '0';

led(6 downto 0) <= whichState(7 downto 1);
led(14) <= metoda;
led(13) <=sign;
led(10) <= signX;
led(9) <= signY;
led(8) <= errorX;
led(7) <= errorY;
end Behavioral;
