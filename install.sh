#!/bin/bash
# ==============================================================================
# Script de Instalación Oficial - VORTEX Assessment Engine
# Arquitectura Unificada / Despliegue en /opt/vortex/
#
# Runtime SPA:
#   Playwright Python -> runtime técnico interno
#   Chromium         -> /opt/vortex/browsers
#
# El usuario NO necesita activar el VENV para ejecutar VORTEX.
# ==============================================================================

set -e
set -u
set -o pipefail

APP_NAME="vortex"
INSTALL_DIR="/opt/$APP_NAME"
SYMLINK_PATH="/usr/local/bin/$APP_NAME"

VENV_DIR="$INSTALL_DIR/env"
BROWSERS_DIR="$INSTALL_DIR/browsers"

PLAYWRIGHT_VERSION="1.62.0"

PACKAGE_URL="https://github.com/matarturo/vortex/raw/main/vortex-latest.tar.gz"
PACKAGE_FILE="/tmp/vortex-latest.tar.gz"

# ==============================================================================
# 1. VALIDAR PRIVILEGIOS
# ==============================================================================

if [ "$EUID" -ne 0 ]; then
    echo "[-] Error: Ejecute este instalador como root o mediante sudo."
    exit 1
fi

echo "============================================================="
echo "        VORTEX Assessment Engine - Installer"
echo "============================================================="
echo "[+] Iniciando despliegue de VORTEX..."
echo

# ==============================================================================
# 2. VALIDAR PRERREQUISITOS DEL SISTEMA
# ==============================================================================

echo "[*] Validando dependencias mínimas del sistema..."

# Validar binarios estándar mediante command -v
bin_dependencies=(
    curl
    tar
    file
    python3
)

missing_deps=()

for dep in "${bin_dependencies[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        missing_deps+=("$dep")
    fi
done

# Validar módulos/paquetes específicos de Python mediante dpkg o chequeo interno
if ! dpkg-query -W -f='${Status}' python3-venv 2>/dev/null | grep -q "install ok installed"; then
    missing_deps+=("python3-venv")
fi

if ! dpkg-query -W -f='${Status}' python3-pip 2>/dev/null | grep -q "install ok installed"; then
    missing_deps+=("python3-pip")
fi

if [ "${#missing_deps[@]}" -gt 0 ]; then
    echo "[-] Faltan dependencias del sistema:"
    printf '    - %s\n' "${missing_deps[@]}"
    echo
    echo "[!] Instálelas antes de continuar:"
    echo "    apt-get update"
    echo "    apt-get install -y ${missing_deps[*]}"
    exit 1
fi

echo "[+] Prerrequisitos mínimos disponibles."

# ==============================================================================
# 3. LIMPIEZA ABSOLUTA DE INSTALACIÓN ANTERIOR
# ==============================================================================

echo
echo "[+] Limpiando instalación anterior..."

rm -rf "$INSTALL_DIR"
rm -f "$SYMLINK_PATH"
rm -f /etc/profile.d/vortex.sh
rm -f "$PACKAGE_FILE"

mkdir -p "$INSTALL_DIR"

echo "[+] Infraestructura base preparada."

# ==============================================================================
# 4. DESCARGAR VORTEX
# ==============================================================================

echo
echo "[+] Descargando VORTEX..."

if ! curl -fL --retry 3 --connect-timeout 15 \
    -o "$PACKAGE_FILE" \
    "$PACKAGE_URL"; then

    echo "[-] Error descargando VORTEX."
    rm -f "$PACKAGE_FILE"
    exit 1
fi

echo "[+] Paquete descargado."

# ==============================================================================
# 5. VALIDAR Y EXTRAER EL PAQUETE
# ==============================================================================

echo "[*] Validando paquete..."

if ! file "$PACKAGE_FILE" | grep -qi "gzip"; then
    echo "[-] El paquete descargado no parece ser un archivo gzip válido."
    rm -f "$PACKAGE_FILE"
    exit 1
fi

echo "[+] Extrayendo VORTEX..."

if ! tar -xzf "$PACKAGE_FILE" -C "$INSTALL_DIR"; then
    echo "[-] Error extrayendo el paquete."
    rm -f "$PACKAGE_FILE"
    exit 1
fi

rm -f "$PACKAGE_FILE"

if [ ! -x "$INSTALL_DIR/vortex" ]; then
    echo "[-] Error crítico: no se encontró el ELF:"
    echo "    $INSTALL_DIR/vortex"
    exit 1
fi

chmod 755 "$INSTALL_DIR/vortex"

echo "[+] ELF VORTEX instalado correctamente."

# ==============================================================================
# 6. CREAR RUNTIME TÉCNICO DE PLAYWRIGHT
# ==============================================================================

echo
echo "============================================================="
echo "  Preparando Runtime SPA / Playwright"
echo "============================================================="

echo "[+] Creando entorno técnico..."

python3 -m venv "$VENV_DIR"

if [ ! -x "$VENV_DIR/bin/python3" ]; then
    echo "[-] Error creando el entorno Python."
    exit 1
fi

echo "[+] Actualizando pip..."

"$VENV_DIR/bin/python3" -m pip install --upgrade pip

echo "[+] Instalando dependencias de VORTEX..."

"$VENV_DIR/bin/python3" -m pip install \
    requests \
    cryptography \
    "playwright==$PLAYWRIGHT_VERSION"

echo "[+] Playwright $PLAYWRIGHT_VERSION instalado."

# ==============================================================================
# 7. CREAR DIRECTORIO DEDICADO PARA LOS NAVEGADORES
# ==============================================================================

echo
echo "[+] Creando runtime de navegador..."

mkdir -p "$BROWSERS_DIR"

chmod 755 "$BROWSERS_DIR"

echo "    Runtime Chromium:"
echo "    $BROWSERS_DIR"

# ==============================================================================
# 8. INSTALAR CHROMIUM EN /opt/vortex/browsers
# ==============================================================================

echo
echo "[+] Instalando Chromium de Playwright..."

export PLAYWRIGHT_BROWSERS_PATH="$BROWSERS_DIR"

if ! "$VENV_DIR/bin/python3" -m playwright install chromium; then
    echo "[-] Error instalando Chromium."
    exit 1
fi

echo "[+] Chromium descargado."

# ==============================================================================
# 9. INSTALAR DEPENDENCIAS NATIVAS DE CHROMIUM
# ==============================================================================

echo
echo "[+] Verificando dependencias nativas de Chromium..."

if "$VENV_DIR/bin/python3" -m playwright install-deps chromium; then
    echo "[+] Dependencias nativas de Chromium verificadas/instaladas."
else
    echo
    echo "[!] Advertencia: no fue posible instalar automáticamente"
    echo "    todas las dependencias nativas de Chromium."
    echo
    echo "    VORTEX continuará con la instalación, pero el crawler"
    echo "    SPA podría no funcionar hasta resolver esas librerías."
fi

# ==============================================================================
# 10. LOCALIZAR Y VALIDAR CHROMIUM
# ==============================================================================

echo
echo "[+] Verificando instalación física de Chromium..."

CHROMIUM_EXECUTABLE="$(
    find "$BROWSERS_DIR" \
        -type f \
        \( -path "*/chrome-linux/chrome" -o \
           -path "*/chrome-linux64/chrome" \) \
        -print -quit 2>/dev/null
)"

if [ -z "$CHROMIUM_EXECUTABLE" ]; then
    echo "[-] Error crítico: Chromium no fue localizado."
    echo "    Directorio esperado:"
    echo "    $BROWSERS_DIR"
    exit 1
fi

chmod 755 "$CHROMIUM_EXECUTABLE"

echo "[+] Chromium encontrado:"
echo "    $CHROMIUM_EXECUTABLE"

# ==============================================================================
# 11. PRUEBA FUNCIONAL REAL PLAYWRIGHT + CHROMIUM
# ==============================================================================

echo
echo "[+] Ejecutando prueba funcional Playwright + Chromium..."

export PLAYWRIGHT_BROWSERS_PATH="$BROWSERS_DIR"

if ! "$VENV_DIR/bin/python3" - <<'PY'
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(
        headless=True
    )

    page = browser.new_page()

    page.goto("about:blank")

    assert page.url == "about:blank"

    browser.close()

print("[+] Playwright + Chromium: OK")
PY
then

    echo "[-] Error: Playwright/Chromium no superó la prueba funcional."
    echo "[-] El runtime SPA no está operativo."
    exit 1
fi

# ==============================================================================
# 12. CREAR WRAPPER GLOBAL
# ==============================================================================

echo
echo "[+] Creando launcher global de VORTEX..."

cat << 'EOF' > "$SYMLINK_PATH"
#!/bin/bash

# ==============================================================================
# VORTEX Global Launcher
# ==============================================================================

INSTALL_DIR="/opt/vortex"
VORTEX_BIN="$INSTALL_DIR/vortex"
BROWSERS_DIR="$INSTALL_DIR/browsers"

# ------------------------------------------------------------------------------
# Validar ELF
# ------------------------------------------------------------------------------

if [ ! -x "$VORTEX_BIN" ]; then
    echo "[-] Error: VORTEX no está instalado correctamente."
    echo "    Falta:"
    echo "    $VORTEX_BIN"
    exit 1
fi

# ------------------------------------------------------------------------------
# Validar runtime Chromium
# ------------------------------------------------------------------------------

if [ ! -d "$BROWSERS_DIR" ]; then
    echo "[-] Error: Runtime Chromium no encontrado."
    echo "    Falta:"
    echo "    $BROWSERS_DIR"
    echo
    echo "    Ejecute: vortex-fix"
    exit 1
fi

# ------------------------------------------------------------------------------
# Configurar ubicación del navegador para Playwright
# ------------------------------------------------------------------------------

export PLAYWRIGHT_BROWSERS_PATH="$BROWSERS_DIR"

# ------------------------------------------------------------------------------
# Ejecutar VORTEX
# ------------------------------------------------------------------------------

cd "$INSTALL_DIR" || exit 1

exec "$VORTEX_BIN" "$@"
EOF

chmod 755 "$SYMLINK_PATH"

echo "[+] Launcher instalado:"
echo "    $SYMLINK_PATH"

# ==============================================================================
# 13. CREAR HERRAMIENTA DE REPARACIÓN
# ==============================================================================

echo
echo "[+] Creando herramienta de reparación..."

cat << 'EOF' > "$INSTALL_DIR/fix-venv.sh"
#!/bin/bash

set -e
set -u
set -o pipefail

INSTALL_DIR="/opt/vortex"
VENV_DIR="$INSTALL_DIR/env"
BROWSERS_DIR="$INSTALL_DIR/browsers"
PLAYWRIGHT_VERSION="1.62.0"

echo "============================================================="
echo " VORTEX - Reparación del Runtime SPA"
echo "============================================================="

echo "[+] Recreando entorno técnico..."

rm -rf "$VENV_DIR"

python3 -m venv "$VENV_DIR"

"$VENV_DIR/bin/python3" -m pip install --upgrade pip

"$VENV_DIR/bin/python3" -m pip install \
    requests \
    cryptography \
    "playwright==$PLAYWRIGHT_VERSION"

mkdir -p "$BROWSERS_DIR"

export PLAYWRIGHT_BROWSERS_PATH="$BROWSERS_DIR"

echo "[+] Instalando Chromium..."

"$VENV_DIR/bin/python3" -m playwright install chromium

echo "[+] Verificando Playwright + Chromium..."

"$VENV_DIR/bin/python3" - <<'PY'
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto("about:blank")
    browser.close()

print("[+] Runtime SPA reparado correctamente.")
PY

echo
echo "[+] Reparación completada."
EOF

chmod 755 "$INSTALL_DIR/fix-venv.sh"

ln -sf "$INSTALL_DIR/fix-venv.sh" /usr/local/bin/vortex-fix

# ==============================================================================
# 14. ACTUALIZAR CACHE DEL SHELL
# ==============================================================================

hash -r 2>/dev/null || true

# ==============================================================================
# 15. VERIFICACIÓN FINAL DE LA INSTALACIÓN
# ==============================================================================

echo
echo "============================================================="
echo " VORTEX - Verificación Final"
echo "============================================================="

if [ ! -x "$SYMLINK_PATH" ]; then
    echo "[-] Error: launcher no disponible."
    exit 1
fi

if [ ! -x "$INSTALL_DIR/vortex" ]; then
    echo "[-] Error: ELF VORTEX no disponible."
    exit 1
fi

if [ ! -d "$BROWSERS_DIR" ]; then
    echo "[-] Error: directorio browsers no disponible."
    exit 1
fi

if [ ! -x "$VENV_DIR/bin/python3" ]; then
    echo "[-] Error: runtime técnico Python no disponible."
    exit 1
fi

echo
echo "============================================================="
echo " ✅ VORTEX INSTALADO CORRECTAMENTE"
echo "============================================================="
echo
echo " ELF VORTEX:"
echo "   $INSTALL_DIR/vortex"
echo
echo " Runtime Playwright:"
echo "   $VENV_DIR"
echo
echo " Runtime Chromium:"
echo "   $BROWSERS_DIR"
echo
echo " Launcher global:"
echo "   $SYMLINK_PATH"
echo
echo " Comandos:"
echo "   vortex status"
echo "   vortex --version"
echo "   vortex scan <objetivo>"
echo
echo " El VENV NO necesita activarse manualmente."
echo " Chromium se ejecuta desde /opt/vortex/browsers."
echo
echo "============================================================="
