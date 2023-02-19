# Photo Album Generator

[Cette page en français.](LISEZMOI.md)

Create a photo album as a website and deploy files used for an autorun CD-ROM on Windows (yes, I know, it's very very old thing).

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## About

This is a Delphi VCL project for Windows.

It was created in 08/1999 to share photo albums on CD-ROM and web sites. [This release](https://github.com/DeveloppeurPascal/photo-album-generator/releases) is from 07/2002.

It was inspired by [Arles Images Web Page Creator](https://www.digitaldutch.com/arles/) from [Digital Dutch](https://www.digitaldutch.com/).

## Folders

* /src contains a Delphi VCL project (Delphi 6 realse for 2002/07 release and now Delphi 11.2 Alexandria)
* /deploy-with-exe contains files and folder needed by the program to generate a photo album. They must be in the same folder than your EXE file.

## Personalize the photo album

/deploy_with_exe/mdl folder contains the HTML pages used for the website (with .MDL extension). Replace them with the 4 template pages of your website.

In each file we have tags for the template engine of the program.

### Template pages

* index.mdl is the template for index page of the album
* browser.mdl is the template for the contact sheet ("planche contact" in french) where all pictures are displayed as thumbs
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
* !$nom_page_precedente$! is replaced by previous picture page (in photo.mdl template page)
* !$nom_page_suivante$! is replaced by next picture page (in photo.mdl template page)
* !$nom_page_derniere$! is replaced by the name of the last picture page of the album

### Styling tags

They are available in all page templates.

They are used in original HTML 3 templates pages. Of course they don't have to be in your HTML 5 templates if you use CSS for styling the photo album.

* !$coul_fond$! is replaced by background color
* !$coul_texte$! is replaced by text color

## Copyright

(c) Patrick Prémartin / Olf Software 1999

## Install

To download this project you better should use "git" command but you also can download a ZIP from [its GitHub repository](https://github.com/DeveloppeurPascal/photo-album-generator).

**Warning :** if the project has submodules dependencies they wont be in the ZIP file. You'll have to download them manually.

## Dependencies

This project needs :
* "[DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies)" installed in lib-externes/librairies folder

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/photo-album-generator) and [open a new issue](https://github.com/DeveloppeurPascal/photo-album-generator/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Dual licensing model

This project is distributed under [AGPL 3.0 or later](https://choosealicense.com/licenses/agpl-3.0/) license.

If you want to use it or a part of it in your projects but don't want to share the sources or don't want to distribute your project under the same license you can buy the right to use it under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.
