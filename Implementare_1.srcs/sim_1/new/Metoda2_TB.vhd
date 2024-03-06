----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 09:34:48 PM
-- Design Name: 
-- Module Name: Metoda2_TB - Behavioral
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

entity Metoda2_TB is
--  Port ( );
end Metoda2_TB;

architecture Behavioral of Metoda2_TB is
signal Clk: std_logic:='0';
signal X: number_type(0 to 3);
signal Y: number_type(0 to 3);
signal Rst: std_logic;
signal Start: std_logic;
signal P: number_type(0 to 7);
signal Sign,Term: std_logic;
begin
DUT: entity WORK.Metoda2_inmultire port map(Clk => Clk,signX => '1', X => X, signY => '0', Y => Y, Rst => Rst, Start => Start, P => P, sign => Sign, Term => Term);
Clk <= not Clk after 5 ns;
gen_vect_test:process
begin
    Rst <= '1';
    wait for 10 ns;
    Start <= '1';
    Rst <= '0';
    X(0) <= "0100"; --4
    X(1) <= "0011";--3 
    X(2) <= "0010"; --2
    X(3) <= "0001";--1
    
    Y(0) <= "1001"; --9
       Y(1) <= "1001"; --9
       Y(2) <= "1001";--9 
       Y(3) <= "1000";--8
    wait for 5000 ns;
    end process;
end Behavioral;
