with Internals.Instructions;

package Internals.IO is
   
   function Read_File (Filename : String) return Internals.Instructions.Program_Type;
   -- Read the given filename and return a program
   
   function Read (Input : String) return Internals.Instructions.Program_Type;
   -- Build a program from a given string
   
   procedure Display (Data : String);
   -- Display the given string
   
end Internals.IO;
