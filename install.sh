#!/bin/zsh
# Instalador para usuarios finales: copia la app en /Applications y le quita la cuarentena
# para que Gatekeeper no la bloquee (la app no está notarizada).
#
#   Uso local:   Scripts/install.sh dist/Leaner-1.0.0.zip
#   Uso remoto:  curl -fsSL https://raw.githubusercontent.com/leaner-app/releases/main/install.sh | zsh
#                (instala siempre la última release publicada)
set -euo pipefail

DEFAULT_URL="https://github.com/leaner-app/releases/releases/latest/download/Leaner.zip"
SOURCE="${1:-${DISKCLEANER_URL:-$DEFAULT_URL}}"
DEST="${DEST:-/Applications}"
APP="Leaner.app"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "▸ Obteniendo $SOURCE"
if [[ "$SOURCE" == http* ]]; then
  curl -fsSL "$SOURCE" -o "$WORK/app.zip"
else
  cp "$SOURCE" "$WORK/app.zip"
fi

echo "▸ Descomprimiendo"
ditto -x -k "$WORK/app.zip" "$WORK/unpacked"
FOUND="$(find "$WORK/unpacked" -maxdepth 2 -name "$APP" -print -quit)"
[[ -n "$FOUND" ]] || { echo "El zip no contiene $APP" >&2; exit 1; }

if pgrep -x Leaner >/dev/null; then
  echo "▸ Cerrando la versión en ejecución"
  osascript -e 'tell application "Leaner" to quit' >/dev/null 2>&1 || pkill -x Leaner || true
  sleep 1
fi

echo "▸ Instalando en $DEST/$APP"
mkdir -p "$DEST"
rm -rf "$DEST/$APP"
ditto "$FOUND" "$DEST/$APP"

echo "▸ Quitando la cuarentena de Gatekeeper"
xattr -dr com.apple.quarantine "$DEST/$APP" 2>/dev/null || true

codesign --verify --deep --strict "$DEST/$APP" && echo "▸ Firma íntegra"
echo
echo "Instalada. Ábrela con:  open \"$DEST/$APP\""
echo "Para que lea la Papelera, Mail y las copias de iPhone, concede «Acceso total al disco» en"
echo "Ajustes del Sistema → Privacidad y seguridad."
