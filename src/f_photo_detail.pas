unit f_photo_detail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  Tfrm_photo_detail = class(TForm)
    Image1: TImage;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frm_photo_detail: Tfrm_photo_detail;

procedure Afficher_Photo (Sender: TForm; Nom: string);

procedure Cacher_Photo;

function Get_Photo_Larg: Integer;
function Get_Photo_Haut: Integer;
function Get_Photo_Larg_Red: Integer;
function Get_Photo_Haut_Red: Integer;

implementation

{$R *.DFM}

uses
    jpeg;

var
   f : TFrm_Photo_Detail;

procedure Afficher_Photo (Sender: TForm; Nom: string);
begin
  if (f = nil)
  then
    f := TFrm_Photo_Detail.Create (nil);
  {endif}
  try
    f.Hide;
    f.Autosize := False;
    f.Image1.Picture.LoadFromFile (Nom);
    f.Autosize := True;
    f.Show;
  finally
  end;
  if (Sender <> nil)
  then
    Sender.SetFocus;
  {endif}
end;

procedure Cacher_Photo;
begin
  if (f <> nil)
  then
    f.Hide;
  {endif}
end;

function Get_Photo_Larg: Integer;
begin
  if (f.Image1.Picture.Width > f.Image1.Picture.Height)
  then
    if (f.Image1.Picture.Width > 600)
    then
      result := 600
    else
      result := f.Image1.Picture.Width
    {endif}
  else
    result := (f.Image1.Picture.Width * Get_Photo_Haut) div f.Image1.Picture.Height
  {endif}
end;

function Get_Photo_Haut: Integer;
begin
  if (f.Image1.Picture.Height > f.Image1.Picture.Width)
  then
    if (f.Image1.Picture.Height > 600)
    then
      result := 600
    else
      result := f.Image1.Picture.Height
    {endif}
  else
    result := (f.Image1.Picture.Height * Get_Photo_Larg) div f.Image1.Picture.Width
  {endif}
end;

function Get_Photo_Larg_Red: Integer;
begin
  if (f.Image1.Picture.Width > f.Image1.Picture.Height)
  then
    result := 100
  else
    result := (f.Image1.Picture.Width * 100) div f.Image1.Picture.Height;
  {endif}
end;

function Get_Photo_Haut_Red: Integer;
begin
  if (f.Image1.Picture.Width < f.Image1.Picture.Height)
  then
    result := 100
  else
    result := (f.Image1.Picture.Height * 100) div f.Image1.Picture.Width;
  {endif}
end;

initialization
  f := nil;

finalization
  if (f <> nil)
  then
    f.Free;
  {endif}

end.
