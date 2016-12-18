with Ada.Text_Io ;
with Ada.Calendar ;
with Glib;             use Glib ;
with Glib.Error ;      use Glib.Error ;
with Gdk;
with Gdk.Threads ;
with Gdk.Gc ;          use Gdk.Gc ;
with Gdk.Color ;
with Gdk.Drawable;     use Gdk.Drawable;
with Gdk.Event;        use Gdk.Event ;
with Gdk.Pixmap;       use Gdk.Pixmap;
with Gdk.Pixbuf;       use Gdk.Pixbuf;
with Gdk.Rectangle;
with Gdk.Window;
with Gtk.Drawing_Area; use Gtk.Drawing_Area;
with Gtk.Main;
with Gtk.Enums;
with Gtk.Widget ;
with Gtk.Rc;
with Gtk.Handlers;
with Gtk.Style;
with Gtk.Window;       use Gtk.Window;
with Pango.Layout;
with Pango.Context;
with Pango.Font ;
with GAda.Core ;

package body GAda.Gr_Core is

   PWidth  : Glib.Gint := 200 ;
   PHeight : Glib.Gint := 200 ;

   ZeMarge : Boolean := True ;

   Taille_Marge : constant Glib.gint := 50 ;

   Black       : constant T_Couleur := (0,0,0) ;
   White       : constant T_Couleur := (255,255,255) ;

   Marge_Bleue : constant T_Couleur := (111, 31, 220) ;

   Mongris     : constant Integer := 230 ;
   Marge_Grise : constant T_Couleur := (mongris, mongris, mongris) ;

   Refresh_Interval : constant Guint32 := 50 ; -- Milliseconds
   Inited        : Boolean := False ; -- Initialized

   Pixmap_Exists : Boolean := False ; -- Ils ont pas de type 'a option (ben en fait si)

   -- Definis dans le .ads
   --Pixmap        : Gdk_Pixmap ;
   --LGC           : Gdk.Gc.Gdk_GC ;

   Window        : Gtk_Window;
   Drawing_Area  : Gtk_Drawing_Area;

   procedure Ajuste_Pos(XX, YY : in out GLib.Gint) is
   begin
      if ZeMarge then
         XX := XX + Taille_Marge ;
         YY := YY + Taille_Marge ;
      end if ;
   end Ajuste_Pos ;

   function Width return Integer is
   begin
      return Integer(PWidth) ;
   end Width ;

   function Height return Integer is
   begin
      return Integer(PHeight) ;
   end Height ;


   package Configured is new Gtk.Handlers.Return_Callback
     (Widget_Type => Gtk_Drawing_Area_Record,
      Return_Type => Boolean);
   package Destroyed is new Gtk.Handlers.Callback
     (Widget_Type => Gtk_Window_Record);
   package WConfigured is new Gtk.Handlers.Return_Callback
     (Widget_Type => Gtk_Window_Record,
      Return_Type => Boolean);


   ---------
   -- Bye --
   ---------
   procedure Bye (Window : access Gtk.Window.Gtk_Window_Record'Class) is
      pragma Warnings (Off, Window);
   begin
      Gtk.Main.Main_Quit;
   end Bye;

   function Conv (C : Integer) return Guint16 is
   begin
      return Guint16(255 * C) ;
   end Conv ;

   procedure RealSetColor(Coul : T_Couleur) is
      Success : Boolean ;
      GdkC : Gdk.Color.Gdk_Color ;
   begin
      Gdk.Color.Set_RGB(GdkC, Conv(Coul.Rouge), Conv(Coul.Vert), Conv(Coul.Bleu)) ;
      Gdk.Color.Alloc_Color  (Gtk.Widget.Get_Default_Colormap, GdkC, False, True, Success);
      Gdk.GC.Set_Foreground(LGC, GdkC) ;
   end RealSetColor ;


   ------------------------------------
   -- History of Button Press Events --
   ------------------------------------

   Buffer_Size : constant Integer := 10 ;

   Event_History : array (Integer range 0..Buffer_Size-1) of T_Event ;
   Index_History : Integer := 0 ;
   Size_History  : Integer := 0 ;

   procedure Get_Coordinates (X, Y : out Integer ; EventX, EventY : Gint) is
   begin
      X := Integer(EventX) ;
      Y := Integer(PHeight) - Integer(EventY) ;

      if Zemarge then
         X := X - Integer(Taille_Marge) ;
         Y := Y + Integer(Taille_Marge) ;
      end if ;
   end Get_Coordinates ;

   procedure Insert_Event(Event : Gdk.Event.Gdk_Event ; Etype : T_Event_Type) is
      My_Event : T_Event ;
   begin
      My_Event.Trouve := True ;
      My_Event.Etype := Etype ;
      My_Event.Age := Integer(1000 * Ada.Calendar.Seconds(Ada.Calendar.Clock)) ;

      -- Mouse button press
      if Etype = Button_Press then
         Get_Coordinates(My_Event.X, My_Event.Y, GInt(Gdk.Event.Get_X(Event)), GInt(Gdk.Event.Get_Y(Event))) ;
      end if ;

      -- Key press
      if Etype = Key_Press then
         declare
            X, Y : GInt;
            OX, OY : GInt ;
            Key : String := Gada.Core.Invconvert(Gdk.Event.Get_String(event)) ;
         begin
            Get_Pointer (Window, X, Y);

            OX := Gtk.Widget.Get_Allocation_X(Gtk.Widget.Gtk_Widget(Drawing_Area)) ;
            OY := Gtk.Widget.Get_Allocation_Y(Gtk.Widget.Gtk_Widget(Drawing_Area)) ;

            Get_Coordinates(My_Event.X, My_Event.Y, X - OX, Y - OY) ;

            My_Event.Key_Code := Integer(Gdk.Event.Get_Key_Val(Event)) ;

            if Key'Length >= 1 then
               My_Event.Key := Key(Key'First) ;
            else
               My_Event.Key := Character'Val(0) ;
            end if ;
         end ;
      end if ;

      Event_History(Index_History) := My_Event ;

      Index_History := (Index_History + 1) mod Event_History'Length ;

      if Size_History < Event_History'Length then
         Size_History := Size_History + 1 ;
      end if ;
   end Insert_Event ;

   -- Not synchronized, but most likely thread-safe (one consumer, one producer)
   -- provided we are careful with the precise order of operations
   function Next_Event return T_Event is
      Event : T_Event ;
      IndexRead : Integer ;
   begin
      if Size_History = 0 then
         -- To cope with active waiting loops
         delay 0.01 ;
         Event := (False, Button_Press, 0, 0, 0, Character'Val(0), 0) ;
      else
         IndexRead := (Index_History - Size_History + Event_History'Length) mod Event_History'Length ;
         Size_History := Size_History - 1 ;

         Event := Event_History(IndexRead) ;
         Event.Age := Integer(1000 * Ada.Calendar.Seconds(Ada.Calendar.Clock)) - Event.Age ;
      end if ;

      return Event ;
   end Next_Event ;

   --------------------
   -- Button_Press --
   --------------------
   function Button_Press_Event (Drawing_Area : access Gtk_Drawing_Area_Record'Class;
                                Event : Gdk.Event.Gdk_Event_Button)
                               return Boolean
   is
   begin
      Insert_Event(Event, Button_Press) ;
      return True ;
   end Button_Press_Event ;

   --------------------
   -- Key_Press      --
   --------------------
   function Key_Press_Event (Window : access Gtk_Window_Record'Class;
                             Event : Gdk.Event.Gdk_Event_Key)
                            return Boolean
   is
   begin
      Insert_Event(Event, Key_Press) ;
      return True ;
   end Key_Press_Event ;

   ------------------
   -- Expose_Event --
   ------------------
   function Expose_Event (Drawing_Area : access Gtk_Drawing_Area_Record'Class;
                          Event : in Gdk.Event.Gdk_Event)
                         return Boolean
   is
      Area : Gdk.Rectangle.Gdk_Rectangle := Gdk.Event.Get_Area (Event);
      Win  : Gdk.Window.Gdk_Window;
      Win_Width, Win_Height : Glib.Gint ;
   begin
      -- Ada.Text_Io.Put_Line("exposing..." &
      --                       Gint'Image(Area.X) &
      --                       Gint'Image(Area.Y) &
      --                       Gint'Image(Gint(Area.Width)) &
      --                       Gint'Image(Gint(Area.Height))) ;

      if not Pixmap_Exists then
         Win := Get_Window (Window);

         Win_Width := Pwidth ;
         Win_Height := PHeight ;

         if ZeMarge then
            Win_Width := Win_Width + Taille_Marge * 2 ;
            Win_Height := Win_Height + Taille_Marge * 2 ;
         end if ;

         Gdk.Pixmap.Gdk_New (Pixmap, Win, Win_Width, Win_Height, -1);

         Draw_Rectangle (Pixmap, Gtk.Style.Get_White (Get_Style (Drawing_Area)),
                         True, 0, 0, Win_Width, Win_Height);

         Gdk.GC.Gdk_New(LGC, Get_Window(Drawing_Area)) ;
         Gdk.GC.Copy(Dst_GC => LGC, Src_GC => Gtk.Style.Get_Black_GC(Get_Style(Drawing_Area))) ;

         if Zemarge then
            -- Bord autour de la marge.
            RealSetColor(Marge_Grise) ;
            Gdk.GC.Set_Line_Attributes(LGC, Gint(1), Line_Solid, Cap_Round, Join_Bevel) ;

            Draw_Rectangle (Pixmap, LGC, True, 0, 0, Win_Width, Win_Height) ;

            RealSetColor(White) ;
            Draw_Rectangle (Pixmap, LGC, True, Taille_Marge, Taille_Marge, pWidth, pHeight);

            Gdk.GC.Set_Line_Attributes(LGC, Gint(1), Line_On_Off_Dash, Cap_Round, Join_Bevel) ;
            RealSetColor(Marge_Bleue) ;
            -- Le calcul des coordonnées pour les bords du rectangle n'est pas très cohérent.
            Draw_Rectangle (Pixmap, LGC, False, Taille_Marge - 2, Taille_Marge - 2, Glib.Gint(pwidth + 3), Glib.Gint(pheight + 3)) ;

            Gdk.GC.Set_Line_Attributes(LGC, Gint(1), Line_Solid, Cap_Round, Join_Bevel) ;

            RealSetColor(Black) ;
         end if ;

         Pixmap_Exists := True ;
      end if ;

      Draw_Pixmap (Get_Window (Drawing_Area),
                   Gtk.Style.Get_Fg_GC (Get_Style (Drawing_Area), Gtk.Enums.State_Normal),
                   Pixmap, Area.X, Area.Y, Area.X, Area.Y,
                   Glib.Gint (Area.Width), Glib.Gint (Area.Height));

      return True;
   end Expose_Event;

   procedure Check_Init is
   begin
      if not Inited then
         Gtk_New (Window, Gtk.Enums.Window_Toplevel);
         Set_Title (Window, "GAda Graphics");
         Set_Border_Width (Window, Border_Width => 6);
         Set_Resizable(Window, False) ;
         Destroyed.Connect (Window, "destroy", Destroyed.To_Marshaller (Bye'Access));

         Gtk_New (Drawing_Area);

         if Zemarge then
            Size (Drawing_Area, PWidth + 2 * Taille_Marge, PHeight + 2 * Taille_Marge);
         else
            Size (Drawing_Area, PWidth, PHeight);
         end if ;

         Add (Window, Drawing_Area);
         Show (Drawing_Area);
         Unrealize (Drawing_Area);

         Set_Events (Drawing_Area, Gdk.Event.Exposure_Mask or Gdk.Event.Button_Press_Mask or Gdk.Event.Key_Press_Mask) ;

         Configured.Connect (Widget => Drawing_Area,
                             Name   => "expose_event",
                             Marsh  => Configured.To_Marshaller
                             (Expose_Event'Access));

         Configured.Connect (Widget => Drawing_Area,
                             Name   => "button_press_event",
                             Marsh  => Configured.To_Marshaller
                               (Button_Press_Event'Access));

         WConfigured.Connect (Widget => Window,
                              Name   => "key_press_event",
                              Marsh  => WConfigured.To_Marshaller
                                (Key_Press_Event'Access)) ;

         Show_All (Window);
         Inited := True ;
      end if ;
   end Check_Init ;

   procedure Enter is
   begin
      Gada.Core.Enter ;
      Check_Init ;

      if not Pixmap_Exists then
         Gada.Core.Leave ;
         while not (Pixmap_Exists) loop
            delay 0.5 ;
         end loop ;
         Gada.Core.Enter ;
      end if ;
   end Enter ;

   procedure Leave is
   begin
      Gada.Core.Leave ;
   end Leave ;

   Timeout_Is_Set : Boolean := False ;

   function Redraw return Boolean is
   begin
      -- On est dans un Callback TIMEOUT : Il faut prendre le verrou mais ne pas bloquer
      Gdk.Threads.Enter ;
      Draw(Drawing_Area) ;
      Timeout_Is_Set := False ;
      Gdk.Threads.Leave ;
      return False ;
   end Redraw ;

   procedure Draw is
      Id : Gtk.Main.Timeout_Handler_Id ;
   begin
      if not Timeout_Is_Set then
         Id := Gtk.Main.Timeout_Add  (Refresh_Interval, Redraw'access) ;
         Timeout_Is_Set := True ;
      end if ;
   end Draw ;

   procedure SetColor(Coul : T_Couleur) is
   begin
      Enter ;
      RealSetColor(Coul) ;
      Leave ;
   end SetColor ;

   procedure Point(X,Y : Integer) is
      XX : Glib.Gint := Glib.Gint(X) ;
      YY : Glib.Gint := PHeight - 1 - Glib.Gint(Y) ;
   begin
      Ajuste_Pos(XX, YY) ;
      Enter ;
      Draw_Point (Pixmap, LGC, XX, YY) ;
      Draw ;
      Leave ;
   end Point ;

   function Grise (Val : Integer) return Integer is
   begin
      return (Val * Mongris / 255 + 3 * Mongris) / 4 ;
   end Grise ;

   function Ajuste_Coul(Coul : T_Couleur) return T_Couleur is
   begin
      return (Grise(Coul.Rouge), Grise(Coul.Vert), Grise(Coul.Bleu)) ;
   end Ajuste_Coul ;

   type T_Effet is (Rien, Normal, Estompe) ;

   function Trouve_Effet (X, Y : Integer) return T_Effet is
      Visible : Boolean ;
      Zone_Interdite : Boolean ;
   begin
      if ZeMarge then

         Visible := (X >= 0 and X < Width and Y >= 0 and Y < Height) ;
         Zone_Interdite := (X >= -3 and X < Width + 3 and Y >= -3 and Y < Height + 3) ;

         if Zone_Interdite then
            if Visible then return Normal ;
            else return Rien ;
            end if ;
         else
            return Estompe ;
         end if ;

      else
         return Normal ;
      end if ;
   end Trouve_Effet ;

   procedure ColorPoint(X,Y : Integer ; Coul : T_Couleur) is
   begin
      case Trouve_Effet(X, Y) is
         when Rien => null ;

         when Normal =>
            SetColor(Coul) ;
            Point(X, Y) ;

         when Estompe =>
            SetColor(Ajuste_Coul(Coul)) ;
            Point(X, Y) ;
      end case ;

      -- C'est un effet de bord utilisé par certains programmes.
      SetColor(Coul) ;
   end ColorPoint ;

   procedure BlackPoint(X,Y : Integer) is
   begin
      ColorPoint(X,Y, Black) ;
   end BlackPoint ;

   procedure Line(X1, Y1, X2, Y2 : Integer) is
      XX1 : Glib.Gint := Glib.Gint(X1) ;
      YY1 : Glib.Gint := PHeight - 1 - Glib.Gint(Y1) ;
      XX2 : Glib.Gint := Glib.Gint(X2) ;
      YY2 : Glib.Gint := PHeight - 1 - Glib.Gint(Y2) ;
   begin
      Ajuste_Pos(XX1, YY1) ;
      Ajuste_Pos(XX2, YY2) ;
      Enter ;
      Draw_Line (Pixmap, LGC, XX1, YY1, XX2, YY2) ;
      Draw ;
      Leave ;
   end Line ;

   procedure ColorLine(X1, Y1, X2, Y2 : Integer ; Coul : T_Couleur) is
   begin
      SetColor(Coul) ;
      Line(X1, Y1, X2, Y2) ;
   end ColorLine ;

   procedure Rectangle(X, Y, Largeur, hauteur : Integer) is
      XX1 : Glib.Gint := Glib.Gint(X) ;
      YY1 : Glib.Gint := PHeight - 1 - Glib.Gint(Y + Hauteur - 1) ;
   begin
      Ajuste_Pos(XX1, YY1) ;
      Enter ;
      Draw_Rectangle (Pixmap, LGC, True, XX1, YY1, Glib.Gint(Largeur), Glib.Gint(Hauteur)) ;
      Draw ;
      Leave ;
   end Rectangle ;

   procedure Cercle(X, Y, Rayon : Integer ; Coul : T_Couleur) is
      XX1 : Glib.Gint := Glib.Gint(X - Rayon) ;
      YY1 : Glib.Gint := PHeight - 1 - Glib.Gint(Y + Rayon) ;
      Diam : Glib.Gint := Glib.Gint (2 * Rayon) ;
   begin
      Ajuste_Pos(XX1, YY1) ;
      SetColor(Coul) ;
      Enter ;
      Draw_Arc (Pixmap, LGC, False, XX1, YY1, Diam, Diam, 0, 360 * 64) ;
      Draw ;
      Leave ;
   end Cercle ;

   procedure Disque(X, Y, Rayon : Integer ; Coul : T_Couleur) is
      XX1 : Glib.Gint := Glib.Gint(X - Rayon) ;
      YY1 : Glib.Gint := PHeight - 1 - Glib.Gint(Y + Rayon) ;
      Diam : Glib.Gint := Glib.Gint (2 * Rayon) ;
   begin
      Ajuste_Pos(XX1, YY1) ;
      SetColor(Coul) ;
      Enter ;
      Draw_Arc (Pixmap, LGC, True, XX1, YY1, Diam, Diam, 0, 360 * 64) ;
      Draw ;
      Leave ;
   end Disque ;

   procedure ColorRectangle(X, Y, Largeur, Hauteur : Integer ; Coul : T_Couleur) is
   begin
      SetColor(Coul) ;
      Rectangle(X,Y,Largeur,Hauteur) ;
   end ColorRectangle ;

   procedure BlackLine(X1, Y1, X2, Y2 : Integer) is
   begin
      ColorLine(X1,Y1,X2,Y2, Black) ;
   end BlackLine ;

   procedure SetLineWidth(Width : Integer) is
   begin
      Enter ;
      Gdk.GC.Set_Line_Attributes(LGC, Gint(Width), Line_Solid, Cap_Round, Join_Bevel) ;
      Leave ;
   end SetLineWidth ;

   procedure Resize(Largeur : Integer ; Hauteur : Integer) is
      Win_Width, Win_Height : Glib.Gint ;
   begin
      Enter ;
      PWidth := Gint(Largeur) ;
      PHeight := Gint(Hauteur) ;

      Pixmap_Exists := False ;
      Gdk.Pixmap.Unref(Pixmap) ;
      Gdk.GC.Unref(LGC) ;

      Win_Width := Pwidth ;
      Win_Height := PHeight ;

      if ZeMarge then
         Win_Width := Win_Width + Taille_Marge * 2 ;
         Win_Height := Win_Height + Taille_Marge * 2 ;
      end if ;

      Size (Drawing_Area, Win_Width, Win_Height);

      Draw ;
      Leave ;
   end Resize ;

   procedure Avec_Marge(Flag : Boolean) is
   begin
      ZeMarge := Flag ;
      Resize(Integer(Pwidth), Integer(Pheight)) ;
   end Avec_Marge ;

   procedure Handle_Error(Msg : String ; Error : GLib.Error.GError) is
   begin

      if (Error = null) or else (GLib.Error.Get_Code(Error) = 0) then
         null ;
      else
         GAda.Core.Put_Err("Erreur avec " & Msg & " : " & Gada.Core.Invconvert(GLib.Error.Get_Message(Error))) ;
         GAda.Core.New_Line ;
         raise Program_Error ;
      end if ;

   end Handle_Error ;

   function Load_Image (Filename : String) return Image is
      Pixbuf : Gdk_Pixbuf ;
      Error : GLib.Error.GError ;
   begin
      Enter ;
      Gdk_New_From_File(Pixbuf, Filename, Error);
      Leave ;

      Handle_Error("Load_Image", Error) ;
      return Pixbuf ;
   end Load_Image ;

   function Largeur_Image(Img : Image) return Integer is
   begin
      return Integer(Gdk.Pixbuf.Get_Width(Img)) ;
   end Largeur_Image ;

   function Hauteur_Image(Img : Image) return Integer is
   begin
      return Integer(Gdk.Pixbuf.Get_Height(Img)) ;
   end Hauteur_Image ;

   procedure Put_Image (X, Y : Integer ; Img : Image) is
      XX1 : Glib.Gint := Glib.Gint(X) ;
      YY1 : Glib.Gint := PHeight - 1 - Glib.Gint(Y) ;
   begin
      Ajuste_Pos(XX1, YY1) ;
      Enter ;
      Render_To_Drawable_Alpha (Pixbuf => Img,
                                Drawable => Pixmap,
                                Src_X => Glib.Gint(0),
                                Src_Y => Glib.Gint(0),
                                Dest_X => XX1,
                                Dest_Y => YY1,
                                Width => Gdk.Pixbuf.Get_Width(Img),
                                Height => Gdk.Pixbuf.Get_Height(Img),
                                Alpha => Alpha_Full,
                                Alpha_Threshold => 0) ;
      Draw ;
      Leave ;
   end Put_Image ;


   procedure Put_Text (X, Y : Integer ; Msg : String ; Size : Integer := 0) is
      XX1 : Glib.Gint := Glib.Gint(X) ;
      YY1 : Glib.Gint := PHeight - 1 - Glib.Gint(Y) ;
   begin
      Ajuste_Pos(XX1, YY1) ;
      Enter ;

      declare
         Layout  : Pango.Layout.Pango_Layout := Gtk.Widget.Create_Pango_Layout(Gtk.Widget.Gtk_Widget(Drawing_Area)) ;
         Font    : Pango.Font.Pango_Font_Description ;
      begin
         Pango.Layout.Set_Text (Layout,Gada.Core.Convert(Msg)) ;

         if Size > 0 then
            Font := Pango.Context.Get_Font_Description (Pango.Layout.Get_Context (Layout)) ;
            Pango.Font.Set_Size (Font, Glib.Gint(Size * 1000)) ;
            Pango.Layout.Set_Font_Description(Layout,Font) ;
         end if ;

         Gdk.Drawable.Draw_Layout(Drawable => Pixmap,
                                  Gc       => Lgc,
                                  X        => XX1,
                                  Y        => YY1,
                                  Layout   => Layout) ;
         Draw ;
         Leave ;
      end ;
   end Put_Text ;



end GAda.Gr_Core ;
