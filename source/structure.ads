--#################################
--##
--## fichier réalisé par Richard Guerci 
--##
--#################################

package structure is
	--constantes
	Taille_min_X:constant:=5;
	Taille_min_Y:constant:=5;
	Taille_max_X:constant:=20;
	Taille_max_Y:constant:=20;
	
	--######################
	--## TYPE POUR TRAITEMENT ##
	--######################
	
	--r pour rouge, b pour bleu, j pour jaune. x représente le vide
	type T_Couleur is (r,b,j,x);
	
	--Tableau qui représente un colonne de type T_bille:
	type T_colonne is array (1..Taille_Max_Y) of T_couleur;

	--Tableau de T_colonne:
	type T_grille is array (1..Taille_Max_X) of T_colonne;
	
	--#####################
	--## TYPE POUR SELECTION ##
	--####################
	
	--Tableau qui représente un colonne de type T_bille:
	type T_colonne_bool is array (1..Taille_Max_Y) of boolean;

	--Tableau de T_colonne:
	type T_grille_bool is array (1..Taille_Max_X) of T_colonne_bool;
	
	--#################
	--## TYPE POUR SCORE ##
	--#################
	
	type T_score is record
		points:integer:=0;
		nom:string(1..20):=(others=>' ');
	end record;
	type Tab_score is array (1..10) of T_score;

end structure;