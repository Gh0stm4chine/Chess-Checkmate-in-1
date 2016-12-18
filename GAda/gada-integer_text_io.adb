with GAda.Core ;

package body GAda.Integer_Text_IO is

   function FGet return Integer renames GAda.Core.FIGet ;
   procedure Put (Aff : in Integer) renames GAda.Core.IPut ;

   procedure Get (Item : out Integer) is
   begin
      Item := FGet ;
   end Get ;

end GAda.Integer_Text_IO ;
