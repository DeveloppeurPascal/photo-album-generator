# Photo Album Generator

Create a photo album as a website and deploy files used for an autorun CD-ROM on Windows (yes, I know, it's very very old thing).

## About

This is a Delphi VCL project for Windows.

It was created in 08/1999 to share photo albums on CD-ROM and web sites. This release is from 07/2002.

## Folders

* /src contains a Delphi VCL project (last modified with Delphi 6)
* /deploy-with-exe contains files and folder needed by the program to generate a photo album. They must be in the same folder than your EXE file.

## Personalize the photo album

/deploy_with_exe/mdl folder contains the HTML pages used for the website (with .MDL extension). Replace them with the 4 template pages of your website.

In each file we have tags for the template engine of the program.

### Template pages

* index.mdl is the template for index page of the album
* browser.mdl is the template for the contact sheet ("planche contact" in french) where all pictores are displayed as thumbs
* photo.mdl is the template for each picture page
* credit.mdl is the template for credit page

### Global tags

They are available in all page templates.

* !$titre$! is replaced by the website title
* !$photographe$! is replaced by the photographers name
* !$commentateur$! is replaced by the editors name
* !$commentaire_accueil$! is replaced by "home comment". Its preferred place is in index.mdl page.

### Pictures list

This is available everywhere but preferred in the browser.mdl template page.

* !$liste_photo$! ... !$/liste_photo$! is a loop in the pictures list
* !$nom_page$! is replaced by the picture page name (to use in A tags to link to the detailed picture page)

### Pictures tags

They are available in pictures list and the detailed picture page.

* !$nom_photo$! is replaced by the picture filename (to use in IMG tags as "img/!$nom_photo$!" SRC attribute)
* !$photo_larg$! is replaced by the picture width
* !$photo_haut$! is replaced by the picture height
* !$photo_larg_red$! is replaced by the picture thumb width
* !$photo_haut_red$! is replaced by the picture thumb height

### Navigation tags

* !$nom_page_premiere$! is replaced by the name of the first picture page of the album
* !$nom_page_precedente$! is replaced by picture picture page (in photo.mdl template page)
* !$nom_page_suivante$! is replaced by next picture page (in photo.mdl template page)
* !$nom_page_derniere$! is replaced by the name of the first picture page of the album

### Styling tags

They are available in all page templates.

They are used in original HTML 3 templates pages. Of course they don't have to be in your HTML 5 templates if you use CSS for styling the photo album.

* !$coul_fond$! is replaced by background color
* !$coul_texte$! is replaced by text color

## License

The project is delivered as it. See it as Delphi / Pascal learning resource.

If you want to share the source files, please share a link to this repository, not the files.

## Copyright

(c) Patrick Prémartin / Olf Software 1999