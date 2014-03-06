library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;

entity generic_pipeline is
   generic (
      DATA_WIDTH     : natural   := 32;
      DATA_DEPTH     : natural   := 8
   );
   port (
      clk            : in std_logic;
      rst            : in std_logic;
      
      empty_out      : out std_logic;
      write_en_in    : in std_logic;
      data_in        : in std_logic_vector(DATA_WIDTH-1 downto 0);
      data_out       : out std_logic_vector(DATA_WIDTH-1 downto 0);
      valid_out      : out std_logic
   );
end generic_pipeline;

architecture Behavioral of generic_pipeline is
   type PIPE_BUFFER is 
      array(DATA_DEPTH-1 downto 0) of 
      std_logic_vector(DATA_WIDTH-1 downto 0);
   signal pipeline_s    : PIPE_BUFFER;
   signal valid_s       : std_logic_vector(DATA_DEPTH-1 downto 0);
begin

   process (clk)
   begin
      if rising_edge(clk) then
         if rst = '1' then
            valid_s <= (others => '0');
         else
            valid_s <= valid_s(DATA_DEPTH-2 downto 0) & write_en_in;
         end if;
      end if;
   end process;

   process (clk)
   begin
      if rising_edge(clk) then
         pipeline_s(0) <= data_in;
         
         for i in 1 to DATA_DEPTH-1 loop
            pipeline_s(i) <= pipeline_s(i-1);
         end loop;
      end if;
   end process;

   empty_out   <= '1' when valid_s = 0 else '0';
   valid_out   <= valid_s(DATA_DEPTH-1);
   data_out    <= pipeline_s(DATA_DEPTH-1);

end Behavioral;

