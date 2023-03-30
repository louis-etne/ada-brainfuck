with Ada.Strings.Unbounded;

with Internals.IO;
with Internals.Memory;

package body Internals.Debug is

   procedure Dump_Memory is
      Result : Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      Memory : constant Internals.Memory.Memory_Array_Type := Internals.Memory.Dump;
      
      use type Ada.Strings.Unbounded.Unbounded_String;
      use type Internals.Memory.Data_Type;
   begin
      for Index in Internals.Memory.Memory_Index_Type loop
         if Memory (Index) /= 0 then
            Result := Result & Character'Val (Memory (Index));
         end if;
      end loop;
      
      Internals.IO.Display (Ada.Strings.Unbounded.To_String (Result));
   end Dump_Memory;

end Internals.Debug;
