#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# VORTEX - PATCH MANAGER
#
# Aplica parches publicados por ZERODAYS LAB sobre la versión instalada.
#
# NO reinstala VORTEX.
# NO elimina el entorno.
# NO elimina reportes.
# NO modifica la licencia.
# ==============================================================================

APP_NAME="vortex"
INSTALL_DIR="/opt/${APP_NAME}"
BINARY_PATH="${INSTALL_DIR}/${APP_NAME}"

MANIFEST_URL="https://api.zerodayslab.co/patches/manifest.json"
PLATFORM="linux-amd64"

TMP_FILE="$(mktemp "${INSTALL_DIR}/.vortex-patch.XXXXXX")"

cleanup() {
    rm -f "$TMP_FILE"
}

trap cleanup EXIT

# ==============================================================================
# 1. VALIDAR INSTALACIÓN
# ==============================================================================

if [[ ! -d "$INSTALL_DIR" ]]; then
    echo "[-] Error: VORTEX no está instalado."
    exit 1
fi

if [[ ! -x "$BINARY_PATH" ]]; then
    echo "[-] Error: no se encontró:"
    echo "    ${BINARY_PATH}"
    exit 1
fi

echo "============================================================="
echo " VORTEX - Patch Manager"
echo "============================================================="

# ==============================================================================
# 2. OBTENER VERSIÓN ACTUAL
# ==============================================================================

VERSION_OUTPUT="$("$BINARY_PATH" --version 2>/dev/null || true)"

CURRENT_VERSION="$(
    echo "$VERSION_OUTPUT" |
    grep -oE 'VORTEX v[0-9]+\.[0-9]+\.[0-9]+' |
    head -n1 |
    sed 's/VORTEX v//'
)"

if [[ -z "$CURRENT_VERSION" ]]; then
    echo "[-] No fue posible determinar la versión instalada."
    exit 1
fi

echo "[+] Versión instalada: ${CURRENT_VERSION}"

# ==============================================================================
# 3. DESCARGAR MANIFEST
# ==============================================================================

MANIFEST_FILE="$(mktemp "${INSTALL_DIR}/.vortex-manifest.XXXXXX")"

if ! curl -fL --retry 3 --connect-timeout 15 \
    -o "$MANIFEST_FILE" \
    "$MANIFEST_URL"; then

    echo "[-] Error descargando manifest.json."
    rm -f "$MANIFEST_FILE"
    exit 1
fi

# ==============================================================================
# 4. LEER MANIFEST
# ==============================================================================

VERSION_TARGET="$(
    jq -r '.data.version_target // empty' "$MANIFEST_FILE"
)"

PATCH_VERSION="$(
    jq -r '.data.patch_version // empty' "$MANIFEST_FILE"
)"

ARTIFACT="$(
    jq -r ".data.platforms[\"${PLATFORM}\"].artifact // empty" "$MANIFEST_FILE"
)"

EXPECTED_SHA256="$(
    jq -r ".data.platforms[\"${PLATFORM}\"].sha256 // empty" "$MANIFEST_FILE"
)"

rm -f "$MANIFEST_FILE"

if [[ -z "$VERSION_TARGET" ||
      -z "$PATCH_VERSION" ||
      -z "$ARTIFACT" ||
      -z "$EXPECTED_SHA256" ]]; then

    echo "[-] Manifest inválido o incompleto."
    exit 1
fi

# ==============================================================================
# 4.1 VALIDAR NOMBRE DEL ARTEFACTO
# ==============================================================================

if [[ ! "$ARTIFACT" =~ ^vortex-patch-${VERSION_TARGET}-p[0-9]+-${PLATFORM}$ ]]; then
    echo "[-] Nombre de artefacto inválido."
    echo "    ${ARTIFACT}"
    exit 1
fi

DOWNLOAD_URL="https://api.zerodayslab.co/patches/${ARTIFACT}"

echo "[+] Parche disponible: ${PATCH_VERSION}"
echo "    Aplicable a: ${VERSION_TARGET}"
echo "    Artefacto: ${ARTIFACT}"

# ==============================================================================
# 5. VALIDAR COMPATIBILIDAD
# ==============================================================================

if [[ "$CURRENT_VERSION" != "$VERSION_TARGET" ]]; then
    echo
    echo "[!] Este parche no corresponde a la versión instalada."
    echo "    Instalado : ${CURRENT_VERSION}"
    echo "    Requerido : ${VERSION_TARGET}"
    echo
    echo "[*] No se realizará ninguna modificación."
    exit 0
fi

# ==============================================================================
# 6. DESCARGAR PARCHE
# ==============================================================================

echo
echo "[+] Descargando parche..."
echo "    ${DOWNLOAD_URL}"

if ! curl -fL --retry 3 --connect-timeout 15 \
    -o "$TMP_FILE" \
    "$DOWNLOAD_URL"; then

    echo "[-] Error descargando el parche."
    exit 1
fi

# ==============================================================================
# 7. VALIDAR ELF
# ==============================================================================

if ! file "$TMP_FILE" | grep -qi "ELF"; then
    echo "[-] El archivo descargado no es un ELF válido."
    exit 1
fi

echo "[+] ELF válido."

# ==============================================================================
# 8. VERIFICAR SHA256
# ==============================================================================

SHA256_ACTUAL="$(sha256sum "$TMP_FILE" | awk '{print $1}')"

echo "[*] Verificando integridad..."
echo "    Esperado: ${EXPECTED_SHA256}"
echo "    Recibido: ${SHA256_ACTUAL}"

if [[ "$SHA256_ACTUAL" != "$EXPECTED_SHA256" ]]; then
    echo "[-] Error crítico: SHA256 no coincide."
    echo "[-] El parche NO será instalado."
    exit 1
fi

echo "[+] Integridad verificada."

# ==============================================================================
# 9. REEMPLAZAR SOLAMENTE EL BINARIO
# ==============================================================================

chmod 755 "$TMP_FILE"

echo
echo "[+] Aplicando parche ${PATCH_VERSION}..."

mv -f "$TMP_FILE" "$BINARY_PATH"

# ==============================================================================
# 10. VERIFICACIÓN FINAL
# ==============================================================================

if [[ ! -x "$BINARY_PATH" ]]; then
    echo "[-] Error: el binario parcheado no quedó disponible."
    exit 1
fi

echo
echo "============================================================="
echo " VORTEX PARCHEADO CORRECTAMENTE"
echo "============================================================="

echo
echo "[+] Versión:"
"$BINARY_PATH" --version

echo
echo "[+] Licencia:"
"$BINARY_PATH" status || true

echo
echo "[+] Entorno preservado."
echo "============================================================="
