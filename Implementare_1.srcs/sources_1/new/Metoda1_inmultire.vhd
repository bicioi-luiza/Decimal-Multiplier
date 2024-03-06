----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 04:00:14 AM
-- Design Name: 
-- Module Name: Metoda1_inmultire - Behavioral
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

entity Metoda1_inmultire is
Port (
    Clk: IN std_logic;
    signX: IN std_logic;
    X: number_type(0 to 3);
    signY: IN std_logic;
    Y: IN number_type(0 to 3);
    Rst: IN std_logic;
    Start: IN std_logic;
    sign: OUT std_logic;
    P: OUT number_type(0 to 7);
    Term: OUT std_logic);
end Metoda1_inmultire;

architecture Behavioral of Metoda1_inmultire is
--definire semnale UC
signal LoadB, RstA, RstB, RstQ, LoadA, shrAQ, LoadQ: std_logic;
--definire semnale necesare pentru restul portmapurilor
signal Bout: number_type(0 to 3):=(others=>"0000");

signal SumatorOut: number_type(0 to 4):=(others=>"0000");
signal SumatorTOut: std_logic;

signal AccOut:  number_type(0 to 4):=(others=>"0000"); 

signal D_in_accumulator:  number_type(0 to 4):=(others=>"0000");
signal firstOperand: number_type(0 to 4):=(others=>"0000");

signal Qout: number_type(0 to 3):=(others=>"0000");
signal A0,Q0,SRI_acc: std_logic_vector(3 downto 0);

begin

sign <= signX xor signY;
D_in_accumulator <= SumatorOut;
A0 <= AccOut(0);
Q0 <= Qout(0);
--firstOperand <= "0000" & Bout;
firstOperand <= Bout & "0000";
--definire UC : in fctie de starea in care ne aflam , decidem daca shiftam sau nu.
UC: entity WORK.UC_Met1 port map(Clk => Clk, Rst => Rst, Start => Start, Q0 => Q0, LoadB => LoadB, RstA => RstA, RstB => RstB, RstQ => RstQ, LoadA => LoadA, LoadQ => LoadQ, shrAQ => shrAQ, Term=>Term);
--salvam x : LoadB=1
Registru_X: entity WORK.bistabil_retine_numar generic map(n=>3) port map (Clk => Clk, Rst => RstB, CE => LoadB, D => X, Q => Bout);
--salvam sau shiftam acumulatorul: shrAQ =1 se shifteaza ; LoadA=1 se salveaza in registru adica starea init sau operatiiProdPartial
Registru_A: entity WORK.SRRN generic map(n=>4) port map(Clk => Clk, D => D_in_accumulator, SRI => "0000", Rst => RstA, CE => shrAQ, Load => loadA, Q => AccOut);
--salvam sau shiftam Q: LoadQ=1 stare init , se salveaza in registru ; shrAQ=1 se shifteza
Registru_Q: entity WORK.SRRN generic map(n=>3) port map(Clk => Clk, D => Y, SRI => A0, Rst => RstQ, CE => shrAQ, Load => LoadQ, Q => Qout);
--facem adunarile repetate pentru pozitia la care ne aflma
SumZec: entity WORK.Cascadare_sumatoare_zecimale port map(X => firstOperand,Y => AccOut, Tin => '0' ,S => SumatorOut , Tout => SumatorTOut );


P(0 to 3)<=Qout(0 to 3);
P(4 to 7)<=AccOut(0 to 3);
--P(0 to 2)<=Qout(1 to 3);
--P(3 to 7)<=AccOut;
end Behavioral;
