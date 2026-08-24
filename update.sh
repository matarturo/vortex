#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# CONFIGURACIÓN Y RUTAS VORTEX
# ============================================================
CONFIG_FILE="/etc/vortex/license.json"
INSTALL_DIR="/opt/vortex"
BINARY_PATH="${INSTALL_DIR}/vortex"
API_URL="https://api.zerodayslab.co/download.php"
PLATFORM="linux-amd64" # <--- Declararla aquí evita el error de variable no vinculada

# 1. Obtener datos de licencia y Hardware ID desde el JSON local
LICENSE_KEY=""
HW_ID=""
if [[ -f "$CONFIG_FILE" ]]; then
    LICENSE_KEY=$(jq -r '.license_key // .key // ""' "$CONFIG_FILE" 2>/dev/null || echo "")
    HW_ID=$(jq -r '.hw_id // ""' "$CONFIG_FILE" 2>/dev/null || echo "")
fi

# 2. Respaldo: Si no está en el JSON, calcular Hardware ID del sistema
if [[ -z "$HW_ID" || "$HW_ID" == "null" ]]; then
    HW_ID=$(cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}' | head -n1)/address 2>/dev/null | tr -d ':' | tr '[:lower:]' '[:upper:]' || true)
    if [[ -z "$HW_ID" ]]; then
        HW_ID=$(head -n 1 /etc/machine-id 2>/dev/null || echo "UNKNOWN_HW")
    fi
fi

# 3. Petición JSON al backend ICARUS
PAYLOAD=$(jq -n \
  --arg lkey "$LICENSE_KEY" \
  --arg hwid "$HW_ID" \
  --arg plat "$PLATFORM" \
  '{license_key: $lkey, hardware_id: $hwid, platform: $plat}')

RESPONSE=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

# 4. Extraer URL de descarga y SHA256
DOWNLOAD_URL=$(echo "$RESPONSE" | jq -r '.download_url // empty')
SHA256_EXPECTED=$(echo "$RESPONSE" | jq -r '.sha256 // empty')

if [[ -z "$DOWNLOAD_URL" || "$DOWNLOAD_URL" == "null" ]]; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error // "Respuesta invalida del servidor"')
    echo "[-] Error de autorización: ${ERROR_MSG}"
    exit 1
fi

# 5. Descarga atómica y verificación de integridad
TMP_FILE=$(mktemp)
echo "[*] Descargando actualización..."
curl -sL "$DOWNLOAD_URL" -o "$TMP_FILE"

SHA256_ACTUAL=$(sha256sum "$TMP_FILE" | awk '{print $1}')

if [[ "$SHA256_EXPECTED" != "$SHA256_ACTUAL" ]]; then
    echo "[-] Fallo de integridad SHA256. Cancelando instalación."
    rm -f "$TMP_FILE"
    exit 1
fi

# 6. Reemplazo seguro del binario
mkdir -p "$INSTALL_DIR"
chmod +x "$TMP_FILE"
mv "$TMP_FILE" "$BINARY_PATH"

echo "[+] Actualización completada con éxito en ${BINARY_PATH}"
