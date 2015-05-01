--#################################
--##
--## fichier réalisé par Richard Guerci 
--##
--#################################

package body P_interface is
	
	-----------------------------------------------------------------------------------
	-- Fenetre qui lance toute l'interface graphique        --
	-- Les autres fenetres découleront de son utilisation --
	-----------------------------------------------------------------------------------
	procedure Debut is
		Fenetre:Gtk_Window;
	        Boite:Gtk_Box;
	        Bouton_1,Bouton_2:Gtk_button;
	begin
		-- controle --
		put_line("Fenetre de départ - Lancement de l'interface");
		
		--initialisation de la fenetre
	        Gtk_New(Fenetre);
	        Set_Title(Fenetre,"Nouvelle partie");
	        Set_Border_Width (Fenetre,10);
	        Set_Default_Size(Fenetre,350,175);
	        --initialisation du conteneur
	        GtK_New_Vbox(Boite);
	        --initialisation des boutons
	        Gtk_New(Bouton_1,"Nouvelle partie");
	        Gtk_New(Bouton_2,"Continuer une partie");
	        
	        --Encapsulation
	        Add(Fenetre,Boite);
	        Pack_Start(Boite,Bouton_1);
		Pack_Start(Boite,Bouton_2);
	        
	        --On affiche le tout
	        Show_all(Fenetre);
	        
	        --Evenement qui permet de fermer le programme si l'on clique sur le bouton fermer
	        --Création d'un lien entre l'évenement du clique et de la procedure fermer
	        Traitement.Connect(Fenetre,"destroy",Traitement.to_Marshaller(Fermer'Access));
	        --Création d'un lien entre l'évenement du clique et de la procedure concerné
	        Traitement_fenetre.Connect(Bouton_1,"clicked",Traitement_fenetre.to_Marshaller(choix_dimensions'Access),fenetre);
	        Traitement_fenetre.Connect(Bouton_2,"clicked",Traitement_fenetre.to_Marshaller(choix_ouvrir'Access),fenetre);
	end Debut;
	
	--------------------------------------------------------------------------------------------
	-- Procedure qui ouvre la fenetre de choix des dimensions --
	--------------------------------------------------------------------------------------------
	procedure choix_dimensions(Element_declancheur:access Gtk_Widget_Record'Class;Fenetre_precedente:Gtk_window) is
	        Fenetre:Gtk_Window;
	        Boite:Gtk_Box;
	        Tableau:Gtk_Table;
	        Label,Label_1,Label_2:Gtk_Label;
	        Bouton:Gtk_Button;
	        Bouton_spin_X,Bouton_spin_Y:Gtk_Spin_Button;
	begin
	        -- controle --
	        put_line("Fenetre de choix des dimensions");
	        
	        --on efface la fenetre precedente
	        Hide(Fenetre_precedente);
	        
	        --initialisation de la fenetre
	        Gtk_New(Fenetre);
	        Set_Title(Fenetre,"Nouvelle partie");
	        Set_Border_Width (Fenetre,10);
	        Set_Default_Size(Fenetre,350,175);
	        --initialisation du conteneur
	        Gtk_New_Vbox(Boite);
	        --initialisation du tableau 4x2
	        Gtk_New(Tableau,4,2,True);
	        --initialisation des labels
	        Gtk_New(Label,"Definissez les dimensions du jeux");
	        Gtk_New(Label_1,"Nombre de ligne");
	        Gtk_New(Label_2,"Nombre de colonne");
	        --initialisation du bouton
		Gtk_New(Bouton,"OK");
		--initialisation des spins boutons
		Gtk_New(Bouton_spin_x,Gdouble(Taille_min_X),Gdouble(Taille_max_X),1.0);
		Set_Value(Bouton_spin_x,Gdouble(15));
		Gtk_New(Bouton_spin_y,Gdouble(Taille_min_Y),Gdouble(Taille_max_Y),1.0);
		Set_Value(Bouton_spin_y,Gdouble(10));
		
		--Encapsulation
		Add(Fenetre,Boite);
		Pack_Start(Boite,Tableau);
		Attach_Defaults(Tableau,Label,0,2,0,1);
		Attach_Defaults(Tableau,Label_1,0,1,1,2);
		Attach_Defaults(Tableau,Bouton_spin_y,1,2,1,2);
		Attach_Defaults(Tableau,Label_2,0,1,2,3);
		Attach_Defaults(Tableau,Bouton_spin_x,1,2,2,3);
		Attach_Defaults(Tableau,Bouton,1,2,3,4);
	        
	        --On affiche le tout
	        Show_all(Fenetre);
		
	        --Evenement qui permet de fermer le programme si l'on clique sur le bouton fermer
	        --Création d'un lien entre l'évenement du clique et de la procedure fermer
	        Traitement.Connect(Fenetre,"destroy",Traitement.to_Marshaller(Fermer'Access));
	        --Création d'un lien entre l'évenement du clique et de la procedure concerné
	        Traitement_parametre_dimensions.Connect(Bouton,"clicked",Traitement_parametre_dimensions.to_Marshaller(initialisation_choix_dimensions'Access),Initialisation_structure_parametre_dimensions(Fenetre,Bouton_spin_x,Bouton_spin_y));
	        
	end choix_dimensions;
	
	--------------------------------------------------------------------------------------------
	-- Procedure qui ouvre la fenetre de choix des dimensions --
	--------------------------------------------------------------------------------------------
	procedure choix_ouvrir(Element_declancheur:access Gtk_Widget_Record'Class;Fenetre_precedente:Gtk_window) is
	        Fenetre:Gtk_Window;
	        Boite,Boite_1,Boite_2:Gtk_Box;
		Edit:Gtk_Entry;
		Bouton:Gtk_button;
		Image:Gtk_image;
		Label,Label_1,Vide:Gtk_label;
	begin
	        -- controle --
	        put_line("Fenetre de choix du fichier");
	        
	        --on efface la fenetre precedente
	        Hide(Fenetre_precedente);
	        
	        --initialisation de la fenetre
	        Gtk_New(Fenetre);
	        Set_Title(Fenetre,"Continuer une partie");
	        Set_Border_Width (Fenetre,20);
	        Set_Default_Size(Fenetre,350,175);
	        --initialisation des conteneurs
	        Gtk_New_Vbox(Boite);
		Gtk_New_Hbox(Boite_1);
		Gtk_New_Hbox(Boite_2);
		--initialisation de l'editeur de texte
		Gtk_New(Edit);
		Set_Max_Length(Edit,20);
	        --initialisation du bouton
		Gtk_New(Bouton);
		--initialisation de l'image
		Gtk_New(Image,"images/open.xpm");
		--initialisation des labels
		Gtk_New(Label,"Entrer le nom du fichier de sauvegarde (sans l'extension)");
		Gtk_New(Label_1,"Ouvrir");
		Gtk_New(Vide," ");
		
		-- Encapsulation
		Add(Fenetre,Boite);
		Pack_Start(Boite,Label);
		Pack_Start(Boite,Boite_1);
		Pack_Start(Boite_1,Edit);
		Pack_Start(Boite_1,Vide);
		Pack_Start(Boite_1,Bouton);
		Add(Bouton,Boite_2);
		Pack_Start(Boite_2,image);
		Pack_Start(Boite_2,label_1);
		
	        --On affiche le tout
	        Show_all(Fenetre);
		
	        --Evenement qui permet de fermer le programme si l'on clique sur le bouton fermer
	        --Création d'un lien entre l'évenement du clique et de la procedure fermer
	        Traitement.Connect(Fenetre,"destroy",Traitement.to_Marshaller(Fermer'Access));
	        --Création d'un lien entre l'évenement du clique et de la procedure concerné
	        Traitement_parametre_ouvrir.Connect(Bouton,"clicked",Traitement_parametre_ouvrir.to_Marshaller(initialisation_choix_ouvrir'Access),Initialisation_structure_prarametre_ouvrir(Fenetre,Edit));
	        
	end choix_ouvrir;
	
	---------------------------------------------------------------------------------------------------------------
	-- Procedure qui traite les données optenu dans la fenetre precedente --
	-- préparation du jeu à partir des dimensions                                        --
	---------------------------------------------------------------------------------------------------------------
	procedure initialisation_choix_dimensions(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_dimensions) is
		X:integer:=Gint'pos(Get_value_as_int(parametre.X));
		Y:integer:=Gint'pos(Get_value_as_int(parametre.Y));
		Grille:T_struct_grille;
	begin
		-- controle --
		put_line("Initialisation de la partie à partir des dimensions X="&Integer'image(X)&" Y="&Integer'Image(Y));
		
	        --on efface la fenetre precedente
	        Hide(parametre.Fenetre);
		
		--on initialise la grille
		Initialisation_grille(Grille,X,Y);
		
		-- On lance la fenetre centrale
		Partie(Grille);
		
	end initialisation_choix_dimensions;
	
	---------------------------------------------------------------------------------------------------------------
	-- Procedure qui traite les données optenu dans la fenetre precedente --
	-- préparation du jeu a partir du fichier                                                --
	---------------------------------------------------------------------------------------------------------------
	procedure initialisation_choix_ouvrir(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_ouvrir) is
		NomFichier:string:=Get_Text(parametre.Edit);
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
		Grille:T_struct_grille;
		G:T_grille;
		x,y,points:integer;
	begin
		-- controle --
		put_line("Initialisation de la partie à partir d'un fichier");
		
		-- On teste si le champs n'est pas vide
		if NomFichier="" then
			Gtk_New(Dialog,parametre.fenetre,0,Message_Warning,Buttons_Close,LF&"Vous devez entrer le nom"&LF&"   du fichier a charger.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		elsif not Existe(NomFichier&".hecatombe") then
			Gtk_New(Dialog,parametre.fenetre,0,Message_Error,Buttons_Close,LF&"Le nom du fichier est incorrect.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		elsif not Conforme(NomFichier&".hecatombe") then
			Gtk_New(Dialog,parametre.fenetre,0,Message_Error,Buttons_Close,LF&"Le fichier n'est pas compatible.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		else
			Hide(parametre.Fenetre);
			
			-- controle --
			put_line("Chargement de "&NomFichier&".hecatombe");
			
			Chargement(NomFichier&".hecatombe",x,y,points,G);
			put_line("X="&integer'image(x));
			put_line("Y="&integer'image(y));
			put_line("POINTS="&integer'image(points));
			Grille.X:=X;
			Grille.Y:=Y;
			Gtk_new(Grille.points,Integer'image(points));
			for I in reverse 1..Y loop
				for J in 1..X loop
					Gtk_new(Grille.Element(J)(I).Couleur,T_couleur'image(G(J)(I)));
				end loop;
			end loop;
			Partie(Grille);
		end if;
		
	end initialisation_choix_ouvrir;
	
	----------------------------------------------------------------------------------------
	-- Initialisation de variable T_struct_grille (de facon aléatoire) --
	----------------------------------------------------------------------------------------
	procedure Initialisation_grille(G:out T_struct_grille;X: in integer;Y: in integer) is
		-- variable nécessaire au randome
		Pos_Couleur_Rand:T_couleur_id;
	begin
		-- controle --
		put_line("Initialisation de la Grille");
		
		G.X:=X;
		G.Y:=Y;
		Gtk_new(G.points,"0");
		
		for I in reverse 1..Y loop
			for J in 1..X loop
				Pos_couleur_Rand:=Couleur_Random.Random(Gen_Couleur);
				Gtk_new(G.Element(J)(I).Couleur,T_couleur'image(T_couleur'Val(Pos_Couleur_Rand)));
				--controle--
				put(T_couleur'image(T_couleur'Val(Pos_Couleur_Rand)));
			end loop;
			-- controle --
			New_line;
		end loop;
		
	end Initialisation_grille;
	
	----------------------------------------------------------------------------------------------------------------------
	-- Fonction qui crée la structure en fonction de ses éléments en paramètre --
	-- structure parametre_dimensions                                                              --
	----------------------------------------------------------------------------------------------------------------------
	function Initialisation_structure_parametre_dimensions(Fenetre:Gtk_window;X,Y:Gtk_spin_button) return parametre_dimensions is
		res:parametre_dimensions;
	begin
		res.Fenetre:=Fenetre;
		res.X:=X;
		res.Y:=Y;
		return res;
	end Initialisation_structure_parametre_dimensions;
	
	----------------------------------------------------------------------------------------------------------------------
	-- Fonction qui crée la structure en fonction de ses éléments en paramètre --
	-- structure parametre_ouvrir                                                                      --
	----------------------------------------------------------------------------------------------------------------------
	function Initialisation_structure_prarametre_ouvrir(Fenetre:Gtk_window;Edit:Gtk_Entry) return parametre_ouvrir is
		res:parametre_ouvrir;
	begin
		res.Fenetre:=Fenetre;
		res.Edit:=Edit;
		return res;
	end Initialisation_structure_prarametre_ouvrir;
	
	------------------------------------------------------------------------
	-- Procedure qui ferme une boite de dialogue --
	------------------------------------------------------------------------
	procedure Fermer_Information(Element_declancheur:access Gtk_Widget_Record'Class;Dialog:Gtk_Message_Dialog) is
	begin
		Hide(Dialog);
		Destroy(Dialog);
	end Fermer_Information;
	
	----------------------------------------------------------------------------------------------------------------------
	-- Fonction qui crée la structure en fonction de ses éléments en paramètre --
	-- structure parametre_grille                                                                       --
	----------------------------------------------------------------------------------------------------------------------
	function Initialisation_structure_parametre_grille(Grille:T_struct_grille;J,I:integer;Selection:Gtk_label) return parametre_grille is
		res:parametre_grille;
	begin
		res.Grille:=Grille;
		res.J:=J;
		res.I:=I;
		res.Selection:=Selection;
		return res;
	end Initialisation_structure_parametre_grille;
	
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Procedure qui modifie les éléments(couleur,selection) de la fenetre quand on passe devant un bouton(J,I) --
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure Selection(Element_declancheur:access Gtk_Widget_Record'Class;parametre: parametre_grille) is
		Tab_couleur:T_grille;
		Tab_booleen:T_grille_bool;
	begin
		-- On convertie la grille de bouton en couleur
		Tab_couleur:=Graph_to_couleur(parametre.grille);
		-- On réalise le traitement de la selection (retour d'un tableau de booleen)
		Tab_booleen:=Traitement_selection(Tab_couleur,parametre.grille.x,parametre.grille.y,parametre.i,parametre.j);
		-- Affichage de la selection
		for Y in reverse 1..parametre.grille.Y loop
			for Z in 1..parametre.grille.X loop
				if Tab_booleen(Z)(Y) then
					Set_Relief(parametre.grille.Element(Z)(Y).bouton,Relief_Normal);
				else
					Set_Relief(parametre.grille.Element(Z)(Y).bouton,Relief_None);
				end if;
			end loop;
		end loop;
		-- on affiche la selection (le nombre)
		Set_text(Parametre.Selection,integer'image(Nb_selection(Tab_booleen,Parametre.grille.x,Parametre.grille.y)));
	end Selection;
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Procedure qui modifie les éléments(couleur,points) de la fenetre quand on clique devant un bouton(J,I) --
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure Clique(Element_declancheur:access Gtk_Widget_Record'Class;parametre: parametre_grille) is
		Tab_couleur:T_grille;
		Tab_booleen:T_grille_bool;
		Fenetre:Gtk_Window;
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
		Score:Tab_Score;
		Nb_score:integer;
	begin
		-- On convertie la grille de bouton en couleur
		Tab_couleur:=Graph_to_couleur(parametre.Grille);
		-- On réalise le traitement de la selection (retour d'un tableau de booleen)
		Tab_booleen:=Traitement_selection(Tab_couleur,parametre.grille.x,parametre.grille.y,parametre.i,parametre.j);
		-- On vérifie que la selection contient au moins 2 billes
		if Nb_selection(Tab_booleen,parametre.grille.x,parametre.grille.y)>=2 then
			-- On supprime des billes selectionné
			Traitement_supprime(parametre.grille.X,parametre.grille.Y,Tab_booleen,Tab_couleur);
			-- On fait tomber les billes
			Gravite(Tab_couleur,parametre.grille.X,parametre.grille.Y);
			-- On modifie la couleur des boutons en fonction de Tab_couleur
			for Y in reverse 1..parametre.grille.Y loop
				for Z in 1..parametre.grille.X loop
					case Tab_couleur(Z)(Y) is
						when r=>Set(parametre.grille.Element(Z)(Y).image,"images/R.xpm");
							Set_Text(parametre.grille.Element(Z)(Y).couleur,"R");
						when b=>Set(parametre.grille.Element(Z)(Y).image,"images/B.xpm");
							Set_Text(parametre.grille.Element(Z)(Y).couleur,"B");
						when j=>Set(parametre.grille.Element(Z)(Y).image,"images/J.xpm");
							Set_Text(parametre.grille.Element(Z)(Y).couleur,"J");
						when x=>Set(parametre.grille.Element(Z)(Y).image,"images/X.xpm");
							Set_Text(parametre.grille.Element(Z)(Y).couleur,"X");
					end case;
				end loop;
			end loop;
			-- MAJ du score
			Set_text(Parametre.Grille.points,Trim(integer'image(Points(integer'value(Get_Text(Parametre.Grille.points)),Nb_selection(Tab_booleen,Parametre.grille.x,Parametre.grille.y))),Left));
			-- la grille est vide on rajoute 1000 points
			if  Tab_couleur(1)(1)=x then
				Set_text(Parametre.Grille.points,Trim(integer'image(integer'value(Get_Text(Parametre.Grille.points))+1000),Left));
			end if;
			--On remet a jour la selection
			Tab_booleen:=Traitement_selection(Tab_couleur,parametre.grille.x,parametre.grille.y,parametre.i,parametre.j);
			for Y in reverse 1..parametre.grille.Y loop
				for Z in 1..parametre.grille.X loop
					if Tab_booleen(Z)(Y) then
						Set_Relief(parametre.grille.Element(Z)(Y).bouton,Relief_Normal);
					else
						Set_Relief(parametre.grille.Element(Z)(Y).bouton,Relief_None);
					end if;
				end loop;
			end loop;
			-- on affiche la selection (le nombre)
			Set_text(Parametre.Selection,integer'image(Nb_selection(Tab_booleen,Parametre.grille.x,Parametre.grille.y)));
			if Fin_partie(Tab_couleur,parametre.grille.x,parametre.grille.y) then
				Gtk_new(fenetre);
				Gtk_New(Dialog,Fenetre,0,Message_Info,Buttons_Close,LF&"La partie est finie.");
				Show(Dialog);
				Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
				
				--On charge le fichier score
				Charge_Score(Score,Nb_score);
				--On vérifie si s'est un nouveau score
				if Meilleur_score(Score,Nb_score,(integer'value(Get_Text(Parametre.Grille.points)))) then
					Fenetre_Ajout_Score(integer'value(Get_Text(Parametre.Grille.points)));
				end if;
			end if;
		end if;
	end Clique;
	
	--------------------------------------------------------------------------------------------------------
	-- Fonction qui convertie une grille de type T_struct_grille en T_grille --
	--------------------------------------------------------------------------------------------------------
	function Graph_to_couleur(G:T_struct_grille) return T_grille is
		res:T_grille;
	begin
		for I in reverse 1..G.Y loop
			for J in 1..G.X loop
				res(J)(I):=T_couleur'value(Get_Text(G.Element(J)(I).couleur));
			end loop;
		end loop;
		return res;
	end;
	
	--------------------------------------------------------
	-- Procedure qui affiche le jeu        --
	-- Elle est le centre du programme --
	--------------------------------------------------------
	procedure Partie(G:T_struct_grille) is
		Fenetre:Gtk_Window;
	        Boite,Boite_1,Boite_2,Boite_3,Boite_4:Gtk_Box;
	        bouton_1,bouton_2,bouton_3,bouton_4,bouton_5,bouton_6,bouton_7:Gtk_Button;
	        image_1,image_2,image_3,image_4,image_5:Gtk_Image;
	        Label_1,Label_2,Label_3:Gtk_Label;
	        Frame:Gtk_Frame;
	        Tableau,Tableau_2:Gtk_Table;
		Grille:T_struct_grille:=G;
	begin
		-- controle --
		Put_line("Fenetre de jeu");
		
		--initialisation de la fenetre
	        Gtk_New(Fenetre);
	        Set_Title(Fenetre,"Hecatombe");
	        Set_Border_Width (Fenetre,5);
	        Set_Default_Size(Fenetre,Gint(Grille.X*34),Gint(Grille.Y*34));
	        --initialisation des conteneurs
	        Gtk_New_Vbox(boite);
	        Gtk_New_Hbox(boite_1);
	        Gtk_New_Vbox(boite_2);
	        Gtk_New_Hbox(boite_3);
	        Gtk_New_Hbox(boite_4);
	        --initialisation des boutons
	        Gtk_New(bouton_1);
	        Gtk_New(bouton_2);
	        Gtk_New(bouton_3);
	        Gtk_New(bouton_4);
	        Gtk_New(bouton_5);
	        Gtk_New(bouton_6,"Aide");
	        Gtk_New(bouton_7,"Aide +");
		--initialisation des images
	        Gtk_New(image_1,"images/new.xpm");
	        Gtk_New(image_2,"images/open.xpm");
	        Gtk_New(image_3,"images/save.xpm");
	        Gtk_New(image_4,"images/highscore.xpm");
	        Gtk_New(image_5,"images/exit.xpm");
	        --initialisation du conteneur frame
	        Gtk_New(Frame);
	        --initialisation des labels
	        Gtk_New(Label_1,"Total:");
	        Gtk_New(Label_2,"Selection:");
	        Gtk_New(Label_3," 0  ");
	        --initialisation du tableau YxX
	        Gtk_New(Tableau,Guint(Grille.Y),Guint(Grille.X),True);
	        --initialisation du tableau 3x3
	        Gtk_New(Tableau_2,3,3,True);
	        
	        
		--Encapsulation
	        Add(fenetre,boite);
	        --bouton et tableau
	        Pack_Start(boite,boite_1);
	        Pack_Start(boite_1,boite_2);
	        Pack_Start(boite_2,Bouton_1);
	        Add(Bouton_1,image_1);
	        Pack_Start(boite_2,Bouton_2);
	        Add(Bouton_2,image_2);
	        Pack_Start(boite_2,Bouton_3);
	        Add(Bouton_3,image_3);
	        Pack_Start(boite_2,Bouton_4);
	        Add(Bouton_4,image_4);
	        Pack_Start(boite_2,Bouton_5);
	        Add(Bouton_5,image_5);
	        Pack_Start(boite_1,Frame);
	        Add(Frame,Tableau);
		for I in reverse 1..Grille.Y loop
			for J in 1..Grille.X loop
				--initialisation du bouton
				Gtk_new(Grille.Element(J)(I).bouton);
				Set_Relief(Grille.Element(J)(I).bouton,Relief_None);
				Set_Focus_On_Click(Grille.Element(J)(I).bouton,false);
				--placement des billes(boutons) dans le tableau
				Attach_Defaults(Tableau,Grille.Element(J)(I).bouton,Guint(J)-1,Guint(J),Guint(Grille.Y-I),Guint(Grille.Y-I)+1);
				--initialisation de l'image en fonction de la couleur
				Gtk_new(Grille.Element(J)(I).image,"images/"&Get_Text(Grille.Element(J)(I).couleur)&".xpm");
				--encapsulation
				Add(Grille.Element(J)(I).bouton,Grille.Element(J)(I).image);
			end loop;
		end loop;
	        --tableau 2
	        Add(boite,Tableau_2);
	        Attach_Defaults(Tableau_2,Boite_3,0,1,1,2);
	        Pack_Start(Boite_3,Label_1);
	        Pack_Start(Boite_3,Grille.points);
	        Attach_Defaults(Tableau_2,Boite_4,0,1,2,3);
	        Pack_Start(Boite_4,Label_2);
	        Pack_Start(Boite_4,Label_3);
	        Attach_Defaults(Tableau_2,Bouton_6,2,3,1,2);
	        Attach_Defaults(Tableau_2,Bouton_7,2,3,2,3);
		
		--On affiche le tout
		Show_all(Fenetre);
		
		--Evenement qui permet de fermer le programme si l'on clique sur le bouton fermer
	        --Création d'un lien entre l'évenement du clique et de la procedure fermer
	        Traitement.Connect(fenetre,"destroy",Traitement.to_Marshaller(Fermer'Access));
		--Création d'un lien entre l'évenement du clique et de la procedure concerné
	        Traitement_fenetre.Connect(Bouton_1,"clicked",Traitement_fenetre.to_Marshaller(choix_dimensions'Access),fenetre);
	        Traitement_fenetre.Connect(Bouton_2,"clicked",Traitement_fenetre.to_Marshaller(choix_ouvrir'Access),fenetre);
	        Traitement_parametre_sauve.Connect(Bouton_3,"clicked",Traitement_parametre_sauve.to_Marshaller(Fenetre_sauvegarde'Access),Initialisation_structure_prarametre_sauve(Grille,false));
	        Traitement.Connect(Bouton_4,"clicked",Traitement.to_Marshaller(Fenetre_Score'Access));
	        Traitement_parametre_sauve.Connect(Bouton_5,"clicked",Traitement_parametre_sauve.to_Marshaller(Fermer_Sauvegarde'Access),Initialisation_structure_prarametre_sauve(Grille,true));
	        Traitement_parametre_triche.Connect(Bouton_6,"clicked",Traitement_parametre_triche.to_Marshaller(Gestion_triche'Access),Initialisation_structure_prarametre_triche(Grille,false,Label_3));
	        Traitement_parametre_triche.Connect(Bouton_7,"clicked",Traitement_parametre_triche.to_Marshaller(Gestion_triche'Access),Initialisation_structure_prarametre_triche(Grille,true,Label_3));
		for I in reverse 1..Grille.Y loop
			for J in 1..Grille.X loop
				--Gestion de la selection
				Traitement_parametre_grille.Connect(Grille.Element(J)(I).bouton,"enter",Traitement_parametre_grille.to_Marshaller(Selection'Access),Initialisation_structure_parametre_grille(Grille,J,I,Label_3));
				--Gestion du clique
				Traitement_parametre_grille.Connect(Grille.Element(J)(I).bouton,"clicked",Traitement_parametre_grille.to_Marshaller(Clique'Access),Initialisation_structure_parametre_grille(Grille,J,I,Label_3));
			end loop;
		end loop;
		
	end Partie;
	
	---------------------------------------------------------------------------------------
	-- Fonction qui initialise la structure parametre_sauve --
	--------------------------------------------------------------------------------------
	function  Initialisation_structure_prarametre_sauve(G:T_struct_grille;opt:boolean) return parametre_sauve is
		res:parametre_sauve;
	begin
		res.Grille:=G;
		res.option:=opt;
		return res;
	end Initialisation_structure_prarametre_sauve;
	
	------------------------------------------------------------------------------------------
	-- Fonction qui initialise la structure parametre_sauve_2 --
	-----------------------------------------------------------------------------------------
	function  Initialisation_structure_prarametre_sauve_2(Fenetre:Gtk_window;Struct:parametre_sauve;Edit:Gtk_Entry) return parametre_sauve_2 is
		res:parametre_sauve_2;
	begin
		res.fenetre:=fenetre;
		res.Struct:=struct;
		res.edit:=edit;
		return res;
	end Initialisation_structure_prarametre_sauve_2;
	
	--------------------------------------------------------------------------------------------
	-- Procedure qui permet la sauvegarde de la partie --
	--------------------------------------------------------------------------------------------
	procedure Fenetre_sauvegarde(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_sauve) is
		Fenetre:Gtk_Window;
		Boite,Boite_1,Boite_2,Boite_3:Gtk_Box;
		Edit:Gtk_Entry;
		Bouton,Bouton_1:Gtk_button;
		Image,Image_1:Gtk_image;
		Label,Label_1,Label_2,Vide:Gtk_label;
		Tab_couleur:T_grille;
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
	begin
		-- controle --
		put_line("Fenetre de sauvegarde");
		
		--initialisation de la fenetre
		Gtk_New(Fenetre);
		
		-- On verifie que la partie n'est pas fini avant de sauvegarder
		Tab_couleur:=Graph_to_couleur(parametre.Grille);
		if Fin_partie(Tab_couleur,parametre.grille.x,parametre.grille.y) then
			Gtk_New(Dialog,fenetre,0,Message_Error,Buttons_Close,LF&"Vous ne pouvez pas sauvegarder une partie finie.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		else
			--initialisation de la fenetre
			Gtk_New(Fenetre);
			Set_Title(Fenetre,"Sauvegarder votre partie");
			Set_Border_Width (Fenetre,20);
			Set_Default_Size(Fenetre,410,175);
			--initialisation des conteneurs
			Gtk_New_Vbox(Boite);
			Gtk_New_Hbox(Boite_1);
			Gtk_New_Hbox(Boite_2);
			Gtk_New_Hbox(Boite_3);
			--initialisation de l'editeur de texte
			Gtk_New(Edit);
			Set_Max_Length(Edit,20);
			--initialisation du bouton
			Gtk_New(Bouton);
			Gtk_New(Bouton_1);
			--initialisation de l'image
			Gtk_New(Image,"images/save.xpm");
			Gtk_New(Image_1,"images/annule.xpm");
			--initialisation des labels
			Gtk_New(Label,"Entrer le nom du fichier de sauvegarde (sans l'extension)");
			if parametre.option then --On regarde si on veut quitter après la sauvegarde
				Gtk_New(Label_1,"Sauver et quitter");
			else
				Gtk_New(Label_1,"Sauver");
			end if;
			Gtk_New(Label_2,"Annuler");
			Gtk_New(Vide," ");
			
			-- Encapsulation
			Add(Fenetre,Boite);
			Pack_Start(Boite,Label);
			Pack_Start(Boite,Boite_1);
			Pack_Start(Boite_1,Edit);
			Pack_Start(Boite_1,Vide);
			Pack_Start(Boite_1,Bouton);
			Add(Bouton,Boite_2);
			Pack_Start(Boite_2,image);
			Pack_Start(Boite_2,label_1);
			Pack_Start(Boite_1,Bouton_1);
			Add(Bouton_1,Boite_3);
			Pack_Start(Boite_3,image_1);
			Pack_Start(Boite_3,Label_2);
			
			--On affiche le tout
			Show_all(Fenetre);
			
			--Evenement qui permet de fermer le programme si l'on clique sur le bouton fermer
			--Création d'un lien entre l'évenement du clique et de la procedure fermer
			Traitement.Connect(Fenetre,"destroy",Traitement.to_Marshaller(Fermer'Access));
			--Création d'un lien entre l'évenement du clique et de la procedure concerné
			Traitement_parametre_sauve_2.Connect(Bouton,"clicked",Traitement_parametre_sauve_2.to_Marshaller(Gestion_sauvegarde'Access),Initialisation_structure_prarametre_sauve_2(Fenetre,parametre,Edit));
			Traitement_fenetre.Connect(Bouton_1,"clicked",Traitement_fenetre.to_Marshaller(Annuler'Access),fenetre);
		end if;
	end Fenetre_sauvegarde;
	
	
	procedure Gestion_sauvegarde(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_sauve_2) is
		NomFichier:string:=Get_Text(parametre.Edit);
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
		points:integer;
	begin
		
		-- On teste si le champs n'est pas vide
		if NomFichier="" then
			Gtk_New(Dialog,parametre.fenetre,0,Message_Info,Buttons_Close,LF&"Vous devez entrer le nom"&LF&"   du fichier pour sauvegarder.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		elsif Existe(NomFichier&".hecatombe") then
			Gtk_New(Dialog,parametre.fenetre,0,Message_Error,Buttons_Close,LF&"Le nom du fichier existe deja.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		else
			-- controle --
			put_line("Sauvegarde du fichier "&NomFichier&".hecatombe");
			-- On ferme la fenetre de sauvegarde
			Hide(parametre.Fenetre);
			
			points:=Integer'value(Get_Label(parametre.Struct.Grille.points));
			Sauvegarde(NomFichier&".hecatombe",parametre.Struct.Grille.x,parametre.Struct.Grille.y,points,Graph_to_couleur(parametre.Struct.Grille));
			
			-- On ferme le programme si l'option est a vrai
			if parametre.Struct.option then
				-- controle --
				put_line("Fermeture du programme");
				Main_quit;
			end if;
		end if;
		
		
	end Gestion_sauvegarde;
	
	---------------------------------------------------------------------------------------
	-- Fonction qui initialise la structure parametre_sauve --
	--------------------------------------------------------------------------------------
	function  Initialisation_structure_prarametre_triche(G:T_struct_grille;opt:boolean;selection:Gtk_label) return parametre_triche is
		res:parametre_triche;
	begin
		res.Grille:=G;
		res.option:=opt;
		res.selection:=selection;
		return res;
	end Initialisation_structure_prarametre_triche;
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Traitement de la relation de la triche entre le traitement du packetage et l'interface graphique --
	---------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure Gestion_triche(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_triche) is
		Fenetre:Gtk_window;
		Tab_couleur:T_grille;
		Tab_booleen:T_grille_bool;
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
	begin
		-- controle --
		put_line("Triche");
		
		--initialisation de la fenetre
		Gtk_New(Fenetre);
		
		-- On verifie que la partie n'est pas fini avant de sauvegarder
		Tab_couleur:=Graph_to_couleur(parametre.Grille);
		if Fin_partie(Tab_couleur,parametre.grille.x,parametre.grille.y) then
			Gtk_New(Dialog,fenetre,0,Message_info,Buttons_Close,LF&"La partie est finie.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		else
			-- On convertie la grille de bouton en couleur
			Tab_couleur:=Graph_to_couleur(parametre.grille);
			-- On réalise le traitement de la selection (retour d'un tableau de booleen)
			if not parametre.option then
				Tab_booleen:=Aide_1(Tab_couleur,parametre.Grille.x,parametre.Grille.y);
			else
				Tab_booleen:=Aide_2(Tab_couleur,parametre.Grille.x,parametre.Grille.y);
			end if;
			-- Affichage de la selection
			for Y in reverse 1..parametre.grille.Y loop
				for Z in 1..parametre.grille.X loop
					if Tab_booleen(Z)(Y) then
						Set_Relief(parametre.grille.Element(Z)(Y).bouton,Relief_Normal);
					else
						Set_Relief(parametre.grille.Element(Z)(Y).bouton,Relief_None);
					end if;
				end loop;
			end loop;
			-- on affiche la selection (le nombre)
			Set_text(Parametre.Selection,integer'image(Nb_selection(Tab_booleen,Parametre.grille.x,Parametre.grille.y)));
		end if;
	end Gestion_triche;
	
	----------------------------------------------------------------------
	-- Fenetre qui permet l'affichage des scores --
	---------------------------------------------------------------------
	procedure Fenetre_Score(Element_declancheur:access Gtk_Widget_Record'Class) is
		Score:Tab_Score;
		Nb_score:integer;
		Fenetre:Gtk_window;
		Boite,Boite_1:Gtk_box;
		Tableau:Gtk_table;
		Label,Label_1,Label_2,Label_3,Label_4,Label_1_1,Label_1_2,Label_2_1,Label_2_2,Label_3_1,Label_3_2,Label_4_1,Label_4_2,Label_5_1,Label_5_2,Label_6_1,Label_6_2,Label_7_1,Label_7_2,Label_8_1,Label_8_2,Label_9_1,Label_9_2,Label_10_1,Label_10_2:Gtk_Label;
		Image,image_1,image_2,image_3,image_4,image_5,image_6,image_7,image_8,image_9,image_10:Gtk_image;
		Bouton:Gtk_button;
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
	begin
		-- controle --
		put_line("Fenetre Score");
		
		--initialisation de la fenetre
		Gtk_New(Fenetre);
		--On charge le fichier score
		Charge_Score(Score,Nb_score);
		
		-- On verifie que le fichier de score existe
		if Nb_score=0 then
			Gtk_New(Dialog,fenetre,0,Message_info,Buttons_Close,LF&"Il n'y a pas de HighScores.");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		else
			--initialisation de la fenetre
			Set_Title(Fenetre,"HighScores");
			Set_Border_Width (Fenetre,20);
			--initialisation des conteneurs
			Gtk_New_Vbox(Boite);
			Gtk_New_Hbox(Boite_1);
			--initialisation du tableau
			Gtk_New(Tableau,12,3,True);
			--initialisation du bouton
			Gtk_New(Bouton);
			--initialisation de l'image
			Gtk_New(Image,"images/annule.xpm");
			Gtk_New(Image_1,"images/1.xpm");
			Gtk_New(Image_2,"images/2.xpm");
			Gtk_New(Image_3,"images/3.xpm");
			Gtk_New(Image_4,"images/4.xpm");
			Gtk_New(Image_5,"images/5.xpm");
			Gtk_New(Image_6,"images/6.xpm");
			Gtk_New(Image_7,"images/7.xpm");
			Gtk_New(Image_8,"images/8.xpm");
			Gtk_New(Image_9,"images/9.xpm");
			Gtk_New(Image_10,"images/10.xpm");
			--initialisation des labels
			Gtk_New(Label,"Tableau des Scores");
			Gtk_New(Label_1,"Place");
			Gtk_New(Label_2,"Score");
			Gtk_New(Label_3,"Nom");
			Gtk_New(Label_4,"Fermer");
			Gtk_New(Label_1_1,Integer'image(Score(1).points));
			Gtk_New(Label_1_2,Trim(Score(1).nom,Right));
			if  Nb_score>=2 then
				Gtk_New(Label_2_1,Integer'image(Score(2).points));
				Gtk_New(Label_2_2,Trim(Score(2).nom,Right));
			else
				Gtk_New(Label_2_1,"/");
				Gtk_New(Label_2_2,"/");
			end if;
			if  Nb_score>=3 then
				Gtk_New(Label_3_1,Integer'image(Score(3).points));
				Gtk_New(Label_3_2,Trim(Score(3).nom,Right));
			else
				Gtk_New(Label_3_1,"/");
				Gtk_New(Label_3_2,"/");
			end if;
			if  Nb_score>=4 then
				Gtk_New(Label_4_1,Integer'image(Score(4).points));
				Gtk_New(Label_4_2,Trim(Score(4).nom,Right));
			else
				Gtk_New(Label_4_1,"/");
				Gtk_New(Label_4_2,"/");
			end if;
			if  Nb_score>=5 then
				Gtk_New(Label_5_1,Integer'image(Score(5).points));
				Gtk_New(Label_5_2,Trim(Score(5).nom,Right));
			else
				Gtk_New(Label_5_1,"/");
				Gtk_New(Label_5_2,"/");
			end if;
			if  Nb_score>=6 then
				Gtk_New(Label_6_1,Integer'image(Score(6).points));
				Gtk_New(Label_6_2,Trim(Score(6).nom,Right));
			else
				Gtk_New(Label_6_1,"/");
				Gtk_New(Label_6_2,"/");
			end if;
			if  Nb_score>=7 then
				Gtk_New(Label_7_1,Integer'image(Score(7).points));
				Gtk_New(Label_7_2,Trim(Score(7).nom,Right));
			else
				Gtk_New(Label_7_1,"/");
				Gtk_New(Label_7_2,"/");
			end if;
			if  Nb_score>=8 then
				Gtk_New(Label_8_1,Integer'image(Score(8).points));
				Gtk_New(Label_8_2,Trim(Score(8).nom,Right));
			else
				Gtk_New(Label_8_1,"/");
				Gtk_New(Label_8_2,"/");
			end if;
			if  Nb_score>=9 then
				Gtk_New(Label_9_1,Integer'image(Score(9).points));
				Gtk_New(Label_9_2,Trim(Score(9).nom,Right));
			else
				Gtk_New(Label_9_1,"/");
				Gtk_New(Label_9_2,"/");
			end if;
			if  Nb_score>=10 then
				Gtk_New(Label_10_1,Integer'image(Score(10).points));
				Gtk_New(Label_10_2,Trim(Score(10).nom,Right));
			else
				Gtk_New(Label_10_1,"/");
				Gtk_New(Label_10_2,"/");
			end if;
			
			
			-- Encapsulation
			Add(Fenetre,Boite);
			Pack_Start(Boite,Label);
			Pack_Start(Boite,Tableau);
				Attach_Defaults(Tableau,Label_1,0,1,0,1);
				Attach_Defaults(Tableau,Label_2,1,2,0,1);
				Attach_Defaults(Tableau,Label_3,2,3,0,1);
				Attach_Defaults(Tableau,image_1,0,1,1,2);
				Attach_Defaults(Tableau,Label_1_1,1,2,1,2);
				Attach_Defaults(Tableau,Label_1_2,2,3,1,2);
				Attach_Defaults(Tableau,image_2,0,1,2,3);
				Attach_Defaults(Tableau,Label_2_1,1,2,2,3);
				Attach_Defaults(Tableau,Label_2_2,2,3,2,3);
				Attach_Defaults(Tableau,image_3,0,1,3,4);
				Attach_Defaults(Tableau,Label_3_1,1,2,3,4);
				Attach_Defaults(Tableau,Label_3_2,2,3,3,4);
				Attach_Defaults(Tableau,image_4,0,1,4,5);
				Attach_Defaults(Tableau,Label_4_1,1,2,4,5);
				Attach_Defaults(Tableau,Label_4_2,2,3,4,5);
				Attach_Defaults(Tableau,image_5,0,1,5,6);
				Attach_Defaults(Tableau,Label_5_1,1,2,5,6);
				Attach_Defaults(Tableau,Label_5_2,2,3,5,6);
				Attach_Defaults(Tableau,image_6,0,1,6,7);
				Attach_Defaults(Tableau,Label_6_1,1,2,6,7);
				Attach_Defaults(Tableau,Label_6_2,2,3,6,7);
				Attach_Defaults(Tableau,image_7,0,1,7,8);
				Attach_Defaults(Tableau,Label_7_1,1,2,7,8);
				Attach_Defaults(Tableau,Label_7_2,2,3,7,8);
				Attach_Defaults(Tableau,image_8,0,1,8,9);
				Attach_Defaults(Tableau,Label_8_1,1,2,8,9);
				Attach_Defaults(Tableau,Label_8_2,2,3,8,9);
				Attach_Defaults(Tableau,image_9,0,1,9,10);
				Attach_Defaults(Tableau,Label_9_1,1,2,9,10);
				Attach_Defaults(Tableau,Label_9_2,2,3,9,10);
				Attach_Defaults(Tableau,image_10,0,1,10,11);
				Attach_Defaults(Tableau,Label_10_1,1,2,10,11);
				Attach_Defaults(Tableau,Label_10_2,2,3,10,11);
				Attach_Defaults(Tableau,Bouton,1,2,11,12);
					Add(Bouton,Boite_1);
						Pack_Start(Boite_1,image);
						Pack_Start(Boite_1,label_4);
			
			--On affiche le tout
			Show_all(Fenetre);
			
			--Création d'un lien entre l'évenement du clique et de la procedure concerné
			Traitement_fenetre.Connect(fenetre,"destroy",Traitement_fenetre.to_Marshaller(Annuler'Access),fenetre);
			Traitement_fenetre.Connect(Bouton,"clicked",Traitement_fenetre.to_Marshaller(Annuler'Access),fenetre);
		end if;
	end Fenetre_Score;
	
	---------------------------------------------------------------------------------
	-- Fonction qui crée la procedure parametre_score --
	---------------------------------------------------------------------------------
	function Initialisation_structure_prarametre_score(Fenetre:Gtk_window;Edit:Gtk_Entry;pts:integer) return parametre_score is
		res:parametre_score;
	begin
		res.Fenetre:=Fenetre;
		res.Edit:=Edit;
		res.pts:=pts;
		return res;
	end Initialisation_structure_prarametre_score;
	
	------------------------------------------------------------------------------------------
	-- Fenetre qui permet de saisir le nom du nouveau score --
	------------------------------------------------------------------------------------------
	procedure Fenetre_Ajout_Score(pts:integer) is
		Fenetre:Gtk_Window;
	        Boite,Boite_1,Boite_2,Boite_3:Gtk_Box;
		Edit:Gtk_Entry;
		Bouton,Bouton_1:Gtk_button;
		Image,Image_1:Gtk_image;
		Label,Label_1,Label_2,Label_3,Vide:Gtk_label;
		Score:Tab_Score;
		Nb_score:integer;
	begin
	        -- controle --
	        put_line("Fenetre nouveau record");
	        
	        --initialisation de la fenetre
	        Gtk_New(Fenetre);
	        Set_Title(Fenetre,"Nouveau record");
	        Set_Border_Width (Fenetre,20);
	        Set_Default_Size(Fenetre,350,175);
	        --initialisation des conteneurs
	        Gtk_New_Vbox(Boite);
		Gtk_New_Hbox(Boite_1);
		Gtk_New_Hbox(Boite_2);
		Gtk_New_Hbox(Boite_3);
		--initialisation de l'editeur de texte
		Gtk_New(Edit);
		Set_Max_Length(Edit,20);
	        --initialisation du bouton
		Gtk_New(Bouton);
		Gtk_New(Bouton_1);
		--initialisation de l'image
		--On charge le fichier score
		Charge_Score(Score,Nb_score);
		Gtk_New(Image,"images/"&trim(integer'image(Position_score(Score,Nb_score,pts)),left)&".xpm");
		Gtk_New(Image_1,"images/annule.xpm");
		--initialisation des labels
		Gtk_New(Label,"Felicitation !");
		Gtk_New(Label_1,"Votre score est entre dans le top 10");
		Gtk_New(Label_2," Valider");
		Gtk_New(Label_3,"Annuler");
		Gtk_New(Vide," ");
		
		-- Encapsulation
		Add(Fenetre,Boite);
		Pack_Start(Boite,Label);
		Pack_Start(Boite,Label_1);
		Pack_Start(Boite,Boite_1);
		Pack_Start(Boite_1,Edit);
		Pack_Start(Boite_1,Vide);
		Pack_Start(Boite_1,Bouton);
		Pack_Start(Boite_1,Bouton_1);
		Add(Bouton,Boite_2);
		Pack_Start(Boite_2,image);
		Pack_Start(Boite_2,label_2);
		Add(Bouton_1,Boite_3);
		Pack_Start(Boite_3,image_1);
		Pack_Start(Boite_3,label_3);
		
	        --On affiche le tout
	        Show_all(Fenetre);
		
	        --Création d'un lien entre l'évenement du clique et de la procedure concerné
	        Traitement_fenetre.Connect(Fenetre,"destroy",Traitement_fenetre.to_Marshaller(Annuler'Access),Fenetre);
	        Traitement_parametre_score.Connect(Bouton,"clicked",Traitement_parametre_score.to_Marshaller(Gestion_score'Access),Initialisation_structure_prarametre_score(Fenetre,Edit,pts));
		Traitement_fenetre.Connect(Bouton_1,"clicked",Traitement_fenetre.to_Marshaller(Annuler'Access),fenetre);
	end Fenetre_Ajout_Score;
	
	procedure Gestion_score(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_score) is
		Nom:string:=Get_Text(parametre.Edit);
		Dialog:Gtk_Message_Dialog;
		LF : constant Character := ASCII.LF;
		Score:Tab_Score;
		Nb_score:integer;
	begin
		-- controle --
		put_line("Gestion du score");
		
		-- On teste si le champs n'est pas vide
		if Nom="" then
			Gtk_New(Dialog,parametre.fenetre,0,Message_Warning,Buttons_Close,LF&"Vous devez entrer votre nom");
			Show(Dialog);
			Traitement_fenetre_info.Connect(Dialog,"response",Traitement_fenetre_info.to_Marshaller(Fermer_Information'Access),Dialog);
		else
			--On masque la fenetre precedante
			hide(parametre.fenetre);
			--On charge les scores dans la variable
			Charge_Score(Score,Nb_score);
			--On ajoute le score et le nom
			Ajout_score(Score,Nb_score,Nom,parametre.pts);
			--On enregistre dans le fichier
			Sauve_Score(Score,Nb_score);
		end if;
	end Gestion_score;
	
	----------------------------------------------------------------------------------------------------------------------
	-- Procedure qui permet d'annuler une opération (fermeture de la fenetre) --
	----------------------------------------------------------------------------------------------------------------------
	procedure Annuler(Element_declancheur:access Gtk_Widget_Record'Class;fenetre:Gtk_window) is
        begin
		hide(fenetre);
        end Annuler;
	
	-----------------------------------------------------------------------------------------------
	-- Fenetre qui permet de fermer et de sauvegarder la partie --
	-----------------------------------------------------------------------------------------------
	procedure Fermer_sauvegarde(Element_declancheur:access Gtk_Widget_Record'Class;parametre:parametre_sauve) is
		Fenetre:Gtk_window;
		Boite:Gtk_box;
		Bouton_1,Bouton_2,Bouton_3:Gtk_button;
	begin
		--initialisation de la fenetre
		Gtk_New(Fenetre);
		Set_Title(Fenetre,"Sauvegarder votre partie");
		Set_Border_Width (Fenetre,20);
		Set_Default_Size(Fenetre,300,50);
		--initialisation de la boite
		Gtk_New_Hbox(Boite);
		-- initialisation des boutons
		Gtk_New(Bouton_1,"Quitter");
		Gtk_New(Bouton_2,"Sauvegarder et quitter");
		Gtk_New(Bouton_3,"Annuler");
		
		--Encapsulation
		Add(Fenetre,Boite);
		Pack_Start(Boite,Bouton_1);
		Pack_Start(Boite,Bouton_2);
		Pack_Start(Boite,Bouton_3);
		
		--On affiche le tout
		Show_all(Fenetre);
		
		--Création d'un lien entre l'évenement du clique et de la procedure concerné
		Traitement_fenetre.Connect(fenetre,"destroy",Traitement_fenetre.to_Marshaller(Annuler'Access),fenetre);
		Traitement.Connect(Bouton_1,"clicked",Traitement.to_Marshaller(Fermer'Access));
	        Traitement_parametre_sauve.Connect(Bouton_2,"clicked",Traitement_parametre_sauve.to_Marshaller(Fenetre_Sauvegarde'Access),parametre);
		Traitement_fenetre.Connect(Bouton_3,"clicked",Traitement_fenetre.to_Marshaller(Annuler'Access),fenetre);
	end Fermer_sauvegarde;
	
	----------------------------------------------------------------------------------------------------------
	-- Procedure qui permet de fermer le programme lors de son appel --
	----------------------------------------------------------------------------------------------------------
	procedure Fermer(Element_declancheur:access Gtk_Widget_Record'Class) is
        begin
		-- controle --
		put_line("Fermeture du programme");
		
		Main_quit;
        end Fermer;
	
end P_interface;