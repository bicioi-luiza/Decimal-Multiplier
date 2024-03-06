----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 01:15:00 AM
-- Design Name: 
-- Module Name: Cascadare_sumatoare_zecimale - Behavioral
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

library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.myPackage.all;
entity Cascadare_sumatoare_zecimale is
Port (
    X: IN number_type(0 to 4);
    Y: IN number_type(0 to 4);
    Tin: IN std_logic;
    S: OUT number_type(0 to 4);
    Tout: OUT std_logic );
end Cascadare_sumatoare_zecimale;

architecture Behavioral of Cascadare_sumatoare_zecimale is
signal T1,T2,T3,T4: STD_LOGIC;
begin
sum_unitati: entity WORK.Sumator_zecimal port map(
           X => X(0),
           Y => Y(0),
           Tin => Tin,
           S => S(0),
           Tout => T1);

sum_zeci: entity WORK.Sumator_zecimal port map(
            X => X(1),
            Y => Y(1),
            Tin => T1,
            S => S(1),
            Tout => T2);

sum_sute: entity WORK.Sumator_zecimal port map(
            X => X(2),
            Y => Y(2),
            Tin => T2,
            S => S(2),
            Tout => T3);

sum_mii: entity WORK.Sumator_zecimal port map(
             X => X(3),
             Y => Y(3),
             Tin => T3,
             S => S(3),
             Tout => T4);

sum_zeci_mii: entity WORK.Sumator_zecimal port map(
             X => X(4),
             Y => Y(4),
             Tin => T4,
             S => S(4),
             Tout => Tout);

end Behavioral;
