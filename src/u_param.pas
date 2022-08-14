unit u_param;

interface

uses
    IniFiles;

var
   Album_ouvert : boolean;
   Album_modifie : boolean;
   Album_Nom : string;
   Album_Path : string;
   Param_Album : TIniFile;

procedure Param_Ouvrir_Album (Nom : string);
procedure Param_Fermer_Album;

implementation

uses
    SysUtils;

procedure Param_Ouvrir_Album (Nom : string);
begin
  Param_Album := TIniFile.Create (Nom);
  Album_Ouvert := True;
  Album_Nom := ExtractFileName (Nom);
  Param_Album.WriteString ('album', 'Nom', Album_Nom); 
  Album_Path := ExtractFilePath (Nom);
end;

procedure Param_Fermer_Album;
begin
  Param_Album.Free;
  Param_Album := nil;
  Album_Ouvert := False;
  Album_Modifie := False;
end;

initialization
  Album_Ouvert := False;
  Album_Modifie := False;
  Param_album := nil;

finalization
  if (Param_Album <> nil)
  then
    Param_Fermer_Album;
  {endif}
end.
