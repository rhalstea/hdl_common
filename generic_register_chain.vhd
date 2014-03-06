library ieee;
use ieee.std_logic_1164.all;

entity generic_register_chain is
   generic (
      DATA_WIDTH        : natural   := 32;
      CHAIN_LENGTH      : natural   := 1
   );
   port (
      clk               : in std_logic;
      rst               : in std_logic;
      data_in           : in std_logic_vector(DATA_WIDTH-1 downto 0);
      data_out          : out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end generic_register_chain;

architecture Behavioral of generic_register_chain is

   type CHAIN_ARRAY is 
      array(CHAIN_LENGTH downto 0) of 
      std_logic_vector(DATA_WIDTH-1 downto 0);

   component generic_register is
   generic (
      DATA_WIDTH        : natural   := 32
   );
   port (
      clk               : in std_logic;
      rst               : in std_logic;
      data_in           : in std_logic_vector(DATA_WIDTH-1 downto 0);
      data_out          : out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
   end component;

   signal chain         : CHAIN_ARRAY;

begin

   chain(CHAIN_LENGTH) <= data_in;

   REGS: for i in CHAIN_LENGTH-1 downto 0 generate
      REG_I: generic_register generic map (
         DATA_WIDTH     => DATA_WIDTH
      )
      port map (
         clk         => clk,
         rst         => rst,
         data_in     => chain(i+1),
         data_out    => chain(i)
      );
   end generate;

   data_out <= chain(0);

end Behavioral;

