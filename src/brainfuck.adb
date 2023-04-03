with Internals.IO;
with Internals.Memory;
with Internals.Instructions;
with Internals.CPU;

procedure Brainfuck is
   Program : constant Internals.Instructions.Program_Type :=
     Internals.IO.Read_File ("/home/louis/Documents/projects/brainfuck/main.bf");
begin
   Internals.Memory.Initialize;
   Internals.CPU.Execute (Program);
end Brainfuck;
