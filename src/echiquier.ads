package Echiquier is

   Caractere_Inconnu : exception ;
   --type Lettres is ('P','p','R','r','D','d','F','f','T','t','C','c');
   --type T_Mat_user is array(1..8,1..8) of Lettres ;
   type T_Mat_user is array(1..8) of String(1..8);

   function Generer return T_Mat_user ;
   function Generer_Repertoire(N:Natural) return T_Mat_user ;
   procedure Afficher(Echiquier : T_Mat_User) ;

end Echiquier ;
