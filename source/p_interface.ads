--#################################
--##
--## fichier réalisé par Richard Guerci 
--##
--#################################


--Appel des librairie GtkADA permettant la gestion des éléments de l'interface graphique
with Gtk.Main,Gtk.Window,Gtk.Box, Gtk.Label,Gtk.Button,Gtk.Spin_Button,Gtk.GEntry,Gtk.Frame,Gtk.Image,Gtk.Menu_Bar, Gtk.Menu_Item,Gtk.Widget,Gtk.Handlers,Gtk.Table,Gtk.Enums,Glib,Gtk.Message_Dialog;
use Gtk.Main,Gtk.Window,Gtk.Box, Gtk.Label,Gtk.Button,Gtk.Spin_Button,Gtk.GEntry,Gtk.Frame,Gtk.Image,Gtk.Menu_Bar, Gtk.Menu_Item,Gtk.Widget,Gtk.Handlers,Gtk.Table,Gtk.Enums,Glib,Gtk.Message_Dialog;

--Appel des libraire réalisée pour le projet
with structure;
use structure;
with p_traitement;
use p_traitement;
with p_fichier;
use p_fichier;

--Appel du paquetage d'entré/sortie Ada
with Ada.text_io;
use Ada.text_io;
with Ada.Strings;
use Ada.Strings;
with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

--Appel du paquetage permettant de générer des nombres aléatoires.
with Ada.Numerics.Discrete_Random;


package P_interface is
	
	--Procedure
	procedure Debut;
	
private
	
	--Type structure qui permettent le transfert de varable entre fenetre
	type parametre_dimensions is record
		Fenetre:Gtk_window;
		X,Y:Gtk_spin_button;
	end record;
	
	type parametre_ouvrir is record
		Fenetre:Gtk_window;
		Edit:Gtk_Entry;
	end record;
	
	--#####################
	--## TYPE POUR INTERFACE ##
	--#####################
	
	--Structure d'un bille (élément sur lequel on clique et qui possède une couleur T_Couleur):
	type T_bille is record
		bouton:Gtk_button;
		image:Gtk_image;
		Couleur:Gtk_label;--contiendra T_couleur sous forme de caractère
	end record;
	
	--Tableau qui représente un colonne de type T_bille_graph:
	type T_colonne_graph is array (1..Taille_Max_Y) of T_bille;

	--Tableau de T_colonne_graph:
	type T_grille_graph is array (1..Taille_Max_X) of T_colonne_graph;

	--Structure qui contient le tout:
	type T_struct_grille is record
		X,Y:integer;
		points:Gtk_Label;
		Element:T_grille_graph;
	end record;
	
	--Type structure qui permettent le transfert de varable entre fenetre
	type parametre_sauve is record
		Grille:T_struct_grille;
		option:boolean;
	end record;
	
	type parametre_triche is record
		Grille:T_struct_grille;
		option:boolean;
		selection:Gtk_label;
	end record;
	
	type parametre_sauve_2 is record
		Fenetre:Gtk_window;
		Struct:parametre_sauve;
		Edit:Gtk_Entry;
	end record;
	
	type parametre_grille is record
		Grille:T_struct_grille;
		J,I:integer;
		Selection:Gtk_label;
	end record;
	
	type parametre_score is record
		Fenetre:Gtk_window;
		Edit:Gtk_Entry;
		pts:integer;
	end record;
	
	--procedure
	procedure choix_dimensions(Element_declancheur:access Gtk_Widget_Record'Class;Fenetre_precedente:Gtk_window);
	procedure choix_ouvrir(Element_declancheur:access Gtk_Widget_Record'Class;Fenetre_precedente:Gtk_window);
	
	procedure initialisation_choix_dimensions(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_dimensions);
	procedure initialisation_choix_ouvrir(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_ouvrir);
	
	function  Initialisation_structure_parametre_dimensions(Fenetre:Gtk_window;X,Y:Gtk_spin_button) return parametre_dimensions;
	function  Initialisation_structure_prarametre_ouvrir(Fenetre:Gtk_window;Edit:Gtk_Entry) return parametre_ouvrir;
	
	procedure Initialisation_grille(G:out T_struct_grille;X: in integer;Y: in integer);
	
	function Initialisation_structure_parametre_grille(Grille:T_struct_grille;J,I:integer;Selection:Gtk_label) return parametre_grille;
	procedure Selection(Element_declancheur:access Gtk_Widget_Record'Class;parametre: parametre_grille);
	procedure Clique(Element_declancheur:access Gtk_Widget_Record'Class;parametre: parametre_grille);
	
	function Graph_to_couleur(G:T_struct_grille) return T_grille;
	
	procedure Partie(G:T_struct_grille);
	
	procedure Fenetre_sauvegarde(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_sauve);
	function  Initialisation_structure_prarametre_sauve(G:T_struct_grille;opt:boolean) return parametre_sauve;
	procedure Gestion_sauvegarde(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_sauve_2);
	function  Initialisation_structure_prarametre_sauve_2(Fenetre:Gtk_window;Struct:parametre_sauve;Edit:Gtk_Entry) return parametre_sauve_2;
	procedure Fermer_sauvegarde(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_sauve);
	
	procedure Gestion_triche(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_triche);
	function  Initialisation_structure_prarametre_triche(G:T_struct_grille;opt:boolean;selection:gtk_label) return parametre_triche;
	
	procedure Fenetre_Score(Element_declancheur:access Gtk_Widget_Record'Class);
	procedure Fenetre_Ajout_Score(pts:integer);
	function Initialisation_structure_prarametre_score(Fenetre:Gtk_window;Edit:Gtk_Entry;pts:integer) return parametre_score;
	procedure Gestion_score(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_score);
	
	procedure Annuler(Element_declancheur:access Gtk_Widget_Record'Class;fenetre:Gtk_window);
	procedure Fermer_Information(Element_declancheur:access Gtk_Widget_Record'Class;Dialog:Gtk_Message_Dialog);
	procedure Fermer(Element_declancheur:access Gtk_Widget_Record'Class);
	
	--Paquetage gérant les actions (Gtk_widget_record)
        package Traitement is new Callback(Gtk_Widget_Record);
        package Traitement_fenetre is new User_Callback(Gtk_Widget_Record,Gtk_window);
        package Traitement_fenetre_info is new User_Callback(Gtk_Widget_Record,Gtk_Message_Dialog);
        package Traitement_parametre_dimensions is new User_Callback(Gtk_Widget_Record,parametre_dimensions);
        package Traitement_parametre_ouvrir is new User_Callback(Gtk_Widget_Record,parametre_ouvrir);
        package Traitement_parametre_grille is new User_Callback(Gtk_Widget_Record,parametre_grille);
	package Traitement_parametre_sauve is new User_Callback(Gtk_Widget_Record,parametre_sauve);
	package Traitement_parametre_sauve_2 is new User_Callback(Gtk_Widget_Record,parametre_sauve_2);
	package Traitement_parametre_triche is new User_Callback(Gtk_Widget_Record,parametre_triche);
	package Traitement_parametre_score is new User_Callback(Gtk_Widget_Record,parametre_score);
	
	--Paquetage et type permettant la génération de variable aléatoire.
        subtype T_couleur_id is integer range 0..2;
        package Couleur_Random is new Ada.Numerics.Discrete_Random(T_couleur_id);
        Gen_Couleur:Couleur_Random.Generator;
	
end P_interface;