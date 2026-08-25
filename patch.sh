#!/usr/bin/env bash

set -euo pipefail

# ==============================================================================
# PATCH.SH — VORTEX
# Canal gratuito de parches de seguridad
# ==============================================================================

INSTALL_DIR="/opt/vortex"
BIN_PATH="${INSTALL_DIR}/vortex"

PATCH_LOG="/var/lib/vortex/.patches_applied"

ICARUS_URL="https://api.zerodayslab.co/icarus.php"

PATCH_PUBLIC_KEY_B64="YroZSwr1wkieroz/RrN5z47CGGxwa2dv34VPsT7b/7w="

MANIFEST_URL="${ICARUS_URL}?manifest=patch"


echo "[*] Canal ICARUS de parches VORTEX"


# ==============================================================================
# 1. VORTEX INSTALADO
# ==============================================================================

if [ ! -x "$BIN_PATH" ]; then
    echo "[-] VORTEX no está instalado."
    exit 1
fi


# ==============================================================================
# 2. VERSION
# ==============================================================================

VERSION_INSTALADA=$(
    "$BIN_PATH" --version 2>&1 |
    grep -oP '\d+\.\d+\.\d+' |
    head -n1
)

if [ -z "$VERSION_INSTALADA" ]; then
    echo "[-] No se pudo determinar la versión instalada."
    exit 1
fi


# ==============================================================================
# 3. PLATFORM
# ==============================================================================

PLATFORM="linux-amd64"

case "$(uname -m)" in
    aarch64|arm64)
        PLATFORM="linux-arm64"
        ;;
esac

echo "[*] Versión: ${VERSION_INSTALADA}"
echo "[*] Plataforma: ${PLATFORM}"


# ==============================================================================
# 4. MANIFEST DESDE ICARUS
# ==============================================================================

echo "[*] Consultando manifest..."

MANIFEST=$(
    curl -fsSL \
        --retry 3 \
        --connect-timeout 15 \
        --max-time 30 \
        "$MANIFEST_URL"
)

if [ -z "$MANIFEST" ]; then
    echo "[-] No se pudo obtener el manifest."
    exit 1
fi


# ==============================================================================
# 5. SEPARAR DATA / SIGNATURE
# ==============================================================================

MANIFEST_DATA=$(echo "$MANIFEST" | jq -c '.data')
MANIFEST_SIG=$(echo "$MANIFEST" | jq -r '.signature // empty')

if [ -z "$MANIFEST_DATA" ] || [ -z "$MANIFEST_SIG" ]; then
    echo "[-] Manifest incompleto."
    exit 1
fi


# ==============================================================================
# 6. VERIFICAR FIRMA ED25519
# ==============================================================================

FIRMA_VALIDA=$(python3 -c "
import base64
from cryptography.hazmat.primitives.asymmetric import ed25519
from cryptography.exceptions import InvalidSignature

pub = base64.b64decode('${PATCH_PUBLIC_KEY_B64}')

key = ed25519.Ed25519PublicKey.from_public_bytes(pub)

data = '''${MANIFEST_DATA}'''.encode('utf-8')

sig = bytes.fromhex('${MANIFEST_SIG}')

try:
    key.verify(sig, data)
    print('OK')
except InvalidSignature:
    print('INVALID')
except Exception as e:
    print('ERROR:' + str(e))
")

if [ "$FIRMA_VALIDA" != "OK" ]; then
    echo "[-] Firma Ed25519 inválida."
    exit 1
fi

echo "[+] Firma Ed25519 verificada."


# ==============================================================================
# 7. VERSION TARGET
# ==============================================================================

VERSION_TARGET=$(
    echo "$MANIFEST_DATA" |
    jq -r '.version_target // empty'
)

if [ "$VERSION_TARGET" != "$VERSION_INSTALADA" ]; then

    echo "[*] No existe parche para ${VERSION_INSTALADA}."
    exit 0

fi


PATCH_VERSION=$(
    echo "$MANIFEST_DATA" |
    jq -r '.patch_version // empty'
)

SEVERIDAD=$(
    echo "$MANIFEST_DATA" |
    jq -r '.severidad // "no especificada"'
)

DESCRIPCION=$(
    echo "$MANIFEST_DATA" |
    jq -r '.descripcion // "Sin descripción"'
)


# ==============================================================================
# 8. EVITAR REAPLICACIÓN
# ==============================================================================

if [ -f "$PATCH_LOG" ] &&
   grep -qxF "$PATCH_VERSION" "$PATCH_LOG"; then

    echo "[*] Parche ${PATCH_VERSION} ya aplicado."
    exit 0

fi


echo "[*] Parche: ${PATCH_VERSION}"
echo "[*] Severidad: ${SEVERIDAD}"
echo "    ${DESCRIPCION}"


# ==============================================================================
# 9. ARTIFACT
# ==============================================================================

ARTIFACT=$(
    echo "$MANIFEST_DATA" |
    jq -r ".platforms[\"${PLATFORM}\"].artifact // empty"
)

SHA256_ESPERADO=$(
    echo "$MANIFEST_DATA" |
    jq -r ".platforms[\"${PLATFORM}\"].sha256 // empty"
)

if [ -z "$ARTIFACT" ] || [ -z "$SHA256_ESPERADO" ]; then
    echo "[-] Datos del artefacto incompletos."
    exit 1
fi


# ==============================================================================
# 10. SOLICITAR DOWNLOAD A ICARUS
#
# PATCH ES PUBLICO.
# No necesita licencia.
#
# El endpoint entrega un ticket de descarga para el artifact solicitado.
# ==============================================================================

PAYLOAD=$(
    jq -n \
        --arg artifact "$ARTIFACT" \
        --arg scope "patch" \
        '{
            artifact: $artifact,
            scope: $scope
        }'
)

RESPONSE=$(
    curl -fsSL \
        --retry 3 \
        --connect-timeout 15 \
        --max-time 30 \
        -X POST \
        "$ICARUS_URL" \
        -H "Content-Type: application/json" \
        -d "$PAYLOAD"
)


DOWNLOAD_URL=$(
    echo "$RESPONSE" |
    jq -r '.download_url // empty'
)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "[-] ICARUS rechazó la descarga:"
    echo "$RESPONSE"
    exit 1
fi


# ==============================================================================
# 11. DESCARGAR
# ==============================================================================

TMP_BIN=$(mktemp)

trap 'rm -f "$TMP_BIN"' EXIT

echo "[*] Descargando parche..."

curl -fsSL \
    --retry 3 \
    --connect-timeout 15 \
    --max-time 300 \
    "$DOWNLOAD_URL" \
    -o "$TMP_BIN"


# ==============================================================================
# 12. SHA256
# ==============================================================================

SHA256_REAL=$(
    sha256sum "$TMP_BIN" |
    awk '{print $1}'
)

if [ "$SHA256_REAL" != "$SHA256_ESPERADO" ]; then

    echo "[-] SHA256 inválido."

    echo "    Esperado: $SHA256_ESPERADO"
    echo "    Obtenido: $SHA256_REAL"

    exit 1

fi

echo "[+] SHA256 verificado."


# ==============================================================================
# 13. BACKUP
# ==============================================================================

BACKUP_PATH="${BIN_PATH}.bak-pre-${PATCH_VERSION}"

cp "$BIN_PATH" "$BACKUP_PATH"

echo "[+] Backup:"
echo "    $BACKUP_PATH"


# ==============================================================================
# 14. REEMPLAZO ATÓMICO
# ==============================================================================

chmod 755 "$TMP_BIN"

mv "$TMP_BIN" "$BIN_PATH"

trap - EXIT


# ==============================================================================
# 15. REGISTRO
# ==============================================================================

mkdir -p "$(dirname "$PATCH_LOG")"

echo "$PATCH_VERSION" >> "$PATCH_LOG"


# ==============================================================================
# 16. VERIFICACIÓN
# ==============================================================================

echo
echo "[+] Parche aplicado correctamente."

"$BIN_PATH" --version

echo
echo "    Backup:"
echo "    $BACKUP_PATH"
