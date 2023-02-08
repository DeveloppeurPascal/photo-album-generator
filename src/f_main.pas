unit f_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, StdActns, Menus, ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type
  Tfrm_main = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Nouveau1: TMenuItem;
    Ouvrir1: TMenuItem;
    Fermer1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    Album1: TMenuItem;
    N1Informationsgnrales1: TMenuItem;
    N2Photographies1: TMenuItem;
    Ajouter1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    N2: TMenuItem;
    Trier1: TMenuItem;
    N3Gnrerlalbum1: TMenuItem;
    N4Testerlalbum1: TMenuItem;
    Aide1: TMenuItem;
    Apropos1: TMenuItem;
    NouvelAlbum: TSaveDialog;
    OuvrirPAG: TOpenDialog;
    OuvrirJPG: TOpenPictureDialog;
    procedure Nouveau1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure N1Informationsgnrales1Click(Sender: TObject);
    procedure Ajouter1Click(Sender: TObject);
    procedure N3Gnrerlalbum1Click(Sender: TObject);
    procedure Ouvrir1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Modifier1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Trier1Click(Sender: TObject);
    procedure N4Testerlalbum1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_main: Tfrm_main;

implementation

uses fileCtrl, u_param, f_operation_en_cours, f_apropos, f_album_info,
  f_photo_ajout,
  f_photo_modif, f_photo_supprimer, f_photo_trier, u_generation,
  u_chgt_version, u_urlOpen;

{$R *.DFM}

procedure Tfrm_main.Nouveau1Click(Sender: TObject);
var
  prog_folder: string;
  album_folder: string;
begin
  prog_folder := ExtractFilePath(Application.ExeName);
  if (Album_Ouvert) then
    if (mrYes = MessageDlg
      ('Un album est actuellement ouvert, voulez-vous le fermer ?',
      mtConfirmation, [mbYes, mbNo], 0)) then
      Fermer1Click(Sender)
    else
      exit;
  { endif }
  { endif }
  if (NouvelAlbum.InitialDir = '') then
    NouvelAlbum.InitialDir := prog_folder + 'album';
  { endif }
  if (NouvelAlbum.Execute) then
    if (DirectoryExists(NouvelAlbum.FileName)) then
      MessageDlg('Le dossier ' + ExtractFileName(NouvelAlbum.FileName) +
        ' existe déjà. Création de l''album impossible', mtError, [mbCancel], 0)
    else
    begin
      oec_Ouverture(20);
      album_folder := NouvelAlbum.FileName;
      oec_Operation_Suivante;
      ForceDirectories(album_folder);
      oec_Operation_Suivante;
      ForceDirectories(album_folder + '\comment');
      oec_Operation_Suivante;
      ForceDirectories(album_folder + '\img');
      oec_Operation_Suivante;
      ForceDirectories(album_folder + '\btn');
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\autorun.inf'),
        PChar(album_folder + '\autorun.inf'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\shelexec.exe'),
        PChar(album_folder + '\shelexec.exe'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\pag.ico'),
        PChar(album_folder + '\pag.ico'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\barre.gif'),
        PChar(album_folder + '\btn\barre.gif'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\haut.gif'),
        PChar(album_folder + '\btn\haut.gif'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\gauche.gif'),
        PChar(album_folder + '\btn\gauche.gif'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'ressources\droite.gif'),
        PChar(album_folder + '\btn\droite.gif'), False);
      oec_Operation_Suivante;
      ForceDirectories(album_folder + '\mdl');
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'mdl\browser.mdl'),
        PChar(album_folder + '\mdl\browser.mdl'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'mdl\credit.mdl'),
        PChar(album_folder + '\mdl\credit.mdl'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'mdl\index.mdl'),
        PChar(album_folder + '\mdl\index.mdl'), False);
      oec_Operation_Suivante;
      CopyFile(PChar(prog_folder + 'mdl\photo.mdl'),
        PChar(album_folder + '\mdl\photo.mdl'), False);
      oec_Operation_Suivante;
      Param_Ouvrir_Album(album_folder + '\' + ExtractFileName(album_folder)
        + '.pag');
      oec_Operation_Suivante;
      Ecrire_Version_Courante;
      oec_Operation_Suivante;
      oec_Fermeture;
      N1Informationsgnrales1Click(Sender);
      Ajouter1Click(Sender);
      N3Gnrerlalbum1Click(Sender);
      N4Testerlalbum1Click(Sender);
      Fermer1.Enabled := True;
      Album1.Enabled := True;
      Modifier1.Enabled := Param_Album.ReadInteger('photos',
        'nb_photos', 0) > 0;
      Supprimer1.Enabled := Param_Album.ReadInteger('photos',
        'nb_photos', 0) > 0;
    end;
  { endif }
  { endif }
end;

procedure Tfrm_main.Fermer1Click(Sender: TObject);
begin
  if (Album_Modifie) then
    if (mrYes = MessageDlg
      ('Cet album a été modifié mais pas généré, voulez-vous le générer avant de le fermer ?',
      mtConfirmation, [mbYes, mbNo], 0)) then
      N3Gnrerlalbum1Click(Sender);
  { endif }
  { endif }
  Param_Fermer_Album;
  Fermer1.Enabled := False;
  Album1.Enabled := False;
end;

procedure Tfrm_main.N1Informationsgnrales1Click(Sender: TObject);
var
  f: TFrm_album_info;
begin
  f := TFrm_album_info.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure Tfrm_main.Ajouter1Click(Sender: TObject);
var
  f: TFrm_Photo_Ajout;
  i: integer;
begin
  f := TFrm_Photo_Ajout.Create(Self);
  try
    if (OuvrirJPG.InitialDir = '') then
      OuvrirJPG.InitialDir := Param_Album.ReadString('photos',
        'default_img_path', Album_Path);
    { endif }
    if (OuvrirJPG.Execute) then
      for i := 0 to Pred(OuvrirJPG.Files.Count) do
      begin
        if (i = 0) then
          Param_Album.WriteString('photos', 'default_img_path',
            ExtractFilePath(OuvrirJPG.Files[i]));
        { endif }
        f.edt_NomPhoto.Text := OuvrirJPG.Files[i];
        f.edt_Commentaire.Lines.Clear;
        f.ShowModal;
      end;
    { endfor }
    { endif }
  finally
    f.Free;
  end;
  Modifier1.Enabled := Param_Album.ReadInteger('photos', 'nb_photos', 0) > 0;
  Supprimer1.Enabled := Param_Album.ReadInteger('photos', 'nb_photos', 0) > 0;
  SetFocus;
end;

procedure Tfrm_main.N3Gnrerlalbum1Click(Sender: TObject);
var
  i: integer;
begin
  oec_Ouverture(8 + Param_Album.ReadInteger('photos', 'nb_photos', 0));
  Generer_Page(Album_Path + 'mdl\index.mdl', Album_Path + 'index.htm', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\index.mdl', Album_Path + 'default.htm', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\index.mdl', Album_Path + 'homepage.htm', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\index.mdl', Album_Path + 'index.html', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\index.mdl', Album_Path + 'default.html', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\index.mdl', Album_Path + 'homepage.html', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\browser.mdl', Album_Path + 'browser.html', 0);
  oec_Operation_Suivante;
  Generer_Page(Album_Path + 'mdl\credit.mdl', Album_Path + 'credit.html', 0);
  oec_Operation_Suivante;
  for i := 1 to Param_Album.ReadInteger('photos', 'nb_photos', 0) do
  begin
    Generer_Page(Album_Path + 'mdl\photo.mdl', Album_Path + 'page' + IntToStr(i)
      + '.html', i);
    oec_Operation_Suivante;
  end;
  { endfor }
  oec_Fermeture;
  MessageDlg('Album photo généré', mtInformation, [mbOK], 0);
  Album_Modifie := False;
end;

procedure Tfrm_main.Ouvrir1Click(Sender: TObject);
var
  prog_folder: string;
begin
  prog_folder := ExtractFilePath(Application.ExeName);
  if (Album_Ouvert) then
    if (mrYes = MessageDlg
      ('Un album est actuellement ouvert, voulez-vous le fermer ?',
      mtConfirmation, [mbYes, mbNo], 0)) then
      Fermer1Click(Sender)
    else
      exit;
  { endif }
  { endif }
  if (OuvrirPAG.InitialDir = '') then
    OuvrirPAG.InitialDir := prog_folder + 'album';
  { endif }
  if (OuvrirPAG.Execute) then
  begin
    Param_Ouvrir_Album(OuvrirPAG.FileName);
    Fermer1.Enabled := True;
    Album1.Enabled := True;
    Modifier1.Enabled := Param_Album.ReadInteger('photos', 'nb_photos', 0) > 0;
    Supprimer1.Enabled := Param_Album.ReadInteger('photos', 'nb_photos', 0) > 0;
    Mettre_A_Niveau_Album;
  end;
  { endif }
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin
  Modifier1.Enabled := False;
  Supprimer1.Enabled := False;
  Fermer1.Enabled := False;
  Album1.Enabled := False;
end;

procedure Tfrm_main.Quitter1Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_main.Apropos1Click(Sender: TObject);
var
  f: TFrm_APropos;
begin
  f := TFrm_APropos.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure Tfrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Album_Ouvert) then
    Fermer1Click(Sender);
  { endif }
end;

procedure Tfrm_main.Modifier1Click(Sender: TObject);
var
  f: TFrm_Photo_Modif;
begin
  f := TFrm_Photo_Modif.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
  SetFocus;
end;

procedure Tfrm_main.Supprimer1Click(Sender: TObject);
var
  f: TFrm_Photo_Supprimer;
begin
  f := TFrm_Photo_Supprimer.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
  Modifier1.Enabled := Param_Album.ReadInteger('photos', 'nb_photos', 0) > 0;
  Supprimer1.Enabled := Param_Album.ReadInteger('photos', 'nb_photos', 0) > 0;
  SetFocus;
end;

procedure Tfrm_main.Trier1Click(Sender: TObject);
var
  f: TFrm_Photo_Trier;
begin
  f := TFrm_Photo_Trier.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
  SetFocus;
end;

procedure Tfrm_main.N4Testerlalbum1Click(Sender: TObject);
begin
  url_Open_In_Browser(Album_Path + 'index.html');
end;

end.
