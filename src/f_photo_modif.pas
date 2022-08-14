unit f_photo_modif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tfrm_Photo_Modif = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edt_Commentaire: TMemo;
    edt_NomPhoto: TComboBox;
    btn_Valider: TBitBtn;
    btn_Fermer: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edt_NomPhotoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ValiderClick(Sender: TObject);
    procedure btn_FermerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_Photo_Modif: Tfrm_Photo_Modif;

implementation

uses f_photo_detail, u_param;

{$R *.DFM}

procedure Tfrm_Photo_Modif.FormCreate(Sender: TObject);
var
   i : integer;
begin
  edt_NomPhoto.Items.Clear;
  For i := 1 to Param_Album.ReadInteger ('photos', 'nb_photos', 0) do
    edt_NomPhoto.Items.Add (Param_Album.ReadString ('photos', 'Image'+IntToStr (i), ''));
  {endfor}
  edt_Commentaire.Lines.Clear;
end;

procedure Tfrm_Photo_Modif.edt_NomPhotoChange(Sender: TObject);
var
   NomPhoto: string;
begin
  NomPhoto := edt_NomPhoto.Items [edt_NomPhoto.ItemIndex];
  Afficher_Photo (Self, Album_Path+'img\'+NomPhoto);
  try
    edt_Commentaire.Lines.LoadFromFile (Album_Path+'comment\'+Param_Album.ReadString ('commentaires', NomPhoto, '')+'.txt');
  except
    edt_Commentaire.Lines.Clear;
  end;
end;

procedure Tfrm_Photo_Modif.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Cacher_Photo;
end;

procedure Tfrm_Photo_Modif.btn_ValiderClick(Sender: TObject);
begin
  edt_Commentaire.Lines.SaveToFile (Album_Path+'comment\'+Param_Album.ReadString ('commentaires', edt_NomPhoto.Items [edt_NomPhoto.ItemIndex], '')+'.txt');
  MessageDlg ('Enregistrement effectué', mtInformation, [mbOK], 0);
end;

procedure Tfrm_Photo_Modif.btn_FermerClick(Sender: TObject);
begin
  Close;
end;

end.
