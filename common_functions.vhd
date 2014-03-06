library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


package common_functions is

   function log2  (v: natural) return natural;

   function append_zero (
      DI:      std_logic_vector;
      size:    natural)
   return std_logic_vector;

   function prepend_zero (
      DI:     std_logic_vector;
      size:   natural)
   return std_logic_vector;

end;

package body common_functions is
   function log2  (v : natural) return natural is
      variable tmp : natural  := v;
      variable ret : natural  := 0;
   begin
      while tmp > 1 loop
         ret := ret + 1;
         tmp := tmp / 2;
      end loop;
      return ret;
   end function;

   -- ----- ----- ----- ----- ----- -----
   function append_zeros (
      DI : std_logic_vector; 
      size : natural) 
   return std_logic_vector is
      variable tmp_s : std_logic_vector(size-1 downto 0) := (others => '0');
   begin
      if DI'length > size then
         tmp_s := DI(DI'length-1 downto DI'length - size);
      else
         tmp_s(size-1 downto size-DI'length) := DI;
      end if;

      return tmp_s;
   end function;

   -- ----- ----- ----- ----- ----- -----
   function prepend_zeros (
      DI : std_logic_vector; 
      size : natural) 
   return std_logic_vector is
      variable tmp_s : std_logic_vector(size-1 downto 0) := (others => '0');
   begin
      if DI'length > size then
         tmp_s := DI(size-1 downto 0);
      else
         tmp_s(DI'length-1 downto 0) := DI;
      end if;

      return tmp_s;
   end function;

end package body;

