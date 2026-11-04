#!/usr/bin/env bash
# Baixa os pacotes de um release do quant-energia-raw, confere o SHA256SUMS e descompacta no destino.
# Uso: ./baixar.sh [release|latest] [destino]
set -euo pipefail
REPO="pimenta-arthur/quant-energia-raw"
REL="${1:-latest}"
DEST="${2:-./raw}"
if [ "$REL" = "latest" ]; then BASE="https://github.com/$REPO/releases/latest/download"
else BASE="https://github.com/$REPO/releases/download/$REL"; fi
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
curl -fsSL "$BASE/SHA256SUMS" -o "$TMP/SHA256SUMS"
while read -r _ nome; do
  echo "baixando ${nome}..."
  curl -fsSL "$BASE/$nome" -o "$TMP/$nome"
done < "$TMP/SHA256SUMS"
(cd "$TMP" && shasum -a 256 -c SHA256SUMS)
mkdir -p "$DEST"
for z in "$TMP"/*.zip; do unzip -q "$z" -d "$DEST"; done
echo "pronto: $DEST"
