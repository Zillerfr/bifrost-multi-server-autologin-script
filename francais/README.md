# Bifrost Config Switcher

Ce projet permet de changer rapidement la configuration de connexion (Serveur, Email, Mot de passe) de Bifrost avant de lancer le jeu.

---

## 🇫🇷 Français (French)

### 📋 Installation
Déposez les fichiers suivants dans le dossier racine de votre jeu (là où se trouve `Bifrost.exe`) :
* `Choose_Bifrost_Server.ps1` : Le script principal (moteur).
* `Launch_Bifrost_WithParams.bat` : Le fichier lanceur.
* `serversconfig.txt` : Votre base de données de comptes et serveurs.

### ⚙️ Configuration
1. **Le fichier `serversconfig.txt`** :
   * Ouvrez ce fichier avec le Bloc-notes.
   * Ajoutez vos lignes sous le format : `NomDuServeur,Email,MotDePasse`.
   * **Important** : Le "NomDuServeur" doit être exactement le même que celui affiché dans la liste des serveurs du jeu (`Bifrost.ServerList.json`).
   * **Important** : Les accents dans le mot de passe peuvent empêcher Bifrost de fonctionner (il s'ouvre et se ferme tout de suite), n'en mettez pas.

2. **Création des raccourcis personnalisés** :
   * Faites un **clic droit** sur `Launch_Bifrost_WithParams.bat` > **Créer un raccourci**.
   * Faites un **clic droit** sur le nouveau raccourci > **Propriétés**.
   * Dans l'onglet **Raccourci**, repérez le champ **Cible**.
   * À la fin du texte, ajoutez un espace puis le nom du serveur entre guillemets.
     * *Exemple* : `"C:\...\Launch_Bifrost_WithParams.bat" "MH Tahiti"`
   * Cliquez sur **Changer d'icône**, puis sur **Parcourir** pour sélectionner l'icône officielle de Marvel Heroes ici :
     * `SteamLibrary\steamapps\common\Marvel Heroes\UnrealEngine3\Binaries\Win64\MarvelHeroesOmega.exe`
   * Une fois un premier raccourci créé, le plus rapide est de copier ce raccourci, le renommer et modifier le nom du serveur dans les **Propriétés** à la fin du champ **Cible**.

### 🚀 Utilisation
* **Mode Raccourci** : Double-cliquez sur votre raccourci personnalisé pour configurer et lancer le jeu en un seul clic.
* **Mode Manuel** : Lancez le fichier `.bat` directement pour choisir un serveur dans une liste interactive.

### ⚠️ Dépannage 
Si le script ne se lance pas, ouvrez PowerShell en tant qu'administrateur et tapez la commande suivante :
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
