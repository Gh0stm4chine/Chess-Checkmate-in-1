with GAda.Gr_Core ;

package body GAda.Advanced_Graphics is

   package AGR renames GAda.Gr_Core ;

   function Load_Image (Filename : String) return Image renames Gada.Gr_Core.Load_Image ;
   procedure Put_Image (X, Y : Integer ; Img : Image) renames Gada.Gr_Core.Put_Image ;

   function Hauteur_Image(Img : Image) return Integer renames GAda.Gr_Core.Hauteur_Image ;
   function Largeur_Image(Img : Image) return Integer renames GAda.Gr_Core.Largeur_Image ;

   function Identity (X : AGR.T_Event_type) return T_Event_Type is
   begin
      case X is
         when AGR.Button_Press => return Button_Press ;
         when AGR.Key_Press    => return Key_Press ;
      end case ;
   end Identity ;

   function Next_Event return T_Event is
      Evt : AGr.T_Event ;
   begin
      Evt := AGr.Next_Event ;
      return (Evt.Trouve, Identity(Evt.Etype), Evt.Age, Evt.X, Evt.Y, Evt.Key, Evt.Key_Code) ;
   end Next_Event ;

   procedure Put_Text (X, Y : Integer ; Msg : String ; Size : Integer := 0) renames GAda.Gr_Core.Put_Text ;

end GAda.Advanced_Graphics ;
