package Internals.Memory is
   -- This package handle the memory use for brainfuck programs
   
   Ct_Size : constant := 30_000;
   -- The memory size
   
   type Data_Type is mod 2 ** 8;
   type Memory_Index_Type is range 0 .. Ct_Size - 1;
   type Memory_Array_Type is array (Memory_Index_Type) of Data_Type;
   
   procedure Initialize;
   -- Initialize the memory
   
   procedure Reset;
   -- Reset the memory to its default state
   
   procedure Write (Position : Memory_Index_Type; Value : Data_Type);
   -- Write the given value in the memory at the given position
   
   function Read (Position : Memory_Index_Type) return Data_Type;
   -- Return the memory value at the given position
   
   function Dump return Memory_Array_Type;
   -- Return the memory content

end Internals.Memory;
