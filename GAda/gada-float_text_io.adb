with GAda.Core ;

package body GAda.Float_Text_IO is

   procedure Put (Aff : in Float) renames GAda.Core.FPut ;
   function FGet return Float renames GAda.Core.FFGet ;

   procedure Get (Item : out Float) is
   begin
      Item := FGet ;
   end Get ;

end GAda.Float_Text_IO ;
