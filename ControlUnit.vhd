----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2023 14:40:28
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ALU_OP : in STD_LOGIC_VECTOR (4 downto 0);
           STAGE : out STD_LOGIC_VECTOR (5 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process (CLK)
    begin
        if rising_edge (CLK) then
            if RESET  = '1' then
                STAGE <= "000001";
            else
                case STAGE is
                    when "000001" =>        -- Fetch
                        STAGE <= "000010";
                    when "000010" =>        -- Decode
                        STAGE <= "000100";
                    when "000100" =>        -- Read Register
                        STAGE <= "001000";
                    when "001000" =>        -- Execute
                        if ALU_OP (3 downto 0) = "1100" or ALU_OP (3 downto 0) = "1101" then        -- if LDR, STR
                            STAGE <= "010000";
                        else
                            STAGE <= "100000";
                        end if;
                    when "010000" =>        -- Memory
                        STAGE <= "100000";
                    when "100000" =>        -- Write Memory
                        STAGE <= "000001";
                    when others =>
                        STAGE <= "000001";                        
                end case;
            end if;
        end if;
    end process;
end Behavioral;
