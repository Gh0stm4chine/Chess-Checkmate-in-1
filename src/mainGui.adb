
with Ada.Text_Io ; use Ada.Text_Io ;
with Ada.Integer_Text_Io ; use Ada.Integer_Text_Io ;
with Gada.Integer_Text_Io ; 
with Gada.Text_Io ;
with Echiquier ; use Echiquier ;
with Pieces_package; use Pieces_package ;
with Echec ; use Echec ;
with Gada.Advanced_Graphics, Gada.Graphics ;
use Gada.Advanced_Graphics , Gada.Graphics ;

procedure mainGui is
   
   package Int renames Gada.Integer_Text_Io;
   package Txt renames Gada.Text_Io ;
   
   procedure Afficher_Image_Pieces(Ech : T_Mat_User ) is
      
   begin
      for I in 1..8 loop
   	 for J in 1..8 loop   
   	    case Ech(I)(J) is
   	       when '*' => null ;
   	       when 'p' => 
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Pion_Noir.png")); 
	       when 'P' =>
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Pion_Blanc.png")); 
	       when 'C' =>
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Cavalier_Blanc.png"));
	       when 'c' => 
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Cavalier_Noir.png")); 
	       when 'F' =>
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Fou_Blanc.png")); 
	       when 'T' =>
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Tour_Blanc.png"));
	       when 'f' => 
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Fou_Noir.png")); 
	       when 'D' =>
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Dame_Blanc.png")); 
	       when 'R' =>
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Roi_Blanc.png"));  
	       when 't' => 
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Tour_Noir.png")); 
	       when 'd' => 
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Dame_Noir.png")); 	
	       when 'r' => 
		  Put_Image(320-J*40,19+I*40,Load_Image("../Img/Roi_Noir.png")); 
	       when others => null ;
	    end case;
	 end loop ;
      end loop ;
 
	       end Afficher_Image_Pieces ;
		  
		  
		  
		  
		  
		  
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
   Echi : Image ;
   Pb : Image ;
   Echiquier_Depart : T_Mat_user ;
   Char_D : Character ;
   Char_F : Character ;
begin
   Echiquier_Depart := Generer_Repertoire(11);
   Echi := Load_Image("../Img/board.png");
   Pb := Load_Image("../Img/Pion_Blanc.png");
   Resize(333,338);
   Put_Image(0,338,echi);
   Afficher_Image_Pieces(Echiquier_Depart);
   Put_Text (10,370,"Choisir entre position personnalisee ou automatique",0);
   --  Put_Image(320-40,0+59+40+40,pb);
   --  Put_Image(320-40-40,0+59+40+40,pb);
   Put(" ********* Resolution d'echec et mat en 1 coup ********* "); new_line ;
   Put(" Resoudre une position peqrrsonnalisee ou depuis le repertoire ? "); new_line ;
   Put("Taper 1 pour une position personnalisee, 2 sinon:  "); 
   Choix := Int.fGet;
   If Choix = 1 then
      Echiquier := generer ;
   elsif Choix = 2 then
      Put("Taper un nombre entre 1 et 10 :  "); 
      N := Int.Fget ; 
      Echiquier := generer_repertoire(N);
   else
      Put("Mauvais choix");
   end if ;
   Put("La position est la suivante : "); new_line ;
   Afficher(Echiquier);
   Resize(333,338);
   Put_Image(0,338,echi);
   Afficher_Image_Pieces(Echiquier);
   Put_Text (90,370,"Position de depart",0);
   new_line ;
   Ech := transposition(Echiquier);
   Put("Taper 0 pour afficher la solution : ");
   Choix_Mat := Int.Fget ;
   If Choix_mat = 0 then
      Echec_Et_Mat(Ech,Pos_Roi(Ech, NOIR),BLANC, Piece_Qui_bouge_D ,Piece_Qui_bouge_F, Mat, Ech_Final );
      if Mat then
         New_Line ;
         Put("Un echec et mat est possible, il faut faire le déplacement suivant : (");
	 case Piece_Qui_bouge_D.Coord.Y is
	    when 8 => Char_D := 'A' ;
	    when 7 => Char_D := 'B' ;
	    when 6 => Char_D := 'C' ;
	    when 5 => Char_D := 'D' ;
	    when 4 => Char_D := 'E' ;
	    when 3 => Char_D := 'F' ;
	    when 2 => Char_D := 'G' ;
	    when 1 => Char_D := 'H' ;
	    when others =>  null ;
	 end case ;
	 case Piece_Qui_bouge_F.Coord.Y is
	    when 8 => Char_F := 'A' ;
	    when 7 => Char_F := 'B' ;
	    when 6 => Char_F := 'C' ;
	    when 5 => Char_F := 'D' ;
	    when 4 => Char_F := 'E' ;
	    when 3 => Char_F := 'F' ;
	    when 2 => Char_F := 'G' ;
	    when 1 => Char_F := 'H' ;
	    when others =>  null ;
	 end case ;
         Put(Integer'Image(Piece_Qui_bouge_D.Coord.X)); Put (",");
         Put (Char_D); Put(") --> (");
         Put(Integer'Image(Piece_Qui_bouge_F.Coord.X)); Put (",");
         Put (Char_F); Put(")");

        -- New_Line;
        -- Put ("Echiquier en position initiale"); New_Line ;
        -- Afficher(Echiquier);
         New_Line;
         Put ("Echiquier en position echec et mat");
         New_Line;
         Afficher(Transposition_Inverse(Ech_Final));
	 Resize(333,338);
	 Put_Image(0,338,echi);
	 Afficher_Image_Pieces(Transposition_Inverse(Ech_Final));
	 Put_Text (90,370,"Position de MAT",0);

      else
         Put("Il n'ya pas d'echec et mat possible");
      end if;
   end if ;


end mainGui ;
