#!/bin/bash
# ==============================================================================
# Script de Instalación Unificado - VORTEX Assessment Engine (RHEL/Rocky Linux)
# Arquitectura Unificada y Robusta / Despliegue en /opt/vortex/
# Diseñado para Rocky Linux 10.2 (Red Quartz) y compatibles RHEL.
# ==============================================================================

APP_NAME="vortex"
INSTALL_DIR="/opt/$APP_NAME"
SYMLINK_PATH="/usr/local/bin/$APP_NAME"
REPO_URL="https://raw.githubusercontent.com/matarturo/vortex/main"

# ============================================================
# 1. VALIDAR PRIVILEGIOS
# ============================================================
if [ "$EUID" -ne 0 ]; then
  echo "[-] Error: Ejecute con sudo."
  exit 1
fi

echo "[+] Iniciando operación de despliegue unificado para RHEL/Rocky..."

# ============================================================
# 2. CONFIGURAR REPOSITORIOS CORPORATIVOS (EPEL/CRB)
# ============================================================
# Esto GARANTIZA que playwright encuentre dependencias como nss o gtk3
# incluso en servidores Minimal Install.
echo "[*] Configurando repositorios extendidos (EPEL y CRB)..."
dnf install -y epel-release &> /dev/null
dnf install -y 'dnf-command(config-manager)' &> /dev/null
# Habilitar CodeReady Builder (CRB) para RHEL/Rocky 9 y 10
dnf config-manager --set-enabled crb &> /dev/null || dnf config-manager --set-enabled powertools &> /dev/null
echo "[+] Repositorios listos."

# ============================================================
# 3. VALIDAR PRERREQUISITOS (LÓGICA RHEL/DNF)
# ============================================================
echo "[*] Validando dependencias mínimas (Ecosistema RPM)..."
dependencies=(curl tar file python3 python3-pip)
missing_deps=()

for dep in "${dependencies[@]}"; do
    if ! rpm -q "$dep" &> /dev/null; then
        missing_deps+=("$dep")
    fi
done

if [ ${#missing_deps[@]} -gt 0 ]; then
    echo "[-] Error Crítico: Faltan dependencias: ${missing_deps[*]}."
    echo "    Ejecute: dnf install -y ${missing_deps[*]}"
    exit 1
fi

# ============================================================
# 4. LIMPIEZA ABSOLUTA
# ============================================================
echo "[+] Iniciando limpieza operativa unificada..."
rm -rf "$INSTALL_DIR"
rm -f "$SYMLINK_PATH"
rm -f /etc/profile.d/vortex.sh
mkdir -p "$INSTALL_DIR"

echo "[+] Reconstruyendo Infraestructura Base..."

# ============================================================
# 5. DESCARGAR VORTEX
# ============================================================
echo "[+] Descargando binario ELF VORTEX (Demo mode)..."
curl -sL -o "/tmp/vortex-latest.tar.gz" https://github.com/matarturo/vortex/raw/main/vortex-latest.tar.gz
if [ $? -ne 0 ]; then echo "[-] Error de descarga."; exit 1; fi
tar -xzf "/tmp/vortex-latest.tar.gz" -C "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/vortex"
rm -f "/tmp/vortex-latest.tar.gz"

echo "[+] Reconstruyendo Entorno Virtual..."

# ============================================================
# 6. RECONSTRUIR VENV Y DEPENDENCIAS (CON SOPORTE RHEL)
# ============================================================
python3 -m venv "$INSTALL_DIR/env"
if [ $? -ne 0 ]; then echo "[-] Error creando venv."; exit 1; fi

source "$INSTALL_DIR/env/bin/activate"
pip install --upgrade pip
pip install requests cryptography playwright

# Instalación de librerías del sistema para Chromium en RHEL/Rocky
echo "[*] Resolviendo librerías OS nativas para Chromium via DNF..."
playwright install-deps chromium

export PLAYWRIGHT_BROWSERS_PATH="$INSTALL_DIR/env/lib/ms-playwright"
echo "[*] Instalando Chromium aislado en la venv..."
playwright install chromium
deactivate

echo "[+] Creando Wrapper Script Unificado Robusto..."

# ============================================================
# 7. CREAR WRAPPER UNIFICADO
# ============================================================
cat << 'EOF' > "$SYMLINK_PATH"
#!/bin/bash
# AUTOMATIZACIÓN TOTAL VORTEX - NO MODIFICAR

INSTALL_DIR="/opt/vortex"

if [ ! -d "$INSTALL_DIR/env" ] || [ ! -x "$INSTALL_DIR/vortex" ]; then
    echo "[-] Error Crítico: La instalación de VORTEX en $INSTALL_DIR parece incompleta."
    echo "    Ejecute el script de reparación o reinstale."
    exit 1
fi

cd "$INSTALL_DIR" || exit 1
source "$INSTALL_DIR/env/bin/activate"
export PLAYWRIGHT_BROWSERS_PATH="$INSTALL_DIR/env/lib/ms-playwright"
"./vortex" "$@"
deactivate
EOF

echo "[+] Asignando permisos y refrescando PATH..."

# ============================================================
# 8. PERMISOS Y ACTUALIZACIÓN
# ============================================================
chmod +x "$SYMLINK_PATH"
hash -r 2>/dev/null

# ============================================================
# 9. DOBLE SEGURIDAD Y HERRAMIENTAS
# ============================================================
echo "[+] Creando script de reparación automatizado..."

cat << 'EOF' > /opt/vortex/fix-venv.sh
#!/bin/bash
echo "[+] Reparando entorno virtual de VORTEX en /opt/vortex/env..."
cd /opt/vortex || exit 1
rm -rf env
python3 -m venv env
source env/bin/activate
pip install --upgrade pip
pip install requests cryptography playwright
playwright install-deps chromium
playwright install chromium
deactivate
echo "[+] Entorno virtual reparado y configurado correctamente."
EOF

chmod +x /opt/vortex/fix-venv.sh
ln -sf /opt/vortex/fix-venv.sh /usr/local/bin/vortex-fix 2>/dev/null

# ============================================================
# 10. VERIFICAR INSTALACIÓN
# ============================================================
if command -v vortex &> /dev/null; then
  echo "============================================================="
  echo "✅ OPERACIÓN UNIFICADA COMPLETADA (RHEL/Rocky). VORTEX está listo."
  echo "🚀 MODO INICIAL: Demo robusta vinculada a CEREBELLUM."
  echo "📌 Ejecute 'vortex status' desde CUALQUIER directorio."
  echo "============================================================="
else
  echo "[-] ADVERTENCIA: 'vortex' no está en el PATH."
fi
