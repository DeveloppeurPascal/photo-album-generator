unit u_generation;

interface

procedure Generer_Page (nom_modele: string; Fic_Resultat: string; num_photo: integer);

implementation

uses
    SysUtils, Classes, u_param, u_generationutilitaire;

function Cumuler_Lignes (Nom_Fichier: string): string;
var
   ch : string;
   Memo: TStringList;
begin
  ch := '';
  Memo := TStringList.Create;
  try
    try
      Memo.LoadFromFile (Nom_Fichier);
    except
      Memo.Clear;
    end;
    while (Memo.Count > 0) do
      begin
        ch := ch + #10#13 + Memo [0];
        Memo.Delete (0);
      end;
    {endwhile}
  finally
    result := ch;
  end;
end;

function remplacer_marqueur (var ch : string; num_photo: integer; marqueur: string): boolean;
var
   n : Integer;
   res: string;
   NomImage : string;
begin
  result := false;
  n := pos (marqueur, ch);
  if (n > 0)
  then
    begin
      NomImage := Param_Album.ReadString ('photos', 'Image'+IntToStr (Num_Photo), '');
      result := true;
      delete (ch, n, length (marqueur));
      if (marqueur = '!$datgen$!')
      then
        res := DateToStr (Date);
      {endif}
      if (marqueur = '!$timgen$!')
      then
        res := TimeToStr (Time);
      {endif}
      if (marqueur = '!$titre$!')
      then
        res := Param_Album.ReadString ('album', 'titre', '');
      {endif}
      if (marqueur = '!$commentateur$!')
      then
        res := Param_Album.ReadString ('album', 'commentateur', '');
      {endif}
      if (marqueur = '!$photographe$!')
      then
        res := Param_Album.ReadString ('album', 'photographe', '');
      {endif}
      if (marqueur = '!$nom_page_suivante$!')
      then
        if (num_photo >= param_album.ReadInteger ('photos', 'nb_photos', 0))
        then
          res := 'credit.html'
        else
          res := 'page'+IntToStr (Succ (Num_Photo))+'.html';
        {endif}
      {endif}
      if (marqueur = '!$nom_page_precedente$!')
      then
        if (num_photo <= 1)
        then
          res := 'browser.html'
        else
          res := 'page'+IntToStr (Pred (Num_Photo))+'.html';
        {endif}
      {endif}
      if (marqueur = '!$nom_page_premiere$!')
      then
        res := 'page'+IntToStr (1)+'.html';
      {endif}
      if (marqueur = '!$nom_page_derniere$!')
      then
        res := 'page'+IntToStr (param_album.ReadInteger ('photos', 'nb_photos', 0))+'.html';
      {endif}
      if (marqueur = '!$nom_page$!')
      then
        res := 'page'+IntToStr (num_photo)+'.html';
      {endif}
      if (marqueur = '!$nom_photo$!')
      then
        res := NomImage;
      {endif}
      if (marqueur = '!$coul_texte$!')
      then
        if (Param_Album.ReadString ('album', 'fond', '') = 'noir')
        then
          res := '#FFFFFF'
        else
          res := '#000000';
        {endif}
      {endif}
      if (marqueur = '!$coul_fond$!')
      then
        if (Param_Album.ReadString ('album', 'fond', '') = 'noir')
        then
          res := '#000000'
        else
          res := '#FFFFFF';
        {endif}
      {endif}
      if (marqueur = '!$commentaire$!')
      then
        res := Cumuler_Lignes (Album_Path+'comment\'+Param_Album.ReadString ('commentaires', Param_Album.ReadString ('photos', 'Image'+IntToStr (Num_Photo), ''), '0')+'.txt');
      {endif}
      if (marqueur = '!$commentaire_accueil$!')
      then
        res := Cumuler_Lignes (Album_Path+'comment\root.txt');
      {endif}
      if (marqueur = '!$photo_larg$!')
      then
        res := Param_Album.ReadString ('taille photo', NomImage+' larg', '0');
      {endif}
      if (marqueur = '!$photo_haut$!')
      then
        res := Param_Album.ReadString ('taille photo', NomImage+' haut', '0');
      {endif}
      if (marqueur = '!$photo_larg_red$!')
      then
        res := Param_Album.ReadString ('taille photo', NomImage+' larg red', '0');
      {endif}
      if (marqueur = '!$photo_haut_red$!')
      then
        res := Param_Album.ReadString ('taille photo', NomImage+' haut red', '0');
      {endif}
      if (marqueur = '!$copyright$!')
      then
        res := 'Page generated by PhotoAlbumGenerator from Patrick "pprem" Pr�martin on the '+DateToStr (Now);
      {endif}
      ch := copy (ch, 1, pred (n))+Changer_Accents (res)+copy (ch, n, succ (length (ch)-n));
    end;
  {endif}
end; { Remplacer_Marqueur }

function modification_marqueur (var ch: string; Num_Photo: integer): boolean;
var
   n : integer;
begin
  result := false;

  // Ajout d'un copyright sur les pages g�n�r�es en modifiant leur ent�te
  n := pos ('<HEAD>', UpperCase (ch));
  if (n > 0)
  then
    begin
      result := True;
      delete (ch, n, length ('<HEAD>')); // attention, le blanc derri�re HEAD dans le r�sultat permet d'�viter de boucler ind�finiement !
      ch := copy (ch, 1, pred (n))+
            '<head >'#10#13+
            '<meta name="generator" content="GenSitePAG">'#10#13+
            '<meta name="generation-date" content="'+DateTimeToStr (now)+'">'#10#13+
            copy (ch, n, succ (length (ch)-n));
    end;
  {endif}

  // Ajout d'un copyright en fin de chaque page g�n�r�e
  n := pos ('</BODY>', UpperCase (ch));
  if (n > 0)
  then
    begin
      result := True;
      delete (ch, n, length ('</BODY>')); // attention, le blanc derri�re /BODY dans le r�sultat permet d'�viter de boucler ind�finiement !
      ch := copy (ch, 1, pred (n))+
            '<small><small><address>Page generated by <a href="http://www.olfsoft.com" target="_top">PhotoAlbumGenerator</a> from <a href="mailto:pprem@pprem.net">Patrick "pprem" Pr�martin</a> on the '+DateToStr (Now)+'.</address></small></small>'#10#13+
            '</body >'#10#13+
            copy (ch, n, succ (length (ch)-n));
    end;
  {endif}

  result := result or remplacer_marqueur (ch, Num_Photo, '!$titre$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$photographe$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$commentaire$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$commentateur$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$nom_page_suivante$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$nom_page_precedente$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$commentaire_accueil$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$nom_page_premiere$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$nom_page_derniere$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$nom_page$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$nom_photo$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$copyright$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$coul_texte$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$coul_fond$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$photo_larg$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$photo_haut$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$photo_larg_red$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$photo_haut_red$!');

  // les autres zones utilis�es
  result := result or remplacer_marqueur (ch, Num_Photo, '!$datgen$!');
  result := result or remplacer_marqueur (ch, Num_Photo, '!$timgen$!');
end; { modification_marqueur }

procedure Stocker_Cles (var lst_photo: TStringList; num_photo: integer);
begin
  lst_photo.Add (IntToStr (Num_Photo));
end;

procedure Restaurer_Cles (var lst_photo: TStringList; var num_photo: integer);
begin
  Num_Photo := StrToInt (lst_Photo [Pred (lst_Photo.Count)]);
  lst_Photo.Delete (pred (lst_Photo.count));
end;

procedure Retour_Page_Web (modele : string; var Resultat : tStringList; num_photo: integer);
var
   ch, upcase_ch : string;
   mdl, lst_if, lst_liste, lst_photo : TStringList;
   no_debut_boucle : longint;
   i : longint;
   reboucler : boolean;
begin
  resultat := tStringList.Create;
  try
    if (not FileExists (modele))
    then // si le fichier de mod�le n'existe pas, on signale une erreur
      raise Exception.Create ('Fichier mod�le '+modele+' inexistant !');
    {endif}
    mdl := TStringList.Create; // contiendra le mod�le � appliquer
    lst_if := TStringList.Create; // contiendra les �ventuels conditionnements des blocs du programme
    lst_liste := TStringList.Create; // stockage des indices en cas de listes imbriqu�es
    lst_photo := TStringList.Create; // stockage des indices en cas de listes imbriqu�es
    try
      mdl.LoadFromFile (modele); // chargement du fichier de mod�le
      No_Debut_Boucle := -1;
      i := 0;
      while (i < mdl.Count) do // on parcourt toutes les lignes du mod�le
        begin
          reboucler := false;
          if (i <= mdl.Count) then ch := mdl [i] else ch := '';
          upcase_ch := UpperCase (ch);
          if  ((not reboucler) and (pos ('!$IF', upcase_ch) > 0) and (pos ('!$/IF', upcase_ch) = 0))
          then // une condition est d�tect�e, on va la v�rifier
            begin
              reboucler := true;
// g�rer ici les �ventuels conditionnements de parties du mod�le des pages
              if (false = true) //(pos ('!$IF LIVRE_EN_VENTE$!', upcase_ch) > 0) and (dm_donnees.Tab_Albums.FieldByName ('Code_Vendeur').AsInteger > 0))
              then // la condition est v�rifi�e, on tient compte des lignes suivantes
                lst_if.Add ('O')
              else // la condition n'est pas v�rifi�e, on ignore les lignes suivantes
                lst_if.Add ('N');
              {endif}
            end;
          {endif}
          if ((not reboucler) and (pos ('!$ELSE$!', upcase_ch) > 0)) // on inverse une condition
          then
            begin
              reboucler := true;
              if (lst_if.count > 0)
              then
                if (lst_if [pred (lst_if.Count)] = 'O')
                then
                  lst_if [pred (lst_if.Count)] := 'N'
                else
                  lst_if [pred (lst_if.Count)] := 'O';
                {endif}
              {endif}
            end;
          {endif}
          if ((not reboucler) and (pos ('!$/IF$!', upcase_ch) > 0)) // on d�pile une condition
          then
            begin
              reboucler := true;
              if (lst_if.count > 0) then lst_if.Delete (pred (lst_if.count));
            end;
          {endif}

// liste des photographies
          if ((not reboucler) and (pos ('!$LISTE_PHOTO$!', upcase_ch) > 0))// and (No_Debut_Boucle = -1)))
          then
            begin
              reboucler := true;
              if (No_Debut_boucle >= 0)
              then
                lst_liste.Add (IntToStr (No_Debut_Boucle)); // stockage de la valeur pr�c�dente
              {endif}
              No_Debut_Boucle := succ (i);
              Stocker_Cles (lst_photo, num_photo);
              Num_Photo := 1;
            end;
          {endif}
          if ((not reboucler) and ((pos ('!$/LISTE_PHOTO$!', upcase_ch) > 0) and (No_Debut_Boucle > -1)))
          then
            begin
              reboucler := true;
              inc (Num_Photo);
              if (Num_Photo > Param_Album.ReadInteger ('photos', 'nb_photos', 0))
              then
                begin
                  Restaurer_Cles (lst_photo, num_photo);
                  if (lst_liste.Count > 0)
                  then
                    begin
                      No_Debut_Boucle := StrToInt (lst_liste [Pred (lst_liste.Count)]);
                      lst_liste.delete (pred (lst_liste.Count));
                    end
                  else
                    No_Debut_Boucle := -1;
                  {endif}
                end
              else
                i := No_Debut_Boucle -1; // le -1 est l� car on r�incr�mente I apr�s !
              {endif}
            end;
          {endif}

// prise en compte des marqueurs
          if (((lst_if.Count = 0) or (lst_if [pred (lst_if.count)] = 'O')) and (not reboucler))
          then
            begin
              while modification_marqueur (ch, num_photo) do; // remplacement des mots-cl�s reconnus par leur valeur
              resultat.Add (ch); // ajout de la cha�ne au r�sultat final
            end;
          {endif}
          inc (i); // passage � la ligne suivante du mod�le
        end;
      {endwhile}
    finally
      lst_photo.Free;
      lst_liste.Free;
      lst_if.Free;
      mdl.Free;
    end;
  finally
  end;
end; { Retour_Page_Web }

procedure Generer_Page (nom_modele: string; Fic_Resultat: string; num_photo: integer);
var
   Resultat: TStringList;
begin
  try
    Retour_Page_Web (nom_modele, resultat, num_photo);
    Resultat.SaveToFile (Fic_Resultat);
  finally
    Resultat.Free;
  end;
end;

end.