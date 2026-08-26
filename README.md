<p align="center">
  <img src="https://zerodayslab.co/imagenes/vortex.webp" width="240" alt="ZERODAYS LAB">
</p>

<h1 align="center">VORTEX ASSESSMENT ENGINE</h1>

<p align="center">
  <strong>Motor de Evaluación de Seguridad para Aplicaciones Web Modernas</strong>
</p>

<p align="center">
  <strong>DAST · SPA Discovery · JavaScript Security · Self-Hosted</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Release-success?style=for-the-badge" alt="Status">
  <img src="https://img.shields.io/badge/Community-$0%20USD-brightgreen?style=for-the-badge" alt="Community">
  <img src="https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge" alt="Platform">
  <img src="https://img.shields.io/badge/OWASP-Top%2010%3A2025-orange?style=for-the-badge" alt="OWASP">
  <img src="https://img.shields.io/badge/Self--Hosted-On--Premise-purple?style=for-the-badge" alt="Self Hosted">
</p>

<p align="center">
  <strong>🚀 VORTEX Community ya está disponible.</strong>
</p>

<p align="center">
  <a href="#-instalación-rápida">⚡ Probar VORTEX</a> ·
  <a href="#-características">Características</a> ·
  <a href="#-community-edition">Community</a> ·
  <a href="#-ediciones-comerciales">PRO / TEAM / Enterprise</a>
</p>

---

# 🚀 VORTEX ya está disponible

**VORTEX Assessment Engine** es una plataforma de evaluación de seguridad web **self-hosted**, desarrollada por **ZERODAYS LAB — Research & Development in Cybersecurity**.

VORTEX combina **DAST (Dynamic Application Security Testing)** con descubrimiento moderno de aplicaciones y análisis de JavaScript.

Está diseñado para evaluar aplicaciones web modernas, incluyendo aquellas construidas como **Single Page Applications (SPA)** con tecnologías como:

- React
- Vue
- Angular
- JavaScript-heavy applications

VORTEX puede descubrir rutas y recursos de una aplicación, analizar recursos JavaScript y ejecutar pruebas de seguridad sobre las superficies descubiertas.

> **Las aplicaciones web cambiaron. VORTEX fue diseñado para evaluarlas.**

**Assess. Discover. Secure.**

---

# 🏗️ Arquitectura

VORTEX utiliza una arquitectura **self-hosted**, diseñada para ejecutarse dentro del entorno del usuario.

```text
┌───────────────────────────────────┐
│        TU INFRAESTRUCTURA         │
│                                   │
│   ┌───────────────────────────┐   │
│   │   VORTEX Assessment       │   │
│   │        Engine             │   │
│   └─────────────┬─────────────┘   │
│                 │                 │
│                 ▼                 │
│          WEB APPLICATION          │
│            TARGET                 │
│                                   │
└───────────────────────────────────┘
```


---

### Requisitos

* Linux 64-bit
* `curl`
* `tar`
* `sudo` / root para la instalación
* Conectividad de red para la instalación y activación inicial

---

# 🖥️ Sistemas Linux validados
```
VORTEX ha sido probado por ZERODAYS LAB en los siguientes entornos:

|           Sistema               |      Versiones    |    Estado     |
|---------------------------------|-------------------|---------------|
| Ubuntu Server                   | 22.04 / 24.04 LTS | ✅ Validado  |
| Debian                          |    12 / 13        | ✅ Validado  |
| Rocky Linux                     |     9 / 10.2      | ✅ Validado  |
| Red hat Entreprise Linux (RHEL) |      10.2         | ✅ Validado  |

```
### Recomendación

Para una instalación nueva recomendamos:

- **Ubuntu Server 22.04 LTS**
- **Debian 13**
- **RHEL 10.2**

según los requisitos de tu infraestructura.

Las pruebas cubren instalación, ejecución del motor, gestión de licencias y actualización del producto.

**Ojo:** si el repositorio no es exactamente `matarturo/vortex`, cambia esa URL por la real.

# ⚡ Instalación rápida

¿Quieres probar VORTEX Community?  **No necesitas tarjeta de crédito para comenzar la evaluación.**

Ejecuta en distribuiciones Ubuntu/Debian:

```bash
curl -sSL -o install.sh https://raw.githubusercontent.com/matarturo/vortex/main/install.sh
cat install.sh
chmod +x install.sh
sudo ./install.sh
```
Ejecuta en distribuiciones RHEL/Roky Linux:

```bash
curl -sSL -o install-rhel.sh https://raw.githubusercontent.com/matarturo/vortex/main/install-rhel.sh
chmod +x install-rhel.sh
sudo ./install-rhel.sh
```

Después de la instalación:

```bash
vortex --help
```

```bash
vortex --version
```
```bash
vortex status
```
Ejecutar tu primer Assessment

```bash
vortex --local --http-port
```

```bash
Revisar el reporte
```

```bash
ls -lah /opt/vortex/reporte/
```

**No necesitas instalar configurar un entorno de desarrollo.**

La distribución Community se entrega como una aplicación Linux empaquetada.

# 🔬 Flujo de evaluación

Una evaluación típica con VORTEX sigue este flujo:

```text
                 APLICACIÓN WEB
                       │
                       ▼
              ┌─────────────────┐
              │     VORTEX      │
              │     Crawler     │
              └────────┬────────┘
                       │
                       ▼
              SPA / Route Discovery
                       │
                       ▼
             JavaScript Analysis
                       │
                       ▼
             Security Assessment
                       │
                       ▼
              ┌─────────────────┐
              │    RESULTS      │
              └────────┬────────┘
                       │
              ┌────────┼────────┐
              ▼        ▼        ▼
            HTML      JSON     SARIF
```

# 🧭 ¿Por qué VORTEX?

Las aplicaciones web modernas ya no funcionan como las aplicaciones web tradicionales.

Gran parte de la navegación, formularios, rutas y lógica de aplicación puede depender de JavaScript.

Los enfoques tradicionales de crawling pueden tener dificultades para descubrir correctamente estas superficies.

**VORTEX nace precisamente de ese problema.**

### VORTEX se enfoca en:

**🔎 Application Discovery**

Descubrimiento de rutas, recursos y superficies de ataque de aplicaciones web.

**🕸️ SPA Discovery**

Diseñado para aplicaciones JavaScript modernas como React, Vue y Angular.

**🔐 JavaScript Security Analysis**

Análisis de bundles y recursos JavaScript en busca de información sensible y elementos de interés para seguridad.

**🛡️ Security Assessment**

Pruebas orientadas a detectar vulnerabilidades y debilidades comunes en aplicaciones web.

**🏠 Self-Hosted / On-Premise**

Ejecuta el motor dentro de tu propia infraestructura.

---

# ✨ Características

## 🕵️ Crawler + SPA Discovery

Descubrimiento de rutas y recursos en aplicaciones web modernas.

VORTEX está diseñado para trabajar con aplicaciones donde la navegación y la lógica dependen fuertemente de JavaScript.

---

## 🔐 Análisis de JavaScript

Analiza recursos y bundles JavaScript en busca de información potencialmente expuesta, incluyendo:

* API Keys
* Tokens
* Credenciales
* Secretos hardcodeados
* Información sensible relacionada con la aplicación

---

## 🛡️ Web Security Testing

VORTEX incorpora pruebas orientadas a diferentes categorías de seguridad web, incluyendo:

* Cross-Site Scripting (XSS)
* SQL Injection
* Path Traversal
* Open Redirect
* Debilidades relacionadas con autenticación
* Security Misconfiguration

> Las capacidades exactas dependen de la versión y edición de VORTEX.

---

## 🔑 Autenticación

VORTEX incorpora capacidades para evaluación de aplicaciones autenticadas y workflows de login.

Esto permite ampliar la superficie de evaluación más allá de las páginas públicas.

---

## 📊 Reportes Multi-Formato

Los resultados pueden generarse en:

* **HTML** — revisión humana y presentación
* **JSON** — automatización e integración
* **SARIF 2.1.0** — integración con workflows modernos de seguridad y desarrollo

---

## 🖥️ Self-Hosted / On-Premise

VORTEX se ejecuta dentro de tu infraestructura.

Tu aplicación objetivo **no necesita estar expuesta a un servicio externo de scanning**.

Esto permite utilizar VORTEX en:

* Laboratorios de seguridad
* Infraestructura corporativa
* Entornos de desarrollo
* QA / Staging
* DevSecOps
* Pentesting autorizado
* Evaluaciones internas

---

## 🆓 Community Edition — GRATIS    **Empieza con VORTEX por $0 USD**

La edición **Community** está diseñada para que desarrolladores y profesionales de seguridad puedan evaluar VORTEX antes de adquirir una licencia comercial.

- 10 escaneos / 7 días
- SPA Discovery         ✅
- Reportes HTML y JSON  ✅
- Reportes SARIF        ❌
- Soporte por correo electronico: <72 horas

### Community está pensada para:

- 👨‍💻 Desarrolladores web
- 🛡️ Profesionales de ciberseguridad
- 🔬 Security Researchers
- 🎓 Estudiantes
- 🕵️ Pentesters
- ⚙️ Profesionales DevSecOps
- 🏢 Equipos que quieran evaluar VORTEX

**No necesitas tarjeta de crédito para comenzar la evaluación.**
---

# 💼 Ediciones comerciales

# 🛒 Adquirir productos y licencias

¿Quieres llevar VORTEX más allá de la edición Community?

La **tienda oficial de ZERODAYS LAB en Gumroad** es el punto de adquisición de nuestras herramientas, licencias y productos digitales.

Gumroad proporciona un entorno de compra seguro y permite utilizar los métodos de pago disponibles para tu región y producto, incluyendo **tarjetas de crédito/débito y PayPal**, cuando están habilitados. :contentReference[oaicite:1]{index=1}

<p align="center">
  <a href="https://arturomata.gumroad.com/">
    <img src="https://img.shields.io/badge/🛒%20TIENDA%20OFICIAL-ZERODAYS%20LAB%20·%20GUMROAD-6f2cff?style=for-the-badge" alt="Tienda oficial ZERODAYS LAB en Gumroad">
  </a>
</p>

<p align="center">
  <strong>Compra de forma segura · Diferentes métodos de pago · Entrega digital</strong>
</p>

```
|     Edición     |     Precio     | Diseñada para               |
|-----------------|---------------:|-----------------------------|
| **Community**   |   **$0 USD**   | Pruebas y evaluación        |
| **PRO**         |   **$99 USD**  | Profesionales y consultores |
| **TEAM**        | **$349 USD**   | Equipos de seguridad        |
| **Enterprise**  | **$999 USD**   | Organizaciones grandes      |
```
### ⭐ PRO — $99 USD

- Escaneos ilimitados
- 1 equipo activo
- Reportes HTML + JSON + SARIF
- Detección de secretos en JS
- Soporte por correo: <48 horas

### 👥 TEAM — $349 USD

- Escaneos ilimitados
- Hasta 5 equipos
- Reportes HTML + JSON + SARIF
- Detección de tokens expuestos en JS
- Soporte por correo: <24 horas

### 🏢 Enterprise — $999 USD

- Escaneos ilimitados
- Hasta 50 equipos
- Reportes HTML + JSON + SARIF
- Detección de secretos en JS
- Soporte 24/7
- Respuesta inferior a 1 hora
- PMA incluido

> **PMA — Plan de Mantenimiento Anual:** proporciona acceso a nuevas versiones y actualizaciones de seguridad conforme a los términos comerciales aplicables.

### 🛍️ Visita nuestra tienda

<p align="center">
  <a href="https://arturomata.gumroad.com/">
    <strong>👉 Visitar la tienda oficial de ZERODAYS LAB</strong>
  </a>
</p>

---

# 🔑 Activación de VORTEX
```
vortex attach <SU_LICENSE_KEY_O_TOKEN>
```

---
# 🧩 Ecosistema ZERODAYS LAB

VORTEX forma parte del ecosistema de herramientas desarrollado por **ZERODAYS LAB**.

```text
                    ZERODAYS LAB
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
     CEREBELLUM       VORTEX          ICARUS
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
```

---

# 🔄 Actualizaciones y mantenimiento

VORTEX separa las actualizaciones de funcionalidades de las correcciones críticas.

### `update.sh`

Canal utilizado para distribuir nuevas versiones y funcionalidades de VORTEX.

Las actualizaciones de versiones están disponibles para usuarios **PRO, TEAM y Enterprise con PMA activo**.

### `patch.sh`

Canal destinado a correcciones críticas y vulnerabilidades de seguridad.

Los parches críticos están disponibles para **todos los usuarios**, incluyendo Community.

No requieren:

- Licencia
- Token
- Hardware ID
- PMA

### Integridad

Los binarios y parches distribuidos por VORTEX incorporan mecanismos de verificación de integridad.

Las actualizaciones verifican el **SHA256** antes de reemplazar el componente instalado.

Los parches utilizan además firma criptográfica **Ed25519** para verificar su procedencia.

> Los parches críticos y correcciones de errores críticos son gratuitos para todos los usuarios. Las nuevas funcionalidades y versiones están sujetas al modelo de mantenimiento correspondiente.

---

# 📄 Reportes

## HTML

Reporte orientado a revisión humana y documentación de la evaluación.

## JSON

Resultados estructurados para automatización e integraciones propias.

## SARIF 2.1.0

Formato diseñado para integrarse con workflows modernos de seguridad y desarrollo.

---

La edición Community se distribuye como una aplicación Linux empaquetada.

---

# 🔒 Uso responsable

VORTEX es una herramienta de evaluación de seguridad.

Utilízalo **únicamente contra aplicaciones, sistemas e infraestructura que sean de tu propiedad o para los cuales tengas autorización explícita para realizar pruebas de seguridad**.

No utilices VORTEX contra sistemas de terceros sin autorización.

El usuario es responsable de garantizar que sus actividades de evaluación cumplan con las leyes, regulaciones y autorizaciones aplicables.

---

# 🐛 Issues & Feedback

¿Encontraste un problema?

Abre un Issue en el repositorio.

Al reportar un problema incluye:

- Distribución Linux
- Versión de VORTEX
- Comando ejecutado
- Mensaje de error relevante
- Pasos para reproducir el problema

### ⚠️ No publiques información sensible

Nunca incluyas en un Issue:

- Contraseñas
- API Keys
- Tokens
- Cookies
- Credenciales
- Datos privados de aplicaciones

---

### 📬 Contacto Soporte comercial

Para consultas comerciales, licenciamiento o asistencia relacionada con el producto:

**arturo@zerodayslab.co**

Para contacto personal:

**arturo.mata@gmail.com**

---

# ⭐ ¿Te resulta útil VORTEX?

Si pruebas VORTEX Community y consideras que el proyecto puede ser útil:

- ⭐ Dale una Star al repositorio
- 🐛 Reporta problemas
- 💬 Comparte tu experiencia
- 🔀 Contribuye con ideas

Tu feedback ayuda a definir el futuro de VORTEX.

---

# 🌐 ZERODAYS LAB

**VORTEX Assessment Engine** es desarrollado por:

**ZERODAYS LAB**
*Research & Development in Cybersecurity*

🌐 https://zerodayslab.co

📦 https://github.com/matarturo/vortex

---

# 📜 Licencia

VORTEX se distribuye bajo un modelo propietario **Open-Core**.

El repositorio público proporciona la distribución Community y los recursos necesarios para su instalación y evaluación.

Las ediciones comerciales y componentes asociados están sujetos a sus respectivos términos de licencia comercial.

Consulta [`LICENSE.md`](LICENSE.md) para conocer los términos aplicables.

---

<p align="center">
  <strong>VORTEX</strong>
</p>

<p align="center">
  <em>Assess. Discover. Secure.</em>
</p>

<p align="center">
  <strong>ZERODAYS LAB · 2026</strong>
</p>
