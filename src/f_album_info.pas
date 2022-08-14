unit f_album_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tfrm_album_info = class(TForm)
    Label1: TLabel;
    edt_titre: TEdit;
    Label2: TLabel;
    edt_photographe: TEdit;
    Label3: TLabel;
    edt_commentateur: TEdit;
    Label4: TLabel;
    edt_Couleur: TComboBox;
    btn_ok: TBitBtn;
    btn_Cancel: TBitBtn;
    Label5: TLabel;
    edt_TexteAccueil: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_album_info: Tfrm_album_info;

implementation

uses u_param, f_operation_en_cours;

{$R *.DFM}

procedure Tfrm_album_info.FormCreate(Sender: TObject);
begin
  edt_titre.Text := Param_Album.ReadString ('album', 'titre', '');
  edt_photographe.Text := Param_Album.ReadString ('album', 'photographe', '');
  edt_commentateur.Text := Param_Album.ReadString ('album', 'commentateur', '');
  edt_couleur.ItemIndex := edt_Couleur.Items.IndexOf (Param_Album.ReadString ('album', 'fond', 'blanc'));
  try
    edt_TexteAccueil.Lines.LoadFromFile (Album_Path+'comment\root.txt');
  except
    edt_TexteAccueil.Lines.Clear;
  end;
end;

procedure Tfrm_album_info.btn_okClick(Sender: TObject);
begin
  Album_Modifie := True;
  Param_Album.WriteString ('album', 'titre', edt_titre.Text);
  Param_Album.WriteString ('album', 'photographe', edt_photographe.Text);
  Param_Album.WriteString ('album', 'commentateur', edt_commentateur.Text);
  Param_Album.WriteString ('album', 'fond', edt_couleur.Items [edt_Couleur.ItemIndex]);
  edt_TexteAccueil.Lines.SaveToFile (Album_Path+'comment\root.txt');
  Close;
end;

procedure Tfrm_album_info.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

end.
