#!/usr/bin/env bash

set -euo pipefail

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }

show_help() {
  cat << EOF
Uso: $0 [OPCIONES]

DESCRIPCION:
  Clona el repositorio https://github.com/Maurux01/simplevim
  y lo instala como configuracion de Neovim en ~/.config/nvim.

OPCIONES:
  -h, --help          Muestra esta ayuda.
  -b, --backup        Restaura el ultimo backup disponible.
  -f, --force         Sobrescribe sin preguntar (no crea backup).
  -i, --interactive   Pide confirmacion antes de instalar.

EJEMPLOS:
  $0                     # Instalacion normal
  $0 -i                  # Modo interactivo
  $0 -f                  # Forzar sobrescritura
  $0 -b                  # Restaurar backup

EOF
  exit 0
}

# Variables
FORCE=false
INTERACTIVE=false
BACKUP_RESTORE=false

# Parsear argumentos
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) show_help ;;
    -b|--backup) BACKUP_RESTORE=true; shift ;;
    -f|--force) FORCE=true; shift ;;
    -i|--interactive) INTERACTIVE=true; shift ;;
    *) error "Opcion desconocida: $1. Usa -h para ayuda." ;;
  esac
done

# Verificar que Neovim esta instalado
info "Verificando instalacion de Neovim"

NVIM_PATH=""
if [ -f "/usr/bin/nvim" ]; then
  NVIM_PATH="/usr/bin/nvim"
elif [ -f "/usr/local/bin/nvim" ]; then
  NVIM_PATH="/usr/local/bin/nvim"
elif command -v nvim &> /dev/null; then
  NVIM_PATH=$(command -v nvim)
else
  error "Neovim no esta instalado. Instalalo primero con el gestor de paquetes de tu sistema."
fi

NVIM_VERSION=$($NVIM_PATH --version | head -n 1)
info "Neovim encontrado en: $NVIM_PATH"
info "Version: $NVIM_VERSION"

# Verificar que Git esta instalado
if ! command -v git &> /dev/null; then
  error "Git no esta instalado. Instalalo para poder clonar el repositorio."
fi

# Detectar sistema operativo
OS="$(uname -s)"
case "$OS" in
  Linux*)     OS_TYPE="Linux" ;;
  Darwin*)    OS_TYPE="macOS" ;;
  FreeBSD*|NetBSD*|OpenBSD*) OS_TYPE="BSD" ;;
  MINGW*|CYGWIN*|MSYS*) OS_TYPE="Windows" ;;
  *)          OS_TYPE="Desconocido" ;;
esac

# Detectar WSL
if [[ "$OS_TYPE" == "Linux" && -f /proc/version && $(grep -i microsoft /proc/version) ]]; then
  OS_TYPE="WSL"
fi

info "Sistema detectado: $OS_TYPE"

# Directorio donde se instalara la configuracion
NVIM_CONFIG_DIR="${HOME}/.config/nvim"

info "Directorio destino: $NVIM_CONFIG_DIR"

# Repositorio a clonar
REPO_URL="https://github.com/Maurux01/simplevim"

# Funcion para restaurar backup
restore_backup() {
  local backups=($(ls -d "${NVIM_CONFIG_DIR}.bak."* 2>/dev/null || true))
  if [ ${#backups[@]} -eq 0 ]; then
    error "No hay backups disponibles."
  fi
  echo "Backups disponibles:"
  for i in "${!backups[@]}"; do
    echo "$((i+1))) ${backups[$i]}"
  done
  echo ""
  read -p "Selecciona el numero del backup a restaurar (0 para cancelar): " choice
  if [[ $choice -eq 0 ]]; then
    info "Cancelado."
    exit 0
  fi
  if [[ $choice -lt 1 || $choice -gt ${#backups[@]} ]]; then
    error "Opcion invalida."
  fi
  local selected="${backups[$((choice-1))]}"
  if [ -d "$NVIM_CONFIG_DIR" ]; then
    rm -rf "$NVIM_CONFIG_DIR"
  fi
  cp -r "$selected" "$NVIM_CONFIG_DIR"
  success "Backup restaurado desde: $selected"
  exit 0
}

# Si se pide restaurar backup
if $BACKUP_RESTORE; then
  restore_backup
fi

# Modo interactivo
if $INTERACTIVE; then
  echo ""
  read -p "Clonar $REPO_URL e instalar en $NVIM_CONFIG_DIR? (s/N): " confirm
  if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    info "Instalacion cancelada."
    exit 0
  fi
fi

# Si existe la carpeta destino
if [ -d "$NVIM_CONFIG_DIR" ]; then
  if $FORCE; then
    warn "Eliminando configuracion existente (--force)."
    rm -rf "$NVIM_CONFIG_DIR"
  else
    BACKUP_DIR="${NVIM_CONFIG_DIR}.bak.$(date +%s)"
    warn "Creando backup en: $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    info "Backup creado."
  fi
fi

# Clonar el repositorio directamente en la carpeta destino
info "Clonando repositorio desde $REPO_URL"
git clone --depth 1 "$REPO_URL" "$NVIM_CONFIG_DIR" || {
  error "Fallo al clonar el repositorio. Verifica tu conexion a internet."
}

success "Repositorio clonado correctamente en $NVIM_CONFIG_DIR"

# Mensaje final
echo ""
info "Instalacion completada"
echo "Configuracion instalada en: $NVIM_CONFIG_DIR"
echo ""
echo "Abre Neovim y ejecuta :PackerSync (si usas packer)."
echo "Para restaurar un backup: $0 -b"
