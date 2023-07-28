----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2023 16:04:51
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
--  Port ( );
end CPU;

architecture Behavioral of CPU is
    component PC
        Port ( CLK : in STD_LOGIC;
           PC_Opcode : in STD_LOGIC_VECTOR (1 downto 0);
           PC_in : in STD_LOGIC_VECTOR (15 downto 0);
           PC_out : out STD_LOGIC_VECTOR (15 downto 0));
     end component;
     
     component ALU
         Port ( CLK : in STD_LOGIC;
           Enable : in STD_LOGIC;
           ALU_Opcode : in STD_LOGIC_VECTOR (4 downto 0);
           PC_in : in STD_LOGIC_VECTOR (15 downto 0);
           Rm_data : in STD_LOGIC_VECTOR (15 downto 0);
           Rn_data : in STD_LOGIC_VECTOR (15 downto 0);
           Imm_data : in STD_LOGIC_VECTOR (15 downto 0);
           Rd_write_enable_in : in STD_LOGIC;
           Result_out : out STD_LOGIC_VECTOR (15 downto 0);
           Branch_out : out STD_LOGIC;
           Rd_write_enable_out : out STD_LOGIC);
     end component;
     
     component ControlUnit
         Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ALU_OP : in STD_LOGIC_VECTOR (4 downto 0);
           STAGE : out STD_LOGIC_VECTOR (5 downto 0));
     end component;
     
     component Decoder
         Port ( CLK : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           INSTRUCTION : in STD_LOGIC_VECTOR (15 downto 0);
           ALU_OP : out std_logic_vector(4 downto 0);
           IMM_DATA : out std_logic_vector(7 downto 0);
           WRITE_ENABLE : out std_logic := '0';
           SEL_Rm : out std_logic_vector (2 downto 0);
           SEL_Rn : out std_logic_vector (2 downto 0);
           SEL_Rd : out std_logic_vector (2 downto 0));
     end component;
     
     component Memory
         Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           WRITE_ENABLE : in STD_LOGIC;
           ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
           DATA_IN : in STD_LOGIC_VECTOR (15 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (15 downto 0));
     end component;
     
     component RegisterFile
         Port ( CLK : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           WRITE_ENABLE : in STD_LOGIC;
           Rd_DATA : in STD_LOGIC_VECTOR (15 downto 0);
           SEL_Rm : in STD_LOGIC_VECTOR (2 downto 0);
           SEL_Rn : in STD_LOGIC_VECTOR (2 downto 0);
           SEL_Rd : in STD_LOGIC_VECTOR (2 downto 0);
           Rm_out : out STD_LOGIC_VECTOR (15 downto 0);
           Rn_out : out STD_LOGIC_VECTOR (15 downto 0));
     end component;
     
     -- Signals within the CPU
     
     --RegisterFile signal
     signal reg_enable : std_logic := '0';
     signal reg_write_enable : std_logic := '0';
     signal Rm_data : std_logic_vector (15 downto 0) := (others => '0');
     signal Rn_data : std_logic_vector (15 downto 0) := (others => '0');
     signal Rd_data : std_logic_vector (15 downto 0) := (others => '0');
     signal sel_Rm : std_logic_vector (2 downto 0) := (others => '0');
     signal sel_Rn : std_logic_vector (2 downto 0) := (others => '0');
     signal sel_Rd : std_logic_vector (2 downto 0) := (others => '0');
     
     --Decoder signal
     signal instruction : std_logic_vector(15 downto 0) := (others => '0');
     signal alu_opcode : std_logic_vector (4 downto 0) := (others => '0');
     signal immediate : std_logic_vector(7 downto 0) := (others  => '0');
     
     --ALU signal
     signal result : std_logic_vector(15 downto 0) := (others => '0');
     signal branch : std_logic := '0';
     signal write_enable_Rd : std_logic := '0';
     signal write_enable_Rd_1 : std_logic:= '0';
     
     --ControlUnit signal
     signal cpu_reset : std_logic := '0';
     signal stage : std_logic_vector := (others => '0');
     
     --PC signal
     signal pc_op : std_logic_vector (1 downto 0) := (others => '0');
     signal pc_in : std_logic_vector (15 downto 0) := (others => '0');
     signal pc_out : std_logic_vector (15 downto 0) := (others => '0');
     
     --Memory signal
     signal write_enable_ram : std_logic := '0';
     signal address : std_logic_vector (15 downto 0) := (others => '0');
     signal memory_data_in : std_logic_vector (15 downto 0) := (others => '0');
     signal memory_data_out : std_logic_vector (15 downto 0) := (others => '0');
     
     --Pipeline signals
     signal enable_fetch : std_logic := '0';
     signal read_register : std_logic := '0';
     signal enable_decoder : std_logic := '0';
     signal enable_alu : std_logic := '0';
     signal enable_ram : std_logic := '0';
     signal write_register : std_logic := '0';
     
     signal CPU_CLK : std_logic := '0';
     constant CLK_PERIOD : time := 10 ns;
begin
end Behavioral;
