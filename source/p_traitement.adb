--#################################
--##
--## fichier réalisé par Richard Guerci & Yann Leguille & Mathieu Lauer
--##
--#################################

package body p_traitement is


	-----------------------------------------------------------------------------------------------------------------------------------###### fait par Richard Guerci
	-- Fonction qui renvoie un tableau de booleen qui représente les case selectionné --
	---------------------------------------------------------------------------------------------------------------------------------
	function Traitement_selection(grille:T_grille;x,y,i,h:integer) return T_grille_bool is
		res:T_grille_bool; --tableau a retourner
		check:T_grille_bool; --tableau qui check si le case a déjà été traité
	begin
		-- initialisation de la selection
		for W in reverse 1..y loop
			for Z in 1..x loop
				res(Z)(W):=false;
				check(Z)(W):=false;
			end loop;
		end loop;
		
		
		--on verifie qu'il s'agit d'un élément cliquable
		if grille(h)(i)=r or grille(h)(i)=b or grille(h)(i)=j then
			Parcours_grille(grille(h)(i),grille,res,check,x,y,i,h);--on forme la selection
		end if;
		
		return res;--on retourne le resultat
	end Traitement_selection;
	
	--------------------------------------------------------------------------------------------------------###### fait par Richard Guerci
	-- Procedure récurcive qui établie le groupe de bille séléctionné --
	------------------------------------------------------------------------------------------------------
	procedure Parcours_grille(Elt:T_couleur;grille:T_grille;Tab,check:in out T_grille_bool;x,y,w,z:integer) is
	begin
		if W+1<=y then
			if check(Z)(W+1)=false then
				check(Z)(W+1):=true;
				if Elt=grille(Z)(W+1) then
					Tab(Z)(W+1):=true;
					Parcours_grille(Elt,grille,Tab,check,x,y,w+1,z);
				end if;
			end if;
		end if;
		if W-1>=1 then
			if check(Z)(W-1)=false then
				check(Z)(W-1):=true;
				if Elt=grille(Z)(W-1) then
					Tab(Z)(W-1):=true;
					Parcours_grille(Elt,grille,Tab,check,x,y,w-1,z);
				end if;
			end if;
		end if;
		if Z+1<=x then
			if check(Z+1)(W)=false then
				check(Z+1)(W):=true;
				if Elt=grille(Z+1)(W) then
					Tab(Z+1)(W):=true;
					Parcours_grille(Elt,grille,Tab,check,x,y,w,z+1);
				end if;
			end if;
		end if;
		if Z-1>=1 then
			if check(Z-1)(W)=false then
				check(Z-1)(W):=true;
				if Elt=grille(Z-1)(W) then
					Tab(Z-1)(W):=true;
					Parcours_grille(Elt,grille,Tab,check,x,y,w,z-1);
				end if;
			end if;
		end if;
	end parcours_grille;
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------###### fait par Yann Leguille
	-- Procedure qui tri les colonnes (fait descendre les couleurs et donc place les X à la fin) --
	--------------------------------------------------------------------------------------------------------------------------------------------
	procedure Tri_colonne(C: in out T_colonne;Y:integer) is
	change:boolean:=false;
	begin
		while not change loop
			change:=true;
			for I in 1..Y-1 loop
				if C(I)=x and  C(I+1)/=x  then
					C(I..(Y-1)):=C((I+1)..Y);
					C(Y):=x;
					change:=false;
				end if;
			end loop;
		end loop;
	end Tri_colonne;
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------###### fait par Yann Leguille
	-- Procedure qui tri la grille (déplace les colonnes vides vers la gauche)                                              --
	-- Un simple test sur la premiere case d'une colonne permet de déterminer si le rang est vide ou pas. --
	---------------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure Tri_grille(G: in out T_grille;W:integer) is 
	change:boolean:=false;
	C:T_colonne;
	begin
		while not change loop
			change:=true;
			for I in 1..W-1 loop
				if G(I)(1)=x and G(I+1)(1)/=x then
					C:=G(I);
					G(I..(W-1)):=G((I+1)..W);
					G(W):=C;
					change:=false;
				end if;
			end loop;
		end loop;
	end Tri_grille;
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------###### fait par Yann Leguille
	-- Procedure qui supprime  les cases selectionné (replace la couleur par x quand la case est a vrai dans T_colonne_bool) --
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure Traitement_supprime(x,y: in integer;Tab_bool: in T_grille_bool;Grille: in out T_grille) is
	begin
		for I in reverse 1..Y loop
			for J in 1..X loop
				if  Tab_bool(J)(I)=true then
					Grille(J)(I):=T_couleur'val(3);
				end if;
			end loop;
		end loop;
	end Traitement_supprime;
	
	-------------------------------------------------------------------------------------------###### fait par Yann Leguille
	-- Fonction qui retourne le nombre de bille selectionné --
	----------------------------------------------------------------------------------------
	function Nb_selection(T:T_grille_bool;x,y:integer) return integer is
	res:integer:=0;
	begin
		for I in reverse 1..Y loop
			for J in 1..X loop
				if  T(J)(I)=true then
					res:=res+1;
				end if;
			end loop;
		end loop;
		return res;
	end Nb_selection;
	
	---------------------------------------------------------------------------------------------------------------###### fait par Yann Leguille
	-- Procedure gravité qui la trie toute la grille après une suppression --
	------------------------------------------------------------------------------------------------------------
	procedure Gravite(Grille: in out T_grille;x,y:integer) is
	begin
		for I in 1..x loop
			Tri_colonne(Grille(I),y);
		end loop;
		Tri_grille(Grille,x);
	end Gravite;
	
	---------------------------------------------------------------###### fait par Yann Leguille
	-- Fonciton qui teste si on a fini le jeu --
	------------------------------------------------------------
	function Fin_partie(grille:T_grille;x,y:integer) return boolean is
		limit:integer:=x;
		res:boolean:=true;
	begin
		for Z in 1..y loop
			for W in 1..limit loop
				if Z=1 and limit=x and grille(w)(1)=T_couleur'val(3) then -- on redéfini la limite pour optimiser
					limit:=w;
				end if;
				if Nb_selection(Traitement_selection(grille,limit,y,w,z),limit,y)>=2 then --on compte combien le groupe contient de bille
					res:=false;
				end if;
			end loop;
		end loop;
		return res;
	end Fin_partie;
	
	----------------------------------------------------------------------------###### fait par Richard Guerci
	-- Fonction qui donne le meilleur coup a jouer --
	--------------------------------------------------------------------------
	function Aide_1(grille:T_grille;x,y:integer) return T_grille_bool is
		limit:integer:=x;
		a,b:integer;
		temp,max:integer:=0;
	begin
		for Z in 1..y loop
			for W in 1..limit loop
				if Z=1 and limit=x and grille(w)(1)=T_couleur'val(3) then -- on redéfini la limite pour optimiser
					limit:=w;
				end if;
				temp:=Nb_selection(Traitement_selection(grille,limit,y,w,z),limit,y);
				if temp>=max then --on compte combien le groupe contient de bille
					a:=w;
					b:=z;
					max:=temp;
				end if;
			end loop;
		end loop;
		return Traitement_selection(grille,x,y,a,b);
	end Aide_1;
	
	---------------------------------------------------------------------------------------------------------------###### fait par Richard Guerci
	-- Fonction qui donne le meilleur coup a jouer en fonction du "futur" --
	-------------------------------------------------------------------------------------------------------------
	function Aide_2(grille:T_grille;x,y:integer) return T_grille_bool is
	res:T_grille_bool;
	n:integer:=0;
	fond:boolean;
	T:Time;
	begin
		for W in reverse 1..y loop
			for Z in 1..x loop
				res(Z)(W):=false;
			end loop;
		end loop;
		
		T:=Clock;
		Simulation(T,grille,x,y,0,n,res,fond);
		put_line("Points esperés >= "&integer'image(n));
		return res;
	end Aide_2;
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------###### fait par Richard Guerci
	-- Fonction récursive qui détermine le coup a jouer avec pour obtenir le meilleur score possible de la grille --
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure Simulation(TempsDepart:Time;grille:T_grille;x,y,profondeur:integer;points: in out integer;grille_bool: in out T_grille_bool;fond: out boolean) is
	G:T_grille;
	G_bool:T_grille_bool;
	n,pts,limite:integer;
	reste:integer:=0;
	fond_temp:boolean;
	T:Time;
	Delais:Duration:=1.5;
	begin
		for W in reverse 1..y loop
			for Z in 1..x loop
				if grille(Z)(W)/=T_couleur'val(3) then
					reste:=reste+1;
				end if;
			end loop;
		end loop;
		if reste> 300 then
			limite:=2;
		elsif reste> 140 then
			limite:=3;
		elsif reste>80 then
			limite:=4;
		else
			limite:=100;
		end if;
		
		T:=Clock;
		if Fin_partie(grille,x,y) or profondeur>=limite or T-TempsDepart>=To_Time_Span(Delais) then --condition d'arret
			if grille(1)(1)=T_couleur'val(3) then -- +1000
				points:=1000;
			else
				points:=0;
			end if;
			fond:=true;
		else
			for Z in reverse 1..y loop
				for W in 1..x loop
					G:=grille; --grille modifiable
					G_bool:=Traitement_selection(G,x,y,w,z);--selection
					n:=Nb_selection(G_bool,x,y);--nombre de selectionné
					if n>=2 and G_bool/=grille_bool then --on verifie qu'il y a au moins 2 billes selectionnées
						pts:=0;
						--on effectue la modif
						Traitement_supprime(x,y,G_bool,G);
						Gravite(G,x,y);
						--et on renvoie récusivement le grille
						Simulation(TempsDepart,G,x,y,profondeur+1,pts,G_bool,fond_temp);
						if fond_temp then
							pts:=pts+(n-2)*(n-2);
							fond:=true;
							if pts>points then
								points:=pts;
								if profondeur=0 then
									grille_bool:=G_bool;
								end if;
							end if;
						end if;
					end if;
				end loop;
			end loop;
		end if;
	end Simulation;
	
	-----------------------------------------------------###### fait par Mathieu Lauer
	-- Fonction qui calcule le score --
	--------------------------------------------------
	function Points(pts, selection:integer) return integer is
	begin
		return pts+(selection-2)*(selection-2);
	end points;
	
	----------------------------------------------------------------------------###### fait par Mathieu Lauer
	-- On cherche si le score fait partie du top 10 --
	-------------------------------------------------------------------------
	function Meilleur_score(score : Tab_Score; nb,pts : Integer) return boolean is
	begin
		if nb<10 then
			return true;
		end if;
		if nb>0 then
			if pts>score(nb).points then
				return true;
			end if;
		end if;
		return false;
	end Meilleur_score;
	
	---------------------------------------------------------------------------------------------------###### fait par Mathieu Lauer
	-- Procedure qui ajoute un score au top 10 (dans la variable) --
	------------------------------------------------------------------------------------------------
	procedure Ajout_score(score : in out Tab_Score; nb: in out Integer;nom:string;pts:integer) is
	ajoute:boolean:=false;
	I:integer:=1;
	bourage:string(1..20):=(others=>' ');
	begin
		if nb=0 then
			score(1).nom:=nom&bourage(1..(20-nom'length));
			score(1).points:=pts;
			nb:=1;
		elsif nb=10 then
			while not ajoute loop
				if pts>score(I).points then
					score((I+1)..nb):=score(I..(nb-1));
					score(I).nom:=nom&bourage(1..(20-nom'length));
					score(I).points:=pts;
					I:=I+1;
					ajoute:=true;
				end if;
				I:=I+1;
			end loop;
		else
			while not ajoute loop
				if pts>score(I).points then
					score((I+1)..(nb+1)):=score(I..(nb));
					score(I).nom:=nom&bourage(1..(20-nom'length));
					score(I).points:=pts;
					ajoute:=true;
				end if;
				I:=I+1;
			end loop;
			nb:=nb+1;
		end if;
	end Ajout_score;
	
	---------------------------------------------------------------------------------------------###### fait par Mathieu Lauer
	-- Fonction qui donne la position du score dans le top 10 --
	------------------------------------------------------------------------------------------
	function Position_score(score:Tab_Score; nb,pts:integer) return integer is
	trouve:boolean:=false;
	res:integer:=0;
	begin
		if nb=0 then
			return 1;
		else
			while  not trouve loop
				res:=res+1;
				if pts>score(res).points then
					trouve:=true;
				end if;
			end loop;
			return res;
		end if;
	end Position_score;
	
end p_traitement;