with Internals.Debug;
with Internals.IO;
with Internals.Memory;

procedure Brainfuck is
begin
   Internals.Memory.Initialize;
   Internals.Memory.Write (0, 72);
   Internals.Memory.Write (1, 101);
   Internals.Memory.Write (2, 108);
   Internals.Memory.Write (3, 108);
   Internals.Memory.Write (4, 111);

   Internals.Debug.Dump_Memory;

   Internals.IO.Run ("++");
end Brainfuck;
