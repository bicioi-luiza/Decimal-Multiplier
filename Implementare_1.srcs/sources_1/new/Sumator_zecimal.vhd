----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 01:04:40 AM
-- Design Name: 
-- Module Name: Sumator_zecimal - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sumator_zecimal is
Port (
    X: IN STD_LOGIC_VECTOR(3 downto 0);
    Y: IN STD_LOGIC_VECTOR(3 downto 0);
    Tin: IN STD_LOGIC;
    S: OUT STD_LOGIC_VECTOR(3 downto 0);
    Tout: OUT STD_LOGIC);
end Sumator_zecimal;

architecture Behavioral of Sumator_zecimal is
signal S1: STD_LOGIC_VECTOR(3 downto 0);
signal T1,T2,Tf: STD_LOGIC;
signal X2: STD_LOGIC_VECTOR(3 downto 0);


begin

sumator1_4biti: entity WORK.Sumator_4biti port map(
X => X,
Y => Y,
Tin => Tin,
S => S1,
Tout => T1);

Tf <= T1 or (S1(3) and S1(2)) or (S1(3) and S1(1));
Tout <= Tf;

X2 <= "0110" when Tf = '1' else "0000";

sumator2_4biti: entity WORK.Sumator_4biti port map(
X => X2,
Y => S1,
Tin => '0',
S => S,
Tout => T2);


end Behavioral;
