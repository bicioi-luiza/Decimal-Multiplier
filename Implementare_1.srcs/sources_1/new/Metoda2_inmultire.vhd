----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 08:57:55 PM
-- Design Name: 
-- Module Name: Metoda2_inmultire - Behavioral
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

entity Metoda2_inmultire is
    Port ( 
    Clk: IN std_logic;
    signX: IN std_logic;
    X: IN number_type(0 to 3);
    signY: IN std_logic;
    Y: IN number_type(0 to 3);
    Rst: IN std_logic;
    Start: IN std_logic;
    P: OUT number_type(0 to 7);
    sign: OUT std_logic;
    Term: OUT std_logic );
end Metoda2_inmultire;

architecture Behavioral of Metoda2_inmultire is
--definire semnale pentru UC
signal LoadA, RstA, LoadQ, RstQ, shrAQ, MuxInit: std_logic;
signal LoadX, RstX: std_logic_vector(8 downto 0);
signal comparatorOUT: std_logic_vector(9 downto 0);
signal AccOut: number_type(0 to 4);
signal A0: std_logic_vector(3 downto 0);
signal Qout: number_type(0 to 3);
signal Q0: std_logic_vector(3 downto 0);
signal firstOperand: number_type(0 to 4);
signal sumatorOUT: number_type(0 to 4);
signal SumatorTOut: std_logic;
signal whichRegister: number_type(0 to 4);
--definire registrii in care vom retine multipli numarului
signal Reg1XIN: number_type(0 to 4);
signal Reg1XOut, Reg2XOut, Reg3XOut, Reg4XOut, Reg5XOut, Reg6XOut, Reg7XOut, Reg8XOut, Reg9XOut: number_type(0 to 4);


begin
sign <= signX xor signY;
A0 <= AccOut(0);
Q0 <= Qout(0);

UCP: entity WORK.UC_met2 port map( Clk => Clk,
                                      Rst => Rst,
                                      Start => Start,
                                      LoadA => LoadA,
                                      RstA => RstA,
                                      RstQ => RstQ,
                                      LoadQ => LoadQ,
                                      shrAQ => shrAQ,
                                      MuxInit => MuxInit,
                                      LoadX => LoadX,
                                      RstX => RstX,
                                      Term => Term);
Reg1XIN <=  X & "0000";
--rezultate salvate in BZ
Reg1X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(0), CE => LoadX(0), D => Reg1XIN, Q => Reg1XOut);
Reg2X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(1), CE => LoadX(1), D => SumatorOUT, Q => Reg2XOut);
Reg3X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(2), CE => LoadX(2), D => SumatorOUT, Q => Reg3XOut);
Reg4X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(3), CE => LoadX(3), D => SumatorOUT, Q => Reg4XOut);
Reg5X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(4), CE => LoadX(4), D => SumatorOUT, Q => Reg5XOut);
Reg6X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(5), CE => LoadX(5), D => SumatorOUT, Q => Reg6XOut);
Reg7X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(6), CE => LoadX(6), D => SumatorOUT, Q => Reg7XOut);
Reg8X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(7), CE => LoadX(7), D => SumatorOUT, Q => Reg8XOut);
Reg9X: entity WORK.bistabil_retine_numar generic map( n => 4) port map (Clk => Clk, Rst => RstX(8), CE => LoadX(8), D => SumatorOUT, Q => Reg9XOut);
--port mapuri A,Q si cascadarea sumatoarelor 
Accumulator: entity WORK.SRRN generic map(n=>4) port map(Clk => Clk, D => SumatorOUT, SRI => "0000", Rst => RstA, CE => shrAQ, Load => LoadA, Q => AccOut);
Registru_Q: entity WORK.SRRN generic map(n=>3) port map(Clk => Clk, D => Y, SRI => A0, Rst => RstQ, CE => shrAQ, Load => LoadQ, Q => Qout);
Sumator_zecimal: entity WORK.Cascadare_sumatoare_zecimale port map(X => firstOperand,Y => AccOut, Tin => '0' ,S => SumatorOUT , Tout => SumatorTOut );


proces_comparator: process(Q0)
begin
    case Q0 is
        when "0000" => comparatorOUT <= "0000000001";
        when "0001" => comparatorOUT <= "0000000010";
        when "0010" => comparatorOUT <= "0000000100";
        when "0011" => comparatorOUT <= "0000001000";
        when "0100" => comparatorOUT <= "0000010000";
        when "0101" => comparatorOUT <= "0000100000";
        when "0110" => comparatorOUT <= "0001000000";
        when "0111" => comparatorOUT <= "0010000000";
        when "1000" => comparatorOUT <= "0100000000";
        when "1001" => comparatorOUT <= "1000000000";
        when others => comparatorOUT <= "0000000000";
    end case;
end process;

alegere_registru: process(clk, comparatorOUT)
begin
    case comparatorOUT is
        when "0000000001" => whichRegister <= (others => "0000");
        when "0000000010" => whichRegister <= Reg1XOut;
        when "0000000100" => whichRegister <= Reg2XOut;
        when "0000001000" => whichRegister <= Reg3XOut;
        when "0000010000" => whichRegister <= Reg4XOut;
        when "0000100000" => whichRegister <= Reg5XOut;
        when "0001000000" => whichRegister <= Reg6XOut;
        when "0010000000" => whichRegister <= Reg7XOut;
        when "0100000000" => whichRegister <= Reg8XOut;
        when "1000000000" => whichRegister <= Reg9XOut;
        when others => whichRegister <= (others => "0000");
    end case;
end process; 
  
firstOperand <= Reg1XOut when MuxInit = '1' else whichRegister;

P(0 to 3)<=Qout(0 to 3);
P(4 to 7)<=AccOut(0 to 3);
end Behavioral;
