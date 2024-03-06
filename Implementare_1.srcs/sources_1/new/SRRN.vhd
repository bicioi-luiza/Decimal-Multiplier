----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2023 03:15:10 AM
-- Design Name: 
-- Module Name: SRRN - Behavioral
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

entity SRRN is
generic(n:integer);
Port (
    Clk: IN std_logic;
    D: in number_type(0 to n); -- daca n=3 , atunci D are 16 biti
    SRI: IN std_logic_vector(3 downto 0);
    Rst: IN std_logic;
    CE: IN std_logic;
    Load: IN std_logic;
    Q: OUT number_type(0 to n));
end SRRN;

architecture Behavioral of SRRN is


signal  temp: number_type(0 to n) :=(others=>"0000");
begin
process(Clk)
begin
    if(clk = '1' and clk'event) then
        if(Rst = '1') then
            temp(0 to n) <= (others => "0000");
        else
            if(Load = '1') then
                temp <= D;
            else
                if(CE = '1') then
                    temp <= temp(1 to n)&SRI; --adica daca n=3 atunci vor fi de la 15 la 4
                   
                end if;
            end if;
        end if;
    end if;
end process;

Q <= temp;

end Behavioral;
