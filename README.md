# Bifrost Config Switcher

Ce projet permet de changer rapidement la configuration de connexion (Serveur, Email, Mot de passe) de Bifrost avant de lancer le jeu.

This project allows you to quickly swap Bifrost connection settings (Server, Email, Password) before launching the game.

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

---

## 🇺🇸 English

### 📋 Installation
Place these files into your game's root folder (the same directory as `Bifrost.exe`):
* `Choose_Bifrost_Server.ps1`: The main script engine.
* `Launch_Bifrost_WithParams.bat`: The launcher file.
* `serversconfig.txt`: Your accounts and servers database.

### ⚙️ Configuration
1. **The `serversconfig.txt` file**: 
   * Open this file with Notepad.
   * Add your data using this format: `ServerName,Email,Password`.
   * **Important**: The "ServerName" must exactly match the name shown in the game's server list (`Bifrost.ServerList.json`).
   * **Important**: Accents in the password can prevent Bifrost from working properly (the program will open and close immediately). Please ensure you do not use any accented characters.

2. **Creating Custom Shortcuts**:
   * **Right-click** on `Launch_Bifrost_WithParams.bat` > **Create shortcut**.
   * **Right-click** the new shortcut > **Properties**.
   * In the **Shortcut** tab, find the **Target** field.
   * At the end of the line, add a space and then the server name in quotes.
     * *Example*: `"C:\...\Launch_Bifrost_WithParams.bat" "MH Tahiti"`
   * Click **Change Icon**, then **Browse** to find the official Marvel Heroes icon here:
     * `SteamLibrary\steamapps\common\Marvel Heroes\UnrealEngine3\Binaries\Win64\MarvelHeroesOmega.exe`

---

### 🚀 Utilisation / Usage
* **Mode Raccourci** : Double-cliquez sur votre raccourci personnalisé pour configurer et lancer le jeu en un seul clic.
* **Mode Manuel** : Lancez le fichier `.bat` directement pour choisir un serveur dans une liste interactive.

* **Shortcut Mode**: Double-click your custom shortcut to configure and launch the game in one click.
* **Manual Mode**: Run the `.bat` file directly to pick a server from an interactive list.

---

### ⚠️ Dépannage / Troubleshooting
Si le script ne se lance pas, ouvrez PowerShell en tant qu'administrateur et tapez la commande suivante :
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

If the script does not run, open PowerShell as administrator and type the following command :
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
