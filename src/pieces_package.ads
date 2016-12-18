with Echiquier; use Echiquier; 

package Pieces_package is 
   
   
   type Couleur is (Noir,Blanc,Vide);
    
   type Pieces is (Roi,Dame,Tour,Fou,Cavalier,Pion,Vide);
   
   type Coordonnees is record
      X : Integer ;
      Y : Integer ;
   end record ;

   type details is record
      P : Pieces ;
      C : Couleur ;
      Coord : Coordonnees ;
   end record ;
   Type T_Mat is array(1..8,1..8) of Details;
   function Deplacement  (Piece : details; Pos_Arrivee : Coordonnees ; Ech : T_Mat ) return boolean ;
   
   function Deplacement2  (Piece : details; Pos_Arrivee : Coordonnees ; Ech : T_Mat ) return boolean ;
   
   function Attribution (Pos : Coordonnees; Echiquier : T_Mat_User) return Details;
   
   function Transposition (Echiquier : T_Mat_User) return T_Mat;
   function Transposition_inverse (Echiquier : T_Mat) return T_Mat_user;
   
end Pieces_package ;
