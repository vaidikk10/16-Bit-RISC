----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2023 13:20:32
-- Design Name: 
-- Module Name: Memory - Behavioral
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

entity Memory is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           WRITE_ENABLE : in STD_LOGIC;
           ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
           DATA_IN : in STD_LOGIC_VECTOR (15 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (15 downto 0));
end Memory;

architecture Behavioral of Memory is
    type memory_array is array (0 to 255) of std_logic_vector (15 downto 0);
        signal ram: memory_array := (
        '0' & "1011" & "000" & x"0A", -- imm r0 = 0x000A (580A)                                                     0
        '0' & "1011" & "001" & x"AA", -- imm r1 = 0x00AA (59AA)                                                     1
        '0' & "0010" & "001" & "001" & "00000", -- not r1 = xFF55 (1120)                                            2
        '0' & "0000" & "010" & "001" & "000" & "00", -- (unsigned) ADD r2 r1 r0, r2 = xFF5F (0220)                  3
        '0' & "1011" & "011" & x"08", -- imm r3 = 0x08  (5B08)                                                      4
        '0' & "0110" & "010" & "010" & "011" & "00", -- LSL r2 by r3, r2 = x5F00  (324C)                            5
        '0' & "1011" & "100" & x"04", -- imm r4 = 0x04       (5C04)                                                 6
        '0' & "0111" & "010" & "010" & "100" & "00", -- LSR r2 by r4, r2 = x05F0 (3A50)                             7
        '1' & "1001" & "000" & x"0B", -- Branch to ram address 11 (C80B)                                            8
        x"0000", -- NOP (0000)                                                                                      9
        x"0000", -- NOP (0000)                                                                                      10
        '0' & "0001" & "101" & "010" & "011" & "00", -- (unsigned) SUB r5 r2 r3, r5 = x05E8 (0D4C)                  11
        '0' & "1011" & "110" & x"FF", -- imm r6 = 0xFF       (5EFF)                                                 12
        '0' & "1101" & "000" & "110" & "101" & "00", -- ST r5 (rM) data at r6 (rN) address (x05E8 at xFF) (68D4)    13
        '0' & "1100" & "111" & "110" & "00000", -- LD r6 address into r7, r7 = x05E8 (67c0)                         14
        '0' & "1000" & "000" & "101" & "111" & "00", --unsigned CMP r0 r5 r7, r0 = x"4000" (40BC)                   15
        '0' & "1011" & "001" & x"18", -- imm r1 = 0x18       (5918)                                                 16
        '0' & "1010" & "000" & "001" & "000" & "00",  -- BEQ r1 r0 .. r1 = addr, r0 = out from cmp (5020)           17
        x"0000", -- nop (0000)                                                                                      18
        x"0000", -- nop (0000)                                                                                      19
        x"0000", -- nop (0000)                                                                                      20
        x"0000", -- nop (0000)                                                                                      21
        x"0000", -- nop (0000)                                                                                      22
        x"0000", -- nop (0000)                                                                                      23
        '0' & "0011" & "010" & "011" & "001" & "00", --AND r2 r3 r1, r2 = x08 (1A64)                                24
        '0' & "0100" & "011" & "010" & "001" & "00", -- OR r3 r2 r1, r3 = 0x14 (2344)                               25
        '0' & "0101" & "100" & "011" & "011" & "00", -- XOR r4 r3 r3, r4 = 0x00  (2C6C)                             26
                
        others => x"0000"
    );
begin


end Behavioral;
