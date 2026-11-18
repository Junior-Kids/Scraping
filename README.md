<h1 align="center">⚡ CAPTCHA - MEGA v2.0</h1>

<p align="center">
  <b>Advanced Web Security Research & Automation Framework</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.8+-3776AB?style=flat-square&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/Framework-TUI-00D9FF?style=flat-square" />
  <img src="https://img.shields.io/badge/Browser-Playwright-2EAD33?style=flat-square&logo=playwright&logoColor=white" />
  <img src="https://img.shields.io/badge/Compilation-Cython-FFD43B?style=flat-square&logo=python&logoColor=black" />
  <img src="https://img.shields.io/badge/Version-2.0-blue?style=flat-square" />
</p>

---

## 📖 Overview

**CAPTCHA - MEGA** is a Python-based Terminal User Interface (TUI) framework designed for web security research, automated web analysis, CAPTCHA mechanism evaluation, and endpoint discovery.

Built with Python, Rich, Playwright, and Cython, it combines browser automation, web scraping, security detection, and endpoint validation within a unified terminal environment.

Its modular architecture simplifies security testing workflows and provides structured results for further analysis.

## ℹ️ Project Information

| | |
|---|---|
| **Version** | 2.0 |
| **Status** | Final Release |
| **Author** | Junior-Kids |
| **Team** | Junior-Kids |
| **Language** | Python |
| **Interface** | Terminal User Interface (TUI) |

---

## ⚠️ Disclaimer

CAPTCHA - MEGA is intended for **educational purposes, authorized security research, and controlled penetration testing**.

Users are responsible for ensuring that their activities comply with applicable laws, service terms, and the authorization granted by system owners.

Do not use this framework to access protected resources, evade access controls, or automate interactions without explicit permission.

The developers assume no responsibility for unauthorized use or misuse of this software.

---

## ✨ Features

### 01. CAPTCHA & Anti-Bot Analysis

Tools for examining CAPTCHA implementations and evaluating browser-based security mechanisms.

- **Cloudflare Analysis**: examines Cloudflare protection behavior and browser challenge responses.
- **Turnstile Analysis**: evaluates visible and invisible Turnstile challenge behavior.
- **hCaptcha Analysis**: experimental hCaptcha integration.
- **reCAPTCHA v3 Analysis**: experimental DOM and token-flow inspection.
- **Altcha Analysis**: examines Proof-of-Work challenge mechanisms.
- **Friendly Captcha Analysis**: retrieves and analyzes Friendly Captcha puzzle data.

### 02. Web Scraping & Endpoint Discovery

Automated web analysis and resource discovery.

- **Scrape MEGA**: crawls authorized web pages and collects links, scripts, and API endpoint references.
- **Scrape + Save JSON**: exports collected analysis results into structured JSON files.
- **Smart JS Scoring**: analyzes JavaScript files for potential hardcoded endpoints and exposed configuration values.
- **Deep Link Scan**: discovers additional subdomains and related web assets within the authorized assessment scope.

### 03. Endpoint Testing & Validation

Utilities for evaluating endpoint accessibility and generating technical request references.

- **Endpoint Validator**: checks endpoint responses and identifies publicly accessible or restricted resources.
- **Playwright Fallback**: uses browser automation for authorized testing when direct HTTP requests encounter browser-based challenges.
- **Payload Generators**: generates cURL, Python, and JavaScript request examples.

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Main programming language |
| Rich | Terminal interface and formatting |
| Playwright | Browser automation |
| Cython | Compilation of Python modules |
| BeautifulSoup4 | HTML parsing |
| lxml | XML and HTML processing |

---

## 📦 Installation

### System Requirements

- **Operating System:** Linux (glibc-based, e.g. Debian/Ubuntu/Kali), macOS, or Windows (WSL)
- **Python:** 3.8 or newer
- **Internet:** stable connection

> ⚠️ **Termux (Android) is not supported natively.** The compiled `.so` modules are linked against glibc and require `libc.so.6`, which Android's Bionic libc does not provide. To run this on Android, install a Linux distro inside Termux first:
>
> ```bash
> pkg install proot-distro -y
> proot-distro install debian
> proot-distro login debian
> ```
>
> Then follow the installation steps below **inside** that Debian shell.

### 1. Clone the Repository

```bash
git clone https://github.com/Junior-Kids/Scraping.git
cd Scraping
```

### 2. Install Dependencies

```bash
chmod +x install.sh
bash install.sh
```

### 3. Install Additional HTML Parsing Dependencies

Only if BeautifulSoup4 is missing:

```bash
pip install beautifulsoup4 lxml
```

### 4. Install Playwright Chromium

```bash
playwright install chromium
```

### 5. Run the Framework

```bash
python3 run.py
```

---

## 📁 Project Structure

```text
captcha/
├── run.py
├── main.so
├── install.sh
├── requirements.txt
├── README.md
│
├── assets/
│
├── modules/
│   ├── __init__.py
│   ├── browser_service.so
│   ├── cloudflare.so
│   ├── hcaptcha.so
│   ├── recaptcha_v3.so
│   ├── turnstile.so
│   ├── altcha.so
│   ├── friendly.so
│   ├── auto_detect.so
│   ├── advanced_scraper.so
│   ├── endpoint_tester.so
│   ├── endpoint_validator.so
│   ├── get_sitekey.so
│   ├── get_source.so
│   ├── path_finder.so
│   ├── scrape_engine.so
│   └── url_resolver.so
│
└── output/
    └── JSON analysis results
```

---

## 📝 Technical Notes & Limitations

**1. Browser Automation**
Modern CAPTCHA and anti-bot systems employ increasingly sophisticated browser and automation detection mechanisms. Detection behavior may vary depending on browser configuration, environment, network conditions, and the protection provider.

**2. Execution Time**
Operations involving browser automation may take longer than direct HTTP requests. Execution time depends on page complexity, network conditions, browser initialization, and the number of endpoints being evaluated.

**3. Compiled Modules**
The framework uses Cython-compiled `.so` modules for its core components. These files are required by the launcher and should not be removed unless the corresponding modules are rebuilt and configured correctly.

**4. Endpoint Accessibility**
An HTTP response code alone does not establish whether an endpoint is fully public or whether its underlying functionality is accessible. Authentication, authorization, rate limits, and application-level controls must be evaluated separately.

---

## 📌 Project Status

CAPTCHA - MEGA v2.0 is currently marked as a **Final Release**.

Future maintenance and compatibility updates may depend on changes in Python, Playwright, browser engines, and third-party security mechanisms.

---

## 👤 Credits

Developed and maintained by **Junior-Kids**.

<p align="center">
  <i>"Research with purpose. Analyze with precision. Build with knowledge."</i>
</p>

<p align="center">
  <b>CAPTCHA - MEGA v2.0</b><br/>
  <sub>Junior-Kids · Security Research Framework</sub>
</p>
