----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 09:50:58 PM
-- Design Name: 
-- Module Name: UC_Principala - Behavioral
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

entity UC_Principala is
Port ( 
       Clk: IN std_logic;
       Rst: IN std_logic;
       Step: IN std_logic;
       Error: IN std_logic;
       TermOp: IN std_logic;
       whichState: OUT std_logic_vector(7 downto 0));
end UC_Principala;

architecture Behavioral of UC_Principala is
--definire stari fsm principal
type stare is (idle, selectMetoda, introdSignX, introdX, introdSignY, introdY, calcul, stop);
signal state: stare:=idle;
begin
proces_stare: process(Clk,Rst)
begin
    if (Rst = '1') then
        state <= idle;
    else
        if(Error = '1') then
            state <= stop;
        else    
        if(Clk = '1' and Clk'event) then
            case state is
                when idle => if (STEP = '1') then
                                state <= selectMetoda;
                             else
                                state <= idle;
                             end if;
                when selectMetoda =>    if (STEP = '1') then
                                            state <= introdSignX;
                                         else
                                            state <= selectMetoda;
                                         end if;
               when introdSignX => if (STEP = '1') then
                                        state <= introdX;
                                   else
                                        state <= introdSignX;
                                   end if;
              when introdX =>   if (STEP = '1') then
                                          state <= introdSignY;
                                  else
                                           state <= introdX;
                                  end if;
              when introdSignY => if (STEP = '1') then
                                        state <= introdY;
                                  else
                                        state <= introdSignY;
                                  end if;
              when introdY =>   if (STEP = '1') then
                                        state <= calcul;
                                  else
                                        state <= introdY;
                                  end if;
              when calcul => if (TermOp = '1') then
                                   state <= stop;
                              else
                                    state <= calcul;
                              end if;
              when others => state <= stop;
            end case;
        end if;
    end if;
    end if;
end process;

proces_iesiri: process(state)
begin
    case state is
        when idle => whichState <= "10000000";
        when selectMetoda => whichState <= "01000000";
        when introdSignX => whichState <= "00100000";
        when introdX => whichState <= "00010000";
        when introdSignY => whichState <= "00001000";
        when introdY => whichState <= "00000100";
        when calcul => whichState <= "00000000";
        when stop => whichState <= "00000001";
        when others => whichState <= "11111111";
    end case;
end process;

end Behavioral;
