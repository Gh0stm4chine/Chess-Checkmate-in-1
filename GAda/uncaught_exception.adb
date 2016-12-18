with Ada.Exceptions ;
pragma Warnings (Off);
with System ; use System ;
with System.Standard_Library; use System.Standard_Library;
pragma Warnings (On);

package body Uncaught_Exception is

   procedure Unhandled_Terminate;
   pragma No_Return (Unhandled_Terminate);
   pragma Import (C, Unhandled_Terminate, "__gnat_unhandled_terminate");
   --  Perform system dependent shutdown code

   procedure To_Stderr (S : String);
   pragma Import (Ada, To_Stderr, "__gnat_to_stderr");

   Last_Exception_Occur : Ada.Exceptions.Exception_Occurrence ;
   Last_Exception_Occur_Present : Boolean := False ;

   Last_Exception_Id : Ada.Exceptions.Exception_Id ;
   Last_Exception_Id_Present : Boolean := False ;

   Present : Boolean := False ; -- An exception is present : either last_exception_occur our last_exception_id is set

   Abort_Signal_Name : String :=
     System.Standard_Library.Abort_Signal_Name(1..System.Standard_Library.Abort_Signal_Def.Name_Length - 1) ;

   -- This procedure is automatically called by the exception mechanism when no handler has been found.
   -- It overrides the default behaviour.
   procedure Last_Chance (Except : Ada.Exceptions.Exception_Occurrence) is
   begin
      if Ada.Exceptions.Exception_Name(Except) = Abort_Signal_Name then
         -- Don't save it, don't print it
         System.Standard_Library.Adafinal;
      else
         Ada.Exceptions.Save_Occurrence(Last_Exception_Occur, Except) ;
         Last_Exception_Occur_Present := True ;
         Present := True ;

         System.Standard_Library.Adafinal;

--
--         To_Stderr (ASCII.LF & "The exception " & Ada.Exceptions.Exception_Name(Except)
--                    & " has been raised: " & ASCII.LF);
         To_Stderr (Ada.Exceptions.Exception_Message(Except) & ASCII.LF);
      end if ;
      Unhandled_Terminate;
   end Last_Chance;

   procedure Notify_Exception (Id : Ada.Exceptions.Exception_Id ; Handler : Ada.Exceptions.Code_Loc ; Is_Others : Character) is

   begin
      if Handler = System.Null_Address then
         -- Unhandled exception
         Last_Exception_Id := Id ;
         Last_Exception_Id_Present := True ;
         Present := True ;
         To_Stderr (Ada.Exceptions.Exception_Name(Id) & ASCII.LF);
      end if ;
   end Notify_Exception ;


   function Is_Present return Boolean is
   begin
      return Present ;
   end Is_Present ;

   function Get_Uncaught_Exception_Name return String is
   begin
      if Last_Exception_Occur_Present then
         return (Ada.Exceptions.Exception_Name(Last_Exception_Occur)) ;
      elsif Last_Exception_Id_Present then
         return (Ada.Exceptions.Exception_Name(Last_Exception_Id)) ;
      else
         return "Exception inconnue" ;
      end if ;

   end Get_Uncaught_Exception_Name ;

   function Get_Uncaught_Exception_Message return String is
   begin
      if Last_Exception_Occur_Present then
         return (Ada.Exceptions.Exception_Message(Last_Exception_Occur)) ;
      elsif Last_Exception_Id_Present then
         return "" ;
      else
         return "Exception inconnue" ;
      end if ;

   end Get_Uncaught_Exception_Message ;

end Uncaught_Exception ;
