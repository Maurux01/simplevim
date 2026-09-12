#!/usr/bin/env bash

set -euo pipefail

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
debug()   { echo -e "${BLUE}[DEBUG]${NC} $1"; }

# --- HELP ---
show_help() {
  cat << EOF
Uso: $0 [OPCIONES]

DESCRIPCION:
  Instala la configuracion de Neovim (fullstack) de forma automatizada.
  Realiza backup y limpieza completa de directorios para evitar conflictos.

OPCIONES:
  -h, --help            Muestra esta ayuda.
  -b, --backup          Restaura el ultimo backup disponible (con menu).
  -f, --force           Sobrescribe sin preguntar (no crea backup).
  -i, --interactive     Pide confirmacion antes de cada paso destructivo.
  -r, --repo URL        Usa un repositorio diferente al predeterminado.
  -t, --branch BRANCH   Especifica una rama del repositorio.
  -p, --packer-sync     Sincroniza plugins (Lazy.nvim) automaticamente al finalizar.

EJEMPLOS:
  $0                          # Instalacion normal
  $0 -i                       # Modo interactivo
  $0 -f                       # Forzar sobrescritura (sin backup)
  $0 -b                       # Restaurar backup (menu interactivo)
  $0 -r usuario/repo          # Instalar desde otro repositorio
  $0 -r usuario/repo -t develop   # Desde la rama develop
  $0 -p                       # Instalar y sincronizar plugins

EOF
  exit 0
}

# --- DETECTAR SO ---
detect_os() {
  local os_type
  os_type=$(uname -s)
  case "$os_type" in
    Linux*)
      if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
        echo "WSL"
      else
        echo "Linux"
      fi
      ;;
    Darwin*) echo "macOS" ;;
    MINGW*|MSYS*|CYGWIN*) echo "Windows" ;;
    *) echo "Desconocido" ;;
  esac
}

# --- VARIABLES POR DEFECTO ---
REPO_URL="https://github.com/Maurux01/simplevim"
BRANCH_NAME=""
FORCE=false
INTERACTIVE=false
BACKUP_RESTORE=false
AUTO_PACKER_SYNC=false

# --- PARSEAR ARGUMENTOS ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) show_help ;;
    -b|--backup) BACKUP_RESTORE=true; shift ;;
    -f|--force) FORCE=true; shift ;;
    -i|--interactive) INTERACTIVE=true; shift ;;
    -r|--repo) REPO_URL="$2"; shift 2 ;;
    -t|--branch) BRANCH_NAME="$2"; shift 2 ;;
    -p|--packer-sync) AUTO_PACKER_SYNC=true; shift ;;
    *) error "Opcion desconocida: $1. Usa -h para ayuda." ;;
  esac
done

# --- VALIDACIONES INICIALES ---
OS=$(detect_os)
info "Sistema operativo detectado: $OS"

# Verificar Neovim (comprobacion cruzada en rutas estandar)
info "Verificando instalacion de Neovim"
NVIM_PATH=""
if command -v nvim &> /dev/null; then
  NVIM_PATH="$(command -v nvim)"
elif [ -f "/usr/bin/nvim" ]; then
  NVIM_PATH="/usr/bin/nvim"
elif [ -f "/usr/local/bin/nvim" ]; then
  NVIM_PATH="/usr/local/bin/nvim"
elif [ "$OS" = "Windows" ]; then
  # Rutas tipicas de Neovim en Windows (Git Bash ve C: como /c/)
  for _cand in "/c/Program Files/Neovim/bin/nvim.exe" "/c/Program Files (x86)/Neovim/bin/nvim.exe" "${HOME}/AppData/Local/Programs/Neovim/bin/nvim.exe" "/opt/neovim/bin/nvim.exe"; do
    if [ -f "$_cand" ]; then
      NVIM_PATH="$_cand"
      break
    fi
  done
  unset _cand
fi
if [ -z "$NVIM_PATH" ]; then
  error "Neovim no esta instalado. Instalalo primero."
fi

NVIM_VERSION=$("$NVIM_PATH" --version | head -n 1)
info "Neovim encontrado en: $NVIM_PATH"
debug "Version: $NVIM_VERSION"

# Verificar Git
if ! command -v git &> /dev/null; then
  error "Git no esta instalado. Instalalo para poder clonar el repositorio."
fi
info "Git detectado correctamente."

# Dependencias opcionales (no bloquean, solo avisan).
# Telescope necesita 'rg' (live_grep) y 'fd' (find_files rapido).
for dep in rg fd node; do
  if ! command -v "$dep" &> /dev/null; then
    warn "Dependencia opcional no encontrada: '$dep'. Instalala con tu gestor de paquetes (apt/brew/pacman/choco/winget)."
  fi
done

# Directorios de Neovim (segun SO: Windows usa %LOCALAPPDATA%\nvim)
if [ "$OS" = "Windows" ]; then
  # Resolver LOCALAPPDATA a ruta Unix (Git Bash/MSYS/Cygwin)
  _LOCALAPPDATA=""
  if [ -n "${LOCALAPPDATA:-}" ]; then
    if command -v cygpath &> /dev/null; then
      _LOCALAPPDATA=$(cygpath -u "$LOCALAPPDATA")
    else
      _LOCALAPPDATA="$LOCALAPPDATA"
    fi
  fi
  # Fallback tipico en Git Bash: $HOME/AppData/Local
  if [ -z "$_LOCALAPPDATA" ] || [ ! -d "$_LOCALAPPDATA" ]; then
    _LOCALAPPDATA="${HOME}/AppData/Local"
  fi
  # TEMP para cache
  _TEMP_DIR=""
  if [ -n "${TEMP:-}" ]; then
    if command -v cygpath &> /dev/null; then
      _TEMP_DIR=$(cygpath -u "$TEMP")
    else
      _TEMP_DIR="$TEMP"
    fi
  elif [ -n "${TMP:-}" ]; then
    if command -v cygpath &> /dev/null; then
      _TEMP_DIR=$(cygpath -u "$TMP")
    else
      _TEMP_DIR="$TMP"
    fi
  fi
  if [ -z "$_TEMP_DIR" ] || [ ! -d "$_TEMP_DIR" ]; then
    _TEMP_DIR="${HOME}/AppData/Local/Temp"
  fi

  NVIM_CONFIG_DIR="${_LOCALAPPDATA}/nvim"
  NVIM_DATA_DIR="${_LOCALAPPDATA}/nvim-data"
  NVIM_CACHE_DIR="${_TEMP_DIR}/nvim"
else
  NVIM_CONFIG_DIR="${HOME}/.config/nvim"
  NVIM_DATA_DIR="${HOME}/.local/share/nvim"
  NVIM_CACHE_DIR="${HOME}/.cache/nvim"
fi

info "Directorios de Neovim:"
echo "  Config:  $NVIM_CONFIG_DIR"
echo "  Datos:   $NVIM_DATA_DIR"
echo "  Cache:   $NVIM_CACHE_DIR"

# --- RESTAURAR BACKUP ---
restore_backup() {
  local backups
  mapfile -t backups < <(ls -d "${NVIM_CONFIG_DIR}.bak."* 2>/dev/null || true)

  if [ ${#backups[@]} -eq 0 ]; then
    error "No hay backups disponibles en ${NVIM_CONFIG_DIR}.bak.*"
  fi

  echo ""
  echo "Backups disponibles:"
  for i in "${!backups[@]}"; do
    echo "  $((i+1))) ${backups[$i]}"
  done
  echo ""
  read -r -p "Selecciona el numero del backup a restaurar (0 para cancelar): " choice

  if [[ "$choice" == "0" ]]; then
    info "Restauracion cancelada por el usuario."
    exit 0
  fi

  if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#backups[@]}" ]; then
    error "Opcion invalida: $choice"
  fi

  local selected="${backups[$((choice-1))]}"
  info "Restaurando backup: $selected"

  if [ -d "$NVIM_CONFIG_DIR" ]; then
    warn "Eliminando configuracion actual: $NVIM_CONFIG_DIR"
    rm -rf "$NVIM_CONFIG_DIR"
  fi

  cp -r "$selected" "$NVIM_CONFIG_DIR"
  success "Backup restaurado correctamente en $NVIM_CONFIG_DIR"
  echo "NOTA: Puede que necesites reinstalar los plugins al abrir Neovim (Lazy sincroniza al iniciar)."
  exit 0
}

# --- FLUJO PRINCIPAL ---
if $BACKUP_RESTORE; then
  restore_backup
fi

# --- MODO INTERACTIVO: confirmar cada paso destructivo ---
confirm_step() {
  [ "$INTERACTIVE" = false ] && return 0
  local prompt="$1"
  read -r -p "$prompt (s/N): " answer
  [[ "$answer" =~ ^[Ss]$ ]]
}

if $INTERACTIVE; then
  echo ""
  echo "ADVERTENCIA: Se eliminaran los siguientes directorios para una instalacion limpia:"
  echo "  - $NVIM_CONFIG_DIR"
  echo "  - $NVIM_DATA_DIR"
  echo "  - $NVIM_CACHE_DIR"
  if ! confirm_step "Deseas continuar?"; then
    info "Instalacion cancelada por el usuario."
    exit 0
  fi
fi

# --- LIMPIEZA ---
info "Iniciando limpieza de directorios..."

# 1. Backup de configuracion
if [ -d "$NVIM_CONFIG_DIR" ]; then
  if $FORCE; then
    warn "Eliminando configuracion existente (sin backup): $NVIM_CONFIG_DIR"
    if confirm_step "Confirmas la eliminacion de $NVIM_CONFIG_DIR?"; then
      rm -rf "$NVIM_CONFIG_DIR"
    else
      info "Abortado por el usuario."
      exit 0
    fi
  else
    BACKUP_DIR="${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
    warn "Se detecto configuracion existente en $NVIM_CONFIG_DIR"
    if confirm_step "Deseas crear un backup en $BACKUP_DIR?"; then
      mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
      success "Backup creado correctamente: $BACKUP_DIR"
    else
      info "Cancelado. No se modifico la configuracion."
      exit 0
    fi
  fi
else
  info "No existe configuracion previa. Continuando."
fi

# 2. Limpiar datos y caché
for dir in "$NVIM_DATA_DIR" "$NVIM_CACHE_DIR"; do
  if [ -d "$dir" ]; then
    warn "Eliminando directorio: $dir"
    if confirm_step "Eliminar $dir?"; then
      rm -rf "$dir"
      success "Eliminado: $dir"
    fi
  fi
done

# --- INSTALACION ---
info "Clonando repositorio: $REPO_URL"

# Soporte para formato "usuario/repo" y URL completa
CLONE_URL="$REPO_URL"
if [[ "$REPO_URL" != http* ]] && [[ "$REPO_URL" != git@* ]]; then
  CLONE_URL="https://github.com/${REPO_URL}"
fi
info "URL de clonacion: $CLONE_URL"

if [ -n "$BRANCH_NAME" ]; then
  info "Usando rama: $BRANCH_NAME"
  if ! git clone --branch "$BRANCH_NAME" --depth 1 "$CLONE_URL" "$NVIM_CONFIG_DIR"; then
    error "Fallo al clonar el repositorio. Verifica la URL y la rama."
  fi
else
  if ! git clone --depth 1 "$CLONE_URL" "$NVIM_CONFIG_DIR"; then
    error "Fallo al clonar el repositorio. Verifica la URL."
  fi
fi

success "Repositorio clonado con exito en $NVIM_CONFIG_DIR"

# --- SINCRONIZAR PACKER ---
if $AUTO_PACKER_SYNC; then
  info "Sincronizando plugins con Lazy.nvim..."
  if [ -n "$NVIM_PATH" ] && [ -x "$NVIM_PATH" ]; then
    "$NVIM_PATH" --headless "+Lazy! sync" +qa \
      && success "Sincronizacion de plugins completada." \
      || warn "No se pudo sincronizar Lazy automaticamente. Abre Neovim y ejecuta :Lazy."
  else
    warn "Neovim no detectado para sincronizacion automatica. Ejecuta :Lazy manualmente."
  fi
else
  info "Lazy.nvim sincronizara los plugins automaticamente al abrir Neovim."
fi

# --- MENSAJE FINAL ---
echo ""
success "INSTALACION COMPLETADA EXITOSAMENTE"
echo ""
echo "Resumen de la accion:"
echo "  + Sistema:         $OS"
echo "  + Repositorio:     $CLONE_URL"
echo "  + Rama:            ${BRANCH_NAME:-'(default)'}"
echo "  + Configuracion:   $NVIM_CONFIG_DIR"
echo "  + Datos/Plugins:   $NVIM_DATA_DIR (se recrean al iniciar)"
echo "  + Cache:           $NVIM_CACHE_DIR (se recrea al iniciar)"
echo ""
echo "Siguientes pasos:"
echo "  1. Abre Neovim:    nvim"
echo "  2. Si no se sincronizaron, ejecuta: :Lazy"
echo "  3. Disfruta tu configuracion fullstack con tema oscuro"
echo ""
echo "Para restaurar un backup:  $0 -b"
echo "Para ver la ayuda:         $0 -h"
echo ""