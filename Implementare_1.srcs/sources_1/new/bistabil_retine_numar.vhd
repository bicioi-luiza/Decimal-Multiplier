----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 03:46:17 AM
-- Design Name: 
-- Module Name: bistabil_retine_numar - Behavioral
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

entity bistabil_retine_numar is
generic(n:integer);
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    CE: IN std_logic;
    D: IN number_type(0 to n);
    Q: OUT number_type(0 to n) );
end bistabil_retine_numar;

architecture Behavioral of bistabil_retine_numar is

begin
process(Clk)
begin
    if(clk = '1' and clk'event) then
        if(Rst = '1') then
            Q(0 to n) <= (others => "0000");
        else
            if(CE = '1') then
                Q <= D;
            end if;
        end if;
    end if;
end process;

end Behavioral;
