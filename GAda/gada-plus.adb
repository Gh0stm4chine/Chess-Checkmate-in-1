with GtkAda.File_Selection ;
use  GtkAda.File_Selection ;
with Gada.Core ;

package body GAda.Plus is

   package Txt renames Gada.Core ;

   function Choisir_Fichier return String is
      Message : String := "Choisissez un fichier" ;
   begin
      Txt.Enter ;
      declare
         Result : String := File_Selection_Dialog  (Txt.Convert(Message),
                                                    Default_Dir => "",
                                                    Dir_Only => False,
                                                    Must_Exist => True) ;
      begin
         Txt.Leave ;
         return Result ;
      end ;
   end Choisir_Fichier ;

end GAda.Plus ;
