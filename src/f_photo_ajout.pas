unit f_photo_ajout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tfrm_photo_ajout = class(TForm)
    Label1: TLabel;
    edt_NomPhoto: TEdit;
    Label2: TLabel;
    edt_Commentaire: TMemo;
    btn_ok: TBitBtn;
    btn_Cancel: TBitBtn;
    procedure edt_NomPhotoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_okClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_photo_ajout: Tfrm_photo_ajout;

implementation

uses f_photo_detail, f_operation_en_cours, u_param;

{$R *.DFM}

procedure Tfrm_photo_ajout.edt_NomPhotoChange(Sender: TObject);
begin
  Afficher_Photo (nil, edt_NomPhoto.Text);
end;

procedure Tfrm_photo_ajout.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Cacher_Photo;
end;

procedure Tfrm_photo_ajout.btn_okClick(Sender: TObject);
var
   NomImage : string;
   NumPhoto, NumCommentaire : Integer;
begin
  oec_Ouverture (13);
  NomImage := ExtractFileName (edt_NomPhoto.Text);
  oec_Operation_Suivante;
  if (not CopyFile (PChar (edt_NomPhoto.Text), PChar (album_path+'img\'+NomImage), True))
  then
    MessageDlg ('Erreur '+IntToStr (GetLastError ())+' lors de la copie de l''image. Ajout abandonné.', mtError, [mbCancel], 0)
  else
    begin
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('photos', 'nb_photos', Param_Album.ReadInteger ('photos', 'nb_photos', 0)+1);
      oec_Operation_Suivante;
      NumPhoto := Param_Album.ReadInteger ('photos', 'nb_photos', 0);
      oec_Operation_Suivante;
      Param_Album.WriteString ('photos', 'Image'+InttoStr (NumPhoto), NomImage);
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('taille photo', NomImage+' larg', Get_Photo_Larg);
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('taille photo', NomImage+' haut', Get_Photo_Haut);
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('taille photo', NomImage+' larg red', Get_Photo_Larg_Red);
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('taille photo', NomImage+' haut red', Get_Photo_Haut_Red);
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('commentaires', 'nb_commentaires', Param_Album.ReadInteger ('commentaires', 'nb_commentaires', 0)+1);
      oec_Operation_Suivante;
      NumCommentaire := Param_Album.ReadInteger ('commentaires', 'nb_commentaires', 0);
      oec_Operation_Suivante;
      Param_Album.WriteInteger ('Commentaires', NomImage, NumCommentaire);
      oec_Operation_Suivante;
      edt_Commentaire.Lines.SaveToFile (album_path+'comment\'+IntToStr (NumCommentaire)+'.txt');
      oec_Operation_Suivante;
    end;
  {endif}
  oec_Fermeture;
  Close;
end;

procedure Tfrm_photo_ajout.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

end.
