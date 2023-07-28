----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2023 13:12:21
-- Design Name: 
-- Module Name: RegisterFile - Behavioral
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

entity RegisterFile is
    Port ( CLK : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           WRITE_ENABLE : in STD_LOGIC;
           Rd_DATA : in STD_LOGIC_VECTOR (15 downto 0);
           SEL_Rm : in STD_LOGIC_VECTOR (2 downto 0);
           SEL_Rn : in STD_LOGIC_VECTOR (2 downto 0);
           SEL_Rd : in STD_LOGIC_VECTOR (2 downto 0);
           Rm_out : out STD_LOGIC_VECTOR (15 downto 0);
           Rn_out : out STD_LOGIC_VECTOR (15 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is
    type register_array is array (0 to 7) of std_logic_vector (15 downto 0);
    signal reg_file: register_array := (others => x"0000");
begin
    process(CLK)
    begin
        if rising_edge (CLK) and ENABLE = '1' then
            Rm_out <= reg_file (to_integer (unsigned (SEL_Rm )));
            Rn_out <= reg_file (to_integer (unsigned (SEL_Rn)));
            
            if WRITE_ENABLE = '1' then
                reg_file(to_integer (unsigned (SEL_Rn))) <= Rd_DATA;
            end if;
        end if;
    end process ;
end Behavioral;
