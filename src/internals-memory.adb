package body Internals.Memory is
   
   Memory : Memory_Array_Type;

   procedure Initialize is
   begin
      Reset;
   end Initialize;
   
   procedure Reset is
   begin
      Memory := (others => Data_Type'First);
   end Reset;
   
   procedure Write (Position : Memory_Index_Type; Value : Data_Type) is
   begin
      Memory (Position) := Value;
   end;
   
   function Read (Position : Memory_Index_Type) return Data_Type is
   begin
      return Memory (Position);
   end Read;
   
   function Dump return Memory_Array_Type is
   begin      
      return Memory;
   end Dump;
   
end Internals.Memory;
