unit u_chgt_version;

interface

procedure Mettre_A_Niveau_Album;

procedure Ecrire_Version_Courante;

implementation

uses
    FileCtrl, Forms, windows, SysUtils, f_operation_en_cours, u_param;

procedure Mettre_A_Niveau_Album;
var
   prog_folder : string;
begin
  if (Param_Album.ReadInteger ('PAG', 'version', 0) < 1)
  then
    begin
      oec_Ouverture (8);
      prog_folder := ExtractFilePath (Application.ExeName);
      oec_Operation_Suivante;
      CopyFile (PChar (Prog_Folder+'ressources\autorun.inf'), PChar (album_path+'autorun.inf'), False);
      oec_Operation_Suivante;
      CopyFile (PChar (Prog_Folder+'ressources\shelexec.exe'), PChar (album_path+'shelexec.exe'), False);
      oec_Operation_Suivante;
      ForceDirectories (album_path+'mdl');
      oec_Operation_Suivante;
      CopyFile (PChar (Prog_Folder+'mdl\browser.mdl'), PChar (album_path+'mdl\browser.mdl'), False);
      oec_Operation_Suivante;
      CopyFile (PChar (Prog_Folder+'mdl\credit.mdl'), PChar (album_path+'mdl\credit.mdl'), False);
      oec_Operation_Suivante;
      CopyFile (PChar (Prog_Folder+'mdl\index.mdl'), PChar (album_path+'mdl\index.mdl'), False);
      oec_Operation_Suivante;
      CopyFile (PChar (Prog_Folder+'mdl\photo.mdl'), PChar (album_path+'mdl\photo.mdl'), False);
      oec_Operation_Suivante;
    end;
  {endif}
  Ecrire_Version_Courante;
  oec_Operation_Suivante;
  oec_Fermeture;
end;

procedure Ecrire_Version_Courante;
begin
  Param_Album.WriteInteger ('PAG', 'version', 1);
end;

end.
