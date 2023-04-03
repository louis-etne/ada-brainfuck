with Ada.Text_IO;

package body Internals.IO is

   function Read_File (Filename : String) return Internals.Instructions.Program_Type is
      File    : Ada.Text_IO.File_Type;
      Program : Internals.Instructions.Program_Type; 
   begin
      Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => Filename);
      
      while not Ada.Text_IO.End_Of_File (File) loop
         declare
            Char : Character;
         begin
            Ada.Text_IO.Get (File, Char);
            
            if Internals.Instructions.Valid_Character_Table (Char) then
               Program.Append (Internals.Instructions.Character_To_Symbol_Table (Char));
            end if;
         end;
      end loop;
      
      return Program;
   end Read_File;

   function Read (Input : String) return Internals.Instructions.Program_Type is
      Program : Internals.Instructions.Program_Type; 
   begin
      for Char of Input loop
         if Internals.Instructions.Valid_Character_Table (Char) then
            Program.Append (Internals.Instructions.Character_To_Symbol_Table (Char));
         end if;
      end loop;
      
      return Program;
   end Read;
   
   procedure Display (Data : String) is
   begin
      Ada.Text_IO.Put (Data);
   end Display;

end Internals.IO;
