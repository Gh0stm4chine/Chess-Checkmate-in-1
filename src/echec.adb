with Ada.Text_IO, Ada.Integer_Text_Io ;
use Ada.Text_IO, Ada.Integer_Text_Io;

package body echec is

   function Pos_Roi(Ech : T_Mat; C : Couleur) return Coordonnees is
      Trouve : Boolean :=False ;
      I : Integer :=1;
      J : Integer := 1;
   begin
      While I <= 8 and Not(Trouve) loop
         J :=1 ;
         While J <= 8 and Not(Trouve) loop
            if Ech(I,J).P=Roi and Ech(I,J).C=C then
               Trouve := True;
            else
               J:=J+1;
            end if;
         end loop ;
         I:=I+1;
      end loop;
      return (I-1,J);
   end Pos_Roi;

   Procedure Detecte_Echec(P1: in Details ; Pos_Roi : in Coordonnees ; Coord : in Coordonnees; Ech : T_Mat; Echec : out Boolean; Piece_Attaquant : out Details ; Ech_Inter : out T_mat) is

   begin
      if Deplacement(P1,Coord,Ech) then

         if Deplacement ((P1.P,P1.C,Coord),(Pos_Roi), Ech) then
            Echec := True;
            Piece_Attaquant := (P1.P,P1.C,Coord);
            Ech_Inter:=Ech;
            Ech_Inter(Coord.X,Coord.y):= (P1.P,P1.C,Coord);
            Ech_Inter(P1.Coord.X,P1.Coord.y):=(Vide, Vide, P1.Coord);
	 
	   
         else
            Echec := False;
         end if;
      else
         Echec := False;
      end if;
   end Detecte_Echec;

   function Roi_Pas_Immobilise (Pos_Roi : in Coordonnees; Couleur_Attaquant : Couleur; Ech_Inter : in T_Mat) return Boolean is
      Roi_Non_Immobilise : boolean := false;


      I : Integer :=1;
      J : integer :=1;
      N: Integer :=1;
      E: Integer :=1;
   begin
      if Pos_Roi.X < 8 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X+1,Pos_Roi.Y),Ech_Inter) then

         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  if Deplacement2(Ech_Inter(I,J),(Pos_Roi.X+1,Pos_Roi.Y),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               end if ;

               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ;
            --Put("1cas"); New_Line;
         End if;
      End if;
      I:=1;N:=1;E:=1;

      if not Roi_Non_Immobilise and then Pos_Roi.X>1 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X-1,Pos_Roi.Y),Ech_Inter) then

         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  if Deplacement2(Ech_Inter(I,J),(Pos_Roi.X-1,Pos_Roi.Y),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               end if ;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("2cas"); New_Line;
         End if;
      End if;
      I:=1;N:=1;E:=1;

      if not Roi_Non_Immobilise and then Pos_Roi.X<8 and then Pos_Roi.Y<8 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X+1,Pos_Roi.Y+1),Ech_Inter) then
        
         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  if Deplacement2 (Ech_Inter(I,J),(Pos_Roi.X+1,Pos_Roi.Y+1),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               end if;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("3cas"); New_Line;
         End if;

      end if;
      I:=1; N:=1;E:=1;

      if not Roi_Non_Immobilise and then Pos_Roi.X>1 and then Pos_Roi.Y<8 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X-1,Pos_Roi.Y+1),Ech_Inter) then


         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  If Deplacement2 (Ech_Inter(I,J),(Pos_Roi.X-1,Pos_Roi.Y+1),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1 ;
                  end if;
               End if;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("4cas"); New_Line;
         End if;

      end if;
      I:=1;N:=1;E:=1;

      if not Roi_Non_Immobilise and then Pos_Roi.X<8 and then Pos_Roi.Y>1 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X+1,Pos_Roi.Y-1),Ech_Inter) then

         
         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  If Deplacement2 (Ech_Inter(I,J),(Pos_Roi.X-1,Pos_Roi.Y-1),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               End if;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("5cas"); New_Line;
         End if;

      end if;
      I:=1;N:=1;E:=1;

      if not Roi_Non_Immobilise and then Pos_Roi.Y<8 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X,Pos_Roi.Y+1),Ech_Inter) then

         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;	    
                  if Deplacement2 (Ech_Inter(I,J),(Pos_Roi.X,Pos_Roi.Y+1),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               End if;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("6cas"); New_Line;
         End if;

      end if;
      I:=1;N:=1; E:=1;

      if  not Roi_Non_Immobilise and then Pos_Roi.Y>1 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X,Pos_Roi.Y-1),Ech_Inter) then

      
         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  if Deplacement2 (Ech_Inter(I,J),(Pos_Roi.X,Pos_Roi.Y-1),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               End if;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("7cas"); New_Line;
         End if;
      end if;
      I:=1;N:=1;E:=1;

      if not Roi_Non_Immobilise and then Pos_Roi.X>1 and then Pos_Roi.Y>1 and then Deplacement (Ech_Inter(Pos_Roi.X,Pos_Roi.Y),(Pos_Roi.X-1,Pos_Roi.Y-1),Ech_Inter) then

         --Ech_Inter2(Pos_Roi.X-1,Pos_Roi.Y-1):=(Vide,Vide,(Pos_Roi.X-1,Pos_Roi.Y-1));
         While I <= 8 and not Roi_Non_Immobilise loop
            J:=1;
            While J <= 8 and not Roi_Non_Immobilise loop
               If Ech_Inter(I,J).C=Couleur_Attaquant then
                  N:=N+1;
                  If Deplacement2 (Ech_Inter(I,J),(Pos_Roi.X-1,Pos_Roi.Y-1),Ech_Inter) then
                     Roi_Non_Immobilise := False or Roi_Non_Immobilise ;
                  else
                     E:=E+1;
                  end if;
               End if;
               J:=J+1;
            end loop;
            I:=I+1;
         end loop;
         if N=E then
            Roi_Non_Immobilise := True ; --Put("8cas"); New_Line;
         End if;
      end if;

      return Roi_Non_Immobilise;
   end Roi_Pas_Immobilise;


   function Contre_Echec(P2 : in Details ; Piece_attaquant : in Details ; Piece_Qui_bouge : in Details; Pos_Roi : in Coordonnees; Ech_inter: in T_Mat) return Boolean is
      A : Boolean := False;
      Vecteur : Coordonnees ;
      Ech_Inter2 : T_Mat := Ech_Inter;
      B : Boolean := True ;
      I : Integer :=1;
      J : Integer :=1;
   begin
      Vecteur := (Pos_Roi.X - Piece_attaquant.coord.x, Pos_Roi.Y - Piece_attaquant.Coord.Y);
      if Deplacement(P2,Piece_Attaquant.coord,Ech_inter) then
         Ech_Inter2(Piece_Attaquant.Coord.X,Piece_attaquant.Coord.Y):= (P2.P,P2.C,(Piece_Attaquant.Coord.X,Piece_attaquant.Coord.Y));
	 Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
	 while I <= 8 and then B loop
	    J:=1;
	    while J <= 8 loop
	       If Ech_inter2(I,J).C = Piece_Attaquant.C then
		  if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
		     B := False ;
		  else
		     B := True and B;
		  end if;
	       end if ;
	       J:=J+1;
	    end loop;
	    I:=I+1;
	 end loop;
	 return B ;
      else
         case Piece_attaquant.p is
            when Cavalier => return False ;
            when Pion => return False ;
            when Tour =>
               if Piece_attaquant.Coord.X = Pos_Roi.X then
                  if Piece_attaquant.Coord.Y > Pos_Roi.Y then
                     for K in Pos_Roi.Y+1..Piece_attaquant.Coord.Y-1 loop
                        if Deplacement (P2,(Pos_Roi.X,K), Ech_Inter) and B then
			   Ech_Inter2(Pos_Roi.X,K):= (P2.P,P2.C,(Pos_Roi.X,K));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
			   while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
			   
			else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  else
                     for K in Piece_attaquant.Coord.Y+1..Pos_Roi.Y-1 loop
                        if Deplacement (P2,(Pos_Roi.X,K), Ech_Inter) then
			   Ech_Inter2(Pos_Roi.X,K):= (P2.P,P2.C,(Pos_Roi.X,K));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  end if;
               Elsif Piece_attaquant.Coord.Y = Pos_Roi.Y then
                  if Piece_attaquant.Coord.X > Pos_Roi.X then
                     for K in Pos_Roi.X+1..Piece_attaquant.Coord.X-1 loop
                        if Deplacement (P2,(K,Pos_Roi.Y), Ech_Inter) then
			   Ech_Inter2(K,Pos_Roi.Y):= (P2.P,P2.C,(K,Pos_Roi.Y));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  else
                     for K in Piece_attaquant.Coord.X+1..Pos_Roi.X-1 loop
                        if Deplacement (P2,(K,Pos_Roi.Y), Ech_Inter) then
			   Ech_Inter2(K,Pos_Roi.Y):= (P2.P,P2.C,(K,Pos_Roi.Y));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  end if;
               else
                  return False ;
               end if;

            when Fou =>
               if Vecteur.X > 0 and then Vecteur.X = Vecteur.Y then
                  for K in Piece_attaquant.Coord.X+1..Pos_Roi.X-1 loop
                     for M in Piece_attaquant.Coord.Y+1..Pos_Roi.Y-1 loop
                        if Deplacement(P2,(K,M),Ech_Inter) then
			   Ech_Inter2(K,M):= (P2.P,P2.C,(K,M));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A := False or A ;
                        end if ;
                     end loop ;
                  end loop ;
                  return A ;
               elsif Vecteur.X > 0 and then Vecteur.X = -Vecteur.Y then
                  for K in Piece_attaquant.Coord.X+1..Pos_Roi.X-1 loop
                     for M in Pos_Roi.Y+1..Piece_attaquant.Coord.Y-1 loop
			if Deplacement(P2,(K,-M+Pos_Roi.Y+Piece_attaquant.coord.Y),Ech_Inter) then
			Ech_Inter2(K,-M+Pos_Roi.Y+Piece_attaquant.coord.Y):= (P2.P,P2.C,(K,-M+Pos_Roi.Y+Piece_attaquant.coord.Y));
			Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A := False or A ;
                        end if ;
                     end loop ;
                  end loop ;
                  return A ;
               elsif Vecteur.X = Vecteur.Y then
                  for K in Pos_Roi.X+1..Piece_attaquant.Coord.X-1 loop
                     for M in Pos_Roi.Y+1..Piece_attaquant.Coord.Y-1 loop
                        if Deplacement(P2,(-K+Pos_Roi.X+Piece_attaquant.coord.X,M),Ech_Inter) then
			   Ech_Inter2(-K+Pos_Roi.X+Piece_attaquant.coord.X,M):= (P2.P,P2.C,(-K+Pos_Roi.X+Piece_attaquant.coord.X,M));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A := False or A ;
                        end if ;
                     end loop ;
                  end loop ;
                  return A ;
               elsif Vecteur.X = -Vecteur.Y then
                  for K in Pos_Roi.X+1..Piece_attaquant.Coord.X-1 loop
                     for M in Piece_attaquant.Coord.Y+1..Pos_Roi.Y-1 loop
                        if Deplacement(P2,(K,M),Ech_Inter) then
			   Ech_Inter2(K,M):= (P2.P,P2.C,(K,M));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A := False or A ;
                        end if ;
                     end loop ;
                  end loop ;
                  return A ;
               else
                  return False;
               end if;

            when Dame =>
               --si la dame met en echec le roi en étant sur la meme ligne ou colonne que le roi
               if Piece_attaquant.Coord.X = Pos_Roi.X then
                  if Piece_attaquant.Coord.Y > Pos_Roi.Y then
                     for K in Pos_Roi.Y+1..Piece_attaquant.Coord.Y-1 loop
                        if Deplacement (P2,(Pos_Roi.X,K), Ech_Inter) then
			   Ech_Inter2(Pos_Roi.X,K):= (P2.P,P2.C,(Pos_Roi.X,K));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  else
                     for K in Piece_attaquant.Coord.Y+1..Pos_Roi.Y-1 loop
                        if Deplacement (P2,(Pos_Roi.X,K), Ech_Inter) then
			   Ech_Inter2(Pos_Roi.X,K):=  (P2.P,P2.C,(Pos_Roi.X,K));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  end if;
               Elsif Piece_attaquant.Coord.Y = Pos_Roi.Y then
                  if Piece_attaquant.Coord.X > Pos_Roi.X then
                     for K in Pos_Roi.X+1..Piece_Attaquant.Coord.X-1 loop
			Ech_Inter2(K,Pos_Roi.Y):=  (P2.P,P2.C,(K,Pos_Roi.Y));
			Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                        if Deplacement (P2,(K,Pos_Roi.Y), Ech_Inter) then
                           while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  else
                     for K in Piece_attaquant.Coord.X+1..Pos_Roi.X-1 loop
                        if Deplacement (P2,(I,Pos_Roi.Y), Ech_Inter) then
			   Ech_Inter2(K,Pos_Roi.Y):= (P2.P,P2.C,(K,Pos_Roi.Y));
			   Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
			   while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                        else
                           A:=False or A ;
                        end if;
                     end loop;
                     return A ;
                  end if;

                  --si la dame met en echec le roi en étant en diagonale par rapport au roi
                  if Vecteur.X > 0 and then Vecteur.X = Vecteur.Y then
                     for K in Piece_attaquant.Coord.X+1..Pos_Roi.X-1 loop
                        for M in Piece_attaquant.Coord.Y+1..Pos_Roi.Y-1 loop
                           if Deplacement(P2,(K,M),Ech_Inter) then
			      Ech_Inter2(K,M):= (P2.P,P2.C,(K,M));
			      Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                              while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                           else
                              A := False or A ;
                           end if ;
                        end loop ;
                     end loop ;
                     return A ;
                  elsif Vecteur.X > 0 and then Vecteur.X = -Vecteur.Y then
                     for K in Piece_attaquant.Coord.X+1..Pos_Roi.X-1 loop
                        for M in Pos_Roi.Y+1..Piece_attaquant.Coord.Y-1 loop
                           if Deplacement(P2,(K,-M+Pos_Roi.Y+Piece_attaquant.coord.Y),Ech_Inter) then
			      Ech_Inter2(K,-M+Pos_Roi.Y+Piece_attaquant.coord.Y):= (P2.P,P2.C,(K,-M+Pos_Roi.Y+Piece_attaquant.coord.Y));
			      Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                              while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                           else
                              A := False or A ;
                           end if ;
                        end loop ;
                     end loop ;
                     return A ;
                  elsif Vecteur.X = Vecteur.Y then
                     for K in Pos_Roi.X+1..Piece_attaquant.Coord.X-1 loop
                        for M in Pos_Roi.Y+1..Piece_attaquant.Coord.Y-1 loop
                           if Deplacement(P2,(-K+Pos_Roi.X+Piece_attaquant.coord.X,M),Ech_Inter) then
			      Ech_Inter2(-K+Pos_Roi.X+Piece_attaquant.coord.X,M):= (P2.P,P2.C,(-K+Pos_Roi.X+Piece_attaquant.coord.X,M));
			      Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
			      while I <= 8 and then B loop
				 J:=1;
				 while J <= 8 loop
				    If Ech_inter2(I,J).C = Piece_Attaquant.C then
				       if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
					  B := False ;
				       else
					  B := True and B;
				       end if;
				    end if ;
				    J:=J+1;
				 end loop;
				 I:=I+1;
			      end loop; 

			      if B then
				 A:=True ;
			      end if;
                           else
                              A := False or A ;
                           end if ;
                        end loop ;
                     end loop ;
                     return A ;
                  elsif Vecteur.X = -Vecteur.Y then
                     for K in Pos_Roi.X+1..Piece_attaquant.Coord.X-1 loop
                        for M in Piece_attaquant.Coord.Y+1..Pos_Roi.Y-1 loop
                           if Deplacement(P2,(K,M),Ech_Inter) then
			      Ech_Inter2(K,M):= (P2.P,P2.C,(K,M));
			      Ech_Inter2(P2.Coord.X,P2.Coord.Y):=(Vide,Vide,P2.Coord);
                              while I <= 8 and then B loop
			      J:=1;
			      while J <= 8 loop
				 If Ech_inter2(I,J).C = Piece_Attaquant.C then
				    if Deplacement (Ech_inter2(I,J),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter2) then
				       B := False ;
				    else
				       B := True and B;
				    end if;
				 end if ;
				 J:=J+1;
			      end loop;
			      I:=I+1;
			   end loop; 

                           if B then
			   A:=True ;
			   end if;
                           else
                              A := False or A ;
                           end if ;
                        end loop ;
                     end loop ;
                     return A ;
                  end if;
               else
                  return False;
               end if;


            when others => return False ;
         end case;
      end if;
   end contre_Echec ;


   
   
   
   
   
   function Echec_Et_Mat (Pos_Roi : Coordonnees; Couleur_Attaquant : Couleur; Piece_Attaquant_F : Details; Piece_Qui_Bouge_F : Details; Ech_Inter : T_Mat) return Boolean is 
      M: Integer :=1;
      N:Integer:=1;
      Mat : Boolean := False;
      Contre_Mat:Boolean:=False;
   begin
      If not (Roi_Pas_Immobilise(Pos_Roi, Couleur_Attaquant, Ech_Inter)) then
	 
	 --le roi ne peut pas se defendre de l'echec
	 -- les autres pieces de l'echiquier peuvent elles defendrent defendre le roi ?
	 M:=1;
	 While M <= 8 and not Contre_Mat loop
	    N:=1;
	    While N <= 8 and not Contre_Mat loop
	       If Ech_Inter(M,N).C=Ech_Inter(Pos_Roi.X,Pos_Roi.Y).C and then not(Ech_Inter(M,N)=Ech_Inter(Pos_Roi.X,Pos_Roi.Y))then -- si les pieces sont dans le camp du roi
		  Contre_Mat := Contre_Echec(Ech_Inter(M,N), Piece_Attaquant_F, Piece_Qui_Bouge_F,  Pos_Roi, Ech_Inter);
	       end if;
	       N:=N+1;
	    end loop;
	    M:=M+1;
	 end loop;
	 --si aucune piece présente sur l'echiquier ne peut defendre le roi
	 If not Contre_Mat then
	    Mat := True ; -- alors il y a echec et mat
	 end if;
	 Contre_Mat:=False;
      end If;
      return Mat;
   end Echec_Et_Mat;
   
   
  
      
      
      
   
   
  
        Procedure Echec_Et_Mat(Ech : in T_Mat; Pos_Roi : in Coordonnees; Couleur_Attaquant : Couleur; Piece_Qui_bouge_D : out Details; Piece_Qui_Bouge_F : Out Details; Mat : out Boolean; Ech_Final : out T_Mat ) is

      Contre_Mat : boolean := False;
      I : integer := 1 ;
      J : integer := 1 ;
      K : integer := 1 ;
      L : integer := 1 ;
      M : integer := 1 ;
      N : integer := 1 ;
      O : Integer := 1 ;
      P : Integer :=1 ;
      Echec : boolean;
      Ech_Inter : T_Mat;
      Piece_Attaquant_F : Details;
      
   begin
      Mat :=False;
      --pour toutes les pieces qui peuvent attaquer
      While I <= 8 and not Mat loop
         J:=1;
         While J <= 8 and not Mat loop
            If Ech(I,J).C = Couleur_Attaquant then
               K:=1;
               
	       --pour tous les endroit ou ils peuvent aller
               While K <= 8 and not Mat loop
                  L:=1;
                  While L <=8 and not Mat loop
                     --est ce que la piece qui bouge met le roi en echec ?
                     Detecte_Echec(Ech(I,J), Pos_Roi, (K,L), Ech, Echec, Piece_Attaquant_F, Ech_Inter) ;
                     
		     --si oui alors
                     If Echec then
			
			Put(I);Put(J); New_Line ;
                        Piece_Qui_Bouge_D:=Ech(I,J);
			Piece_Qui_Bouge_F:=Piece_Attaquant_F; --la pice qui bouge est celle qui met echec le roi
			
			Mat:=Echec_Et_Mat(Pos_Roi,Couleur_Attaquant, Piece_Attaquant_F, Piece_Qui_Bouge_F, Ech_Inter);
			if Mat then
			   Ech_Final:=Ech_Inter;
			end if;
	
		     else
		
			-- si la piece ne met pas echec le roi en allant en (K,L), est ce qu'une autre piece le met en echec ?
			if Deplacement (Ech(I,J),(K,L),Ech) then
			   Piece_Qui_bouge_D:=Ech(I,J);	
			   Ech_Inter := Ech ;
			   Ech_Inter(K,L):=(Ech_Inter(I,J).P,Ech_Inter(I,J).C,(K,L))  ;
			   Ech_Inter(I,J):=(Vide,Vide,(I,J));
			   Piece_Qui_bouge_F:=Ech(K,L);	
			   -- pour toutes les pieces qui attaquent y a il echec		 
			   o:=1;
			   while o <= 8 and not mat loop
			      p:=1;
			      while p <= 8 and not Mat loop
				  If Ech(o,p).C = Piece_Qui_bouge_D.C then
				    
				    if Deplacement (Ech_inter(o,p),(Pos_Roi.X,Pos_Roi.Y),Ech_Inter) then
				     
				       Piece_Attaquant_F:=Ech_inter(o,p);
				       
				       --Le roi est il immobile ?
				       
				       	Mat:=Echec_Et_Mat(Pos_Roi,Couleur_Attaquant, Piece_Attaquant_F, Piece_Qui_Bouge_F, Ech_Inter);
			if Mat then
			   Ech_Final:=Ech_Inter;
			end if;
				       
				      
				    end if;
				 end if ;
				 p:=p+1;
			      end loop;
			      o:=o+1;
			   end loop;
			end if;
			
		     end If;
                     L:=L+1;
                  end loop;
                  K:=K+1;
               end Loop;
            End If;
            J:=J+1;
         end loop;
         I:=I+1;
      end loop;

   end Echec_Et_Mat ;
      
      
end Echec ;
