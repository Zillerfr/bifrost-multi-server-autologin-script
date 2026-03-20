param (
    [string]$ConfigName
)

# Path configuration
$launchConfigPath = Join-Path $PSScriptRoot "Bifrost.LaunchConfig.json"
$serverListPath   = Join-Path $PSScriptRoot "Bifrost.ServerList.json"
$dataPath         = Join-Path $PSScriptRoot "serversconfig.txt"
$exePath          = Join-Path $PSScriptRoot "Bifrost.exe"

# 1. Basic checks
if (-not (Test-Path $dataPath)) { Write-Host "ERROR: serversconfig.txt not found." -ForegroundColor Red; pause; exit }
if (-not (Test-Path $launchConfigPath)) { Write-Host "ERROR: Bifrost.LaunchConfig.json not found." -ForegroundColor Red; pause; exit }
if (-not (Test-Path $serverListPath)) { Write-Host "ERROR: Bifrost.ServerList.json not found." -ForegroundColor Red; pause; exit }

# 2. Data loading (Import-Csv with forced headers)
$choices = Import-Csv $dataPath -Header "Label", "Var1", "Var2" | Where-Object { $_.Label -ne $null -and $_.Label -ne "" }

$selectedItem = $null

# 3. Selection logic (Auto or Manual)
if (-not [string]::IsNullOrWhiteSpace($ConfigName)) {
    # Searching for the label while ignoring spaces and case
    $selectedItem = $choices | Where-Object { $_.Label.Trim() -ieq $ConfigName.Trim() }
    
    if ($null -eq $selectedItem) {
        Write-Host "Configuration '$ConfigName' not found in serversconfig.txt." -ForegroundColor Yellow
        Write-Host "Switching to manual mode...`n" -ForegroundColor Gray
    }
}

if ($null -eq $selectedItem) {
    Clear-Host
    Write-Host "===============================================" -ForegroundColor Cyan
    Write-Host "           CONFIGURATION SELECTION" -ForegroundColor Cyan
    Write-Host "===============================================" -ForegroundColor Cyan
    for ($i = 0; $i -lt $choices.Count; $i++) {
        Write-Host ("[{0}] {1}" -f ($i + 1), $choices[$i].Label)
    }
    $selection = Read-Host "`nEnter the chosen number"
    $val = 0
    if ([int]::TryParse($selection, [ref]$val) -and $val -le $choices.Count -and $val -gt 0) {
        $selectedItem = $choices[$val - 1]
    }
}

# 4. File processing and launching
if ($null -ne $selectedItem) {
    try {
        # Searching for the server index
        $serverList = Get-Content $serverListPath -Raw | ConvertFrom-Json
        $serverIndex = -1
        
        for ($i = 0; $i -lt $serverList.Count; $i++) {
            if ($serverList[$i].Name.Trim() -ieq $selectedItem.Label.Trim()) {
                $serverIndex = $i
                break
            }
        }

        # Updating the main JSON
        $launchConfig = Get-Content $launchConfigPath -Raw | ConvertFrom-Json
        $launchConfig.AutoLoginEmailAddress = $selectedItem.Var1
        $launchConfig.AutoLoginPassword     = $selectedItem.Var2
        
        if ($serverIndex -ne -1) {
            $launchConfig.ServerIndex = $serverIndex
        } else {
            Write-Host "WARNING: The name '$($selectedItem.Label)' was not found in ServerList.json (Index not modified)." -ForegroundColor Yellow
        }
        
        $launchConfig | ConvertTo-Json -Depth 10 | Set-Content $launchConfigPath
        Write-Host "`nSuccess: Configuration applied!" -ForegroundColor Green
        
        # Launching the EXE
        if (Test-Path $exePath) {
            Write-Host "Launching Bifrost..." -ForegroundColor Gray
            Start-Process -FilePath $exePath
            # Only pause if in interactive mode
            if ([string]::IsNullOrWhiteSpace($ConfigName)) {
                 Write-Host "`nPress any key to exit..."
                 $null = [System.Console]::ReadKey($true)
            }
        } else {
            Write-Host "WARNING: Bifrost.exe not found." -ForegroundColor Yellow
            pause
        }
    }
    catch {
        Write-Host "`nTechnical error: $($_.Exception.Message)" -ForegroundColor Red
        pause
    }
} else {
    Write-Host "`nInvalid choice or cancelled." -ForegroundColor Red
    pause
}