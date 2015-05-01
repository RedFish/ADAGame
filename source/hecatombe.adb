--#################################
--##
--## fichier réalisé par Richard Guerci 
--##
--#################################

-- Methode de compilation:
-- LINUX: gnatmake hecatombe.adb `gtkada-config`
-- WINDOWS: gnatmake hecatombe.adb -Ic:\gtkada\include\gtkada

--appel du paquetage gérant l'interface graphique
with Gtk.main,p_interface;
use Gtk.main,p_interface;

procedure hecatombe is
begin
        --initialisatation de l'interface graphique
        Init;
	
	--Lancement de la premiere fenetre du jeu
        Debut;
        
        --on lance la 'boucle d'action' de gtk main qui attend qu'il se passe quelque chose
        Main;
end hecatombe;