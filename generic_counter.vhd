library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity generic_counter is
   generic (
      WIDTH          : natural   := 64
   );
   port (
      clk            : in std_logic;
      rst            : in std_logic;
      stall_in       : in std_logic;
      done_out       : out std_logic;

      start_in       : in std_logic_vector(WIDTH-1 downto 0);
      end_in         : in std_logic_vector(WIDTH-1 downto 0);
      step_in        : in std_logic_vector(WIDTH-1 downto 0);

      valid_out      : out std_logic;
      result_out     : out std_logic_vector(WIDTH-1 downto 0)
  );
end generic_counter;

architecture behavioral of generic_counter is
   signal counter_s  : std_logic_vector(WIDTH-1 downto 0);
begin

   done_out <= '1' when counter_s = end_in and rst = '0' else '0';

   process (clk)
   begin
      if rising_edge(clk) then
         if rst = '1' then
            counter_s   <= start_in;
            result_out  <= start_in;
            valid_out   <= '0';

         else
            if counter_s < end_in and stall_in = '0' then
               counter_s   <= counter_s + step_in;
               result_out  <= counter_s;
               valid_out   <= '1';
            else
               valid_out   <= '0';
            end if;

         end if;
      end if;
   end process;

end behavioral;

