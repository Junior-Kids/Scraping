#!/bin/bash

R="\033[91m"; G="\033[92m"; Y="\033[93m"; C="\033[96m"; W="\033[97m"; N="\033[0m"
BOLD="\033[1m"; DIM="\033[2m"

AUTHOR="Junior-Kids"
LOG="install.log"
FAILED=0
: > "$LOG"

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
    echo -e "${DIM}          BY: ${AUTHOR}${N}"
    echo -e "${W}  ──────────────────────────────────────────────────────${N}"
    echo ""
}

panel() {
    echo ""
    echo -e "${W}  ── ${BOLD}${Y}$1${N}"
    echo ""
}

item() {
    echo -e "  ${C}【${W}•${C}】${N} $1"
}

step() {
    local text="$1"; shift
    local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i=0
    echo ">>> $text" >> "$LOG"
    "$@" >> "$LOG" 2>&1 &
    local pid=$!
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r  ${C}%s${N} %s..." "${frames[$((i % 10))]}" "$text"
        i=$((i + 1))
        sleep 0.1
    done
    wait "$pid"
    local rc=$?
    if [ $rc -eq 0 ]; then
        printf "\r  ${G}✓${N} %-45s\n" "$text"
    else
        printf "\r  ${R}✗${N} %-45s\n" "$text"
        FAILED=$((FAILED + 1))
    fi
    return $rc
}

detect_env() {
    if [ -n "$TERMUX_VERSION" ] || [ -d "/data/data/com.termux" ] || [[ "$PREFIX" == *com.termux* ]]; then
        ENV="termux"
        ENV_NAME="Termux (Android)"
        PY="python"
    else
        ENV="linux"
        ENV_NAME=$(grep -m1 '^PRETTY_NAME=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')
        ENV_NAME="${ENV_NAME:-Linux}"
        PY="python3"
    fi

    if [ "$ENV" = "linux" ]; then
        if [ "$(id -u)" -eq 0 ]; then
            SUDO=""
        elif command -v sudo >/dev/null 2>&1; then
            SUDO="sudo"
        else
            SUDO=""
            NO_ROOT=1
        fi
        if command -v apt-get >/dev/null 2>&1; then PM="apt"
        elif command -v pacman >/dev/null 2>&1; then PM="pacman"
        elif command -v dnf >/dev/null 2>&1; then PM="dnf"
        else PM=""
        fi
    fi
}

check_env() {
    panel "CHECK ENVIRONMENT"
    detect_env
    item "Environment : ${Y}${ENV_NAME}${N}"
    item "OS          : ${Y}$(uname -s)${N}"
    item "Arch        : ${Y}$(uname -m)${N}"

    if ! command -v "$PY" >/dev/null 2>&1; then
        item "Python      : ${R}Not found${N}"
        return
    fi
    item "Python      : ${Y}$($PY --version 2>&1)${N}"
}

install_system_deps() {
    panel "SYSTEM PACKAGES"
    if [ "$ENV" = "termux" ]; then
        step "Update package list" pkg update -y
        step "Install python & build tools" pkg install -y python libxml2 libxslt clang make
        return
    fi

    if [ -n "$NO_ROOT" ]; then
        item "${Y}Tanpa root/sudo, lewati paket sistem${N}"
        return
    fi

    case "$PM" in
        apt)
            step "Update package list" $SUDO apt-get update -y
            step "Install python & build tools" $SUDO apt-get install -y python3 python3-pip python3-venv build-essential libxml2-dev libxslt1-dev
            ;;
        pacman)
            step "Install python & build tools" $SUDO pacman -S --noconfirm --needed python python-pip base-devel libxml2 libxslt
            ;;
        dnf)
            step "Install python & build tools" $SUDO dnf install -y python3 python3-pip gcc make libxml2-devel libxslt-devel
            ;;
        *)
            item "${Y}Package manager tidak dikenali, lewati${N}"
            ;;
    esac
}

setup_pip() {
    PIP="$PY -m pip"
    PIP_FLAGS=""
    if [ "$ENV" = "linux" ]; then
        if ! $PY -c 'import sys; sys.exit(0 if sys.prefix != sys.base_prefix else 1)' 2>/dev/null; then
            if $PIP install --help 2>/dev/null | grep -q "break-system-packages"; then
                PIP_FLAGS="--break-system-packages"
            fi
        fi
    fi
}

install_python_deps() {
    panel "PYTHON PACKAGES"
    if ! command -v "$PY" >/dev/null 2>&1; then
        item "${R}Python tidak ditemukan, instalasi dibatalkan${N}"
        exit 1
    fi

    setup_pip
    step "Update pip" $PIP install --upgrade pip $PIP_FLAGS
    step "Install rich, requests, bs4, lxml, cython" $PIP install $PIP_FLAGS rich requests beautifulsoup4 lxml cython
    step "Install playwright" $PIP install $PIP_FLAGS playwright

    if [ -f requirements.txt ]; then
        step "Install requirements.txt" $PIP install $PIP_FLAGS -r requirements.txt
    fi
}

install_browser() {
    panel "BROWSER ENGINE"
    if [ "$ENV" = "termux" ]; then
        item "${Y}Chromium Playwright tidak didukung langsung di Termux${N}"
        item "Solusi: ${G}pkg install proot-distro${N} lalu install Debian/Kali di dalamnya"
        item "Jalankan ulang installer ini di dalam distro tersebut"
        return
    fi

    if [ "$(id -u)" -eq 0 ]; then
        step "Install Chromium + dependensi" $PY -m playwright install --with-deps chromium
    else
        step "Install Chromium" $PY -m playwright install chromium
        if [ -n "$SUDO" ]; then
            step "Install dependensi Chromium" $SUDO env "PATH=$PATH" $PY -m playwright install-deps chromium
        fi
    fi
}

setup_project() {
    panel "PROJECT SETUP"
    mkdir -p output assets
    touch output/.gitkeep assets/.gitkeep
    item "output/  : ${G}OK${N}"
    item "assets/  : ${G}OK${N}"
    [ -f install.sh ] && chmod +x install.sh
    [ -f run.py ] && chmod +x run.py
}

test_imports() {
    panel "VERIFY MODULES"
    local mods=("rich:rich" "requests:requests" "bs4:beautifulsoup4" "lxml:lxml" "playwright:playwright" "Cython:cython")
    local pair mod label
    for pair in "${mods[@]}"; do
        mod="${pair%%:*}"
        label="${pair##*:}"
        if $PY -c "import $mod" 2>/dev/null; then
            echo -e "  ${G}✓ ${label}${N}"
        else
            echo -e "  ${R}✗ ${label}${N}"
            FAILED=$((FAILED + 1))
        fi
    done
}

main() {
    banner
    check_env
    install_system_deps
    install_python_deps
    install_browser
    setup_project
    test_imports

    panel "INSTALLATION COMPLETE!"
    if [ "$FAILED" -gt 0 ]; then
        item "${Y}${FAILED} langkah gagal, cek detail di ${W}${LOG}${N}"
    fi
    item "How to run it : ${G}${PY} run.py${N}"
    item "Output folder : ${G}./output/${N}"
    echo ""
    echo -e "${W}  ──────────────────────────────────────────────────────${N}"
    echo -e "${BOLD}${Y}  THANKS FOR USING SCRAPING CAPTCHA!${N}"
    echo -e "${DIM}  BY: ${AUTHOR}${N}"
    echo -e "${W}  ──────────────────────────────────────────────────────${N}"
    echo ""
}

main
