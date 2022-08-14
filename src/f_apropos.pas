unit f_apropos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tfrm_APropos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_APropos: Tfrm_APropos;

implementation

{$R *.DFM}

procedure Tfrm_APropos.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
