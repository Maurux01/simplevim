#Requires -Version 5.1
<#
.SYNOPSIS
    Instalador de simplevim para Neovim en Windows.

.DESCRIPTION
    Instala la configuracion de Neovim (fullstack) de forma automatizada en Windows.
    Realiza backup y limpieza completa de directorios para evitar conflictos.

.PARAMETER Help
    Muestra esta ayuda.

.PARAMETER Backup
    Restaura el ultimo backup disponible (con menu).

.PARAMETER Force
    Sobrescribe sin preguntar (no crea backup).

.PARAMETER Interactive
    Pide confirmacion antes de cada paso destructivo.

.PARAMETER Repo
    Usa un repositorio diferente al predeterminado.

.PARAMETER Branch
    Especifica una rama del repositorio.

.PARAMETER LazySync
    Sincroniza plugins (Lazy.nvim) automaticamente al finalizar.

.EXAMPLE
    .\script.ps1
    .\script.ps1 -Interactive
    .\script.ps1 -Force
    .\script.ps1 -Backup
    .\script.ps1 -Repo "usuario/repo" -Branch "develop"
    .\script.ps1 -LazySync
#>

param(
    [switch]$Help,
    [switch]$Backup,
    [switch]$Force,
    [switch]$Interactive,
    [string]$Repo = "https://github.com/Maurux01/simplevim",
    [string]$Branch = "",
    [switch]$LazySync
)

# --- COLORES ---
function Write-Info    { param([string]$Msg) Write-Host "[INFO] " -ForegroundColor Green -NoNewline; Write-Host $Msg }
function Write-Warn    { param([string]$Msg) Write-Host "[WARN] " -ForegroundColor Yellow -NoNewline; Write-Host $Msg }
function Write-Error   { param([string]$Msg) Write-Host "[ERROR] " -ForegroundColor Red -NoNewline; Write-Host $Msg; exit 1 }
function Write-OK      { param([string]$Msg) Write-Host "[OK] " -ForegroundColor Green -NoNewline; Write-Host $Msg }
function Write-Debug   { param([string]$Msg) Write-Host "[DEBUG] " -ForegroundColor Cyan -NoNewline; Write-Host $Msg }

# --- HELP ---
if ($Help) {
    Get-Help -Full $PSCommandPath
    exit 0
}

# --- DIRECTORIOS DE NEOVIM EN WINDOWS ---
# Neovim en Windows usa: %LOCALAPPDATA%\nvim
# Data:    %LOCALAPPDATA%\nvim-data
# Cache:   %TEMP%\nvim (o %LOCALAPPDATA%\nvim-data\cache)

$NvimConfigDir = Join-Path $env:LOCALAPPDATA "nvim"
$NvimDataDir   = Join-Path $env:LOCALAPPDATA "nvim-data"
$NvimCacheDir  = Join-Path $env:TEMP "nvim"

Write-Info "Sistema operativo detectado: Windows"
Write-Info "Directorios de Neovim:"
Write-Host "  Config:  $NvimConfigDir"
Write-Host "  Datos:   $NvimDataDir"
Write-Host "  Cache:   $NvimCacheDir"

# --- VERIFICAR NEOVIM ---
Write-Info "Verificando instalacion de Neovim"
$NvimPath = Get-Command nvim -ErrorAction SilentlyContinue
if (-not $NvimPath) {
    Write-Error "Neovim no esta instalado. Instalalo primero (https://neovim.io)."
}
$NvimVersion = & nvim --version 2>$null | Select-Object -First 1
Write-Info "Neovim encontrado en: $($NvimPath.Source)"
Write-Debug "Version: $NvimVersion"

# --- VERIFICAR GIT ---
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git no esta instalado. Instalalo para poder clonar el repositorio."
}
Write-Info "Git detectado correctamente."

# --- FUNCION: CONFIRMAR PASO ---
function Confirm-Step {
    param([string]$Prompt)
    if (-not $Interactive) { return $true }
    $answer = Read-Host "$Prompt (s/N)"
    return ($answer -eq "s" -or $answer -eq "S")
}

# --- RESTAURAR BACKUP ---
function Restore-Backup {
    $backupPattern = "$NvimConfigDir.bak.*"
    $backups = Get-ChildItem -Path $backupPattern -Directory -ErrorAction SilentlyContinue | Sort-Object Name

    if ($backups.Count -eq 0) {
        Write-Error "No hay backups disponibles en $NvimConfigDir.bak.*"
    }

    Write-Host ""
    Write-Host "Backups disponibles:"
    for ($i = 0; $i -lt $backups.Count; $i++) {
        Write-Host "  $($i + 1)) $($backups[$i].FullName)"
    }
    Write-Host ""
    $choice = Read-Host "Selecciona el numero del backup a restaurar (0 para cancelar)"

    if ($choice -eq "0") {
        Write-Info "Restauracion cancelada por el usuario."
        exit 0
    }

    if (-not ($choice -match '^\d+$') -or [int]$choice -lt 1 -or [int]$choice -gt $backups.Count) {
        Write-Error "Opcion invalida: $choice"
    }

    $selected = $backups[[int]$choice - 1].FullName
    Write-Info "Restaurando backup: $selected"

    if (Test-Path $NvimConfigDir) {
        Write-Warn "Eliminando configuracion actual: $NvimConfigDir"
        Remove-Item -Recurse -Force $NvimConfigDir
    }

    Copy-Item -Recurse $selected $NvimConfigDir
    Write-OK "Backup restaurado correctamente en $NvimConfigDir"
    Write-Host "NOTA: Puede que necesites reinstalar los plugins al abrir Neovim (Lazy sincroniza al iniciar)."
    exit 0
}

# --- FLUJO PRINCIPAL ---
if ($Backup) {
    Restore-Backup
}

# --- MODO INTERACTIVO ---
if ($Interactive) {
    Write-Host ""
    Write-Host "ADVERTENCIA: Se eliminaran los siguientes directorios para una instalacion limpia:"
    Write-Host "  - $NvimConfigDir"
    Write-Host "  - $NvimDataDir"
    Write-Host "  - $NvimCacheDir"
    if (-not (Confirm-Step "Deseas continuar?")) {
        Write-Info "Instalacion cancelada por el usuario."
        exit 0
    }
}

# --- LIMPIEZA ---
Write-Info "Iniciando limpieza de directorios..."

# 1. Backup de configuracion
if (Test-Path $NvimConfigDir) {
    if ($Force) {
        Write-Warn "Eliminando configuracion existente (sin backup): $NvimConfigDir"
        if (Confirm-Step "Confirmas la eliminacion de $NvimConfigDir?") {
            Remove-Item -Recurse -Force $NvimConfigDir
        } else {
            Write-Info "Abortado por el usuario."
            exit 0
        }
    } else {
        $timestamp = Get-Date -Format "yyyyMMddHHmmss"
        $BackupDir = "$NvimConfigDir.bak.$timestamp"
        Write-Warn "Se detecto configuracion existente en $NvimConfigDir"
        if (Confirm-Step "Deseas crear un backup en $BackupDir?") {
            Rename-Item $NvimConfigDir $BackupDir
            Write-OK "Backup creado correctamente: $BackupDir"
        } else {
            Write-Info "Cancelado. No se modifico la configuracion."
            exit 0
        }
    }
} else {
    Write-Info "No existe configuracion previa. Continuando."
}

# 2. Limpiar datos y cache
foreach ($dir in @($NvimDataDir, $NvimCacheDir)) {
    if (Test-Path $dir) {
        Write-Warn "Eliminando directorio: $dir"
        if (Confirm-Step "Eliminar $dir?") {
            Remove-Item -Recurse -Force $dir
            Write-OK "Eliminado: $dir"
        }
    }
}

# --- INSTALACION ---
Write-Info "Clonando repositorio: $Repo"

# Soporte para formato "usuario/repo" y URL completa
$CloneUrl = $Repo
if (-not ($Repo -match "^(https?|git@)")) {
    $CloneUrl = "https://github.com/$Repo"
}
Write-Info "URL de clonacion: $CloneUrl"

$cloneArgs = @("clone", "--depth", "1")
if ($Branch -ne "") {
    Write-Info "Usando rama: $Branch"
    $cloneArgs += "--branch"
    $cloneArgs += $Branch
}
$cloneArgs += $CloneUrl
$cloneArgs += $NvimConfigDir

& git @cloneArgs
if ($LASTEXITCODE -ne 0) {
    Write-Error "Fallo al clonar el repositorio. Verifica la URL y la rama."
}

Write-OK "Repositorio clonado con exito en $NvimConfigDir"

# --- SINCRONIZAR LAZY ---
if ($LazySync) {
    Write-Info "Sincronizando plugins con Lazy.nvim..."
    $nvimExe = $NvimPath.Source
    & "$nvimExe" --headless "+Lazy! sync" +qa 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-OK "Sincronizacion de plugins completada."
    } else {
        Write-Warn "No se pudo sincronizar Lazy automaticamente. Abre Neovim y ejecuta :Lazy."
    }
} else {
    Write-Info "Lazy.nvim sincronizara los plugins automaticamente al abrir Neovim."
}

# --- MENSAJE FINAL ---
Write-Host ""
Write-OK "INSTALACION COMPLETADA EXITOSAMENTE"
Write-Host ""
Write-Host "Resumen de la accion:"
Write-Host "  + Sistema:         Windows"
Write-Host "  + Repositorio:     $CloneUrl"
Write-Host "  + Rama:            $(if ($Branch -ne "") { $Branch } else { '(default)' })"
Write-Host "  + Configuracion:   $NvimConfigDir"
Write-Host "  + Datos/Plugins:   $NvimDataDir (se recrean al iniciar)"
Write-Host "  + Cache:           $NvimCacheDir (se recrea al iniciar)"
Write-Host ""
Write-Host "Siguientes pasos:"
Write-Host "  1. Abre Neovim:    nvim"
Write-Host "  2. Si no se sincronizaron, ejecuta: :Lazy"
Write-Host "  3. Disfruta tu configuracion fullstack con tema oscuro"
Write-Host ""
Write-Host "Para restaurar un backup:  .\script.ps1 -Backup"
Write-Host "Para ver la ayuda:         .\script.ps1 -Help"
Write-Host ""
