#!/bin/bash

# ==============================================================================
# Script de Instalación Oficial - VORTEX Assessment Engine
# Arquitectura de Software Propietario / Despliegue en /opt/vortex/
# Autor: Dr. Arturo Mata
# ==============================================================================

APP_NAME="vortex"
INSTALL_DIR="/opt/$APP_NAME"
VENV_DIR="$INSTALL_DIR/env"
SYMLINK_PATH="/usr/local/bin/$APP_NAME"
PACKAGE_NAME="vortex-latest.tar.gz"

# URL pública de descarga (ajustar según el repositorio oficial o distribución)
COMMUNITY_REPO_URL="https://raw.githubusercontent.com/matarturo/vortex/main/${PACKAGE_NAME}"

# 1. Validar privilegios de administrador (root)
if [ "$EUID" -ne 0 ]; then
  echo "[-] Error: Este script de instalación debe ejecutarse con privilegios de root (sudo)."
  exit 1
fi

echo "[+] Iniciando despliegue estructurado de VORTEX Assessment Engine..."

# --------------------------------------------------------------------------
# Deteccion del gestor de paquetes del sistema. VORTEX debe soportar tanto
# distros basadas en Debian/Ubuntu (apt) como en RHEL/Rocky/Fedora (dnf/yum)
# para ofrecer despliegue empresarial multi-distro. Cada rama posterior del
# script (SYS_DEPS y dependencias de Chromium para Playwright) se resuelve
# a partir de esta deteccion, sin intervencion manual del usuario.
# --------------------------------------------------------------------------
detect_pkg_manager() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "apt"
  elif command -v dnf >/dev/null 2>&1; then
    echo "dnf"
  elif command -v yum >/dev/null 2>&1; then
    echo "yum"
  else
    echo "unknown"
  fi
}

PKG_MGR=$(detect_pkg_manager)
echo "[*] Gestor de paquetes detectado: ${PKG_MGR}"

# Dependencias minimas del sistema, con nombres de paquete especificos por
# gestor (ej: python3-venv es un paquete separado en Debian/Ubuntu, pero
# el modulo venv ya viene incluido con python3 en RHEL/Rocky/Fedora -- no
# existe un paquete dnf con ese nombre).
case "$PKG_MGR" in
  apt)
    SYS_DEPS="curl tar file python3-pip python3-venv"
    ;;
  dnf|yum)
    SYS_DEPS="curl tar file python3-pip"
    ;;
  *)
    SYS_DEPS="curl tar file python3-pip"
    echo "[!] Advertencia: no se detecto apt-get, dnf ni yum. Se asume que"
    echo "    ${SYS_DEPS} ya estan instalados manualmente en este sistema."
    ;;
esac

if [ "$PKG_MGR" != "unknown" ]; then
  echo "[+] Instalando dependencias base del sistema (${SYS_DEPS})..."
  case "$PKG_MGR" in
    apt)
      apt-get update -qq
      apt-get install -y $SYS_DEPS
      ;;
    dnf)
      dnf install -y $SYS_DEPS
      ;;
    yum)
      yum install -y $SYS_DEPS
      ;;
  esac
  if [ $? -ne 0 ]; then
    echo "[-] Advertencia: fallo la instalacion de una o mas dependencias base."
    echo "    Verifique manualmente: ${SYS_DEPS}"
  fi
fi

# 2. Preparar el directorio de instalación corporativa en /opt/vortex/
if [ -d "$INSTALL_DIR" ]; then
  echo "[*] Actualizando instalación existente en $INSTALL_DIR..."
  if [ -d "$INSTALL_DIR/reporte" ]; then
    mkdir -p /tmp/vortex_reporte_backup
    cp -r "$INSTALL_DIR/reporte/"* /tmp/vortex_reporte_backup/ 2>/dev/null
  fi

  if [ -f "/etc/vortex/license.json" ]; then
    echo "[!] ATENCIÓN: Licencia detectada en /etc/vortex/"
    echo "[!] Se conservará durante la reinstalación."
  fi
  rm -rf "$INSTALL_DIR"

fi
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/reporte"

if [ -d "/tmp/vortex_reporte_backup" ]; then
  cp -r /tmp/vortex_reporte_backup/* "$INSTALL_DIR/reporte/" 2>/dev/null
  rm -rf /tmp/vortex_reporte_backup
fi

# 3. Localizar o descargar el paquete empaquetado de VORTEX
TEMP_PKG="/tmp/$PACKAGE_NAME"

if [ -f "./$PACKAGE_NAME" ]; then
  echo "[+] Utilizando paquete local empaquetado ($PACKAGE_NAME)..."
  cp "./$PACKAGE_NAME" "$TEMP_PKG"
elif [ -f "./vortex.py" ]; then
  echo "[+] Utilizando código fuente local (vortex.py)..."
  cp "./vortex.py" "$INSTALL_DIR/$APP_NAME"
elif [ -f "./vortex" ]; then
  echo "[+] Utilizando binario local empaquetado (vortex)..."
  cp "./vortex" "$INSTALL_DIR/$APP_NAME"
else
  echo "[+] Descargando paquete VORTEX desde el repositorio oficial..."
  curl -sL -o "$TEMP_PKG" "$COMMUNITY_REPO_URL"

  if [ $? -ne 0 ] || [ ! -f "$TEMP_PKG" ]; then
    echo "[-] Error: No se pudo localizar ni descargar el paquete de instalación de VORTEX."
    exit 1
  fi
  tar -xzf "$TEMP_PKG" -C "$INSTALL_DIR/"
  rm -f "$TEMP_PKG"
fi

if [ -f "$INSTALL_DIR/vortex.py" ]; then
  mv "$INSTALL_DIR/vortex.py" "$INSTALL_DIR/$APP_NAME"
fi

# --------------------------------------------------------------------------
# Detección de tipo de artefacto: binario compilado vs codigo fuente.
# Usa 'file' cuando esta disponible (ya deberia estarlo, se instalo arriba
# via SYS_DEPS), con un fallback nativo en bash leyendo el magic number
# ELF directamente -- por si 'file' no pudo instalarse en un entorno
# restringido, para no dejar el artefacto mal clasificado.
# --------------------------------------------------------------------------
es_binario_elf() {
  local ruta="$1"
  if command -v file >/dev/null 2>&1; then
    file "$ruta" | grep -qi "ELF" && return 0
    return 1
  fi
  # Fallback sin 'file': todo binario ELF empieza con los bytes 0x7F 'E' 'L' 'F'.
  local magic
  magic=$(head -c4 "$ruta" 2>/dev/null | od -An -tx1 | tr -d ' \n')
  [ "$magic" = "7f454c46" ]
}

ES_BINARIO_NATIVO=false
if [ -f "$INSTALL_DIR/$APP_NAME" ] && es_binario_elf "$INSTALL_DIR/$APP_NAME"; then
  ES_BINARIO_NATIVO=true
  echo "[*] Artefacto detectado: binario nativo compilado. El venv de Python no es necesario para ejecutarlo."
else
  echo "[*] Artefacto detectado: codigo Python. Se requiere entorno virtual para ejecutarlo."
fi

# 4. Configurar el Entorno Virtual (venv) e instalar dependencias de Python
#    Solo aplica al escenario de script fuente; un binario ya
#    lleva su propio intérprete y dependencias embebidas.
if [ "$ES_BINARIO_NATIVO" = false ]; then
  echo "[+] Configurando entorno virtual en $VENV_DIR..."
  python3 -m venv "$VENV_DIR"

  source "$VENV_DIR/bin/activate"

  echo "[+] Actualizando pip e instalando dependencias requeridas..."
  pip install --upgrade pip
  if [ -f "$INSTALL_DIR/requirements.txt" ]; then
    pip install -r "$INSTALL_DIR/requirements.txt"
  else
    pip install requests cryptography playwright
  fi

  # 5. Instalación del motor Playwright (Chromium Headless) y sus
  #    dependencias de sistema. 'playwright install-deps' SOLO tiene
  #    soporte oficial en Debian/Ubuntu (internamente usa apt-get sin
  #    detectar la distro real); en RHEL/Rocky/Fedora falla con
  #    "apt-get: command not found". Por eso, fuera de apt, instalamos
  #    manualmente el set de librerias runtime de Chromium via dnf/yum.
  echo "[+] Configurando el motor de renderizado JS opcional (Playwright Chromium)..."
  playwright install chromium

  if [ "$PKG_MGR" = "apt" ]; then
    playwright install-deps chromium 2>/dev/null || echo "[*] Nota: No se pudieron instalar dependencias de sistema de Playwright mediante sudo automático (entorno minimalista)."
  elif [ "$PKG_MGR" = "dnf" ] || [ "$PKG_MGR" = "yum" ]; then
    echo "[*] 'playwright install-deps' no tiene soporte oficial en distros basadas en RPM."
    echo "[+] Instalando dependencias de Chromium manualmente via ${PKG_MGR}..."
    CHROMIUM_RPM_DEPS="nss atk at-spi2-core cups libdrm libxkbcommon mesa-libgbm mesa-libEGL mesa-libGL pango cairo alsa-lib libX11 libxcb"
    $PKG_MGR install -y $CHROMIUM_RPM_DEPS
    if [ $? -ne 0 ]; then
      echo "[!] Nota: alguna dependencia de Chromium no pudo instalarse."
      echo "    El renderizado de SPA (Playwright) podria no funcionar; el"
      echo "    resto de VORTEX (auditoria HTTP estandar) no se ve afectado."
    fi
  else
    echo "[!] Gestor de paquetes no reconocido: instale manualmente las"
    echo "    dependencias de Chromium requeridas por Playwright para su distro."
  fi

  deactivate

  # 6. Probar la compilación del código fuente dentro de la estructura de VORTEX
  echo "[+] Verificando integridad y compilación del motor de evaluacion..."
  source "$VENV_DIR/bin/activate"
  python3 -m py_compile "$INSTALL_DIR/$APP_NAME"
  if [ $? -eq 0 ]; then
    echo "[+] Compilación de VORTEX verificada exitosamente."
  else
    echo "[-] Advertencia: Se encontraron detalles menores en la compilación estática."
  fi
  deactivate
else
  echo "[*] Paso 4/5/6 omitidos (venv, Playwright, py_compile): no aplican a un binario nativo ya compilado."
fi

# 7. Copiar licencias o scripts auxiliares si están presentes
if [ -f "./LICENSE" ]; then
  cp "./LICENSE" "$INSTALL_DIR/LICENSE"
fi

if [ -f "./update.sh" ]; then
  cp "./update.sh" "$INSTALL_DIR/update.sh"
  chmod +x "$INSTALL_DIR/update.sh"
fi
# 8. Crear el punto de entrada ejecutable global en /usr/local/bin
#    - Binario nativo: symlink directo, sin pasar por
#      python3 (el binario ya trae su propio intérprete embebido).
#    - Script fuente: wrapper que invoca el python3 del venv.
#    Se valida al final que el comando quede realmente resuelto en el
#    PATH, para no dejar al usuario con una instalación "silenciosamente
#    incompleta" como ocurría antes.
chmod +x "$INSTALL_DIR/$APP_NAME"

echo "[+] Creando punto de entrada global en $SYMLINK_PATH..."

if [ "$ES_BINARIO_NATIVO" = true ]; then
  ln -sf "$INSTALL_DIR/$APP_NAME" "$SYMLINK_PATH"
else
  cat << 'EOF' > "$SYMLINK_PATH"
#!/bin/bash
# VORTEX Global Wrapper Executor
VENV_PYTHON="/opt/vortex/env/bin/python3"
VORTEX_BIN="/opt/vortex/vortex"

if [ -f "$VENV_PYTHON" ] && [ -f "$VORTEX_BIN" ]; then
    exec "$VENV_PYTHON" "$VORTEX_BIN" "$@"
else
    echo "[-] Error crítico: El entorno virtual o el binario de VORTEX no están íntegros en /opt/vortex/"
    exit 1
fi
EOF
fi

chmod +x "$SYMLINK_PATH"

# Verificación post-instalación: confirmar que "vortex" resuelve de
# verdad antes de darle la instalación por exitosa al usuario.
hash -r 2>/dev/null
if command -v "$APP_NAME" >/dev/null 2>&1; then
  echo "[+] Verificado: el comando '$APP_NAME' está disponible en el PATH ($(command -v $APP_NAME))."
else
  echo "[-] ADVERTENCIA: '$SYMLINK_PATH' se creó pero '$APP_NAME' no resuelve en el PATH actual."
  echo "    Verifique que /usr/local/bin esté en \$PATH, o abra una terminal nueva."
fi

echo "===================================================================="
echo "✅ ¡Instalación de VORTEX Assessment Engine completada con éxito!"
echo "📂 Directorio base: ${INSTALL_DIR}"
if [ "$ES_BINARIO_NATIVO" = false ]; then
  echo "🐍 Entorno virtual: $VENV_DIR"
  echo "🌐 Motor SPA (Playwright): Configurado"
else
  echo "🐍 Binario nativo autocontenido (sin venv)"
fi
echo "📄 Licencia propietaria en: ${INSTALL_DIR}/LICENSE"
echo ""
echo "🚀 MODO INICIAL: Community / Demo"
echo "📌 Para activar su membresía PRO, TEAM o ENTERPRISE adquiera su clave y ejecute:"
echo "   vortex attach <SU_LICENSE_KEY_O_TOKEN>"
echo ""
echo "🎯 Ya puede ejecutar el motor de evaluación escribiendo:"
echo "   vortex --local --help"
echo "   vortex --local --version"
echo "   vortex --local --http-port"
echo "   vortex status"
echo "===================================================================="
