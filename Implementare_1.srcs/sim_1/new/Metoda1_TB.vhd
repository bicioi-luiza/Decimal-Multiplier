----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 04:16:42 AM
-- Design Name: 
-- Module Name: Metoda1_TB - Behavioral
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

entity Metoda1_TB is
--  Port ( );
end Metoda1_TB;

architecture Behavioral of Metoda1_TB is
signal Clk: std_logic:='0';
signal X: number_type(0 to 3):=(--X=2
"1001", --X(0)=>
"1001",--X(1)=>
"1001",--X(2)=>
others =>"1001");
signal Y: number_type(0 to 3):=( --Y=-2
"1001",--Y(0)=>
"1001",--Y(1)=>
"1001",--Y(2)=>
others =>"1001");
signal Rst: std_logic:='0';
signal Start: std_logic:='1';
signal P: number_type(0 to 7):=(others=>"0000");
signal Sign,Term: std_logic;
begin
DUT: entity WORK.Metoda1_inmultire port map (Clk => Clk, X => X, Y => Y,signX => '1', signY => '1', Rst => Rst, Start => Start,Sign => Sign, P => P, Term => Term);
Clk <= not Clk after 5 ns;



end Behavioral;
