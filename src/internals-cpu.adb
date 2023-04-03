with Internals.IO;
with Internals.Memory;

package body Internals.CPU is

   package State is
      Program         : Internals.Instructions.Program_Type := Internals.Instructions.Empty_Program;
      
      -- Registers
      Program_Counter : Internals.Instructions.Program_Index_Type := Internals.Instructions.Program_Index_Type'First;
      Pointer         : Internals.Memory.Memory_Index_Type := Internals.Memory.Memory_Index_Type'First;
      
      procedure Reset;
   end State;
   
   package body State is
      procedure Reset is
      begin
         Program := Internals.Instructions.Empty_Program;
         Program_Counter := Internals.Instructions.Program_Index_Type'First;
         Pointer := Internals.Memory.Memory_Index_Type'First;
      end Reset;
   end State;
   
   procedure Do_Move_Right is
   begin
      State.Pointer := Internals.Memory.Memory_Index_Type'Succ (State.Pointer);
   end Do_Move_Right;
   
   procedure Do_Move_Left is
   begin
      State.Pointer := Internals.Memory.Memory_Index_Type'Pred (State.Pointer);
   end Do_Move_Left;
   
   procedure Do_Increment is
      Value : constant Internals.Memory.Data_Type :=
        Internals.Memory.Data_Type'Succ (Internals.Memory.Read (State.Pointer));
   begin
      Internals.Memory.Write (State.Pointer, Value);
   end Do_Increment;
   
   procedure Do_Decrement is
      Value : constant Internals.Memory.Data_Type :=
        Internals.Memory.Data_Type'Pred (Internals.Memory.Read (State.Pointer));
   begin
      Internals.Memory.Write (State.Pointer, Value);
   end Do_Decrement;
   
   procedure Do_Output_Char is
      Value : constant Internals.Memory.Data_Type := Internals.Memory.Read (State.Pointer);
   begin
      Internals.IO.Display ("" & Character'Val (Value));
   end Do_Output_Char;
   
   procedure Do_Input_Char is
   begin
      null;
   end Do_Input_Char;
   
   procedure Do_Jump_Past is
      use type Internals.Memory.Data_Type;
      
      Braces_Level : Natural := 1;
   begin
      if Internals.Memory.Read (State.Pointer) = 0 then
         loop
            State.Program_Counter := Internals.Instructions.Program_Index_Type'Succ (State.Program_Counter);
            
            case State.Program.Element (State.Program_Counter) is
               when Internals.Instructions.Jump_Past   =>
                  Braces_Level := Braces_Level + 1;
               when Internals.Instructions.Jump_Back   =>
                  Braces_Level := Braces_Level - 1;
               when Internals.Instructions.Move_Right 
                  | Internals.Instructions.Move_Left  
                  | Internals.Instructions.Increment  
                  | Internals.Instructions.Decrement  
                  | Internals.Instructions.Output_Char
                  | Internals.Instructions.Input_Char 
                  | Internals.Instructions.Invalid     => 
                  null;
            end case;
            
            exit when Braces_Level = 0;
         end loop;
      end if;
   end Do_Jump_Past;
   
   procedure Do_Jump_Back is
      Braces_Level : Natural := 1;
   begin
      loop
         State.Program_Counter := Internals.Instructions.Program_Index_Type'Pred (State.Program_Counter);
         
         case State.Program.Element (State.Program_Counter) is
            when Internals.Instructions.Jump_Past   =>
               Braces_Level := Braces_Level - 1;
            when Internals.Instructions.Jump_Back   =>
               Braces_Level := Braces_Level + 1;
            when Internals.Instructions.Move_Right 
               | Internals.Instructions.Move_Left  
               | Internals.Instructions.Increment  
               | Internals.Instructions.Decrement  
               | Internals.Instructions.Output_Char
               | Internals.Instructions.Input_Char 
               | Internals.Instructions.Invalid     => 
               null;
         end case;
         
         exit when Braces_Level = 0;
      end loop;
      
      State.Program_Counter := Internals.Instructions.Program_Index_Type'Pred (State.Program_Counter);
   end Do_Jump_Back;
   
   procedure Execute (Program : Internals.Instructions.Program_Type) is
      use type Internals.Instructions.Program_Index_Type;
   begin
      State.Reset;      
      State.Program := Program;
      
      loop
         case State.Program.Element (State.Program_Counter) is
            when Internals.Instructions.Move_Right  => Do_Move_Right;
            when Internals.Instructions.Move_Left   => Do_Move_Left;
            when Internals.Instructions.Increment   => Do_Increment;
            when Internals.Instructions.Decrement   => Do_Decrement;
            when Internals.Instructions.Output_Char => Do_Output_Char;
            when Internals.Instructions.Input_Char  => Do_Input_Char;
            when Internals.Instructions.Jump_Past   => Do_Jump_Past;
            when Internals.Instructions.Jump_Back   => Do_Jump_Back;
            when Internals.Instructions.Invalid     => null;
         end case;
         
         State.Program_Counter := Internals.Instructions.Program_Index_Type'Succ (State.Program_Counter);
         exit when State.Program_Counter = Internals.Instructions.Program_Index_Type (Program.Length);
      end loop;
   end Execute;

end Internals.CPU;
