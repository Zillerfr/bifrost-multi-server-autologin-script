
# Bifrost Config Switcher

This project allows you to quickly swap Bifrost connection settings (Server, Email, Password) before launching the game.

---

## 🇺🇸 English

### 📋 Installation
Place the following files into your game's root folder (where `Bifrost.exe` is located):
* `Choose_Bifrost_Server.ps1`: The main script (engine).
* `Launch_Bifrost_WithParams.bat`: The launcher file.
* `serversconfig.txt`: Your accounts and servers database.

### ⚙️ Configuration
1. **The `serversconfig.txt` file**:
   * Open this file with Notepad.
   * Add your lines using the following format: `ServerName,Email,Password`.
   * **Important**: The "ServerName" must exactly match the name displayed in the game's server list (`Bifrost.ServerList.json`).
   * **Important**: Accents in the password can prevent Bifrost from working properly (the program will open and close immediately). Please ensure you do not use any accented characters.

2. **Creating Custom Shortcuts**:
   * **Right-click** on `Launch_Bifrost_WithParams.bat` > **Create shortcut**.
   * **Right-click** the new shortcut > **Properties**.
   * In the **Shortcut** tab, find the **Target** field.
   * At the end of the text, add a space and then the server name in quotes.
     * *Example*: `"C:\...\Launch_Bifrost_WithParams.bat" "MH Tahiti"`
   * Click on **Change Icon**, then **Browse** to select the official Marvel Heroes icon here:
     * `SteamLibrary\steamapps\common\Marvel Heroes\UnrealEngine3\Binaries\Win64\MarvelHeroesOmega.exe`
   * Once the first shortcut is created, the fastest way is to copy this shortcut, rename it, and modify the server name in the **Properties** at the end of the **Target** field.

### 🚀 Usage
* **Shortcut Mode**: Double-click your custom shortcut to configure and launch the game in one click.
* **Manual Mode**: Run the `.bat` file directly to choose a server from an interactive list.

### ⚠️ Troubleshooting 
If the script does not run, open PowerShell as an administrator and type the following command:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
