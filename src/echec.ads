with Echiquier, Pieces_package ;
use Echiquier, Pieces_package ;

package Echec is 
   
      function Pos_Roi(Ech: T_Mat; C : Couleur) return Coordonnees ;    --Renvoie les coordonnes du roi adverse
   
      Procedure Detecte_echec(P1: in Details ; Pos_Roi : in Coordonnees ; Coord : in Coordonnees; Ech : T_Mat; Echec : out Boolean; Piece_Attaquant : out Details ; Ech_Inter : out T_mat) ;
   -- Detecte si la piece 1 peut faire echec
      
      function Roi_Pas_Immobilise (Pos_Roi : in Coordonnees; Couleur_Attaquant : Couleur; Ech_Inter : in  T_Mat) return Boolean; 
      
    function Contre_Echec(P2 : in Details ; Piece_Attaquant : in Details ; Piece_Qui_bouge : in Details; Pos_Roi : in Coordonnees; Ech_inter: in T_Mat) return Boolean; -- Detecte si la piece 2 peut contrer l'echec de la piece 1 
   
   Procedure Echec_Et_Mat(Ech : in T_Mat; Pos_Roi : in Coordonnees; Couleur_Attaquant : Couleur;  Piece_Qui_Bouge_D : out Details; Piece_Qui_Bouge_F : out Details; Mat : out Boolean; Ech_Final : out T_Mat) ; -- Si echec et mat renvoie les détails de la piece(Couleur,coordonnee) sinon renvoie Faux 
    
   
end Echec ; 
