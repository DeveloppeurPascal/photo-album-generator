# Photo Album Generator

[This page in english.](README.md)

Génère un album photo en tant que site Internet avec page contact comme accueil. Ces fichiers peuvent être utilisés de façon autonome, sur un site ou gravés sur CD-Rom avec démarrage automatique sous Windows (vieille technique de l'autorun, peut-être plus fonctionnelle de nos jours).

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## A propos

Ce programme est un projet Delphi VCL pour Windows.

Il a été créé en août 1999 pour partager des albums photos sur CD-rom et sur un site Internet. [Cette version](https://github.com/DeveloppeurPascal/photo-album-generator/releases) date de 07/2002.

Le projet a été inspiré du fameux logiciel [Arles Images Web Page Creator](https://www.digitaldutch.com/arles/) de [Digital Dutch](https://www.digitaldutch.com/).

## Dossiers

* /src contient les sources du projet Delphi VCL (version Delphi 6 pour la release de juillet 2002 et Delphi 11.2 Alexandria pour l'actuelle version)
* /deploy-with-exe contient les fichiers et dossiers copiés par le programme lors de la création d'un projet d'album photo. Ils doivent se trouver dans le même dossier que votre exécutable.

## Personnalisez l'album photo

Le dossier /deploy_with_exe/mdl contient les fchiers HTML servant de modèle au site. Une fois votre projet d'album créé, il vous suffit de les personnaliser.

Dans chaque fichier se trouvent des tags remplacés par le moteur de génération de pages du programme.

### Les pages de modèles

* index.mdl sert de modèle HTML pour la page d'accueil de votre album photo
* browser.mdl sert de modèle pour la planche contact de l'album (affichant les images qui font ensuite l'objet d'une page dédiée chacune
* photo.mdl sert de modèle pour les pages de chaque photo
* credit.mdl correspond au modèle de la page des crédits / copyrights de votre album

### Tags globaux

Ils sont disponibles dans tous les modèles de pages.

* !$titre$! est remplacé par le titre du site (saisi au niveau des informations générales)
* !$photographe$! est remplacé par le nom du photographe
* !$commentateur$! est remplacé par le nom de l'éditeur de l'album
* !$commentaire_accueil$! est remplacé par le commentaire lié à l'album photos. Idéalement sa place est sur index.mdl qui sert de page d'accueil pour l'album photo.

### Liste des images

C'est disponible partout mais sa place est plus sur browser.mdl qui sert de planche contact.

* !$liste_photo$! ... !$/liste_photo$! est la boucle permettant de traiter les infos de chaque image
* !$nom_page$! est remplacé par le nom de la page de l'image actuelle (à utiliser en HREF du lien vers la page de de détail de l'image)

### Les tags des photos

Ces tags sont utilisables pour chaque image d'une liste d'images ou d'une page de détail.

* !$nom_photo$! est remplacé par le nom du fichier image (à utiliser en SRC du tag IMG avec par exemple "img/!$nom_photo$!")
* !$photo_larg$! est remplacé par la largeur de l'image
* !$photo_haut$! est remplacé par la hauteur de l'image
* !$photo_larg_red$! est remplacé par la largeur de l'image réduite
* !$photo_haut_red$! est remplacé par la hauteur de l'image réduite

### Tags de navigation

* !$nom_page_premiere$! est remplacé par le nom de la première page de l'album
* !$nom_page_precedente$! est remplacé par le nom de page de l'image précédente (dans le template photo.mdl)
* !$nom_page_suivante$! est remplacé par le nom de page de l'image suivante (dans le template photo.mdl)
* !$nom_page_derniere$! est remplacé par le nom de la dernière page de l'album photo

### Tags de mise en forme

Ils sont disponibles dans tous les modèles.

Ils étaient utilisés dans la première version des modèles en HTML 3 mais vous n'êtes pas obligés de vous en servir si vous décidez d'exploiter HTML 5 et ses feuilles de style pour personnaliser le look de votre album.

* !$coul_fond$! est remplacé par la couleur de background (blanc / noir)
* !$coul_texte$! est remplacé par la couleur de texte (noir / blanc)

## Copyright

(c) Patrick Prémartin / Olf Software 1999

## Installation

Pour télécharger ce projet il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/photo-album-generator).

**Attention :** si le projet utilise des dépendances sous forme de sous modules ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

## Dépendances

Ce dépôt de code dépend des dépôts suivants :
* "[DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies)" à installer dans le dossier lib-externes/librairies

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/photo-album-generator) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/photo-album-generator/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Modèle de licence double

Ce projet est distribué sous licence [AGPL 3.0 ou ultérieure] (https://choosealicense.com/licenses/agpl-3.0/).

Si vous voulez l'utiliser en totalité ou en partie dans vos projets mais ne voulez pas en partager les sources ou ne voulez pas distribuer votre projet sous la même licence, vous pouvez acheter le droit de l'utiliser sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).
