unit f_photo_trier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tfrm_photo_trier = class(TForm)
    ListePhotos: TListBox;
    btn_Monter: TBitBtn;
    btn_Descendre: TBitBtn;
    btn_Fermer: TBitBtn;
    procedure btn_FermerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListePhotosClick(Sender: TObject);
    procedure btn_MonterClick(Sender: TObject);
    procedure btn_DescendreClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_photo_trier: Tfrm_photo_trier;

implementation

uses f_photo_detail, f_operation_en_cours, u_param;

{$R *.DFM}

procedure Tfrm_photo_trier.btn_FermerClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_photo_trier.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Cacher_Photo;
end;

procedure Tfrm_photo_trier.FormCreate(Sender: TObject);
var
   i : integer;
begin
  ListePhotos.Clear;
  For i := 1 to Param_Album.ReadInteger ('photos', 'nb_photos', 0) do
    ListePhotos.Items.Add (Param_Album.ReadString ('photos', 'Image'+IntToStr (i), ''));
  {endfor}
end;

procedure Tfrm_photo_trier.ListePhotosClick(Sender: TObject);
begin
  Afficher_Photo (Self, Album_Path+'img\'+ListePhotos.Items [ListePhotos.ItemIndex]);
end;

procedure Tfrm_photo_trier.btn_MonterClick(Sender: TObject);
var
   i, j : integer;
begin
  if (ListePhotos.ItemIndex > 0)
  then
    begin
      oec_Ouverture (6);
      i := Succ (ListePhotos.ItemIndex);
      oec_Operation_Suivante;
      j := ListePhotos.ItemIndex;
      oec_Operation_Suivante;
      Param_Album.WriteString ('photos', 'Image'+IntToStr (i), ListePhotos.Items [Pred (j)]);
      oec_Operation_Suivante;
      Param_Album.WriteString ('photos', 'Image'+IntToStr (Pred (i)), ListePhotos.Items [j]);
      oec_Operation_Suivante;
      ListePhotos.Items.Insert (Succ (j), ListePhotos.Items [Pred (j)]);
      oec_Operation_Suivante;
      ListePhotos.Items.Delete (Pred (j));
      oec_Operation_Suivante;
      oec_Fermeture;
    end;
  {endif}
end;

procedure Tfrm_photo_trier.btn_DescendreClick(Sender: TObject);
var
   i, j : integer;
   ch : string;
begin
  if (ListePhotos.ItemIndex < Pred (ListePhotos.Items.Count))
  then
    begin
      oec_Ouverture (7);
      i := Succ (ListePhotos.ItemIndex);
      oec_Operation_Suivante;
      j := ListePhotos.ItemIndex;
      oec_Operation_Suivante;
      Param_Album.WriteString ('photos', 'Image'+IntToStr (i), ListePhotos.Items [Succ (j)]);
      oec_Operation_Suivante;
      Param_Album.WriteString ('photos', 'Image'+IntToStr (Succ (i)), ListePhotos.Items [j]);
      oec_Operation_Suivante;
      ch := ListePhotos.Items [Succ (j)];
      oec_Operation_Suivante;
      ListePhotos.Items.Delete (Succ (j));
      oec_Operation_Suivante;
      ListePhotos.Items.Insert (j, ch);
      oec_Operation_Suivante;
      oec_Fermeture;
    end;
  {endif}
end;

end.
