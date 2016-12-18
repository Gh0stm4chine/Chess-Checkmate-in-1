with Gdk.Gc ;
with Gdk.Pixmap ;
with Gdk.Pixbuf ;

package GAda.Gr_Core is

   procedure Resize(Largeur : Integer ; Hauteur : Integer) ;

   type T_Couleur is record
      Rouge : Integer range 0..255 ;
      Vert  : Integer range 0..255 ;
      Bleu  : Integer range 0..255 ;
   end record ;

   function Width return Integer ;
   function Height return Integer ;

   procedure SetColor(Coul : T_Couleur) ;

   procedure ColorPoint(X, Y : Integer ; Coul : T_Couleur) ;
   procedure BlackPoint(X, Y : Integer) ;
   procedure Point(X, Y : Integer) ;

   procedure ColorLine(X1, Y1, X2, Y2 : Integer ; Coul : T_Couleur) ;
   procedure BlackLine(X1, Y1, X2, Y2 : Integer) ;
   procedure Line(X1, Y1, X2, Y2 : Integer) ;

   procedure Rectangle(X, Y, Largeur, Hauteur : Integer) ;
   procedure ColorRectangle(X, Y, Largeur, Hauteur : Integer ; Coul : T_Couleur) ;

   procedure Cercle(X, Y, Rayon : Integer ; Coul : T_Couleur) ;
   procedure Disque(X, Y, Rayon : Integer ; Coul : T_Couleur) ;

   procedure Draw ;
   procedure SetLineWidth(Width : Integer) ;

   Pixmap        : Gdk.Pixmap.Gdk_Pixmap ;  -- C'est bien un Gdk_Drawable
   LGC           : Gdk.Gc.Gdk_GC ;

   subtype Image is Gdk.Pixbuf.Gdk_Pixbuf ;

   function Load_Image (Filename : String) return Image ;
   procedure Put_Image (X, Y : Integer ; Img : Image) ;

   function Hauteur_Image(Img : Image) return Integer ;
   function Largeur_Image(Img : Image) return Integer ;

   type T_Event_Type is (Button_Press, Key_Press) ;

   type T_Event is record
      -- Vaut FALSE si aucun evenement disponible
      Trouve : Boolean ;

      -- Type de l'evenement
      Etype : T_Event_Type ;

      -- Age en millisecondes
      Age : Integer ;

      -- Coordonnees de la souris
      X, Y : Integer ;

      -- Touche appuyée
      Key : Character ;

      -- Code de la touche appuyée
      Key_Code : Integer ;
   end record ;

   function Next_Event return T_Event ;

   procedure Put_Text (X, Y : Integer ; Msg : String ; Size : Integer := 0) ;

   procedure Avec_Marge(Flag : Boolean) ;

end GAda.Gr_Core ;
