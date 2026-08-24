#!/usr/bin/env bash
set -euo pipefail

LICENSE_FILE="/etc/vortex/license.json"
# Ajustar a la URL real de producción o entorno de prueba de download.php
BACKEND_URL="https://zerodayslab.co/download.php"
INSTALL_DIR="/opt/vortex"
BIN_PATH="${INSTALL_DIR}/vortex"

# 1. Validar existencia de la licencia local
if [ ! -f "$LICENSE_FILE" ]; then
    echo "[-] No hay licencia activada. Ejecute: vortex attach <TOKEN>"
    exit 1
fi

LICENSE_KEY=$(jq -r '.license_key // empty' "$LICENSE_FILE")
if [ -z "$LICENSE_KEY" ]; then
    echo "[-] No se encontró license_key en el registro local."
    exit 1
fi

# 2. Obtener el Hardware ID directamente desde el binario instalado
if [ ! -x "$BIN_PATH" ]; then
    echo "[-] El binario de VORTEX no se encuentra o no es ejecutable en ${BIN_PATH}"
    exit 1
fi

HARDWARE_ID=$("${BIN_PATH}" --show-hwid | grep -oP '(?<=: ).*' || true)
if [ -z "$HARDWARE_ID" ]; then
    # Fallback por si el grep falla en algunas distribuciones
    HARDWARE_ID=$("${BIN_PATH}" --show-hwid | awk '{print $NF}')
fi

if [ -z "$HARDWARE_ID" ]; then
    echo "[-] No se pudo extraer el Hardware ID del equipo."
    exit 1
fi

# 3. Detectar la arquitectura de la plataforma
PLATFORM="linux-amd64"
case "$(uname -m)" in
    aarch64|arm64) PLATFORM="linux-arm64" ;;
esac

# 4. Enviar solicitud POST al backend de descargas (download.php)
echo "[*] Solicitando actualización para hardware_id=${HARDWARE_ID:0:12}... plataforma=${PLATFORM}"
RESPUESTA=$(curl -sS -X POST "$BACKEND_URL" \
    -H "Content-Type: application/json" \
    -d "{\"license_key\":\"${LICENSE_KEY}\",\"hardware_id\":\"${HARDWARE_ID}\",\"platform\":\"${PLATFORM}\"}")

# 5. Extraer la URL firmada y el SHA256 devueltos por download.php
# Verificar si el JSON contiene un error explícito del backend
ERROR_BACKEND=$(echo "$RESPUESTA" | jq -r '.error // empty')
if [ -n "$ERROR_BACKEND" ] && [ "$ERROR_BACKEND" != "null" ]; then
    echo "[-] Actualización rechazada por el servidor central: ${ERROR_BACKEND}"
    exit 1
fi

DOWNLOAD_URL=$(echo "$RESPUESTA" | jq -r '.download_url // empty')
SHA256_ESPERADO=$(echo "$RESPUESTA" | jq -r '.sha256 // empty')

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" = "null" ]; then
    echo "[-] No se pudo obtener la URL de actualización del servidor."
    exit 1
fi

# 6. Descargar el binario latest de forma temporal
TMP_BIN=$(mktemp)
echo "[*] Descargando el binario actualizado..."
curl -# -o "$TMP_BIN" "$DOWNLOAD_URL"

# 7. Validar la integridad mediante el hash SHA256 provisto por el servidor
SHA256_REAL=$(sha256sum "$TMP_BIN" | cut -d' ' -f1)
if [ "$SHA256_REAL" != "$SHA256_ESPERADO" ]; then
    echo "[-] Error crítico: El checksum SHA256 no coincide."
    echo "    Esperado:  ${SHA256_ESPERADO}"
    echo "    Obtenido:  ${SHA256_REAL}"
    echo "    La actualización fue descartada por seguridad."
    rm -f "$TMP_BIN"
    exit 1
fi

# 8. Reemplazar de forma atómica el binario antiguo por el nuevo
chmod +x "$TMP_BIN"
echo "[*] Actualizando binario en ${BIN_PATH}..."
sudo mv "$TMP_BIN" "$BIN_PATH"
echo "[+] VORTEX se ha actualizado y verificado correctamente."
"${BIN_PATH}" --version

