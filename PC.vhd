----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2023 12:49:57
-- Design Name: 
-- Module Name: PC - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( CLK : in STD_LOGIC;
           PC_Opcode : in STD_LOGIC_VECTOR (1 downto 0);
           PC_in : in STD_LOGIC_VECTOR (15 downto 0);
           PC_out : out STD_LOGIC_VECTOR (15 downto 0));
end PC;

architecture Behavioral of PC is
signal pc_result: std_logic_vector (15 downto 0) := x"0000";                -- Initialising PC with 0000
begin
    process(CLK )
    begin
        if rising_edge (clk) then
            case PC_Opcode is
                when "00" =>                            -- reset
                    pc_result <= x"0000";
                when "01" =>                            -- increment
                    pc_result <= STD_LOGIC_VECTOR(unsigned(pc_result) + 1);
                when "10" =>                            -- branch
                    pc_result <= PC_in;
                when "11" =>                             -- NOP
                when others =>
            end case;
         end if;
    end process;
 PC_out <= pc_result;
end Behavioral;
