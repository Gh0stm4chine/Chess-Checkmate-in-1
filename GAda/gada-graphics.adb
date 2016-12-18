with GAda.Gr_Core ;

package body GAda.Graphics is

   package G renames GAda.Gr_Core ;


   procedure BlackPoint(X, Y : Integer) renames G.BlackPoint ;
   procedure BlackLine(X1, Y1, X2, Y2 : Integer) renames G.BlackLine ;

   procedure Resize(Largeur : Integer ; Hauteur : Integer) renames G.Resize ;

   procedure SetColor (Coul : T_Couleur) is
   begin
      G.SetColor ((Coul.Rouge, Coul.Vert, Coul.Bleu)) ;
   end SetColor ;

   procedure ColorPoint(X, Y : Integer ; Coul : T_Couleur) is
   begin
      G.ColorPoint (X, Y, (Coul.Rouge, Coul.Vert, Coul.Bleu)) ;
   end ColorPoint ;

   procedure ColorLine(X1, Y1, X2, Y2 : Integer ; Coul : T_Couleur) is
   begin
      G.ColorLine (X1, Y1, X2, Y2, (Coul.Rouge, Coul.Vert, Coul.Bleu)) ;
   end ColorLine ;

   procedure Cercle(X, Y, Rayon : Integer ; Coul : T_Couleur) is
   begin
      G.Cercle (X, Y, Rayon, (Coul.Rouge, Coul.Vert, Coul.Bleu)) ;
   end Cercle ;

   procedure Disque(X, Y, Rayon : Integer ; Coul : T_Couleur) is
   begin
      G.Disque (X, Y, Rayon, (Coul.Rouge, Coul.Vert, Coul.Bleu)) ;
   end Disque ;

   procedure ColorRectangle(X, Y, Largeur, Hauteur : Integer ; Coul : T_Couleur) is
   begin
      G.ColorRectangle (X,Y,Largeur,Hauteur, (Coul.Rouge, Coul.Vert, Coul.Bleu)) ;
   end ColorRectangle ;

   procedure Avec_Marge(Flag : Boolean) renames G.Avec_Marge ;

end GAda.Graphics ;
