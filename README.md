<!-- 📌 LOGO: reemplazar la linea de abajo con tu imagen -->
<p align="center">
  <img src="https://zerodayslab.co/imagenes/zero.webp" width="280" alt="ZERODAYS LAB Logo">
</p>

<p align="center">
  <h1 align="center">VORTEX ASSESSMENT ENGINE</h1>
</p>

<p align="center">
  <b>Motor de Evaluación de Seguridad Ofensiva (DAST + Análisis JS)</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Release-success?style=for-the-badge" alt="Status">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Ubuntu%20%7C%20Debian%20%7C%20RHEL-blue?style=for-the-badge" alt="Platform">
  <img src="https://img.shields.io/badge/License-Proprietary%20%2F%20Open--Core-red?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/OWASP-Top%2010%3A2025-orange?style=for-the-badge" alt="OWASP">
</p>

---

## 🚀 Acerca de VORTEX

**VORTEX** no es solo un escáner; es un **Assessment Engine de Próxima Generación** desarrollado por **ZERODAYS LAB** (Research & Development in Cybersecurity).

Trasciende el *Dynamic Application Security Testing (DAST)* tradicional. VORTEX automatiza el descubrimiento de vulnerabilidades en aplicaciones web modernas, incluyendo **SPA (React, Vue, Angular)**. Su análisis profundo de bundles de JavaScript detecta secretos hardcodeados y riesgos que otros escáneres simplemente pasan por alto.

Distribuido como binario nativo autocontenido: no requiere Python, pip ni dependencias adicionales en la máquina del cliente.

---

## ✨ Características Destacadas

* 🕵️ **Crawler + SPA Discovery:** Descubre rutas en aplicaciones React, Vue y Angular.
* 🔐 **Detección de Secretos en JS:** Análisis estático de bundles para encontrar API keys y tokens.
* 📊 **Reportes Multi-Formato:** Genera reportes en HTML, JSON y **SARIF 2.1.0** para integración nativa con GitHub, GitLab, AWS y Azure.
* ⚡ **Rápido y Liviano:** Consume menos del **6% de CPU** y solo **62 MB de RAM** (benchmark verificado).
* 🔧 **Autenticación Integrada:** Login automático con credenciales y detección de credenciales por defecto.
* 🛡️ **OWASP Top 10:2025:** Pruebas alineadas con el estándar, incluyendo XSS, SQLi y Path Traversal.

---

## 💳 Modelo Comercial (Open-Core)

VORTEX opera bajo un modelo **Open-Core**. El binario base es público, pero el motor de escaneo avanzado (núcleo) está en un repositorio privado.

| Nivel | Inversión | Cobertura y Soporte |
| :--- | :--- | :--- |
| **Community** | **$0 USD** | Hasta **3 escaneos** durante 7 días. Ideal para pruebas de concepto y evaluación. |
| **PRO** | **$99 USD** | Escaneos ilimitados. **1 equipo activo**. Reportes completos (HTML + JSON + SARIF). Soporte por correo en 48 horas. |
| **TEAM** | **$349 USD** | Escaneos ilimitados. Hasta **5 equipos activos**. Soporte por correo en 24 horas. |
| **Enterprise** | **$999 USD** | Escaneos ilimitados. Hasta **50 equipos**. **Soporte 24/7 con respuesta &lt; 1 hora**. PMA incluido. |

> **💡 PMA (Plan de Mantenimiento Anual):** Para los planes PRO y TEAM, el acceso a nuevas versiones y parches de seguridad está sujeto a una suscripción anual de **$30 USD/año**. Sin el PMA, tu versión actual seguirá funcionando con escaneos ilimitados, pero no recibirás actualizaciones.

---

## 💻 Requisitos del Sistema

* **Sistema Operativo:** Linux de 64 bits (Ubuntu LTS 20.04+, Debian 11+, RHEL, CentOS, Rocky Linux).
* **Dependencias:** `curl`, `tar` (presentes por defecto en cualquier distribución Linux moderna).
* **Entorno de Ejecución:** **Python 3.13+** (El script de instalación `install.sh` verificará y gestionará la instalación de Python de forma automática si no está presente).
* **Privilegios:** `sudo`/root solo para la instalación inicial y el enlace simbólico global.

---

## ⚙️ Instalación Rápida (Community)

Para probar la versión Community:

```bash
curl -sSL https://github.com/matarturo/vortex/raw/main/install.sh | sudo bash
---
```
## 📄 Licencia

Software propietario (Open-Core). Uso sujeto a los términos de la licencia adquirida. Ver `LICENSE` para más detalles.
