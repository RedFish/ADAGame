--#################################
--##
--## fichier réalisé par Nicolas Ferrari
--##
--#################################

package body p_fichier is

	--------------------------------------------------------------------------------
	-- Fonction qui vérifie si le nom d'un fichier existe --
	--------------------------------------------------------------------------------
	function Existe(nom : string)return Boolean is
		F : File_Type; -- Déclaration d'une variable de type Fichier
	begin
		OPEN(F,IN_FILE,nom); -- Ouverture du fichier
		CLOSE(F); -- Fermeture du fichier si pas d'exception
		return true; -- Renvoi true si pas d'exception
	exception
		when NAME_ERROR=>return false; -- si erreur sur le nom, alors fichier existe pas -> false
	end Existe;
	
	--------------------------------------------------------------------------------------
	-- Chargement d'une partie en cours depuis un fichier --
	---------------------------------------------------------------------------------------
	procedure Chargement(nom : string; z,y,points : out integer; grille : out T_Grille) is
		F : File_Type;
		str : string(1..50);
		E : Character;
		n : integer;
		temp : T_Grille;
	begin
		OPEN(F,In_File,nom);
		
		GET_LINE(F,str(1..50),n);
		z:=Integer'Value(str(3..n));
	
		GET_LINE(F,str(1..50),n);
		y:=Integer'Value(str(3..n));

		GET_LINE(F,str(1..50),n);
		points:=Integer'Value(str(8..n));
	
		Skip_Line(F);
	
		for I in  1..y loop
			for w in 1..z loop
				GET(F,E);
				case E is
					when 'x'=>temp(I)(w):=T_Couleur'Value("x");
					when 'X'=>temp(I)(w):=T_Couleur'Value("x");
					when 'r' =>temp(I)(w):=r;
					when 'R'=>temp(I)(w):=r;
					when 'b'=>temp(I)(w):=b;
					when 'B'=>temp(I)(w):=b;
					when 'j'=>temp(I)(w):=T_Couleur'Value("j");
					when 'J'=>temp(I)(w):=T_Couleur'Value("j");
					when others => PUT_LINE("Pas la bonne valeur");
				end case;
			end loop;
			Skip_Line(F);
		end loop;
	
		for I in reverse 1..y loop
			for w in 1..z loop
				grille(w)(i) := temp(y-I+1)(w);
				PUT(T_Couleur'Image(grille(w)(i)));
			end loop;
			New_Line;
		end loop;
		
		CLOSE(F);
	end Chargement;
	
	----------------------------------------------------------------------------------------------------------
	-- Procedure qui permet de sauvegarder une partie dans un fichier--
	----------------------------------------------------------------------------------------------------------
	procedure Sauvegarde(nom : in string; x,y,points : in integer; grille : in T_Grille)is
		F : File_Type;
	begin
		CREATE(F,Out_File,nom);
		PUT(F,"X=");
		PUT(F,Trim(Integer'Image(x),Ada.Strings.Left));
		New_Line(F);
		PUT(F,"Y=");
		PUT(F,Trim(Integer'Image(y),Ada.Strings.Left));
		New_Line(F);
		PUT(F,"POINTS=");
		PUT(F,Trim(Integer'Image(points),Ada.Strings.Left));
		New_Line(F);
		PUT(F,"CARTE");
		New_Line(F);
		for I in reverse 1..y loop
			for J in 1..x loop
				PUT(F,Ada.Characters.Handling.To_Lower(T_Couleur'Image(grille(J)(I))));
			end loop;
			New_Line(F);
		end loop;
		PUT(F,"FINCARTE");
		CLOSE(F);
	end Sauvegarde;
	
	--------------------------------------------------------------------------------------------------------------------------------------
	-- Fonction qui verifie l'état du fichier, s'il est conforme au format donné dans le sujet --
	--------------------------------------------------------------------------------------------------------------------------------------
	function Conforme(nom : string) return Boolean is
		F : File_Type;
		str : string(1..50);
		E : Character;
		n : integer;
		z,y : Integer;
	begin
		OPEN(F,In_File,nom);
	
		GET_LINE(F,str(1..50),n);
		if (str(1..2)/="X=") then
			return false;
		else
			if (Integer'Value(str(3..n))>Taille_Max_X) then
				return false;
			else
				z := Integer'Value(str(3..n));
			end if;
		end if;
        
		GET_LINE(F,str(1..50),n);
		if (str(1..2)/="Y=") then
			return false;
		else
			if (Integer'Value(str(3..n))>Taille_Max_Y) then
				return false;
			else
				y := Integer'Value(str(3..n));
			end if;
		end if;

		GET_LINE(F,str(1..50),n);
		if (str(1..7)/="POINTS=") then
			return false;
		else
			if (Integer'Value(str(8..n))<0) then
				return false;
			end if;
		end if;
        
		GET_LINE(F,str(1..50),n);
		if (str(1..5)/="CARTE") then
			return false;
		end if;

		for I in  1..y loop
			for w in 1..z loop
				GET(F,E);
				if (E/='x')and(E/='j')and(E/='b')and(E/='r') then
					return false;
				end if;
			end loop;
			Skip_Line(F);
		end loop;
        
		GET_LINE(F,str(1..50),n);
		if (str(1..8)/="FINCARTE") then
			return false;
		end if;
		
		CLOSE(F);
		
		return true;
        
		exception 
			when END_ERROR=> return false;
	end Conforme;
	
	-----------------------------------------------------------------------------------------
	-- Fonction qui vérifie si le fichier de score est conforme --
	-----------------------------------------------------------------------------------------
	function Conforme_Score return Boolean is
		F : File_Type;
		str : string(1..20);
		n : integer;
	begin
	
		OPEN(F,In_File,"highscore.score");

		while not End_Of_File(F) loop
			GET_LINE(F,str(1..20),n);
			if Integer'Value(str(1..n))<0 then
				CLOSE(F);
				return false;
			end if;
			GET_LINE(F,str(1..20),n);
			if (str(1..n) = "") then
				CLOSE(F);
				return false;
			end if;
		end loop;
		CLOSE(F);
		return true;
		
		exception
			when CONSTRAINT_ERROR=>CLOSE(F );return false;
	end Conforme_Score;
	
	----------------------------------------------------------------------------------------------------------
	-- Procedure qui charge le fichier de score dans un type Tab_score --
	---------------------------------------------------------------------------------------------------------- 
	procedure Charge_Score (score : out Tab_Score; nb: out Integer) is
		F : File_Type;
		str : string(1..20);
		n : integer;
	begin
		nb := 0;
		if Existe("highscore.score") then 
			if Conforme_Score then
				OPEN(F,In_File,"highscore.score");
				while not End_Of_File(F) loop
					nb := nb+1;
					GET_LINE(F,str(1..20),n);
					score(nb).points := Integer'Value(str(1..n));
					GET_LINE(F,str(1..20),n);
					score(nb).nom(1..n) := str(1..n);
				end loop;
				CLOSE(F);
			else
				PUT_LINE("Score pas confrome !");
			end if;		
		end if;
	end Charge_Score;
	
	-----------------------------------------------------------------------------------------------------------------
	-- Procedure qui sauvegarde un type Tab_score dans le fichier de score --
	-----------------------------------------------------------------------------------------------------------------
	procedure Sauve_Score(score : Tab_Score; nb : Integer) is
		F : File_Type;
	begin
	
		if Existe("highscore.score") then
			OPEN(F,Out_File,"highscore.score");
		else
			CREATE(F,Out_File,"highscore.score");
		end if;

		for I in 1..nb loop
			PUT(F,Trim(Integer'Image(score(I).points),Ada.Strings.Left));
			New_Line(F);
			PUT(F,Trim(score(I).nom(1..score(I).nom'Length),Ada.Strings.Right));
			New_Line(F);
		end loop;
		CLOSE(F);
		
	end Sauve_Score;
	
end p_fichier;