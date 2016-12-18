with Pieces_package; use Pieces_package;
with Ada.Integer_Text_Io ;
with Ada.Text_Io ;
With Echiquier ; use Echiquier;
use Ada.Text_Io;
use Ada.Integer_Text_Io;




package body Pieces_package is
   Erreur_Lettre_Inexistante : exception ;
   function Attribution (Pos : Coordonnees; Echiquier : T_Mat_user) return Details is
   begin
      case Echiquier(Pos.X)(Pos.Y) is
         when 'R'=> return (Roi, Blanc, Pos);
         when 'r'=> return (Roi, noir, Pos);
         when 'D'=> return (Dame, Blanc, Pos);
         when 'd'=> return (Dame, Noir, Pos);
         when 'C'=> return (Cavalier, Blanc, Pos);
         when 'c'=> return (Cavalier, Noir, Pos);
         when 'F'=> return (Fou, Blanc, Pos);
         when 'f'=> return (Fou, Noir, Pos);
         when 'T'=> return (Tour, Blanc, Pos);
         when 't'=> return (Tour, Noir, Pos);
         when 'P'=> return (Pion, Blanc, Pos);
         when 'p'=> return (Pion, Noir, Pos);
         when '.' => return (vide,vide,Pos);
         when others => raise Erreur_Lettre_inexistante ;
      end case ;
   end Attribution;

   function Transposition (Echiquier : T_Mat_User) return T_Mat is
      Mat : T_Mat;
   begin
      for I in Echiquier'Range loop
         for J in Echiquier(I)'range loop
            Mat(I,J):= Attribution ((I,J),Echiquier);
         end loop;
      end loop;
      return Mat;
   end Transposition;

   function Transposition_inverse (Echiquier : T_Mat) return T_Mat_user is
      Mat : T_Mat_user;
   begin
      for I in Echiquier'Range(1) loop
         for J in Echiquier'Range(2) loop
            case Echiquier(I,J).P is
               when Pion =>
                  if Echiquier(I,J).C = BLANC then
                     Mat(I)(J) := 'P' ;
                  else
                     Mat(I)(J) := 'p' ;
                  end if ;
               when VIDE => Mat(I)(J) := '.' ;
               when Dame =>
                  if Echiquier(I,J).C = BLANC then
                     Mat(I)(J) := 'D' ;
                  else
                     Mat(I)(J) := 'd' ;
                  end if ;
               when Roi =>
                  if Echiquier(I,J).C = BLANC then
                     Mat(I)(J) := 'R' ;
                  else
                     Mat(I)(J) := 'r' ;
                  end if ;
               when Fou =>
                  if Echiquier(I,J).C = BLANC then
                     Mat(I)(J) := 'F' ;
                  else
                     Mat(I)(J) := 'f' ;
                  end if ;
               when Cavalier =>
                  if Echiquier(I,J).C = BLANC then
                     Mat(I)(J) := 'C' ;
                  else
                     Mat(I)(J) := 'c' ;
                  end if ;
               when Tour =>
                  if Echiquier(I,J).C = BLANC then
                     Mat(I)(J) := 'T' ;
                  else
                     Mat(I)(J) := 't' ;
                  end if ;
            end case ;

         end loop;
      end loop;
      return Mat;
   end Transposition_inverse;


   function Deplacement (Piece : details; Pos_Arrivee : Coordonnees ; Ech : T_Mat) return boolean is
      Vecteur : Coordonnees ;
      TempT : Boolean ; -- Variable Temporaire pour le deplacement de la tour ;
      TempF : Boolean ; -- Variable Temporaire pour le deplacement du fou ;
      TempD : Boolean ; -- Variable Temporaire pour le deplacement de la dame ;
      I,J : Integer;
   begin
      Vecteur := (Pos_arrivee.X - Piece.coord.X, Pos_arrivee.Y - Piece.coord.Y);
      if Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C /= Piece.C then
         case Piece.P is
            when Vide => return False ;
            when Pion =>
               if Piece.C = BLANC then
                  if Piece.coord.X = 2 then
                     if  Vecteur = (1,0) and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).P = Vide then
                        return True ;
                     elsif Vecteur = (2,0) And then Ech(Pos_Arrivee.X-1,Pos_Arrivee.Y).P = Vide and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).P = Vide then
                        return True ;
                     elsif Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C = NOIR and then (Vecteur =(1,1) or Vecteur = (1,-1)) then
                        return True ;
                     else
                        return False ;
                     end if ;
                  elsif Vecteur =(1,0) and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).P = Vide then
                     return True ;
                  elsif Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C = NOIR and then (Vecteur =(1,1) or Vecteur = (1,-1)) then
                     return True ;
                  else
                     return False ;
                  end if ;
               else
                  if Piece.coord.X = 7 then
                     if  Vecteur = (-1,0) and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).P = Vide then
                        return True ;
                     elsif Vecteur = (-2,0) and then Ech(Pos_Arrivee.X+1,Pos_Arrivee.Y).P = Vide and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).P = Vide then
                        return True ;
                     elsif Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C = BLANC and then (Vecteur =(-1,-1) or Vecteur = (-1,1)) then
                        return True ;
                     else
                        return False ;
                     end if ;
                  elsif Vecteur =(-1,0) and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).P = Vide then
                     return True ;
                  elsif Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C = BLANC and then (Vecteur =(-1,-1) or Vecteur = (-1,1)) then
                     return True ;
                  else
                     return False ;
                  end if ;
               end if ;

            when Cavalier =>
               if abs(Vecteur.X) = 1 and then abs(Vecteur.Y) = 2 then
                  return True ;
               elsif abs(Vecteur.X) = 2 and then abs(Vecteur.Y) = 1 then
                  return True ;
               else
                  return False ;
               end if ;

            when Fou =>
               TempF := True ;

               if Vecteur.X > 0 and then Vecteur.X = Vecteur.Y then
                  --le fou est en haut a gauche du roi
                  I:=Piece.Coord.X+1; J:=Piece.Coord.Y+1;
                  while I < Pos_Arrivee.X and J < Pos_Arrivee.Y loop
                     if Ech(I,J).P = Vide  then
                        TempF := TempF and True ;
                     else
                        TempF := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;

               elsif Vecteur.X > 0 and then Vecteur.X = -Vecteur.Y then
                  --le fou est en haut a droite du roi
                  I:=Piece.Coord.X+1; J:=Pos_Arrivee.Y+1;
                  while I < Pos_Arrivee.X and J < Piece.coord.Y loop

                     if Ech(I,-J+Pos_Arrivee.Y+Piece.coord.Y).P = Vide then
                        TempF := TempF and True ;
                     else
                        TempF := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;

               elsif Vecteur.X = Vecteur.Y then
                  --le fou est en bas a droite du roi
                  I:=Pos_Arrivee.X+1; J:=Pos_Arrivee.Y+1;
                  while I < Piece.Coord.X and J < Piece.coord.Y loop
                     if Ech(I,J).P = Vide  then
                        TempF := TempF and True ;
                     else
                        TempF := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;

               elsif Vecteur.X = -Vecteur.Y then
                  --le fou est en bas a gauche du roi
                  I:=Pos_Arrivee.X+1; J:=Piece.Coord.Y+1;
                  while I < Piece.Coord.X and J < Pos_Arrivee.Y loop
                     if Ech(-I+Pos_Arrivee.X+Piece.coord.X,J).P = Vide then
                        TempF := TempF and True ;
                     else
                        TempF := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;
               else
                  TempF := False ;
               end if ;

               return TempF ;


            when Tour =>
               Tempt := True ;
               if Vecteur.X = 0 then
                  if Pos_Arrivee.Y > Piece.Coord.Y then
                     for K in Piece.Coord.Y+1..Pos_Arrivee.Y-1 loop
                        if Ech(Piece.Coord.X,K).P = Vide then
                           Tempt := Tempt and True ;
                        else
                           Tempt := False ;
                        end if ;
                     end loop ;
                  elsif Pos_Arrivee.Y < Piece.Coord.Y then
                     for K in Pos_Arrivee.Y+1..Piece.Coord.Y-1 loop
                        if Ech(Piece.Coord.X,K).P = Vide then
                           Tempt := Tempt and True ;
                        else
                           Tempt := False ;
                        end if ;
                     end loop ;
		  else
		     Tempt := False ;
                  end if ;
               elsif Vecteur.Y = 0 then
                  if Pos_Arrivee.X > Piece.Coord.X then
                     for K in Piece.Coord.X+1..Pos_Arrivee.X-1 loop
                        if Ech(K,Piece.Coord.Y).P = Vide then
                           Tempt := Tempt and True ;
                        else
                           Tempt := False ;
                        end if ;
                     end loop ;
                  elsif Pos_Arrivee.X < Piece.Coord.X then
                     for K in Pos_Arrivee.X+1..Piece.Coord.X-1 loop
                        if Ech(K,Piece.Coord.Y).P = Vide then
                           Tempt := Tempt and True ;
                        else
                           Tempt := False ;
                        end if ;
                     end loop ;
		  else
		     Tempt := False ;
                  end if ;
               else
                  Tempt := False  ;
               end if ;
               return Tempt ;

            when Roi =>
               if abs(Vecteur.X) = 1 and then abs(Vecteur.Y) = 0 and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C /= Piece.C then
                  return True ;
               elsif abs(Vecteur.X) = 0 and then abs(Vecteur.Y) = 1 and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C /=Piece.C then
                  return True ;
               elsif abs(Vecteur.X) = 1 and then abs(Vecteur.Y) = 1 and then Ech(Pos_Arrivee.X,Pos_Arrivee.Y).C /=Piece.C  then
                  return True ;
               else
                  return False ;
               end if ;

            when Dame =>
               TempD := True ;
               if abs (Vecteur.X) = abs (Vecteur.Y) then -- cas du deplacement d'un fou

                  if Vecteur.X > 0 and then Vecteur.X = Vecteur.Y then
                     --le fou est en haut a gauche du roi
                     I:=Piece.Coord.X+1; J:=Piece.Coord.Y+1;
                     while I < Pos_Arrivee.X and J < Pos_Arrivee.Y loop
                        if Ech(I,J).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                        I:=I+1; J:=J+1;
                     end loop ;

                  elsif Vecteur.X > 0 and then Vecteur.X = -Vecteur.Y then
                     --le fou est en haut a droite du roi
                     I:=Piece.Coord.X+1; J:=Pos_Arrivee.Y+1;
                     while I < Pos_Arrivee.X and J < Piece.coord.Y loop

                        if Ech(I,-J+Pos_Arrivee.Y+Piece.coord.Y).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                        I:=I+1; J:=J+1;
                     end loop ;

                  elsif Vecteur.X = Vecteur.Y then
                     --le fou est en bas a droite du roi
                     I:=Pos_Arrivee.X+1; J:=Pos_Arrivee.Y+1;
                     while I < Piece.Coord.X and J < Piece.coord.Y loop
                        if Ech(I,J).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                        I:=I+1; J:=J+1;
                     end loop ;

                  elsif Vecteur.X = -Vecteur.Y then
                     --le fou est en bas a gauche du roi
                     I:=Pos_Arrivee.X+1; J:=Piece.Coord.Y+1;
                     while I < Piece.Coord.X and J < Pos_Arrivee.Y loop
                        if Ech(-I+Pos_Arrivee.X+Piece.coord.X,J).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                        I:=I+1; J:=J+1;
                     end loop ;
		  end if;
		  
		     
	     elsif Vecteur.X = 0  then -- Cas du deplacement de la tour
                  if Pos_Arrivee.Y > Piece.Coord.Y then
                     for K in Piece.Coord.Y+1..Pos_Arrivee.Y-1 loop
                        if Ech(Piece.Coord.X,K).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                     end loop ;
                  else
                     for K in Pos_Arrivee.Y+1..Piece.Coord.Y-1 loop
                        if Ech(Piece.Coord.X,K).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                     end loop ;
                  end if ;
               elsif Vecteur.Y = 0 then -- Cas du deplacement de la tour
                  if Pos_Arrivee.X > Piece.Coord.X then
                     for K in Piece.Coord.X+1..Pos_Arrivee.X-1 loop
                        if Ech(K,Piece.Coord.Y).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                     end loop ;
                  else
                     for K in Pos_Arrivee.X+1..Piece.Coord.X-1 loop
                        if Ech(K,Piece.Coord.Y).P = Vide then
                           TempD := TempD and True ;
                        else
                           TempD := False ;
                        end if ;
                     end loop ;
                  end if ;
               else
                  TempD := FALSE ;
               end if ;
               return TempD ;
         end case ;
      else
         return False ;
      end if ;
		     
		        

   end Deplacement;

   function Deplacement2 (Piece : details; Pos_Arrivee : Coordonnees ; Ech : T_Mat) return boolean is
      Vecteur : Coordonnees ;
      TempT : Boolean ; -- Variable Temporaire pour le deplacement de la tour ;
      TempF : Boolean ; -- Variable Temporaire pour le deplacement du fou ;
      TempD : Boolean ; -- Variable Temporaire pour le deplacement de la dame ;
      I : Integer ;
      J : Integer ;
   begin
      Vecteur := (Pos_arrivee.X - Piece.coord.x, Pos_arrivee.Y - Piece.coord.Y);
      case Piece.P is
         when Vide => return False ;
         when Pion =>
            if Piece.C = BLANC then
               If (Vecteur =(1,1) or Vecteur = (1,-1)) then
                  return True ;
               else
                  return False ;
               end if ;
            else
               if Vecteur =(-1,-1) or Vecteur = (-1,1) then
                  return True ;
               else
                  return False ;
               end if ;
            end if ;

         when Cavalier =>
            if abs(Vecteur.X) = 1 and then abs(Vecteur.Y) = 2 then
               return True ;
            elsif abs(Vecteur.X) = 2 and then abs(Vecteur.Y) = 1 then
               return True ;
            else
               return False ;
            end if ;

         when Fou =>
            TempF := True ;
            if Vecteur.X > 0 and then Vecteur.X = Vecteur.Y then
               --le fou est en haut a gauche du roi
               I:=Piece.Coord.X+1; J:=Piece.Coord.Y+1;
               while I < Pos_Arrivee.X and J < Pos_Arrivee.Y loop
                  if Ech(I,J).P = Vide or Ech(I,J).P = Roi then
                     TempF := TempF and True ;
                  else
                     TempF := False ;
                  end if ;
                  I:=I+1; J:=J+1;
               end loop ;

            elsif Vecteur.X > 0 and then Vecteur.X = -Vecteur.Y then
               --le fou est en haut a droite du roi
               I:=Piece.Coord.X+1; J:=Pos_Arrivee.Y+1;
               while I < Pos_Arrivee.X and J < Piece.coord.Y loop

                  if Ech(I,-J+Pos_Arrivee.Y+Piece.coord.Y).P = Vide or Ech(I,-J+Pos_Arrivee.Y+Piece.coord.Y).P = Roi then
                     TempF := TempF and True ;
                  else
                     TempF := False ;
                  end if ;
                  I:=I+1; J:=J+1;
               end loop ;

            elsif Vecteur.X = Vecteur.Y then
               --le fou est en bas a droite du roi
               I:=Pos_Arrivee.X+1; J:=Pos_Arrivee.Y+1;
               while I < Piece.Coord.X and J < Piece.coord.Y loop
                  if Ech(I,J).P = Vide or Ech(I,J).P = Roi then
                     TempF := TempF and True ;
                  else
                     TempF := False ;
                  end if ;
                  I:=I+1; J:=J+1;
               end loop ;

            elsif Vecteur.X = -Vecteur.Y then
               --le fou est en bas a gauche du roi
               I:=Pos_Arrivee.X+1; J:=Piece.Coord.Y+1;
               while I < Piece.Coord.X and J < Pos_Arrivee.Y loop
                  if Ech(-I+Pos_Arrivee.X+Piece.coord.X,J).P = Vide or Ech(-I+Pos_Arrivee.X+Piece.coord.X,J).P =Roi then
                     TempF := TempF and True ;
                  else
                     TempF := False ;
                  end if ;
                  I:=I+1; J:=J+1;
               end loop ;

            else
               TempF := False ;
            end if ;

            return TempF ;

         when Tour =>
            Tempt := True ;
            if Vecteur.X = 0 then
               if Pos_Arrivee.Y > Piece.Coord.Y then
                  for K in Piece.Coord.Y+1..Pos_Arrivee.Y-1 loop
                     if Ech(Piece.Coord.X,K).P = Vide or Ech(Piece.Coord.X,K).P =Roi then
                        Tempt := Tempt and True ;
                     else
                        Tempt := False ;
                     end if ;
                  end loop ;
               elsif Pos_Arrivee.Y < Piece.Coord.Y then
                  for K in Pos_Arrivee.Y+1..Piece.Coord.Y-1 loop
                     if Ech(Piece.Coord.X,K).P = Vide or Ech(Piece.Coord.X,K).P =Roi then
                        Tempt := Tempt and True ;
                     else
                        Tempt := False ;
                     end if ;
                  end loop ;
	       else
		  Tempt := False ;
               end if ;
            elsif Vecteur.Y = 0 then
               if Pos_Arrivee.X > Piece.Coord.X then
                  for K in Piece.Coord.X+1..Pos_Arrivee.X-1 loop
                     if Ech(K,Piece.Coord.Y).P = Vide or Ech(K,Piece.Coord.Y).P =Roi then
                        Tempt := Tempt and True ;
                     else
                        Tempt := False ;
                     end if ;
                  end loop ;
               elsif Pos_Arrivee.X < Piece.Coord.X then
                  for K in Pos_Arrivee.X+1..Piece.Coord.X-1 loop
                     if Ech(K,Piece.Coord.Y).P = Vide or Ech(K,Piece.Coord.Y).P =Roi then
                        Tempt := Tempt and True ;
                     else
                        Tempt := False ;
                     end if ;
                  end loop ;
	       else
		  TempT := False;
               end if ;
            else
               Tempt := False  ;
            end if ;
            return Tempt ;

         when Roi =>
            if abs(Vecteur.X) = 1 and then abs(Vecteur.Y) = 0 then
               return True ;
            elsif abs(Vecteur.X) = 0 and then abs(Vecteur.Y) = 1 then
               return True ;
            elsif abs(Vecteur.X) = 1 and then abs(Vecteur.Y) = 1  then
               return True ;
            else
               return False ;
            end if ;

         when Dame =>
            TempD := True ;
            if abs (Vecteur.X) = abs (Vecteur.Y) then -- cas du deplacement d'un fou

               if Vecteur.X > 0 and then Vecteur.X = Vecteur.Y then
                  --le fou est en haut a gauche du roi
                  I:=Piece.Coord.X+1; J:=Piece.Coord.Y+1;
                  while I < Pos_Arrivee.X and J < Pos_Arrivee.Y loop
                     if Ech(I,J).P = Vide or Ech(I,J).P = Roi then
                        TempD := TempD and True ;
                     else
                        TempD := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;

               elsif Vecteur.X > 0 and then Vecteur.X = -Vecteur.Y then
                  --le fou est en haut a droite du roi
                  I:=Piece.Coord.X+1; J:=Pos_Arrivee.Y+1;
                  while I < Pos_Arrivee.X and J < Piece.coord.Y loop

                     if Ech(I,-J+Pos_Arrivee.Y+Piece.coord.Y).P = Vide or Ech(I,-J+Pos_Arrivee.Y+Piece.coord.Y).P = Roi then
                        TempD := TempD and True ;
                     else
                        TempD := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;

               elsif Vecteur.X = Vecteur.Y then
                  --le fou est en bas a droite du roi
                  I:=Pos_Arrivee.X+1; J:=Pos_Arrivee.Y+1;
                  while I < Piece.Coord.X and J < Piece.coord.Y loop
                     if Ech(I,J).P = Vide or Ech(I,J).P = Roi then
                        TempD := TempD and True ;
                     else
                        TempD := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;

               elsif Vecteur.X = -Vecteur.Y then
                  --le fou est en bas a gauche du roi
                  I:=Pos_Arrivee.X+1; J:=Piece.Coord.Y+1;
                  while I < Piece.Coord.X and J < Pos_Arrivee.Y loop
                     if Ech(-I+Pos_Arrivee.X+Piece.coord.X,J).P = Vide or Ech(-I+Pos_Arrivee.X+Piece.coord.X,J).P =Roi then
                        TempD := TempD and True ;
                     else
                        TempD := False ;
                     end if ;
                     I:=I+1; J:=J+1;
                  end loop ;
               end if;

	    elsif Vecteur.X = 0  then -- Cas du deplacement de la tour en ligne
	       if Pos_Arrivee.Y > Piece.Coord.Y then
		  for K in Piece.Coord.Y+1..Pos_Arrivee.Y-1 loop
		     if Ech(Piece.Coord.X,K).P = Vide or Ech(Piece.Coord.X,K).P = Roi then
			TempD := TempD and True ;
		     else
			TempD := False ;
		     end if ;
		  end loop ;
	       elsif Pos_Arrivee.Y < Piece.Coord.Y then
		  for K in Pos_Arrivee.Y+1..Piece.Coord.Y-1 loop
		     if Ech(Piece.Coord.X,K).P = Vide or Ech(Piece.Coord.X,K).P = Roi then
			TempD := TempD and True ;
		     else
			TempD := False ;
		     end if ;
		  end loop ;
	       else 
		  TempD := False ; 
	       end if ;
	    elsif Vecteur.Y = 0 then -- Cas du deplacement de la tour en colonne
	       if Pos_Arrivee.X > Piece.Coord.X then
		  for K in Piece.Coord.X+1..Pos_Arrivee.X-1 loop
		     if Ech(K,Piece.Coord.Y).P = Vide or Ech(K,Piece.Coord.Y).P = Roi then
			TempD := TempD and True ;
		     else
			TempD := False ;
		     end if ;
		  end loop ;
	       elsif Pos_Arrivee.X < Piece.Coord.X then
		  for K in Pos_Arrivee.X+1..Piece.Coord.X-1 loop
		     if Ech(K,Piece.Coord.Y).P = Vide or Ech(K,Piece.Coord.Y).P = Roi  then
			TempD := TempD and True ;
		     else
			TempD := False ;
		     end if ;
		  end loop ;
	       else 
		  TempD := False ; 
	       end if ;
	    else
	       TempD := FALSE ;
	    end if ;
	    return TempD ;
      end case ;





   end Deplacement2;


end Pieces_package;
