with GAda.Core ;
with Ada.Strings.Fixed ;

package body GAda.Text_IO is

   procedure Put (Aff : in String) renames GAda.Core.Put ;
   procedure Put_Line (Aff : in String) renames GAda.Core.Put_Line ;
   procedure New_Line renames GAda.Core.New_Line ;
   function FGet return String renames GAda.Core.FGet ;
   procedure Get (Item : out String) renames GAda.Core.Get ;
   procedure Put (Aff : in Character) renames GAda.Core.Put ;
   procedure Put_Line (Aff : in Character) renames Gada.Core.Put_Line ;

   function Normalise (X : String ; N : Integer) return String is
      Result : String(1..N) ;
   begin
      Ada.Strings.Fixed.Move(Source => X,
                             Target => Result,
                             Drop => Ada.Strings.Right,
                             Justify => Ada.Strings.Left) ;
      return Result ;
   end Normalise ;

   procedure Replace (Aff : in String) renames GAda.Core.Replace ;

end GAda.Text_IO ;

