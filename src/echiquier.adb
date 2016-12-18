with Ada.Integer_Text_Io ;
with Ada.Text_Io ;
With Echiquier ;
use Ada.Text_Io;
use Ada.Integer_Text_Io;


package body Echiquier is
function Generer return T_Mat_user is
   Echiquier : T_Mat_user ;
begin
   --Echiquier := (others => (others => " * "));
   Put("Rentrez ligne par ligne et appuyez sur entree tous les 8 caracteres :");New_Line ;
         for I in Echiquier'Range loop
            Get(Echiquier(I)); Skip_Line ;
            New_Line ;
         end loop ;
         return Echiquier ;
end generer ;

function Generer_Repertoire(N : Natural) return T_Mat_user is
   Echiquier : T_Mat_User ;
begin
   case N is
      when 1 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := 'R';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := '.';Echiquier(1)(7) := 'F';Echiquier(1)(8) := 't';
         Echiquier(2)(1) := 'P';Echiquier(2)(2) := 'P';Echiquier(2)(3) := 'P';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := 'T';Echiquier(2)(7) := '.';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := '.';Echiquier(3)(2) := '.';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := '.';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := '.';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := 'p';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := '.';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := 'p';Echiquier(7)(3) := 'p';Echiquier(7)(4) := 'T';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := 't';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := '.';Echiquier(8)(2) := 'r';Echiquier(8)(3) := '.';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := '.';Echiquier(8)(7) := '.';Echiquier(8)(8) := '.';
      when 2 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := '.';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := '.';Echiquier(2)(3) := '.';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := 'R';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := 'T';Echiquier(3)(2) := '.';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := 'P';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := 'F';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := 'C';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := '.';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := 'p';Echiquier(7)(2) := 'p';Echiquier(7)(3) := '.';Echiquier(7)(4) := '.';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := 't';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := 'r';Echiquier(8)(2) := '.';Echiquier(8)(3) := '.';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := 't';Echiquier(8)(7) := '.';Echiquier(8)(8) := '.';
       when 3 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := 'T';Echiquier(1)(6) := '.';Echiquier(1)(7) := '.';Echiquier(1)(8) := 'T';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := 'R';Echiquier(2)(3) := '.';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := 'P';Echiquier(3)(2) := '.';Echiquier(3)(3) := 'P';Echiquier(3)(4) := 'D';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := '.';Echiquier(3)(8) := 'F';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := 'P';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := 'P';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := 'C';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := 'p';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := 'p';Echiquier(6)(7) := '.';Echiquier(6)(8) := 'p';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := '.';Echiquier(7)(3) := 'p';Echiquier(7)(4) := '.';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := '.';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := 't';Echiquier(8)(2) := 'd';Echiquier(8)(3) := '.';Echiquier(8)(4) := 'r';Echiquier(8)(5) := '.';Echiquier(8)(6) := '.';Echiquier(8)(7) := 't';Echiquier(8)(8) := '.';
	 
      when 4 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := 'R';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := 'T';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := 'P';Echiquier(2)(3) := 'P';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := 'P';Echiquier(3)(2) := 'T';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := 'F';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := 'P';Echiquier(4)(6) := '.';Echiquier(4)(7) := 'D';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := 'C';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := 'p';Echiquier(6)(2) := 'p';Echiquier(6)(3) := 'P';Echiquier(6)(4) := 'C';Echiquier(6)(5) := '.';Echiquier(6)(6) := 'p';Echiquier(6)(7) := '.';Echiquier(6)(8) := 'p';
         Echiquier(7)(1) := 'f';Echiquier(7)(2) := '.';Echiquier(7)(3) := '.';Echiquier(7)(4) := 'c';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := 'p';Echiquier(7)(8) := 't';
         Echiquier(8)(1) := 't';Echiquier(8)(2) := 'r';Echiquier(8)(3) := '.';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := 'd';Echiquier(8)(7) := '.';Echiquier(8)(8) := '.';
       when 5 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := 'T';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := '.';Echiquier(2)(3) := 'R';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := 'P';
         Echiquier(3)(1) := '.';Echiquier(3)(2) := 'P';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := 'P';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := 'F';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := '.';Echiquier(5)(5) := 'f';Echiquier(5)(6) := 'C';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := 'D';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := 'f';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := 'c';Echiquier(7)(3) := 'P';Echiquier(7)(4) := 'p';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := '.';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := '.';Echiquier(8)(2) := '.';Echiquier(8)(3) := 'r';Echiquier(8)(4) := '.';Echiquier(8)(5) := 't';Echiquier(8)(6) := '.';Echiquier(8)(7) := '.';Echiquier(8)(8) := 'T';
      when 6 =>
         Echiquier(1)(1) := 'T';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := 'R';Echiquier(1)(6) := 'T';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := 'P';Echiquier(2)(3) := 'C';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := 'P';
         Echiquier(3)(1) := 'P';Echiquier(3)(2) := 'D';Echiquier(3)(3) := 'P';Echiquier(3)(4) := '.';Echiquier(3)(5) := 'P';Echiquier(3)(6) := '.';Echiquier(3)(7) := 'P';Echiquier(3)(8) := 'F';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := 'P';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := 'F';Echiquier(5)(2) := '.';Echiquier(5)(3) := 'C';Echiquier(5)(4) := 'p';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := 'd';Echiquier(5)(8) := 'f';
         Echiquier(6)(1) := 'p';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := 'p';Echiquier(6)(6) := '.';Echiquier(6)(7) := 'p';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := 'p';Echiquier(7)(3) := 'p';Echiquier(7)(4) := '.';Echiquier(7)(5) := 'c';Echiquier(7)(6) := '.';Echiquier(7)(7) := '.';Echiquier(7)(8) := 'p';
         Echiquier(8)(1) := 't';Echiquier(8)(2) := 'f';Echiquier(8)(3) := 'r';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := '.';Echiquier(8)(7) := 'c';Echiquier(8)(8) := 't';
      when 7 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := '.';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := '.';Echiquier(2)(3) := '.';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := '.';Echiquier(3)(2) := '.';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := '.';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := '.';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := '.';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := '.';Echiquier(7)(3) := '.';Echiquier(7)(4) := '.';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := '.';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := '.';Echiquier(8)(2) := '.';Echiquier(8)(3) := '.';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := '.';Echiquier(8)(7) := '.';Echiquier(8)(8) := '.'; 
	 
      when 8 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := '.';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := '.';Echiquier(2)(3) := '.';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := '.';Echiquier(3)(2) := '.';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := '.';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := '.';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := '.';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := '.';Echiquier(7)(3) := '.';Echiquier(7)(4) := '.';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := '.';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := '.';Echiquier(8)(2) := '.';Echiquier(8)(3) := '.';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := '.';Echiquier(8)(7) := '.';Echiquier(8)(8) := '.'; 
	 
      when 9 =>
         Echiquier(1)(1) := '.';Echiquier(1)(2) := '.';Echiquier(1)(3) := '.';Echiquier(1)(4) := '.';Echiquier(1)(5) := '.';Echiquier(1)(6) := '.';Echiquier(1)(7) := '.';Echiquier(1)(8) := '.';
         Echiquier(2)(1) := '.';Echiquier(2)(2) := '.';Echiquier(2)(3) := '.';Echiquier(2)(4) := '.';Echiquier(2)(5) := '.';Echiquier(2)(6) := '.';Echiquier(2)(7) := '.';Echiquier(2)(8) := '.';
         Echiquier(3)(1) := '.';Echiquier(3)(2) := '.';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := '.';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := '.';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := '.';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := '.';Echiquier(7)(2) := '.';Echiquier(7)(3) := '.';Echiquier(7)(4) := '.';Echiquier(7)(5) := '.';Echiquier(7)(6) := '.';Echiquier(7)(7) := '.';Echiquier(7)(8) := '.';
         Echiquier(8)(1) := '.';Echiquier(8)(2) := '.';Echiquier(8)(3) := '.';Echiquier(8)(4) := '.';Echiquier(8)(5) := '.';Echiquier(8)(6) := '.';Echiquier(8)(7) := '.';Echiquier(8)(8) := '.'; 
      when 11 =>
         Echiquier(1)(1) := 'T';Echiquier(1)(2) := 'C';Echiquier(1)(3) := 'F';Echiquier(1)(4) := 'R';Echiquier(1)(5) := 'D';Echiquier(1)(6) := 'F';Echiquier(1)(7) := 'C';Echiquier(1)(8) := 'T';
         Echiquier(2)(1) := 'P';Echiquier(2)(2) := 'P';Echiquier(2)(3) := 'P';Echiquier(2)(4) := 'P';Echiquier(2)(5) := 'P';Echiquier(2)(6) := 'P';Echiquier(2)(7) := 'P';Echiquier(2)(8) := 'P';
         Echiquier(3)(1) := '.';Echiquier(3)(2) := '.';Echiquier(3)(3) := '.';Echiquier(3)(4) := '.';Echiquier(3)(5) := '.';Echiquier(3)(6) := '.';Echiquier(3)(7) := '.';Echiquier(3)(8) := '.';
         Echiquier(4)(1) := '.';Echiquier(4)(2) := '.';Echiquier(4)(3) := '.';Echiquier(4)(4) := '.';Echiquier(4)(5) := '.';Echiquier(4)(6) := '.';Echiquier(4)(7) := '.';Echiquier(4)(8) := '.';
         Echiquier(5)(1) := '.';Echiquier(5)(2) := '.';Echiquier(5)(3) := '.';Echiquier(5)(4) := '.';Echiquier(5)(5) := '.';Echiquier(5)(6) := '.';Echiquier(5)(7) := '.';Echiquier(5)(8) := '.';
         Echiquier(6)(1) := '.';Echiquier(6)(2) := '.';Echiquier(6)(3) := '.';Echiquier(6)(4) := '.';Echiquier(6)(5) := '.';Echiquier(6)(6) := '.';Echiquier(6)(7) := '.';Echiquier(6)(8) := '.';
         Echiquier(7)(1) := 'p';Echiquier(7)(2) := 'p';Echiquier(7)(3) := 'p';Echiquier(7)(4) := 'p';Echiquier(7)(5) := 'p';Echiquier(7)(6) := 'p';Echiquier(7)(7) := 'p';Echiquier(7)(8) := 'p';
         Echiquier(8)(1) := 't';Echiquier(8)(2) := 'c';Echiquier(8)(3) := 'f';Echiquier(8)(4) := 'r';Echiquier(8)(5) := 'd';Echiquier(8)(6) := 'f';Echiquier(8)(7) := 'c';Echiquier(8)(8) := 't'; 
      when others =>  null ;
	 
   end case ;
   return Echiquier ;

end Generer_Repertoire ;


procedure Afficher (Echiquier : T_Mat_User) is
begin
   for I in Echiquier'Range loop
      Put(Echiquier(I));
      New_Line;
   end loop ;
end Afficher ;

end Echiquier ;



