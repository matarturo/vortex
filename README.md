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

# ⚡ Instalación rápida

¿Quieres probar VORTEX Community?

Ejecuta:

```bash
curl -sSL https://github.com/matarturo/vortex/raw/main/install.sh | sudo bash
```
Después de la instalación:

```bash
vortex --version
```
```bash
vortex --help
```

**No necesitas instalar configurar un entorno de desarrollo.**

La distribución Community se entrega como una aplicación Linux empaquetada.

### Requisitos

* Linux 64-bit
* `curl`
* `tar`
* `sudo` / root para la instalación
* Conectividad de red para la instalación y activación inicial

Entornos objetivo:

* Ubuntu
* Debian
* RHEL
* Rocky Linux
* Otras distribuciones Linux 64-bit compatibles

---


**Ojo:** si el repositorio no es exactamente `matarturo/vortex`, cambia esa URL por la real.

### 3. ¿Por qué VORTEX?

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

# 🧪 Community Edition — GRATIS

## Empieza con VORTEX por $0 USD

La edición **Community** está diseñada para que desarrolladores y profesionales de seguridad puedan evaluar VORTEX antes de adquirir una licencia comercial.

| Capacidad | Community |
|---|---:|
| Precio | **$0 USD** |
| Periodo de evaluación | **7 días** |
| Escaneos | **Hasta 3** |
| Self-Hosted | ✅ |
| SPA Discovery | ✅ |
| JavaScript Analysis | ✅ |
| Security Assessment | ✅ |
| HTML Reports | ✅ |
| JSON Reports | ✅ |
| SARIF | ✅ |
| Soporte comercial | — |

### Community está pensada para:

- 👨‍💻 Desarrolladores
- 🛡️ Profesionales de ciberseguridad
- 🔬 Security Researchers
- 🎓 Estudiantes
- 🕵️ Pentesters
- ⚙️ Profesionales DevSecOps
- 🏢 Equipos que quieran evaluar VORTEX

**No necesitas tarjeta de crédito para comenzar la evaluación.**
---

# 💼 Ediciones comerciales

Cuando necesites eliminar las restricciones de evaluación:

| Edición | Precio | Diseñada para |
|---|---:|---|
| **Community** | **$0 USD** | Evaluación |
| **PRO** | **$99 USD** | Profesionales |
| **TEAM** | **$349 USD** | Equipos de seguridad |
| **Enterprise** | **$999 USD** | Organizaciones |

### PRO — $99 USD

- Escaneos ilimitados
- 1 instalación activa
- Reportes completos
- Soporte comercial

### TEAM — $349 USD

- Escaneos ilimitados
- Hasta 5 instalaciones activas
- Soporte prioritario

### Enterprise — $999 USD

- Escaneos ilimitados
- Hasta 50 instalaciones activas
- Soporte empresarial
- PMA incluido

> **PMA — Plan de Mantenimiento Anual:** proporciona acceso a nuevas versiones y actualizaciones de seguridad conforme a los términos comerciales aplicables.

---

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


---

# 📄 Reportes

## HTML

Reporte orientado a revisión humana y documentación de la evaluación.

## JSON

Resultados estructurados para automatización e integraciones propias.

## SARIF 2.1.0

Formato diseñado para integrarse con workflows modernos de seguridad y desarrollo.

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
│            TARGET                │
│                                   │
└───────────────────────────────────┘
```

La edición Community se distribuye como una aplicación Linux empaquetada.

---

# 📦 Instalación

## Community

```bash
curl -sSL https://github.com/matarturo/vortex/raw/main/install.sh | sudo bash
```

Verifica la instalación:

```bash
vortex --help
```

Consulta las opciones disponibles:

```bash
vortex --help
```

Para obtener instrucciones específicas de uso y evaluación, consulta la documentación incluida en el repositorio.

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

# 🌐 ZERODAYS LAB

**VORTEX Assessment Engine** es desarrollado por:

**ZERODAYS LAB**  
*Research & Development in Cybersecurity*

🌐 https://zerodayslab.co

### Soporte comercial

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
