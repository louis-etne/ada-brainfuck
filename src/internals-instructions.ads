with Ada.Containers.Vectors;

package Internals.Instructions is

   -- Characters
   type Valid_Character_Array_Type is array (Character) of Boolean;
   
   Valid_Character_Table : constant Valid_Character_Array_Type :=
     ('>'    => True,
      '<'    => True,
      '+'    => True,
      '-'    => True,
      '.'    => True,
      ','    => True,
      '['    => True,
      ']'    => True,
      others => False);

   -- Symbols
   type Symbol_Kind_Type is 
     (Move_Right,
      Move_Left,
      Increment,
      Decrement,
      Output_Char,
      Input_Char,
      Jump_Past,
      Jump_Back,
      Invalid);
   
   type Character_To_Symbol_Array_Type is array (Character) of Symbol_Kind_Type;
   
   Character_To_Symbol_Table : constant Character_To_Symbol_Array_Type :=
     ('>'    => Move_Right,
      '<'    => Move_Left,
      '+'    => Increment,
      '-'    => Decrement,
      '.'    => Output_Char,
      ','    => Input_Char,
      '['    => Jump_Past,
      ']'    => Jump_Back,
      others => Invalid);
   
   -- Program
   type Program_Index_Type is new Natural;
   package Program_Package is new Ada.Containers.Vectors (Index_Type   => Program_Index_Type,
                                                          Element_Type => Symbol_Kind_Type,
                                                          "="          => "=");
   subtype Program_Type is Program_Package.Vector;
   
   Empty_Program : constant Program_Type := Program_Package.Empty_Vector;
   
end Internals.Instructions;
