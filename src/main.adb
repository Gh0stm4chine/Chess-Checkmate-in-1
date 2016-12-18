with Ada.Text_Io ; use Ada.Text_Io ;
with Ada.Integer_Text_Io ; use Ada.Integer_Text_Io ;
with Echiquier ; use Echiquier ;
with Pieces_package; use Pieces_package ;
with Echec ; use Echec ;

procedure Main is
   Echiquier : T_Mat_user ;
   Ech : T_Mat ;
   Trouve : Boolean := False ;
   --Ech_Inter : T_Mat ;
   Piece_Qui_bouge_D : Details;
   Piece_Qui_bouge_F : Details;
   Mat : Boolean ;
   N : natural ;
   Choix : integer ;
   Choix_mat : integer ;
   Ech_Final : T_Mat;
begin
   Put(" ********* Resolution d'echec et mat en 1 coup ********* "); new_line ;
   Put(" Resoudre une position personnalisee ou depuis le repertoire ? "); new_line ;
   Put("Taper 1 pour une position personnalisee, 2 sinon:  ");
   Get(Choix);
   If Choix = 1 then
      Echiquier := generer ;
   elsif Choix = 2 then
      Put("Taper un nombre entre 1 et 10 :  ");
      get(N);
      Echiquier := generer_repertoire(N);
   else
      Put("Mauvais choix");
   end if ;
   Put("La position est la suivante : "); new_line ;
   Afficher(Echiquier);
   new_line ;
   Ech := transposition(Echiquier);
   Put("Taper 0 pour afficher la solution : ");
   get(Choix_mat);
   If Choix_mat = 0 then
      Echec_Et_Mat(Ech,Pos_Roi(Ech, NOIR),BLANC, Piece_Qui_bouge_D ,Piece_Qui_bouge_F, Mat, Ech_Final );
      if Mat then
         New_Line ;
         Put("Un echec et mat est possible, il faut faire le déplacement suivant : (");
         Put(Integer'Image(Piece_Qui_bouge_D.Coord.X)); Put (",");
         Put (Integer'Image(Piece_Qui_bouge_D.Coord.Y)); Put(") --> (");
         Put(Integer'Image(Piece_Qui_bouge_F.Coord.X)); Put (",");
         Put (Integer'Image(Piece_Qui_bouge_F.Coord.Y)); Put(")");

        -- New_Line;
        -- Put ("Echiquier en position initiale"); New_Line ;
        -- Afficher(Echiquier);
         New_Line;
         Put ("Echiquier en position echec et mat");
         New_Line;
         Afficher(Transposition_Inverse(Ech_Final));

      else
         Put("Il n'ya pas d'echec et mat possible");
      end if;
   end if ;


end Main ;
