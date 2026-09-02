#!/bin/zsh
# Instalador para usuarios finales: copia la app en /Applications y comprueba su firma.
# Leaner está firmada con Developer ID y notarizada por Apple, así que Gatekeeper la acepta
# sin tener que tocar la cuarentena.
#
#   Uso local:   ./install.sh Leaner-1.1.0.zip
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

echo "▸ Comprobando la firma"
codesign --verify --deep --strict "$DEST/$APP" && echo "  firma íntegra"
if spctl --assess --type execute "$DEST/$APP" >/dev/null 2>&1; then
  echo "  notarizada por Apple: se abre con doble clic, sin avisos"
else
  echo "  aviso: Gatekeeper no la acepta; ábrela con clic derecho → Abrir"
fi
echo
echo "Instalada. Ábrela con:  open \"$DEST/$APP\""
echo "Para que lea la Papelera, Mail y las copias de iPhone, concede «Acceso total al disco» en"
echo "Ajustes del Sistema → Privacidad y seguridad."
