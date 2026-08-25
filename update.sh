#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# VORTEX - ACTUALIZADOR OFICIAL
#
# UPDATE:
#   Descarga una nueva versión completa del binario VORTEX.
#
# NO elimina:
#   - licencia
#   - reportes
#   - entorno Python
#   - Chromium / Playwright
#   - configuración
#
# El historial de versiones se administra exclusivamente por el proveedor
# en el servidor y NO es gestionado por este script.
# ==============================================================================

APP_NAME="vortex"
INSTALL_DIR="/opt/${APP_NAME}"
BINARY_PATH="${INSTALL_DIR}/${APP_NAME}"

UPDATE_URL="https://api.zerodayslab.co/updates/vortex-latest-linux-amd64"

# SHA256 del artefacto publicado actualmente.
# Debe actualizarse cuando se publique un nuevo binario.
EXPECTED_SHA256="d6138cea749e09c532e206e46ecf3d0ee0b24a60048baaee3351cfe4df51361c"

TMP_FILE="$(mktemp "${INSTALL_DIR}/.vortex-update.XXXXXX")"

cleanup() {
    rm -f "$TMP_FILE"
}

trap cleanup EXIT

# ==============================================================================
# 1. VALIDAR INSTALACIÓN
# ==============================================================================

if [[ ! -d "$INSTALL_DIR" ]]; then
    echo "[-] Error: VORTEX no está instalado en ${INSTALL_DIR}."
    exit 1
fi

if [[ ! -x "$BINARY_PATH" ]]; then
    echo "[-] Error: No se encontró el binario VORTEX:"
    echo "    ${BINARY_PATH}"
    exit 1
fi

echo "============================================================="
echo " VORTEX - Actualizador"
echo "============================================================="
echo "[+] Instalación detectada:"
echo "    ${INSTALL_DIR}"
echo

# ==============================================================================
# 2. MOSTRAR VERSIÓN ACTUAL
# ==============================================================================

echo "[*] Versión actualmente instalada:"
"$BINARY_PATH" --version || true
echo

# ==============================================================================
# 3. DESCARGAR NUEVO BINARIO
# ==============================================================================

echo "[+] Descargando actualización..."
echo "    ${UPDATE_URL}"

if ! curl -fL --retry 3 --connect-timeout 15 \
    -o "$TMP_FILE" \
    "$UPDATE_URL"; then

    echo "[-] Error descargando la actualización."
    exit 1
fi

# ==============================================================================
# 4. VALIDAR QUE SEA UN ELF
# ==============================================================================

if ! file "$TMP_FILE" | grep -qi "ELF"; then
    echo "[-] Error: el archivo descargado no es un binario ELF válido."
    exit 1
fi

echo "[+] Binario ELF válido."

# ==============================================================================
# 5. VERIFICAR SHA256
# ==============================================================================

SHA256_ACTUAL="$(sha256sum "$TMP_FILE" | awk '{print $1}')"

echo "[*] Verificando integridad SHA256..."
echo "    Esperado: ${EXPECTED_SHA256}"
echo "    Recibido: ${SHA256_ACTUAL}"

if [[ "$SHA256_ACTUAL" != "$EXPECTED_SHA256" ]]; then
    echo "[-] Error crítico: SHA256 no coincide."
    echo "[-] La actualización NO será instalada."
    exit 1
fi

echo "[+] Integridad SHA256 verificada."

# ==============================================================================
# 6. PRESERVAR EL ENTORNO
# ==============================================================================

echo
echo "[*] El entorno existente será conservado."

[[ -d "${INSTALL_DIR}/env" ]] && \
    echo "    [+] env/ conservado"

[[ -d "${INSTALL_DIR}/browsers" ]] && \
    echo "    [+] browsers/ conservado"

[[ -d "${INSTALL_DIR}/reporte" ]] && \
    echo "    [+] reporte/ conservado"

[[ -f "/etc/vortex/license.json" ]] && \
    echo "    [+] licencia conservada"

# ==============================================================================
# 7. REEMPLAZO ATÓMICO DEL BINARIO
# ==============================================================================

echo
echo "[+] Instalando nuevo binario..."

chmod 755 "$TMP_FILE"

mv -f "$TMP_FILE" "$BINARY_PATH"

echo "[+] Binario actualizado correctamente."

# ==============================================================================
# 8. VERIFICACIÓN FINAL
# ==============================================================================

if [[ ! -x "$BINARY_PATH" ]]; then
    echo "[-] Error: el nuevo binario no quedó disponible."
    exit 1
fi

echo
echo "============================================================="
echo " VORTEX ACTUALIZADO CORRECTAMENTE"
echo "============================================================="

echo
echo "[+] Nueva versión:"
"$BINARY_PATH" --version

echo
echo "[+] Licencia:"
"$BINARY_PATH" status || true

echo
echo "[+] Entorno preservado."
echo "============================================================="
