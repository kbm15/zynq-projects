----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.06.2022 13:51:42
-- Design Name: 
-- Module Name: blinky - Behavioral
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

entity blinky is
    Port ( GCLK : in STD_LOGIC;
           SW0 : in STD_LOGIC;
           LD0 : out STD_LOGIC);
end blinky;

architecture Behavioral of blinky is
  constant c_CNT_10HZ  : natural := 5000000;
  constant c_CNT_1HZ   : natural := 50000000;
  signal r_CNT_10HZ  : natural range 0 to c_CNT_10HZ;
  signal r_CNT_1HZ   : natural range 0 to c_CNT_1HZ;
  signal r_TOGGLE_10HZ  : std_logic := '0';
  signal r_TOGGLE_1HZ   : std_logic := '0';
  
  signal w_LED_SELECT : std_logic;

begin
  p_10_HZ : process (GCLK) is
  begin
    if rising_edge(GCLK) then
      if r_CNT_10HZ = c_CNT_10HZ-1 then  
        r_TOGGLE_10HZ <= not r_TOGGLE_10HZ;
        r_CNT_10HZ    <= 0;
      else
        r_CNT_10HZ <= r_CNT_10HZ + 1;
      end if;
    end if;
  end process p_10_HZ;
 
   
  p_1_HZ : process (GCLK) is
  begin
    if rising_edge(GCLK) then
      if r_CNT_1HZ = c_CNT_1HZ-1 then  
        r_TOGGLE_1HZ <= not r_TOGGLE_1HZ;
        r_CNT_1HZ    <= 0;
      else
        r_CNT_1HZ <= r_CNT_1HZ + 1;
      end if;
    end if;
  end process p_1_HZ; 
   
  w_LED_SELECT <= r_TOGGLE_10HZ  when (SW0 = '1') else
                  r_TOGGLE_1HZ;
 
  LD0 <= w_LED_SELECT;

end Behavioral;
