--#################################
--##
--## fichier réalisé par Richard Guerci & Yann Leguille & Mathieu Lauer
--##
--#################################

with structure;
use structure;
with Ada.text_io;
use Ada.text_io;
with Ada.Real_Time;
use Ada.Real_Time;

package p_traitement is
	function Traitement_selection(grille:T_grille;x,y,i,h:integer) return T_grille_bool; -- fait par Richard Guerci
	procedure Parcours_grille(Elt:T_couleur;grille:T_grille;Tab,check:in out T_grille_bool;x,y,w,z:integer); -- fait par Richard Guerci
	procedure Tri_colonne(C: in out T_colonne;Y:integer); -- fait par Yann Leguille
	procedure Tri_grille(G: in out T_grille;W:integer); -- fait par Yann Leguille
	procedure Traitement_supprime(x,y: in integer;Tab_bool: in T_grille_bool;Grille: in out T_grille); -- fait par Yann Leguille
	function Nb_selection(T:T_grille_bool;x,y:integer) return integer; -- fait par Yann Leguille
	procedure Gravite(Grille: in out T_grille;x,y:integer); -- fait par Yann Leguille
	function Fin_partie(grille:T_grille;x,y:integer) return boolean; -- fait par Yann Leguille
	function Aide_1(grille:T_grille;x,y:integer) return T_grille_bool; -- fait par Richard Guerci
	function Aide_2(grille:T_grille;x,y:integer) return T_grille_bool; -- fait par Richard Guerci
	procedure Simulation(TempsDepart:Time;grille:T_grille;x,y,profondeur:integer;points: in out integer;grille_bool: in out T_grille_bool;fond: out boolean); -- fait par Richard Guerci
	function Points(pts, selection:integer) return integer; -- fait par Mathieu Lauer
	function Meilleur_score(score : Tab_Score; nb,pts : Integer) return boolean; -- fait par Mathieu Lauer
	procedure Ajout_score(score : in out Tab_Score; nb: in out Integer;nom:string;pts:integer); -- fait par Mathieu Lauer
	function Position_score(score:Tab_Score; nb,pts:integer) return integer; -- fait par Mathieu Lauer
end p_traitement;