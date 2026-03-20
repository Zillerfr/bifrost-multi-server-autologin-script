param (
    [string]$ConfigName
)

# Configuration des chemins
$launchConfigPath = Join-Path $PSScriptRoot "Bifrost.LaunchConfig.json"
$serverListPath   = Join-Path $PSScriptRoot "Bifrost.ServerList.json"
$dataPath         = Join-Path $PSScriptRoot "serversconfig.txt"
$exePath          = Join-Path $PSScriptRoot "Bifrost.exe"

# 1. Vérifications de base
if (-not (Test-Path $dataPath)) { Write-Host "ERREUR : serversconfig.txt introuvable." -ForegroundColor Red; pause; exit }
if (-not (Test-Path $launchConfigPath)) { Write-Host "ERREUR : Bifrost.LaunchConfig.json introuvable." -ForegroundColor Red; pause; exit }
if (-not (Test-Path $serverListPath)) { Write-Host "ERREUR : Bifrost.ServerList.json introuvable." -ForegroundColor Red; pause; exit }

# 2. Chargement des données (Import-Csv avec headers forcés)
$choices = Import-Csv $dataPath -Header "Label", "Var1", "Var2" | Where-Object { $_.Label -ne $null -and $_.Label -ne "" }

$selectedItem = $null

# 3. Logique de sélection (Auto ou Manuel)
if (-not [string]::IsNullOrWhiteSpace($ConfigName)) {
    # On cherche le label en ignorant les espaces et la casse
    $selectedItem = $choices | Where-Object { $_.Label.Trim() -ieq $ConfigName.Trim() }
    
    if ($null -eq $selectedItem) {
        Write-Host "Configuration '$ConfigName' non trouvee dans serversconfig.txt." -ForegroundColor Yellow
        Write-Host "Basculement en mode manuel...`n" -ForegroundColor Gray
    }
}

if ($null -eq $selectedItem) {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "       SELECTION DE LA CONFIGURATION" -ForegroundColor Cyan
    Write-Host "===============================================" -ForegroundColor Cyan
    for ($i = 0; $i -lt $choices.Count; $i++) {
        Write-Host ("[{0}] {1}" -f ($i + 1), $choices[$i].Label)
    }
    $selection = Read-Host "`nEntrez le numero choisi"
    $val = 0
    if ([int]::TryParse($selection, [ref]$val) -and $val -le $choices.Count -and $val -gt 0) {
        $selectedItem = $choices[$val - 1]
    }
}

# 4. Traitement des fichiers et lancement
if ($null -ne $selectedItem) {
    try {
        # Recherche de l'index du serveur
        $serverList = Get-Content $serverListPath -Raw | ConvertFrom-Json
        $serverIndex = -1
        
        for ($i = 0; $i -lt $serverList.Count; $i++) {
            if ($serverList[$i].Name.Trim() -ieq $selectedItem.Label.Trim()) {
                $serverIndex = $i
                break
            }
        }

        # Mise à jour du JSON principal
        $launchConfig = Get-Content $launchConfigPath -Raw | ConvertFrom-Json
        $launchConfig.AutoLoginEmailAddress = $selectedItem.Var1
        $launchConfig.AutoLoginPassword     = $selectedItem.Var2
        
        if ($serverIndex -ne -1) {
            $launchConfig.ServerIndex = $serverIndex
        } else {
            Write-Host "AVERTISSEMENT : Le nom '$($selectedItem.Label)' n'a pas ete trouve dans ServerList.json (Index non modifie)." -ForegroundColor Yellow
        }
        
        $launchConfig | ConvertTo-Json -Depth 10 | Set-Content $launchConfigPath
        Write-Host "`nSucces : Configuration appliquee !" -ForegroundColor Green
        
        # Lancement de l'EXE
        if (Test-Path $exePath) {
            Write-Host "Lancement de Bifrost..." -ForegroundColor Gray
            Start-Process -FilePath $exePath
            # On ne pause que si on est en mode interactif
            if ([string]::IsNullOrWhiteSpace($ConfigName)) {
                 Write-Host "`nAppuyez sur une touche pour quitter..."
                 $null = [System.Console]::ReadKey($true)
            }
        } else {
            Write-Host "AVERTISSEMENT : Bifrost.exe introuvable." -ForegroundColor Yellow
            pause
        }
    }
    catch {
        Write-Host "`nErreur technique : $($_.Exception.Message)" -ForegroundColor Red
        pause
    }
} else {
    Write-Host "`nChoix invalide ou annule." -ForegroundColor Red
    pause
}