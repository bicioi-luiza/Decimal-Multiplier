----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 03:44:45 AM
-- Design Name: 
-- Module Name: bistabil_semn - Behavioral
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

entity bistabil_semn is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    CE: IN std_logic;
    D: IN std_logic;
    Q: OUT std_logic );
end bistabil_semn;

architecture Behavioral of bistabil_semn is

begin
process(Clk)
begin
    if(clk = '1' and clk'event) then
        if(Rst = '1') then
            Q <= '0';
        else
            if(CE = '1') then
                Q <= D;
            end if;
        end if;
    end if;
end process;

end Behavioral;
