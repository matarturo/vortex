<p align=*center*> <img src=*[https://zerodayslab.co/imagenes/vortex.webp*](https://zerodayslab.co/imagenes/vortex.webp*) width=*240* alt=***ZERODAYS** **LAB***> </p>

<h1 align=*center*>**VORTEX** **ASSESSMENT** **ENGINE**</h1>

<p align=*center"> <strong>Motor de Evaluación de Seguridad para Aplicaciones Web Modernas</strong> </p>

<p align=*center*> <strong>**DAST** · **SPA** Discovery · JavaScript Security · Self-Hosted</strong> </p>

<p align=*center*>
    <img src="[https://img.shields.io/badge/Status-Release-success?style=for-the-badge"](https://img.shields.io/badge/Status-Release-success?style=for-the-badge*) alt=*Status*>
    <img src=*[https://img.shields.io/badge/Community-$0%**20USD**-brightgreen?style=for-the-badge"](https://img.shields.io/badge/Community-$0%**20USD**-brightgreen?style=for-the-badge*) alt=*Community*>
    <img src=*[https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge"](https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge*) alt=*Platform*>
    <img src=*[https://img.shields.io/badge/**OWASP**-Top%**2010**%**3A2025**-orange?style=for-the-badge"](https://img.shields.io/badge/**OWASP**-Top%**2010**%**3A2025**-orange?style=for-the-badge*) alt=*OWASP*>
    <img src=*[https://img.shields.io/badge/Self--Hosted-On--Premise-purple?style=for-the-badge"](https://img.shields.io/badge/Self--Hosted-On--Premise-purple?style=for-the-badge*) alt=*Self Hosted*>
</p>

<p align=*center"> <strong>🚀 **VORTEX** Community ya está disponible.</strong> </p>

<p align=*center*>
    <a href=*#-instalación-rápida*>⚡ Probar **VORTEX**</a> ·
    <a href=*#-características*>Características</a> ·
    <a href=*#-community-edition*>Community</a> ·
    <a href=*#-ediciones-comerciales*>**PRO** / **TEAM** / Enterprise</a>
</p>

---

# 🚀 VORTEX ya está disponible

****VORTEX** Assessment Engine** es una plataforma de evaluación de seguridad web **self-hosted**, desarrollada por ****ZERODAYS** **LAB** — Research & Development in Cybersecurity**.

**VORTEX** combina ****DAST** (Dynamic Application Security Testing)** con descubrimiento moderno de aplicaciones y análisis de JavaScript.

Está diseñado para evaluar aplicaciones web modernas, incluyendo aquellas construidas como **Single Page Applications (**SPA**)** con tecnologías como:

- React
- Vue
- Angular
- JavaScript-heavy applications

**VORTEX** puede descubrir rutas y recursos de una aplicación, analizar recursos JavaScript y ejecutar pruebas de seguridad sobre las superficies descubiertas.

> **Las aplicaciones web cambiaron. **VORTEX** fue diseñado para evaluarlas.**

**Assess. Discover. Secure.**

---

# ⚡ Instalación rápida

¿Quieres probar **VORTEX** Community?

### Ubuntu / Debian

```bash curl -sSL -o install.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install.sh) cat install.sh chmod +x install.sh sudo ./install.sh Rocky Linux / **RHEL** curl -sSL -o install-rhel.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh) cat install-rhel.sh chmod +x install-rhel.sh sudo ./install-rhel.sh
```
Después de la instalación:

vortex --version vortex --help

También puedes verificar el estado:

vortex status

No necesitas instalar Python, pip ni configurar un entorno de desarrollo para utilizar la distribución binaria.

La distribución Community se entrega como una aplicación Linux empaquetada.

Requisitos
Linux 64-bit
curl
tar
sudo / root para la instalación
Conectividad de red para la instalación y activación inicial
Sistemas Linux validados
Sistema	Versiones	Estado
Ubuntu Server	22.04 / 24.04 **LTS**	✅ **VALIDADO**
Debian	12 / 13	✅ **VALIDADO**
Rocky Linux	9 / 10.2	✅ **VALIDADO**
**RHEL**	10.2	✅ **VALIDADO**

Recomendación oficial: para una instalación nueva se recomienda utilizar Ubuntu Server 22.04 **LTS**, Debian 13 o **RHEL** 10.2, según los requisitos de tu infraestructura.

Las pruebas cubren instalación, ejecución del motor, gestión de licencias y actualización del producto.

🧭 ¿Por qué **VORTEX**?

Las aplicaciones web modernas ya no funcionan como las aplicaciones web tradicionales.

Gran parte de la navegación, formularios, rutas y lógica de aplicación puede depender de JavaScript.

Los enfoques tradicionales de crawling pueden tener dificultades para descubrir correctamente estas superficies.

**VORTEX** nace precisamente de ese problema.

**VORTEX** se enfoca en:

🔎 Application Discovery

Descubrimiento de rutas, recursos y superficies de ataque de aplicaciones web.

🕸️ **SPA** Discovery

Diseñado para aplicaciones JavaScript modernas como React, Vue y Angular.

🔐 JavaScript Security Analysis

Análisis de bundles y recursos JavaScript en busca de información sensible y elementos de interés para seguridad.

🛡️ Security Assessment

Pruebas orientadas a detectar vulnerabilidades y debilidades comunes en aplicaciones web.

🏠 Self-Hosted / On-Premise

Ejecuta el motor dentro de tu propia infraestructura.

✨ Características 🕵️ Crawler + **SPA** Discovery

Descubrimiento de rutas y recursos en aplicaciones web modernas.

**VORTEX** está diseñado para trabajar con aplicaciones donde la navegación y la lógica dependen fuertemente de JavaScript.

🔐 Análisis de JavaScript

Analiza recursos y bundles JavaScript en busca de información potencialmente expuesta, incluyendo:

**API** Keys Tokens Credenciales Secretos hardcodeados Información sensible relacionada con la aplicación 🛡️ Web Security Testing

**VORTEX** incorpora pruebas orientadas a diferentes categorías de seguridad web, incluyendo:

Cross-Site Scripting (**XSS**) **SQL** Injection ### Path Traversal ### Open Redirect Debilidades relacionadas con autenticación ### Security Misconfiguration

Las capacidades exactas pueden depender de la versión y edición de **VORTEX**.

🔑 Autenticación

**VORTEX** incorpora capacidades para evaluación de aplicaciones autenticadas y workflows de login.

Esto permite ampliar la superficie de evaluación más allá de las páginas públicas.

📊 Reportes Multi-Formato

Los resultados pueden generarse en:

**HTML** — revisión humana y presentación **JSON** — automatización e integración **SARIF** 2.1.0 — integración con workflows modernos de seguridad y desarrollo 🖥️ Self-Hosted / On-Premise

**VORTEX** se ejecuta dentro de tu infraestructura.

Tu aplicación objetivo no necesita estar expuesta a un servicio externo de scanning.

Esto permite utilizar **VORTEX** en:

Laboratorios de seguridad Infraestructura corporativa Entornos de desarrollo QA / Staging DevSecOps Pentesting autorizado Evaluaciones internas 🧪 Community Edition — **GRATIS** Empieza con **VORTEX** por $0 **USD**

La edición Community está diseñada para que desarrolladores y profesionales de seguridad puedan evaluar **VORTEX** antes de adquirir una licencia comercial.

Capacidad	Community
Precio	$0 **USD**
Periodo de evaluación	7 días
Escaneos	Hasta 3
Self-Hosted	✅
**SPA** Discovery	✅
JavaScript Analysis	✅
Security Assessment	✅
**HTML** Reports	✅
**JSON** Reports	✅
**SARIF**	✅
Soporte por correo	72 horas
Community está pensada para:
👨‍💻 Desarrolladores
🛡️ Profesionales de ciberseguridad
🔬 Security Researchers
🎓 Estudiantes
🕵️ Pentesters
⚙️ Profesionales DevSecOps
🏢 Equipos que quieran evaluar **VORTEX**

No necesitas tarjeta de crédito para comenzar la evaluación.

💼 Ediciones comerciales

Cuando necesites eliminar las restricciones de evaluación:

Edición	Precio	Diseñada para
Community	$0 **USD**	Pruebas y evaluación
**PRO**	$99 **USD**	Profesionales y consultores
**TEAM**	$**349** **USD**	Equipos de seguridad
Enterprise	$**999** **USD**	Organizaciones grandes
⭐ **PRO** — $99 **USD**

Para profesionales, investigadores y consultores.

Escaneos ilimitados 1 equipo activo Reportes **HTML** + **JSON** + **SARIF** Detección de secretos en JavaScript Soporte por correo: 48 horas 👥 **TEAM** — $**349** **USD**

Para equipos de seguridad.

Escaneos ilimitados Hasta 5 equipos Reportes **HTML** + **JSON** + **SARIF** Detección de tokens expuestos en JavaScript Soporte por correo: 24 horas 🏢 Enterprise — $**999** **USD**

Para organizaciones grandes.

Escaneos ilimitados Hasta 50 equipos Reportes **HTML** + **JSON** + **SARIF** Detección de secretos en JavaScript Soporte 24/7 Respuesta objetivo inferior a 1 hora **PMA** incluido 🔄 **PMA** — Plan de Mantenimiento Anual

**PMA**: $30 **USD** / año

El **PMA** proporciona acceso a nuevas versiones y mejoras de rendimiento conforme a los términos comerciales aplicables.

Importante

Los parches de seguridad y correcciones de errores críticos son gratuitos para todos los usuarios, independientemente del plan.

Sin **PMA**, las nuevas versiones y funcionalidades no se actualizan automáticamente, pero los parches críticos continúan disponibles mediante patch.sh.

Enterprise incluye **PMA** de serie.

🔬 Flujo de evaluación

Una evaluación típica con **VORTEX** sigue este flujo:

    **APLICACI**ÓN **WEB**
    │
    ▼
    ┌─────────────────┐
    │     **VORTEX**      │
    │     Crawler     │
    └────────┬────────┘
    │
    ▼
    **SPA** / Route Discovery
    │
    ▼
    JavaScript Analysis
    │
    ▼
    Security Assessment
    │
    ▼
    ┌─────────────────┐
    │     **RESULTS**     │
    └────────┬────────┘
    │
    ┌────────┼────────┐
    ▼        ▼        ▼
    **HTML**      **JSON**     **SARIF**
🚀 **QUICK** **START**
Guía de Inicio Rápido

Instala **VORTEX** y ejecuta tu primer Security Assessment en minutos.

Del servidor al primer resultado
Instalar
    │
    ▼
Validar
    │
    ▼
Assessment
    │
    ▼
Reporte
01 — Instalación

Ejecuta el instalador oficial desde tu servidor Linux.

El proceso prepara la estructura de **VORTEX** y deja disponible el comando global vortex.

Ubuntu / Debian curl -sSL -o install.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install.sh) cat install.sh chmod +x install.sh sudo ./install.sh Rocky Linux / **RHEL** curl -sSL -o install-rhel.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh) cat install-rhel.sh chmod +x install-rhel.sh sudo ./install-rhel.sh

En servidores de producción se recomienda descargar primero el instalador, inspeccionarlo y posteriormente ejecutarlo con privilegios de administrador.

02 — Validar la instalación

Comprueba que **VORTEX** esté disponible:

which vortex vortex --version vortex status

También puedes verificar el ejecutable:

file /opt/vortex/vortex readlink -f *$(which vortex)* 03 — Primer Security Assessment

Una vez instalado **VORTEX** puedes ejecutar un assessment local o dirigirlo hacia una aplicación web para la que tengas autorización.

Modo local

Utiliza el modo local para realizar una primera prueba del motor sobre tu propio entorno.

vortex --local --http-port Aplicación web

Ejecuta un assessment contra una aplicación web para la que tengas autorización.

vortex [https://**127**.0.0.1](https://**127**.0.0.1) \
    --username admin \
    --password mypass

Utiliza credenciales de prueba y únicamente objetivos sobre los que tengas autorización explícita.

04 — Visualizar el reporte

Al finalizar el assessment, **VORTEX** genera los resultados en el directorio de reportes.

**HTML** **REPORT**

El reporte **HTML** es autocontenido y está diseñado para facilitar la revisión de:

### Security Score

Hallazgos Severidades Evidencias Recomendaciones de remediación

Ejemplo:

open /opt/vortex/reporte/informe_*.html

En servidores sin entorno gráfico puedes copiar el reporte **HTML** a tu estación de trabajo y abrirlo con un navegador.

¿Qué sigue?

Después de tu primer assessment puedes:

Revisar el reporte **HTML**. Analizar los resultados **JSON**. Integrar **SARIF** 2.1.0 en tu pipeline CI/CD. Evaluar las capacidades comerciales de **VORTEX**. 📦 Instalación de **VORTEX**

**VORTEX** proporciona instaladores específicos para las principales familias de distribuciones Linux.

El instalador detecta automáticamente el tipo de artefacto y prepara la instalación correspondiente.

🐧 Debian Family Ubuntu / Debian

Instalador principal para sistemas basados en Debian.

Gestiona:

Estructura de instalación Dependencias Artefacto de **VORTEX** Punto de entrada global

Instalador:

install.sh Instalación recomendada curl -sSL -o install.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install.sh) cat install.sh chmod +x install.sh sudo ./install.sh Instalación directa curl -sSL [https://raw.githubusercontent.com/matarturo/vortex/main/install.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install.sh) | sudo bash 🔴 Red Hat Family Rocky Linux / **RHEL**

Para sistemas basados en Red Hat utiliza:

install-rhel.sh

El instalador está preparado para trabajar con los gestores de paquetes disponibles en este ecosistema, utilizando dnf o yum según el entorno detectado.

Instalación recomendada curl -sSL -o install-rhel.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh) cat install-rhel.sh chmod +x install-rhel.sh sudo ./install-rhel.sh Instalación directa curl -sSL [https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh) | sudo bash 🔐 Recomendación de seguridad

En servidores de producción es preferible inspeccionar cualquier script antes de ejecutarlo con privilegios de administrador.

Por ejemplo:

curl -sSL -o install.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install.sh) cat install.sh

o:

curl -sSL -o install-rhel.sh [https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh](https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh) cat install-rhel.sh

Esta práctica es especialmente recomendable para herramientas de seguridad.

🏗️ Estructura de instalación

Ambos instaladores utilizan la misma estructura principal de **VORTEX**.

Ruta	Función
/opt/vortex/	Directorio principal de **VORTEX**
/opt/vortex/vortex	Binario o ejecutable principal
/opt/vortex/env/	Entorno virtual cuando se instala código Python
/opt/vortex/reporte/	Directorio destinado a los reportes generados
/usr/local/bin/vortex	Punto de entrada global del comando
⚙️ Binario nativo y entorno Python

El instalador detecta automáticamente el tipo de artefacto distribuido.

Binario **ELF**

Si el artefacto es un ejecutable **ELF**, **VORTEX** se ejecuta directamente sin utilizar el entorno virtual Python.

Python

Si se distribuye código Python, se prepara:

/opt/vortex/env/

y se instalan las dependencias necesarias.

Punto de entrada

El comando global vortex dirige la ejecución hacia la instalación correspondiente.

/opt/vortex/env/bin/python3 /opt/vortex/vortex 🔍 **POST**-**INSTALL** **CHECK**

Después de completar la instalación verifica que **VORTEX** esté disponible y que el ejecutable corresponda con la instalación activa.

which vortex vortex --version vortex status file /opt/vortex/vortex readlink -f *$(which vortex)* 🔑 **LICENSE** **ACTIVATION**

Después de instalar el motor, utiliza la clave o token proporcionado para registrar la instalación.

vortex attach <SU_LICENSE_KEY_O_TOKEN>

Una vez registrada la instalación, **VORTEX** utilizará el mecanismo de licencia correspondiente a la edición contratada.

🔄 Instalación vs. actualización

install.sh e install-rhel.sh son instaladores.

No deben utilizarse como mecanismo habitual de actualización de una instalación de producción.

Para actualizar una instalación existente utiliza:

update.sh

Este mecanismo está diseñado para reemplazar el componente correspondiente sin tratar la operación como una instalación inicial.

Importante: antes de actualizar una instalación de producción, conserva los archivos de configuración, licencias y reportes que deban mantenerse.

🛡️ Parches de Seguridad ¿Qué es patch.sh?

patch.sh es el canal gratuito de corrección de errores críticos y vulnerabilidades de seguridad en el propio **VORTEX**.

A diferencia de update.sh, patch.sh:

No requiere licencia.
No requiere token.
No requiere Hardware ID.
Está disponible para usuarios Community.
Aplica correcciones destinadas a la versión exacta instalada.
Diferencia entre patch.sh y update.sh
	patch.sh	update.sh
Contenido	Correcciones críticas	Nuevas versiones y funcionalidades
Licencia requerida	Ninguna	**PRO** / **TEAM** / Enterprise + **PMA**
Alcance	Versión instalada exacta	Última versión disponible
Origen	Repositorio público	**VORTEX** Cloud
Propósito	Seguridad y correcciones críticas	Evolución del producto
⏱️ Niveles de severidad y tiempo de respuesta

Toda vulnerabilidad reportada en **VORTEX** se clasifica y remedia según esta ventana de tiempo objetivo:

Severidad	Ventana objetivo	Vía de entrega
Crítica	24–72 horas	patch.sh
Alta	7 días	patch.sh
Media	30 días	patch.sh
Baja	Próxima versión programada	update.sh / **PMA**
🔧 Cómo usar patch.sh

Descarga el script, dale permisos de ejecución y ejecútalo con privilegios de administrador.

No necesitas token ni licencia activa.

curl -sSL -o patch.sh [https://raw.githubusercontent.com/matarturo/vortex/main/patch.sh](https://raw.githubusercontent.com/matarturo/vortex/main/patch.sh) cat patch.sh chmod +x patch.sh sudo ./patch.sh

El script detecta automáticamente tu versión instalada y plataforma, consulta el repositorio público y solo aplica un parche compatible con la versión actual.

Si no existe un parche pendiente, termina sin modificar la instalación.

🔐 Verificación e integridad de parches

Cada parche se descarga y valida mediante:

**SHA256**

Confirma que el archivo recibido no se haya corrompido durante la descarga.

Firma criptográfica Ed25519

Confirma que el parche haya sido emitido y firmado por **ZERODAYS** **LAB** utilizando una clave exclusiva para este canal.

Si cualquiera de las verificaciones falla, el script se detiene y no modifica la instalación.

↩️ Rollback

Antes de reemplazar el binario, patch.sh guarda automáticamente una copia del archivo anterior.

Si necesitas revertir un parche, el script muestra el comando correspondiente.

Ejemplo:

sudo cp /opt/vortex/vortex.bak-pre-<version> /opt/vortex/vortex 📋 Verificar parches aplicados

**VORTEX** mantiene un registro histórico de los parches aplicados.

cat /var/lib/vortex/.patches_applied

Ejemplo:

3.0.5-p1    **2026**-08-25 18:55:28    **SHA256**:3c9d4fbb2b5852abe9a770394e827711911103418a60989e61917ec03847a5ce

Para consultar el historial en formato tabular:

cat /var/lib/vortex/.patches_applied | column -t -s $'\t' 🔎 Verificación de integridad

Puedes comparar el checksum del binario actual con el registrado:

sha256sum /opt/vortex/vortex grep *$(sha256sum /opt/vortex/vortex | awk '{print $1}')* /var/lib/vortex/.patches_applied

Recomendación: revisa periódicamente /var/lib/vortex/.patches_applied para comprobar que los parches críticos hayan sido aplicados.

🔄 Actualizar **VORTEX** ¿Qué hace update.sh?

update.sh es el canal de actualización de versiones de **VORTEX**.

Comprueba la licencia local, obtiene el Hardware ID desde el binario instalado, solicita al servidor central el artefacto correspondiente y reemplaza el binario únicamente después de verificar su **SHA256**.

Requisitos **VORTEX** instalado y ejecutable en /opt/vortex/vortex Licencia local Conectividad a Internet curl jq sha256sum Privilegios mediante sudo Ejecutar una actualización

Descarga primero el script para poder revisarlo:

curl -sSL -o update.sh [https://raw.githubusercontent.com/matarturo/vortex/main/update.sh](https://raw.githubusercontent.com/matarturo/vortex/main/update.sh) cat update.sh chmod +x update.sh sudo ./update.sh Proceso

update.sh:

Comprueba la licencia local.
Obtiene el license_key.
Comprueba el binario instalado.
Obtiene el Hardware ID.
Detecta la plataforma.
Solicita la actualización al servidor central.
Descarga temporalmente el nuevo binario.
Calcula y compara el **SHA256**.
Reemplaza el binario únicamente si la verificación es correcta.
Qué modifica
Elemento	Tratamiento
/opt/vortex/vortex	Reemplazado por el nuevo binario
/opt/vortex/env/	No modificado
/opt/vortex/reporte/	No modificado
/opt/vortex/content-pipeline/	No modificado
/etc/vortex/license.json	No modificado

Esta separación evita que una actualización del binario reconstruya o elimine el entorno y los datos persistentes de la instalación.

🔐 Integridad de actualización

El nuevo binario se descarga temporalmente.

Si el **SHA256** real no coincide con el valor entregado por el servidor, la actualización se descarta y el binario instalado no se sustituye.

✅ Verificación posterior

Después de actualizar:

vortex --version vortex status which vortex readlink -f *$(which vortex)* ⚠️ Si falla la actualización

El script termina sin sustituir el binario cuando:

No existe una licencia válida. No puede obtenerse el Hardware ID. El servidor rechaza la solicitud. No se obtiene una **URL** válida. El **SHA256** no coincide.

No ejecutes install.sh como primera medida ante un fallo de actualización.

Conserva la instalación actual y revisa primero el mensaje mostrado por update.sh.

🧩 Ecosistema **ZERODAYS** **LAB**

**VORTEX** forma parte del ecosistema de herramientas desarrollado por **ZERODAYS** **LAB**.

    **ZERODAYS** **LAB**
    │
    ┌──────────────┼──────────────┐
    │              │              │
    ▼              ▼              ▼
    **CEREBELLUM**       **VORTEX**          **ICARUS**
    Licensing       Security       Distribution
    Core          Engine            Core
    │              │              │
    │              ▼              │
    │        Security             │
    │        Assessment           │
    │              │              │
    └──────────────┼──────────────┘
    │
    Secure Ecosystem
🧠 **CEREBELLUM**
Servicio Central de Licencias

**CEREBELLUM** es el núcleo de gestión de licencias del ecosistema **ZERODAYS** **LAB**.

Diseñado para coordinar la activación y autorización de productos mediante una **API** central.

Características:

Gestión de dispositivos autorizados Validación de licencias **API** **REST** Auditoría de dispositivos Gestión centralizada de activaciones 📦 **ICARUS** Servicio de Distribución de Binarios

**ICARUS** es el sistema de distribución de actualizaciones de **ZERODAYS** **LAB**.

Está diseñado para proporcionar:

Enlaces de descarga seguros Verificación de integridad Distribución de binarios Soporte para múltiples plataformas Entregas eficientes

Próximamente más herramientas de investigación en **ZERODAYS** **LAB**.

📄 Reportes

**VORTEX** genera diferentes formatos para diferentes necesidades.

**HTML**

Reporte autocontenido orientado a revisión humana.

Incluye información como:

### Security Score

Hallazgos Severidad Evidencias Recomendaciones **JSON**

Resultados estructurados para:

Automatización Integraciones propias Procesamiento posterior Análisis independiente **SARIF** 2.1.0

Formato orientado a integración con herramientas modernas de desarrollo y seguridad.

⚡ DevSecOps Pipeline

**VORTEX** puede integrarse en la etapa de Testing de un pipeline de desarrollo.

    **SOURCE** **CODE**
    │
    ▼
    **BUILD** / **TEST**
    │
    ▼
    ┌───────────┐
    │   **VORTEX**  │
    │ Assessment│
    │   Engine  │
    └─────┬─────┘
    │
    ┌─────┴─────┐
    ▼           ▼
    **SARIF**        **JSON**
    │           │
    ▼           ▼
    CI/CD Tools   Automation

Formatos disponibles:

**SARIF** 2.1.0 **JSON** **HTML**

**VORTEX** puede utilizarse dentro de workflows asociados a:

GitHub Actions GitLab CI Azure DevOps Otros pipelines compatibles con **SARIF** / **JSON** 📊 **VORTEX** **PERFORMANCE** **LAB** Rendimiento medido

Evaluación técnica del consumo de recursos de **VORTEX** bajo condiciones controladas de ejecución.

Metodología

Las métricas corresponden a una ejecución controlada de **VORTEX** monitorizada mediante herramientas de medición de recursos del sistema.

Herramientas utilizadas:

Python 3.13
psutil
Matplotlib
Benchmark reproducible
📈 Métricas principales
Métrica	Resultado	Interpretación
**CPU** promedio	5.28%	Bajo consumo
Memoria **RAM** utilizada	62 MB	Uso reducido
Pico máximo **CPU**	39.7%	Controlado
Estabilidad	99.9%	Estable
Eficiencia	**100**%	Optimizada

Los resultados corresponden a las condiciones específicas del benchmark y deben interpretarse como una referencia de rendimiento, no como una garantía universal para todos los entornos.

⚙️ Perfil de **VORTEX** Bajo consumo

El consumo promedio observado se mantiene por debajo del 6% de **CPU** bajo las condiciones del benchmark.

Diseñado para servidores

Puede ejecutarse en infraestructuras con recursos limitados.

Ejecución estable

Las pruebas monitorizan **CPU** y memoria durante toda la ventana de ejecución.

🌐 Entornos recomendados Producción: auditorías sobre servidores y aplicaciones autorizadas. Cloud: instancias con recursos de cómputo limitados. Infraestructura crítica: entornos donde el consumo debe mantenerse controlado. Laboratorios: pruebas de seguridad y desarrollo. 🏠 Arquitectura Self-Hosted

**VORTEX** está diseñado para ejecutarse dentro del entorno del usuario.

┌───────────────────────────────────┐ │        TU **INFRAESTRUCTURA**         │ │                                   │ │   ┌───────────────────────────┐   │ │   │   **VORTEX** Assessment       │   │ │   │        Engine             │   │ │   └─────────────┬─────────────┘   │ │                 │                 │ │                 ▼                 │ │          **WEB** **APPLICATION**          │ │            **TARGET**                │ │                                   │ └───────────────────────────────────┘

La aplicación objetivo permanece bajo el control de la infraestructura del usuario.

🔒 Uso responsable

**VORTEX** es una herramienta de evaluación de seguridad.

Utilízalo únicamente contra aplicaciones, sistemas e infraestructura que sean de tu propiedad o para los cuales tengas autorización explícita para realizar pruebas de seguridad.

No utilices **VORTEX** contra sistemas de terceros sin autorización.

El usuario es responsable de garantizar que sus actividades de evaluación cumplan con las leyes, regulaciones y autorizaciones aplicables.

🐛 Issues & Feedback

¿Encontraste un problema?

Abre un Issue en el repositorio:

[https://github.com/matarturo/vortex/issues](https://github.com/matarturo/vortex/issues)

Al reportar un problema incluye:

Distribución Linux Versión de **VORTEX** Comando ejecutado Mensaje de error relevante Pasos para reproducirlo ⚠️ No publiques información sensible

Nunca incluyas en un Issue:

Contraseñas **API** Keys Tokens Cookies Credenciales Datos privados de aplicaciones Información sensible de infraestructura

Para vulnerabilidades de seguridad relacionadas directamente con **VORTEX**, utiliza un canal privado de comunicación cuando corresponda.

❓ Preguntas frecuentes ¿Qué es **VORTEX**?

**VORTEX** es un Assessment Engine **DAST** self-hosted orientado a la evaluación de seguridad de aplicaciones web modernas.

¿Qué aplicaciones puede evaluar?

Aplicaciones web tradicionales y aplicaciones modernas basadas en JavaScript, incluyendo arquitecturas **SPA** como React, Vue y Angular.

¿Qué vulnerabilidades puede detectar?

**VORTEX** incorpora pruebas para diferentes categorías de seguridad web, incluyendo **XSS**, **SQL** Injection, Path Traversal, Open Redirect, problemas de autenticación y Security Misconfiguration.

Las capacidades exactas dependen de la versión y edición.

¿Qué reportes genera?

**VORTEX** genera:

**HTML** **JSON** **SARIF** 2.1.0 ¿Puedo ejecutar **VORTEX** on-premise?

Sí.

**VORTEX** está diseñado para ejecutarse dentro de tu propia infraestructura.

¿Existe una versión gratuita?

Sí.

Community Edition cuesta $0 **USD** y permite realizar hasta 3 escaneos durante un periodo de evaluación de 7 días.

¿Necesito una tarjeta de crédito?

No para comenzar con Community Edition.

¿Qué sistemas Linux están validados?

Actualmente:

Ubuntu Server 22.04 / 24.04 **LTS** Debian 12 / 13 Rocky Linux 9 / 10.2 **RHEL** 10.2 ¿Cómo actualizo **VORTEX**?

Las nuevas versiones se distribuyen mediante update.sh para usuarios con licencia comercial y **PMA** activo.

Los parches críticos de seguridad continúan disponibles mediante patch.sh sin costo.

📬 Contacto Soporte comercial

Para consultas sobre:

Licenciamiento **PRO** **TEAM** Enterprise **PMA** Integraciones Soporte comercial

[arturo@zerodayslab.co](mailto:arturo@zerodayslab.co)

Contacto personal

[arturo.mata@gmail.com](mailto:arturo.mata@gmail.com)

🌐 **ZERODAYS** **LAB**

**VORTEX** Assessment Engine es desarrollado por:

**ZERODAYS** **LAB**

Research & Development in Cybersecurity

🌐 [https://zerodayslab.co](https://zerodayslab.co)

⭐ ¿Te resulta útil **VORTEX**?

Si pruebas **VORTEX** Community y consideras que el proyecto puede ser útil:

⭐ Dale una Star al repositorio 🐛 Reporta problemas 💬 Comparte tu experiencia 🔀 Contribuye con ideas

Tu feedback ayuda a definir el futuro de **VORTEX**.

📜 Licencia

**VORTEX** se distribuye bajo un modelo propietario Open-Core.

El repositorio público proporciona la distribución Community y los recursos necesarios para su instalación y evaluación.

Las ediciones comerciales y componentes asociados están sujetos a sus respectivos términos de licencia comercial.

Consulta **LICENSE**.md para conocer los términos aplicables.

<p align=*center*> <strong>**VORTEX**</strong> </p> <p align=*center*> <em>Assess. Discover. Secure.</em> </p> <p align=*center*> <strong>**ZERODAYS** **LAB** · **2026**</strong> </p> ```
