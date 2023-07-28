----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2023 13:21:00
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( CLK : in STD_LOGIC;
           Enable : in STD_LOGIC;
           ALU_Opcode : in STD_LOGIC_VECTOR (4 downto 0);
           PC_in : in STD_LOGIC_VECTOR (15 downto 0);
           Rm_data : in STD_LOGIC_VECTOR (15 downto 0);
           Rn_data : in STD_LOGIC_VECTOR (15 downto 0);
           Imm_data : in STD_LOGIC_VECTOR (7 downto 0);
           Rd_write_enable_in : in STD_LOGIC;
           Result_out : out STD_LOGIC_VECTOR (15 downto 0);
           Branch_out : out STD_LOGIC;
           Rd_write_enable_out : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
    signal signed_add : std_logic_vector (15 downto 0);
    signal signed_sub : std_logic_vector (15 downto 0);
    signal unsigned_add : std_logic_vector (15 downto 0);
    signal unsigned_sub : std_logic_vector (15 downto 0);
    signal both_positive : std_logic;
    signal both_negative : std_logic;
    signal overflow : std_logic;
begin
    process (CLK)
    begin
        Rd_write_enable_out <= Rd_write_enable_in;
        
        signed_add <= std_logic_vector (signed (Rm_data) + signed(Rn_data));
        signed_sub <= std_logic_vector (signed (Rm_data) - signed(Rn_data));
        
        unsigned_add <= std_logic_vector (unsigned (Rm_data) + unsigned(Rn_data));
        unsigned_sub <= std_logic_vector (unsigned (Rm_data) - unsigned(Rn_data));
        
        -- +ve Overflow Check
        if Rm_data(Rm_data'left) = '0' and Rn_data (Rn_data'left) = '0' then
            both_positive <= '1';
        else
            both_positive <= '0';
        end if;
        
        -- -ve Overflow Check
                -- +ve Overflow Check
        if Rm_data(Rm_data'left) = '1' and Rn_data (Rn_data'left) = '1' then
            both_negative <= '1';
        else
            both_negative <= '0';
        end if;
        
        
        -- Check if Overflow
        if(signed(signed_add) < 0 and both_positive = '1') or (signed(signed_sub) > 0 and both_negative = '1') then
            overflow <= '1';
         else
            overflow <= '0';
        end if;
        
        
        -- ALU Operation, Right 3-0 bits is opcode, and 4-3 is the conditional bit
        case ALU_Opcode (3 downto 0) is
            when "0000" =>                      -- ADD
                -- If condition bit is '1' then signed operation, else unsigned
                if ALU_Opcode (4) = '1' then
                    Result_out <= signed_add;
                else
                    Result_out <= unsigned_add;
                end if;
                Branch_out <= '0';
            
            when "0001" =>                      -- SUB
                if ALU_Opcode (4) = '1' then
                    Result_out <= signed_sub;
                else
                    Result_out <= unsigned_sub;
                end if;
                Branch_out <= '0';
             
            when "0010" =>                      -- NOT
                Result_out <= not Rm_data;
                Branch_out <= '0';
           
            when "0011" =>                       -- AND
                Result_out <= Rm_data  and Rn_data;
                Branch_out <= '0';
             
             when "0100" =>                     -- OR
                Result_out <= Rm_data or Rn_data;
                Branch_out <= '0';
                
             when "0101" =>                     -- XOR
                Result_out <= Rm_data xor Rn_data;
                Branch_out <= '0';
                
             when "0110" =>                     -- LSL
                Result_out <= std_logic_vector(shift_left(unsigned(Rm_data), to_integer(unsigned(Rn_data(3 downto 0)))));
                Branch_out <= '0';
              
             when "0111" =>                     -- LSR
                Result_out <= STD_LOGIC_VECTOR(shift_right(unsigned(Rm_data), to_integer(unsigned(Rn_data(3 downto 0)))));
                Branch_out <= '0';
        end case;
    end process;
end Behavioral;
