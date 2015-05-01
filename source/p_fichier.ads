--#################################
--##
--## fichier réalisé par Nicolas Ferrari
--##
--#################################

with Ada.text_io;
use Ada.text_io;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Characters.Handling;
use Ada.Characters.Handling;

with structure;
use structure;

package p_fichier is

	function Existe(nom : string) return boolean;
	function Conforme(nom : string) return boolean;
	procedure Chargement(nom : string; z,y,points : out integer; grille : out T_Grille);
	procedure Sauvegarde(nom : in string; x,y,points : in integer; grille : in T_Grille);
	
	procedure Sauve_Score(score : Tab_Score; nb : Integer);
	procedure Charge_Score (score : out Tab_Score; nb: out Integer);
	function Conforme_Score return Boolean;
	
end p_fichier;