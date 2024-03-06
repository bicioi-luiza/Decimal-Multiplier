----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 08:59:32 PM
-- Design Name: 
-- Module Name: UC_met2 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC_met2 is
Port ( 
    Clk: IN std_logic;
    Rst: IN std_logic;
    Start: IN std_logic;
    LoadA: OUT std_logic;
    RstA: OUT std_logic;
    LoadQ: OUT std_logic;
    RstQ: OUT std_logic;
    shrAQ: OUT std_logic;
    LoadX: OUT std_logic_vector(8 downto 0);
    RstX: OUT std_logic_vector(8 downto 0);
    MuxInit: OUT std_logic;
    Term: OUT std_logic);
end UC_met2;

architecture Behavioral of UC_met2 is
--definire stari fsm
type stare is (idle, init, init2X, init3X, init4X, init5X, init6X, init7X, init8X, init9X, adun, shiftez, testC, stop);
signal state:stare:=idle; --se initializeaza starea initiala
signal STEP_CNT: std_logic_vector(2 downto 0):="000"; --determina la a cat cifra a lui B s-a ajuns
begin

proces_stare: process(Clk)
begin
    if(Rst = '1') then
        state <= idle;
    else
        if (Clk = '1' and Clk'event) then
            case state is
                when idle =>
                            if(Start = '1') then
                                state <= init;
                            else
                                state <= idle;
                            end if;
                            STEP_CNT <= "100"; --avem 4 cifre per nr deci initializam step_cnt cu 4
                when init =>
                            state <= init2X;
                when init2X => 
                            state <= init3X;
                when init3X => 
                            state <= init4X;
                when init4X => 
                            state <= init5X;
                when init5X => 
                            state <= init6X;
                when init6X => 
                            state <= init7X;
                when init7X => 
                            state <= init8X;
                when init8X => 
                            state <= init9X;
                when init9X =>
                            state <= adun;
                when adun =>
                            state <= shiftez;
                when shiftez =>
                            state <= testC;
                            STEP_CNT <= STEP_CNT - 1;
                when testC =>
                            if(STEP_CNT > 0) then
                                state <= adun;
                            else
                                state <= stop;
                            end if;
                when others =>
                            state <= stop;
            end case;
        end if;
    end if;
end process;

proces_iesiri: process(state)
begin
    case state is
        when idle =>  
                LoadA <= '0';
                RstA <= '1';
                LoadQ <= '0';
                RstQ <= '1';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000001";
                RstX <= "111111110";
                Term <= '0';
                
         when init =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '1';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';
                
         when init2X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000000010";
                RstX <= "000000000";
                Term <= '0';
         
         when init3X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000000100";
                RstX <= "000000000";
                Term <= '0';
                
         when init4X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000001000";
                RstX <= "000000000";
                Term <= '0';

         when init5X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000010000";
                RstX <= "000000000";
                Term <= '0';

         when init6X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000100000";
                RstX <= "000000000";
                Term <= '0';

         when init7X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "001000000";
                RstX <= "000000000";
                Term <= '0';

         when init8X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "010000000";
                RstX <= "000000000";
                Term <= '0';

         when init9X =>
                LoadA <= '0';
                RstA <= '1';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "100000000";
                RstX <= "000000000";
                Term <= '0';
         
         when adun =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';

         when shiftez =>
                LoadA <= '0';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '1';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';

         when testC =>
                LoadA <= '0';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';

         when stop =>
                LoadA <= '0';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '1';      
    end case;
end process;

end Behavioral;
