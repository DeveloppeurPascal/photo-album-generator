program PhotoAlbumGenerator;

uses
  Forms,
  f_main in 'f_main.pas' {frm_main},
  u_param in 'u_param.pas',
  f_operation_en_cours in '..\..\dev_w32\unites\f_operation_en_cours.pas' {frm},
  f_apropos in 'f_apropos.pas' {frm_APropos},
  f_album_info in 'f_album_info.pas' {frm_album_info},
  f_photo_detail in 'f_photo_detail.pas' {frm_photo_detail},
  f_photo_ajout in 'f_photo_ajout.pas' {frm_photo_ajout},
  f_photo_modif in 'f_photo_modif.pas' {frm_Photo_Modif},
  f_photo_supprimer in 'f_photo_supprimer.pas' {frm_photo_Supprimer},
  f_photo_trier in 'f_photo_trier.pas' {frm_photo_trier},
  u_generation in 'u_generation.pas',
  u_GenerationUtilitaire in '..\unites\u_GenerationUtilitaire.pas',
  u_chgt_version in 'u_chgt_version.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Photo Album Generator';
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
