unit f_photo_supprimer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tfrm_photo_Supprimer = class(TForm)
    Label1: TLabel;
    edt_NomPhoto: TComboBox;
    btn_Supprimer: TBitBtn;
    btn_Fermer: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn_FermerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_NomPhotoChange(Sender: TObject);
    procedure btn_SupprimerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_photo_Supprimer: Tfrm_photo_Supprimer;

implementation

uses f_operation_en_cours, u_param, f_photo_detail;

{$R *.DFM}

procedure Tfrm_photo_Supprimer.FormCreate(Sender: TObject);
var
   i : integer;
begin
  edt_NomPhoto.Items.Clear;
  For i := 1 to Param_Album.ReadInteger ('photos', 'nb_photos', 0) do
    edt_NomPhoto.Items.Add (Param_Album.ReadString ('photos', 'Image'+IntToStr (i), ''));
  {endfor}
end;

procedure Tfrm_photo_Supprimer.btn_FermerClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_photo_Supprimer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Cacher_Photo;
end;

procedure Tfrm_photo_Supprimer.edt_NomPhotoChange(Sender: TObject);
begin
  Afficher_Photo (Self, Album_Path+'img\'+edt_NomPhoto.Items [edt_NomPhoto.ItemIndex]);
end;

procedure Tfrm_photo_Supprimer.btn_SupprimerClick(Sender: TObject);
var
   i : integer;
   NomImage : string;
   vu : boolean;
begin
  oec_Ouverture (7+Param_Album.ReadInteger ('photos', 'nb_photos', 0));
  NomImage := ExtractFileName (edt_NomPhoto.Items [edt_NomPhoto.ItemIndex]);
  oec_Operation_Suivante;
  vu := False;
  oec_Operation_Suivante;
  for i := 1 to Param_Album.ReadInteger ('photos', 'nb_photos', 0) do
    begin
      if (vu)
      then
        Param_Album.WriteString ('photos', 'Image'+IntToStr (i-1), Param_Album.ReadString ('photos', 'Image'+IntToStr (i), ''))
      else
        vu := (Param_Album.ReadString ('photos', 'Image'+IntToStr (i), '') = NomImage);
      {endif}
      oec_Operation_Suivante;
    end;
  {endif}
  Param_Album.DeleteKey ('photos', 'Image'+Param_Album.ReadString ('photos', 'nb_photos', '0'));
  oec_Operation_Suivante;
  Param_Album.WriteInteger ('photos', 'nb_photos', Param_Album.ReadInteger ('photos', 'nb_photos', 0)-1);
  oec_Operation_Suivante;
  if not DeleteFile (Album_Path+'img\'+NomImage)
  then
    MessageDlg ('Suppression de '+Album_Path+'img\'+NomImage+' impossible, pensez à le faire vous-même...', mtError, [mbCancel], 0);
  {endif}
  oec_Operation_Suivante;
  if not DeleteFile (Album_Path+'comment\'+Param_Album.ReadString ('commentaires', NomImage, '')+'.txt')
  then
    MessageDlg ('Suppression de '+Album_Path+'comment\'+Param_Album.ReadString ('commentaires', NomImage, '')+'.txt'+' impossible, pensez à le faire vous-même...', mtError, [mbCancel], 0);
  {endif}
  oec_Operation_Suivante;
  Param_Album.DeleteKey ('commentaires', NomImage);
  oec_Operation_Suivante;
  oec_Fermeture;
  Close;
end;

end.
