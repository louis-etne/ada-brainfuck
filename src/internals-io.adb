with Ada.Text_IO;

package body Internals.IO is

   procedure Read (Filename : String)
   is
   begin
      Display ("Reading " & Filename);
   end Read;
   
   procedure Run (Symbols : String) is
   begin
      Display ("Running " & Symbols);
   end Run;

   procedure Display (Data : String) is
   begin
      Ada.Text_IO.Put_Line (Data);
   end Display;

end Internals.IO;
