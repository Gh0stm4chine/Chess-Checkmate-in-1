with Ada.Exceptions ;

package Uncaught_Exception is

   --
   -- This works only with gnat > 3.4
   --
   procedure Last_Chance(Except : Ada.Exceptions.Exception_Occurrence) ;
   pragma Export (C, Last_Chance, "__gnat_last_chance_handler") ;
   pragma No_Return (Last_Chance) ;

   --
   -- This one is for gnat 3.2
   --
   procedure Notify_Exception(Id : Ada.Exceptions.Exception_Id ; Handler : Ada.Exceptions.Code_Loc ; Is_Others : Character);
   pragma Export (C, Notify_Exception, "__gnat_notify_exception");

   function Get_Uncaught_Exception_Name return String ;
   function Get_Uncaught_Exception_Message return String ;
   function Is_Present return Boolean ;

end Uncaught_Exception ;

