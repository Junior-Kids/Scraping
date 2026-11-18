#!/bin/bash
# ============================================================
# SPECTRA CAPTCHA SOLVER - INSTALLER
# BY: DAFFA_SUKA LOLIPOP
# ============================================================

R="\033[91m"; G="\033[92m"; Y="\033[93m"; C="\033[96m"; W="\033[97m"; N="\033[0m"
BOLD="\033[1m"; DIM="\033[2m"

# ==================== BANNER ====================
banner() {
    clear
    echo ""
    echo -e "${G}   ╺┳╸┏━╸┏━┓┏┳┓╻ ╻╻ ╻   ┏━┓┏━╸╺┳╸╻ ╻┏━┓${N}"
    echo -e "${G}    ┃ ┣╸ ┣┳┛┃┃┃┃ ┃┏╋┛   ┗━┓┣╸  ┃ ┃ ┃┣━┛${N}"
    echo -e "${G}    ╹ ┗━╸╹┗╸╹ ╹┗━┛╹ ╹   ┗━┛┗━╸ ╹ ┗━┛╹${N}"
    echo ""
    echo -e "${Y}  ░█████╗░░█████╗░██████╗░████████╗░█████╗░██╗  ██╗░█████╗░${N}"
    echo -e "${Y}  ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║  ██║██╔══██╗${N}"
    echo -e "${Y}  ██║░░╚═╝███████║██████╔╝░░░██║░░░███████║╚██╗██╔╝███████║${N}"
    echo -e "${Y}  ██║░░██╗██╔══██║██╔═══╝░░░░██║░░░██╔══██║░╚███╔╝░██╔══██║${N}"
    echo -e "${Y}  ╚█████╔╝██║░░██║██║░░░░░░░░██║░░░██║░░██║░██╔██╗░██║░░██║${N}"
    echo -e "${Y}  ░╚════╝░╚═╝░░╚═╝╚═╝░░░░░░░░╚═╝░░░╚═╝░░╚═╝╚═╝╚═╝╚═╝░░╚═╝${N}"
    echo ""
    echo -e "${W}          [ SPECTRA CAPTCHA SOLVER ]${N}"
    echo -e "${DIM}          BY: DAFFA_SUKA LOLIPOP${N}"
    echo -e "${W}  ──────────────────────────────────────────────────────${N}"
    echo ""
}

# ==================== PANEL SIMPEL ====================
panel() {
    echo -e "${W}  ── ${BOLD}${Y}$1${N} ${W}${N}"
    echo ""
}

item() {
    echo -e "  ${C}【${W}•${C}】${N} $1"
}

# ==================== LOADING ====================
loading() {
    local text="$1"
    local frames=("[■□□□□□□□□□]" "[■■□□□□□□□□]" "[■■■□□□□□□□]" "[■■■■□□□□□□]" "[■■■■■□□□□□]" "[■■■■■■□□□□]" "[■■■■■■■□□□]" "[■■■■■■■■□□]" "[■■■■■■■■■□]" "[■■■■■■■■■■]")
    local colors=("\033[91m" "\033[93m" "\033[92m" "\033[96m" "\033[95m")
    echo ""
    for i in $(seq 0 19); do
        local c=${colors[$((i % 5))]}
        local f=${frames[$((i % 10))]}
        printf "\r\t ${c}${text}...${N} ${f} "
        sleep 0.15
    done
    printf "\r\t ${G}✓ ${text} selesai!     ${N}\n"
    echo ""
}

# ==================== ENV CHECK ====================
check_env() {
    panel "CHECK ENVIRONMENT"
    if [ -n "$TERMUX_VERSION" ] || [ -d "/data/data/com.termux" ]; then
        ENV="termux"
        item "Environment : ${Y}Termux${N}"
    elif grep -qi "kali" /etc/os-release 2>/dev/null; then
        ENV="kali"
        item "Environment : ${Y}Kali Linux${N}"
    elif grep -qi "debian\|ubuntu" /etc/os-release 2>/dev/null; then
        ENV="debian"
        item "Environment : ${Y}Debian/Ubuntu${N}"
    else
        ENV="unknown"
        item "Environment : ${Y}Unknown${N}"
    fi
    item "OS          : ${Y}$(uname -s)${N}"
    item "Arch        : ${Y}$(uname -m)${N}"
    PY_VER=$(python3 --version 2>/dev/null || echo "Not found")
    item "Python      : ${Y}${PY_VER}${N}"
    echo ""
}

# ==================== INSTALL DEPS ====================
install_python_deps() {
    if [ "$ENV" = "termux" ]; then
        loading "Update pip"
        pip install --upgrade pip >/dev/null 2>&1
        loading "Install Python packages"
        pip install rich requests beautifulsoup4 lxml >/dev/null 2>&1
        loading "Install Playwright"
        pip install playwright >/dev/null 2>&1
        loading "Install Chromium"
        python -m playwright install chromium >/dev/null 2>&1
    else
        loading "Update pip"
        pip3 install --upgrade pip >/dev/null 2>&1 || pip install --upgrade pip >/dev/null 2>&1
        loading "Install Python packages"
        pip3 install rich requests beautifulsoup4 lxml >/dev/null 2>&1 || pip install rich requests beautifulsoup4 lxml >/dev/null 2>&1
        loading "Install Playwright"
        pip3 install playwright >/dev/null 2>&1 || pip install playwright >/dev/null 2>&1
        loading "Install Chromium"
        python3 -m playwright install chromium >/dev/null 2>&1 || python -m playwright install chromium >/dev/null 2>&1
    fi
}

# ==================== SETUP PROJECT ====================
setup_project() {
    loading "Create output & assets folder"
    mkdir -p output assets
    touch output/.gitkeep assets/.gitkeep
    item "output/  : ${G}OK${N}"
    item "assets/  : ${G}OK${N}"
}

# ==================== TEST IMPORT ====================
test_imports() {
    loading "Test import modules"
    if [ "$ENV" = "termux" ]; then PY=python; else PY=python3; fi

    $PY -c 'import rich' 2>/dev/null && echo -e "  ${G}✓ rich${N}" || echo -e "  ${R}✗ rich${N}"
    $PY -c 'import requests' 2>/dev/null && echo -e "  ${G}✓ requests${N}" || echo -e "  ${R}✗ requests${N}"
    $PY -c 'import bs4' 2>/dev/null && echo -e "  ${G}✓ beautifulsoup4${N}" || echo -e "  ${R}✗ beautifulsoup4${N}"
    $PY -c 'import lxml' 2>/dev/null && echo -e "  ${G}✓ lxml${N}" || echo -e "  ${R}✗ lxml${N}"
    $PY -c 'import playwright' 2>/dev/null && echo -e "  ${G}✓ playwright${N}" || echo -e "  ${R}✗ playwright${N}"
}

# ==================== MAIN ====================
main() {
    banner
    check_env
    panel "STARTING INSTALLATION"
    install_python_deps
    setup_project
    test_imports
    echo ""
    panel "INSTALLATION COMPLETE!"
    item "How to run it : ${G}python3 main.py${N}"
    item "Output folder : ${G}./output/${N}"
    echo ""
    echo -e "${W}  ──────────────────────────────────────────────────────${N}"
    echo -e "${BOLD}${Y}  THANKS FOR USING SPECTRA CAPTCHA!${N}"
    echo -e "${DIM}  BY: DAFFA_SUKA LOLIPOP${N}"
    echo -e "${W}  ──────────────────────────────────────────────────────${N}"
    echo ""
}

main
