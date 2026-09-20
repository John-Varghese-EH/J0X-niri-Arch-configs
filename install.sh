#!/usr/bin/env bash
# ╔═══════════════════════════════════════════════════════════════════╗
# ║                                                                   ║
# ║       ██╗ ██████╗ ██╗  ██╗    ██████╗  ██████╗ ████████╗███████╗  ║
# ║       ██║██╔═══██╗╚██╗██╔╝    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝  ║
# ║       ██║██║   ██║ ╚███╔╝     ██║  ██║██║   ██║   ██║   ███████╗  ║
# ║  ██   ██║██║   ██║ ██╔██╗     ██║  ██║██║   ██║   ██║   ╚════██║  ║
# ║  ╚█████╔╝╚██████╔╝██╔╝ ██╗    ██████╔╝╚██████╔╝   ██║   ███████║  ║
# ║   ╚════╝  ╚═════╝ ╚═╝  ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝  ║
# ║                                                                   ║
# ║      The Ultimate Arch Linux Setup for Windows Dual Booters       ║
# ║                 Niri · Noctalia · Keyd · Ydotool                  ║
# ║                                                                   ║
# ║                 Created by: John Varghese (J0X)                   ║
# ║                  LinkedIn: /in/John--Varghese/                    ║
# ║                  GitHub: John-Varghese-EH                         ║
# ║                                                                   ║
# ╚═══════════════════════════════════════════════════════════════════╝
#
# USAGE:
#   ./install.sh                     Interactive guided installation
#   ./install.sh --all               Install everything non-interactively
#   ./install.sh --only-keyd         Install only keyboard remapping
#   ./install.sh --install-deps      Also install optional dependencies
#   ./install.sh --dry-run           Preview changes without applying
#   ./install.sh --uninstall         Remove symlinks and restore backups
#   ./install.sh -h | --help         Show full help
#
# REQUIREMENTS: Arch Linux / CachyOS · Niri compositor · Wayland session
# LICENSE: GPL-3.0 — See LICENSE file for details.

set -Euo pipefail

# ─────────────────────── Terminal Auto-Launcher ────────────────
if [[ ! -t 1 ]]; then
    for term in foot kitty alacritty wezterm gnome-terminal konsole xterm; do
        if command -v "$term" >/dev/null 2>&1; then
            exec "$term" -e "$0" "$@"
        fi
    done
    echo "Error: No terminal emulator found. Please run this script in a terminal." >&2
    exit 1
fi

# ─────────────────────── Error Handling ──────────────────────
FAILED_CMDS=()
trap 'FAILED_CMDS+=("Line $LINENO: $BASH_COMMAND"); ((ERRORS++)) || true' ERR

# ─────────────────────── Constants ───────────────────────

readonly VERSION="2.0.0"
SCRIPT_NAME="$(basename "$0")"; readonly SCRIPT_NAME
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; readonly DOTFILES_DIR
BACKUP_DIR="$HOME/.local/share/j0x-dotfiles-backups/$(date +%Y%m%d-%H%M%S)"; readonly BACKUP_DIR
LOG_FILE="/tmp/j0x-dotfiles-install-$(date +%Y%m%d-%H%M%S).log"; readonly LOG_FILE

# ─────────────────────── Color Palette ───────────────────────

# shellcheck disable=SC2034
if [[ -t 1 ]]; then
    readonly RESET='\033[0m'
    readonly BOLD='\033[1m'
    readonly DIM='\033[2m'
    readonly ITALIC='\033[3m'
    readonly UNDERLINE='\033[4m'
    readonly RED='\033[38;5;196m'
    readonly GREEN='\033[38;5;82m'
    readonly YELLOW='\033[38;5;220m'
    readonly BLUE='\033[38;5;39m'
    readonly MAGENTA='\033[38;5;135m'
    readonly CYAN='\033[38;5;87m'
    readonly WHITE='\033[38;5;255m'
    readonly GRAY='\033[38;5;245m'
    readonly ORANGE='\033[38;5;208m'
    readonly BG_RED='\033[48;5;196m'
    readonly BG_GREEN='\033[48;5;22m'
    readonly BG_BLUE='\033[48;5;24m'
    readonly BG_YELLOW='\033[48;5;58m'
else
    readonly RESET='' BOLD='' DIM='' ITALIC='' UNDERLINE=''
    readonly RED='' GREEN='' YELLOW='' BLUE='' MAGENTA='' CYAN='' WHITE='' GRAY='' ORANGE=''
    readonly BG_RED='' BG_GREEN='' BG_BLUE='' BG_YELLOW=''
fi

# ─────────────────────── Default Configuration ───────────────────────

TERMINAL="${TERMINAL:-alacritty}"
BROWSER="${BROWSER:-brave}"
FILE_MANAGER="${FILE_MANAGER:-nautilus}"

INSTALL_NIRI=true
INSTALL_NOCTALIA=true
INSTALL_KEYD=true
NON_INTERACTIVE=false
DRY_RUN=false
INSTALL_DEPS=false
UNINSTALL=false
VERBOSE=false
SKIP_CHECKS=false

# Track state
WARNINGS=0
ERRORS=0
CHANGES=0

# ─────────────────────── Logging ───────────────────────

log() { echo "[$(date +%H:%M:%S)] $*" >> "$LOG_FILE"; }

print_header() {
    echo ""
    echo -e "${MAGENTA}${BOLD}"
    echo "  ╔═══════════════════════════════════════════════════════════════════╗"
    echo "  ║                                                                   ║"
    echo "  ║       ██╗ ██████╗ ██╗  ██╗    ██████╗  ██████╗ ████████╗███████╗  ║"
    echo "  ║       ██║██╔═══██╗╚██╗██╔╝    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝  ║"
    echo "  ║       ██║██║   ██║ ╚███╔╝     ██║  ██║██║   ██║   ██║   ███████╗  ║"
    echo "  ║  ██   ██║██║   ██║ ██╔██╗     ██║  ██║██║   ██║   ██║   ╚════██║  ║"
    echo "  ║  ╚█████╔╝╚██████╔╝██╔╝ ██╗    ██████╔╝╚██████╔╝   ██║   ███████║  ║"
    echo "  ║   ╚════╝  ╚═════╝ ╚═╝  ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝  ║"
    echo "  ║                                                                   ║"
    echo "  ║      The Ultimate Arch Linux Setup for Windows Dual Booters       ║"
    echo "  ║                 Niri · Noctalia · Keyd · Ydotool                  ║"
    echo "  ║                                                                   ║"
    echo "  ║                 Created by: John Varghese (J0X)                   ║"
    echo "  ║                  LinkedIn: /in/John--Varghese/                    ║"
    echo "  ║                  GitHub: John-Varghese-EH                         ║"
    echo "  ║                                                                   ║"
    echo "  ╚═══════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""
}

info()    { echo -e "  ${CYAN}●${RESET} $*"; log "INFO: $*"; }
success() { echo -e "  ${GREEN}✔${RESET} $*"; log "SUCCESS: $*"; }
warn()    { echo -e "  ${YELLOW}⚠${RESET} ${YELLOW}$*${RESET}"; log "WARN: $*"; ((WARNINGS++)) || true; }
error()   { echo -e "  ${RED}✖${RESET} ${RED}$*${RESET}"; log "ERROR: $*"; ((ERRORS++)) || true; }
fatal()   { echo -e "\n  ${BG_RED}${WHITE}${BOLD} FATAL ${RESET} ${RED}$*${RESET}\n"; log "FATAL: $*"; exit 1; }
step()    { echo -e "\n  ${BLUE}${BOLD}▸ $*${RESET}"; log "STEP: $*"; }
substep() { echo -e "    ${DIM}→${RESET} $*"; log "  $*"; }
dry()     { echo -e "  ${ORANGE}[DRY-RUN]${RESET} $*"; log "DRY-RUN: $*"; }

separator() {
    echo -e "  ${DIM}─────────────────────────────────────────────────────────${RESET}"
}

# ─────────────────────── Usage ───────────────────────

usage() {
    echo -e "${BOLD}${WHITE}USAGE${RESET}"
    echo -e "  ${GREEN}$SCRIPT_NAME${RESET} [options]"
    echo ""
    echo -e "${BOLD}${WHITE}MODES${RESET}"
    echo -e "  ${CYAN}(default)${RESET}              Interactive guided installation"
    echo -e "  ${CYAN}--all${RESET}                  Install everything non-interactively"
    echo -e "  ${CYAN}--only-niri${RESET}            Install only Niri compositor config"
    echo -e "  ${CYAN}--only-noctalia${RESET}        Install only Noctalia shell config"
    echo -e "  ${CYAN}--only-keyd${RESET}            Install only Keyd key remapping"
    echo -e "  ${CYAN}--install-deps${RESET}         Also install optional packages via pacman"
    echo -e "  ${CYAN}--uninstall${RESET}            Remove symlinks and restore backups"
    echo -e "  ${CYAN}--dry-run${RESET}              Preview changes without applying anything"
    echo ""
    echo -e "${BOLD}${WHITE}CUSTOMIZATION${RESET}"
    echo -e "  ${CYAN}--terminal <cmd>${RESET}       Set terminal emulator  (default: ${DIM}$TERMINAL${RESET})"
    echo -e "  ${CYAN}--browser <cmd>${RESET}        Set web browser         (default: ${DIM}$BROWSER${RESET})"
    echo -e "  ${CYAN}--file-manager <cmd>${RESET}   Set file manager        (default: ${DIM}$FILE_MANAGER${RESET})"
    echo ""
    echo -e "${BOLD}${WHITE}FLAGS${RESET}"
    echo -e "  ${CYAN}--non-interactive${RESET}      Skip all confirmation prompts"
    echo -e "  ${CYAN}--skip-checks${RESET}          Skip environment compatibility checks"
    echo -e "  ${CYAN}--verbose${RESET}              Enable verbose output"
    echo -e "  ${CYAN}-h, --help${RESET}             Show this help message"
    echo -e "  ${CYAN}-v, --version${RESET}          Show version"
    echo ""
    echo -e "${BOLD}${WHITE}EXAMPLES${RESET}"
    echo -e "  ${DIM}# Full interactive install${RESET}"
    echo -e "  ${GREEN}./install.sh${RESET}"
    echo ""
    echo -e "  ${DIM}# Install everything + dependencies with kitty as terminal${RESET}"
    echo -e "  ${GREEN}./install.sh --all --install-deps --terminal kitty${RESET}"
    echo ""
    echo -e "  ${DIM}# Preview what would change without touching the system${RESET}"
    echo -e "  ${GREEN}./install.sh --dry-run${RESET}"
    echo ""
    echo -e "  ${DIM}# Safely remove all configs and restore originals${RESET}"
    echo -e "  ${GREEN}./install.sh --uninstall${RESET}"
}

# ─────────────────────── Argument Parsing ───────────────────────

parse_args() {
    while [[ "$#" -gt 0 ]]; do
        # shellcheck disable=SC2034
        case $1 in
            --terminal)       TERMINAL="$2"; shift ;;
            --browser)        BROWSER="$2"; shift ;;
            --file-manager)   FILE_MANAGER="$2"; shift ;;
            --only-niri)      INSTALL_NIRI=true;  INSTALL_NOCTALIA=false; INSTALL_KEYD=false ;;
            --only-noctalia)  INSTALL_NIRI=false; INSTALL_NOCTALIA=true;  INSTALL_KEYD=false ;;
            --only-keyd)      INSTALL_NIRI=false; INSTALL_NOCTALIA=false; INSTALL_KEYD=true ;;
            --all)            INSTALL_NIRI=true;  INSTALL_NOCTALIA=true;  INSTALL_KEYD=true; NON_INTERACTIVE=true ;;
            --non-interactive) NON_INTERACTIVE=true ;;
            --dry-run)        DRY_RUN=true ;;
            --install-deps)   INSTALL_DEPS=true ;;
            --uninstall)      UNINSTALL=true ;;
            --verbose)        VERBOSE=true ;;
            --skip-checks)    SKIP_CHECKS=true ;;
            -v|--version)     echo "J0X Dotfiles Installer v${VERSION}"; exit 0 ;;
            -h|--help)        usage; exit 0 ;;
            *)                error "Unknown option: $1"; echo ""; usage; exit 1 ;;
        esac
        shift
    done
}

# ─────────────────────── Utility Functions ───────────────────────

command_exists() { command -v "$1" &>/dev/null; }

confirm() {
    local prompt="$1"
    local default="${2:-n}"
    if [[ "$NON_INTERACTIVE" == true ]]; then return 0; fi
    local yn_hint="y/N"
    [[ "$default" == "y" ]] && yn_hint="Y/n"
    echo -ne "  ${CYAN}?${RESET} ${prompt} [${yn_hint}]: "
    read -r -n 1 reply
    echo ""
    reply="${reply:-$default}"
    [[ "$reply" =~ ^[Yy]$ ]]
}

choose_one() {
    local prompt="$1"; shift
    local options=("$@")
    echo -e "\n  ${CYAN}?${RESET} ${prompt}"
    for i in "${!options[@]}"; do
        echo -e "    ${BOLD}$((i+1)))${RESET} ${options[$i]}"
    done
    echo -ne "  ${DIM}Selection [1-${#options[@]}]:${RESET} "
    read -r choice
    echo "$choice"
}

spinner() {
    local pid=$1
    local msg="${2:-Working}"
    local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        echo -ne "\r  ${MAGENTA}${frames[$i]}${RESET} ${msg}..."
        i=$(( (i + 1) % ${#frames[@]} ))
        sleep 0.08
    done
    wait "$pid" 2>/dev/null
    local exit_code=$?
    echo -ne "\r\033[K"
    return $exit_code
}

# ─────────────────────── Safety Checks ───────────────────────

check_environment() {
    step "Running Environment Checks"

    # ── Check OS ──
    if [[ -f /etc/os-release ]]; then
        # shellcheck source=/dev/null
        source /etc/os-release
        if [[ "${ID_LIKE:-$ID}" == *arch* || "${ID:-}" == *cachyos* || "${ID:-}" == *arch* ]]; then
            success "Detected: ${BOLD}${NAME:-Arch Linux}${RESET} (Arch-based)"
        else
            warn "Detected: ${NAME:-Unknown OS} — This setup is designed for Arch Linux / CachyOS."
            warn "Some features (pacman packages, keyd, ydotool) may not work correctly."
            if ! confirm "Continue anyway?"; then
                fatal "Installation aborted. This setup requires an Arch-based distribution."
            fi
        fi
    else
        warn "Could not detect OS. Proceeding with caution."
    fi

    # ── Check Display Server ──
    if [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
        success "Display Server: ${BOLD}Wayland${RESET}"
    elif [[ "${XDG_SESSION_TYPE:-}" == "x11" ]]; then
        warn "Display Server: X11 detected."
        warn "This setup is designed for ${BOLD}Wayland${RESET}. Niri and ydotool will NOT work on X11."
        if ! confirm "Continue anyway? (Keyd config will still work on X11)"; then
            fatal "Installation aborted. Switch to a Wayland session first."
        fi
    elif [[ -z "${XDG_SESSION_TYPE:-}" ]]; then
        warn "No display session detected (running from TTY or SSH?)."
        warn "Configs will be linked but may not take effect until a Wayland session starts."
    fi

    # ── Check Compositor ──
    if command_exists niri; then
        local niri_ver
        niri_ver=$(niri --version 2>/dev/null | head -1 || echo "unknown")
        success "Compositor: ${BOLD}Niri${RESET} ($niri_ver)"
    else
        warn "Niri compositor is ${BOLD}NOT installed${RESET}."
        warn "The Niri configs will be linked, but they won't function without Niri."
        echo ""
        echo -e "  ${DIM}  Install Niri:${RESET}"
        echo -e "  ${DIM}    Arch:    sudo pacman -S niri${RESET}"
        echo -e "  ${DIM}    CachyOS: sudo pacman -S niri (pre-packaged)${RESET}"
        echo ""
        if [[ "$INSTALL_NIRI" == true ]] && ! confirm "Link Niri configs anyway?"; then
            INSTALL_NIRI=false
            info "Skipping Niri configuration."
        fi
    fi

    # ── Check Noctalia ──
    if command_exists qs; then
        success "Shell: ${BOLD}Noctalia${RESET} (quickshell found)"
    else
        warn "Noctalia Shell (quickshell) is ${BOLD}NOT installed${RESET}."
        warn "The shell bar, launcher, and session menus will not function."
        if [[ "$INSTALL_NOCTALIA" == true ]] && ! confirm "Link Noctalia configs anyway?"; then
            INSTALL_NOCTALIA=false
            info "Skipping Noctalia configuration."
        fi
    fi

    # ── Check Keyd ──
    if command_exists keyd; then
        success "Key Remapper: ${BOLD}Keyd${RESET} (installed)"
    else
        warn "Keyd is ${BOLD}NOT installed${RESET}."
        warn "Keyboard layers (Numpad, Navigation, Mouse Control) will not work."
        echo -e "  ${DIM}  Install: sudo pacman -S keyd${RESET}"
        if [[ "$INSTALL_KEYD" == true ]] && ! confirm "Link Keyd config anyway?"; then
            INSTALL_KEYD=false
            info "Skipping Keyd configuration."
        fi
    fi

    # ── Check if running as root ──
    if [[ "$EUID" -eq 0 ]]; then
        warn "Running as ${BOLD}root${RESET}. Symlinks will be created for root's home directory."
        warn "This is typically not what you want. Run as your normal user instead."
        if ! confirm "Continue as root?"; then
            fatal "Re-run as your normal user: ./install.sh"
        fi
    fi

    separator
}

check_optional_tools() {
    step "Checking Optional Tools"

    local tools=(
        "waybar:Status bar — provides system tray and workspace indicators"
        "alacritty:GPU-accelerated terminal — bound to Ctrl+Alt+T"
        "btop:Resource monitor — bound to Ctrl+Shift+Esc (Task Manager)"
        "fuzzel:Wayland-native app launcher and dmenu replacement"
        "cliphist:Clipboard history manager — bound to Win+V"
        "wdisplays:Display configurator — bound to Win+P"
        "smile:Emoji picker — bound to Win+Period"
        "ydotool:Input automation — powers keyboard mouse control"
        "wl-copy:Wayland clipboard utility (part of wl-clipboard)"
        "brightnessctl:Screen brightness control via keybinds"
    )

    local missing=()
    for entry in "${tools[@]}"; do
        local cmd="${entry%%:*}"
        local desc="${entry#*:}"
        if command_exists "$cmd"; then
            success "${BOLD}$cmd${RESET} ${DIM}— $desc${RESET}"
        else
            warn "${BOLD}$cmd${RESET} ${DIM}— $desc${RESET} ${RED}(not found)${RESET}"
            missing+=("$cmd")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo ""
        if [[ "$INSTALL_DEPS" == true ]]; then
            info "Will attempt to install missing tools..."
        else
            if confirm "You are missing ${#missing[@]} recommended tools. Would you like to install them now?" "y"; then
                INSTALL_DEPS=true
                info "Will attempt to install missing tools..."
            else
                echo -e "  ${DIM}Tip: Re-run with ${CYAN}--install-deps${RESET}${DIM} to install missing tools automatically.${RESET}"
                echo -e "  ${DIM}Or manually: ${CYAN}sudo pacman -S ${missing[*]}${RESET}"
            fi
        fi
    else
        echo ""
        success "All recommended tools are installed!"
    fi

    separator
}

# ─────────────────────── Dependency Installation ───────────────────────

install_dependencies() {
    step "Installing Optional Dependencies"

    local packages=(
        "niri"
        "keyd"
        "waybar"
        "alacritty"
        "btop"
        "fuzzel"
        "cliphist"
        "wl-clipboard"
        "wdisplays"
        "ydotool"
        "brightnessctl"
        "nautilus"
        "polkit-kde-agent"
    )

    # Filter to only missing packages
    local to_install=()
    for pkg in "${packages[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
            to_install+=("$pkg")
        fi
    done

    if [[ ${#to_install[@]} -eq 0 ]]; then
        success "All packages are already installed!"
        return 0
    fi

    info "The following packages will be installed:"
    for pkg in "${to_install[@]}"; do
        substep "$pkg"
    done
    echo ""

    if ! confirm "Install ${#to_install[@]} packages via pacman?" "y"; then
        info "Skipping dependency installation."
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        dry "Would run: sudo pacman -S --needed --noconfirm ${to_install[*]}"
        return 0
    fi

    info "Installing packages (sudo password may be required)..."
    if sudo pacman -S --needed --noconfirm "${to_install[@]}" 2>&1 | tee -a "$LOG_FILE" >/dev/null; then
        success "All packages installed successfully!"
    else
        error "Some packages failed to install. Check log: $LOG_FILE"
    fi

    # Post-install configuration for each tool
    configure_installed_tools

    separator
}

configure_installed_tools() {
    step "Configuring Installed Tools"

    # ── Keyd ──
    if pacman -Qi keyd &>/dev/null 2>&1; then
        substep "${BOLD}keyd${RESET} — kernel-level key remapper"
        if ! systemctl is-enabled --quiet keyd 2>/dev/null; then
            info "Enabling keyd.service..."
            if sudo systemctl enable --now keyd 2>&1 | tee -a "$LOG_FILE" >/dev/null; then
                success "keyd.service enabled and started."
            else
                warn "Could not enable keyd. Run: sudo systemctl enable --now keyd"
            fi
        else
            success "keyd.service is already enabled."
        fi
    fi

    # ── Ydotool ──
    if pacman -Qi ydotool &>/dev/null 2>&1; then
        substep "${BOLD}ydotool${RESET} — input automation for mouse control"

        # Ensure user is in the input group
        if groups "$USER" | grep -qw input; then
            success "User ${BOLD}$USER${RESET} is in the 'input' group."
        else
            info "Adding $USER to the 'input' group (required for /dev/uinput)..."
            if [[ "$DRY_RUN" == true ]]; then
                dry "Would run: sudo usermod -aG input $USER"
            else
                if sudo usermod -aG input "$USER" 2>&1 | tee -a "$LOG_FILE" >/dev/null; then
                    success "Added $USER to 'input' group. ${YELLOW}Log out and back in for this to take effect.${RESET}"
                else
                    warn "Could not add user to input group."
                fi
            fi
        fi

        # Enable the user-level ydotool service
        if ! systemctl --user is-enabled --quiet ydotool 2>/dev/null; then
            info "Enabling ydotool.service (user)..."
            if systemctl --user enable --now ydotool 2>&1 | tee -a "$LOG_FILE" >/dev/null; then
                success "ydotool.service (user) enabled and started."
            else
                warn "Could not enable ydotool. Run: systemctl --user enable --now ydotool"
            fi
        else
            success "ydotool.service (user) is already enabled."
        fi
    fi

    # ── Waybar ──
    if command_exists waybar; then
        substep "${BOLD}waybar${RESET} — status bar"
        success "Waybar is installed. It will auto-start via Niri's autostart.kdl."
    fi

    # ── Cliphist ──
    if command_exists cliphist && command_exists wl-copy; then
        substep "${BOLD}cliphist${RESET} + ${BOLD}wl-clipboard${RESET} — clipboard history"
        success "Clipboard stack ready. Bound to ${DIM}Win+V${RESET} via autostart watchers."
    fi

    # ── Brightnessctl ──
    if command_exists brightnessctl; then
        substep "${BOLD}brightnessctl${RESET} — backlight control"
        # Check if user can write to backlight without sudo
        if brightnessctl get &>/dev/null 2>&1; then
            success "Brightness control works without root."
        else
            info "Adding $USER to 'video' group for backlight control..."
            if [[ "$DRY_RUN" == true ]]; then
                dry "Would run: sudo usermod -aG video $USER"
            else
                if sudo usermod -aG video "$USER" 2>&1 | tee -a "$LOG_FILE" >/dev/null; then
                    success "Added $USER to 'video' group."
                else
                    warn "Could not add user to video group."
                fi
            fi
        fi
    fi

    # ── Polkit Agent ──
    if [[ -f /usr/lib/polkit-kde-authentication-agent-1 ]]; then
        substep "${BOLD}polkit-kde-agent${RESET} — authentication prompts"
        success "Polkit agent available. Will auto-start via autostart.kdl."
    fi

    # ── Btop ──
    if command_exists btop; then
        substep "${BOLD}btop${RESET} — resource monitor"
        success "Bound to ${DIM}Ctrl+Shift+Esc${RESET} (Task Manager shortcut)."
    fi

    # ── Fuzzel ──
    if command_exists fuzzel; then
        substep "${BOLD}fuzzel${RESET} — Wayland-native dmenu/launcher"
        success "Used by clipboard history picker (${DIM}Win+V${RESET})."
    fi

    # ── Wdisplays ──
    if command_exists wdisplays; then
        substep "${BOLD}wdisplays${RESET} — display configurator"
        success "Bound to ${DIM}Win+P${RESET} (like Windows projection menu)."
    fi

    # ── Smile ──
    if command_exists smile; then
        substep "${BOLD}smile${RESET} — emoji picker"
        success "Bound to ${DIM}Win+Period${RESET}."
    fi

    # ── XDG Portal environment ──
    substep "${BOLD}XDG Desktop Portal${RESET} — app integration"
    if [[ -f /usr/lib/xdg-desktop-portal ]] || pacman -Qi xdg-desktop-portal &>/dev/null 2>&1; then
        success "Portal stack detected. Environment variables set in autostart.kdl."
    else
        warn "xdg-desktop-portal not found. File dialogs and screen sharing may not work."
        echo -e "    ${DIM}Install: sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gnome${RESET}"
    fi
}

# ─────────────────────── Core Functions ───────────────────────

link_config() {
    local source_name="$1"
    local target_parent="$2"
    local source_path="$DOTFILES_DIR/$source_name"
    local target_path
    target_path="$target_parent/$(basename "$source_name")"

    if [[ ! -e "$source_path" ]]; then
        warn "Source does not exist: $source_path — Skipping."
        return 1
    fi

    if [[ "$DRY_RUN" == true ]]; then
        dry "Would link: $source_name → $target_path"
        if [[ -e "$target_path" || -L "$target_path" ]]; then
            dry "Would backup existing: $target_path → $BACKUP_DIR/"
        fi
        ((CHANGES++)) || true
        return 0
    fi

    mkdir -p "$target_parent"
    mkdir -p "$BACKUP_DIR"

    if [[ -e "$target_path" || -L "$target_path" ]]; then
        local backup_name
        backup_name="$(basename "$target_path")"
        cp -a "$target_path" "$BACKUP_DIR/$backup_name"
        substep "Backed up: ${DIM}$target_path → $BACKUP_DIR/$backup_name${RESET}"
        rm -rf "$target_path"
    fi

    ln -s "$source_path" "$target_path"
    success "Linked: ${BOLD}$source_name${RESET} → ${DIM}$target_path${RESET}"
    ((CHANGES++)) || true
}

customize_configs() {
    step "Applying App Customizations"

    info "Terminal: ${BOLD}$TERMINAL${RESET}"
    info "Browser:  ${BOLD}$BROWSER${RESET}"
    info "Files:    ${BOLD}$FILE_MANAGER${RESET}"

    if [[ "$DRY_RUN" == true ]]; then
        dry "Would replace app references in .kdl files"
        return 0
    fi

    # Work on a temporary copy so the repo stays clean
    local temp_niri
    temp_niri=$(mktemp -d)
    cp -a "$DOTFILES_DIR/niri" "$temp_niri/"

    # Replace application commands
    find "$temp_niri/niri" -type f -name "*.kdl" -exec sed -i \
        -e "s/spawn \"alacritty\"/spawn \"$TERMINAL\"/g" \
        -e "s/spawn \"brave\"/spawn \"$BROWSER\"/g" \
        -e "s/spawn \"helium\"/spawn \"$BROWSER\"/g" \
        -e "s/spawn \"nautilus\"/spawn \"$FILE_MANAGER\"/g" \
        -e "s/Terminal: alacritty/Terminal: $TERMINAL/g" \
        -e "s/Terminal (Alacritty)/Terminal ($TERMINAL)/g" \
        -e "s/Browser: helium/Browser: $BROWSER/g" \
        -e "s/Browser: brave/Browser: $BROWSER/g" \
        -e "s/Manager: nautilus/Manager: $FILE_MANAGER/g" \
        -e "s/File Explorer (Nautilus)/File Explorer ($FILE_MANAGER)/g" \
        {} +

    # Copy customized version to actual niri dir
    cp -a "$temp_niri/niri"/* "$DOTFILES_DIR/niri/"
    rm -rf "$temp_niri"

    success "App references updated in configuration files."
    separator
}

install_niri() {
    step "Installing Niri Configuration"
    substep "Target: ${DIM}~/.config/niri/${RESET}"
    link_config "niri" "$HOME/.config"
    
    if command_exists niri; then
        substep "Validating Niri config..."
        echo ""
        if niri validate -c "$HOME/.config/niri/config.kdl"; then
            success "Niri config is valid!"
        else
            warn "Niri config validation failed! Please check syntax."
        fi
        echo ""
    fi
}

install_noctalia() {
    step "Installing Noctalia Shell Configuration"
    substep "Target: ${DIM}~/.config/noctalia/${RESET}"
    link_config "noctalia" "$HOME/.config"
}

install_keyd() {
    step "Installing Keyd Configuration"
    substep "Target: ${DIM}/etc/keyd/default.conf${RESET}"

    if [[ "$DRY_RUN" == true ]]; then
        dry "Would copy keyd/default.conf → /etc/keyd/default.conf (requires sudo)"
        dry "Would restart keyd service"
        ((CHANGES++)) || true
        return 0
    fi

    if [[ "$EUID" -ne 0 ]]; then
        if ! confirm "Keyd requires root to install to /etc/keyd. Use sudo?" "y"; then
            info "Skipping Keyd. You can manually copy:"
            echo -e "    ${DIM}sudo cp $DOTFILES_DIR/keyd/default.conf /etc/keyd/default.conf${RESET}"
            return 0
        fi
    fi

    sudo mkdir -p /etc/keyd

    # Backup existing keyd config
    if [[ -f /etc/keyd/default.conf ]]; then
        mkdir -p "$BACKUP_DIR"
        sudo cp /etc/keyd/default.conf "$BACKUP_DIR/keyd-default.conf"
        substep "Backed up existing keyd config → ${DIM}$BACKUP_DIR/keyd-default.conf${RESET}"
    fi

    # Ask user to customize text macros before installing
    configure_text_macros

    sudo cp "$DOTFILES_DIR/keyd/default.conf" /etc/keyd/default.conf
    success "Installed keyd config → ${DIM}/etc/keyd/default.conf${RESET}"
    ((CHANGES++)) || true

    # Restart keyd if running
    if systemctl is-active --quiet keyd 2>/dev/null; then
        substep "Restarting keyd service..."
        if sudo systemctl restart keyd; then
            success "Keyd service restarted."
        else
            warn "Failed to restart keyd."
        fi
    else
        warn "Keyd service is not running. Enable it with: ${BOLD}sudo systemctl enable --now keyd${RESET}"
    fi
}

# ─────────────────────── Text Macro Wizard ───────────────────────

configure_text_macros() {
    if [[ "$NON_INTERACTIVE" == true ]]; then return 0; fi

    separator
    echo ""
    echo -e "  ${BOLD}${WHITE}⌨️  Text Expansion Macros${RESET}"
    echo -e "  ${DIM}Keyd can instantly type text snippets when you press RightAlt + a key.${RESET}"
    echo -e "  ${DIM}This is perfect for emails, URLs, signatures, or any text you type often.${RESET}"
    echo ""
    echo -e "  ${BOLD}Current macro slots:${RESET}"
    echo -e "    ${CYAN}RightAlt + 1${RESET}  →  Email address"
    echo -e "    ${CYAN}RightAlt + 2${RESET}  →  GitHub URL"
    echo -e "    ${CYAN}RightAlt + 3${RESET}  →  LinkedIn URL"
    echo -e "    ${CYAN}RightAlt + 4${RESET}  →  (empty — available)"
    echo -e "    ${CYAN}RightAlt + 5${RESET}  →  (empty — available)"
    echo ""

    if ! confirm "Would you like to customize your text macros?" "y"; then
        info "Keeping default placeholder macros."
        return 0
    fi

    echo ""
    echo -e "  ${DIM}Type the text you want each shortcut to produce.${RESET}"
    echo -e "  ${DIM}Press Enter to skip a slot (keeps the default or leaves empty).${RESET}"
    echo ""

    local macro_1="" macro_2="" macro_3="" macro_4="" macro_5=""

    echo -ne "  ${CYAN}RightAlt + 1${RESET} (Email)     : "
    read -r macro_1

    echo -ne "  ${CYAN}RightAlt + 2${RESET} (GitHub)    : "
    read -r macro_2

    echo -ne "  ${CYAN}RightAlt + 3${RESET} (LinkedIn)  : "
    read -r macro_3

    echo -ne "  ${CYAN}RightAlt + 4${RESET} (Custom)    : "
    read -r macro_4

    echo -ne "  ${CYAN}RightAlt + 5${RESET} (Custom)    : "
    read -r macro_5

    echo ""

    local conf="$DOTFILES_DIR/keyd/default.conf"

    # Apply each non-empty macro
    if [[ -n "$macro_1" ]]; then
        sed -i "s|^1 = macro(.*)|1 = macro($macro_1)|" "$conf"
        success "Slot 1 → ${DIM}$macro_1${RESET}"
    fi
    if [[ -n "$macro_2" ]]; then
        sed -i "s|^2 = macro(.*)|2 = macro($macro_2)|" "$conf"
        success "Slot 2 → ${DIM}$macro_2${RESET}"
    fi
    if [[ -n "$macro_3" ]]; then
        sed -i "s|^3 = macro(.*)|3 = macro($macro_3)|" "$conf"
        success "Slot 3 → ${DIM}$macro_3${RESET}"
    fi
    if [[ -n "$macro_4" ]]; then
        # Append new macro line if slot 4 doesn't exist
        if grep -q '^4 = macro(' "$conf"; then
            sed -i "s|^4 = macro(.*)|4 = macro($macro_4)|" "$conf"
        else
            sed -i "/^3 = macro(/a 4 = macro($macro_4)" "$conf"
        fi
        success "Slot 4 → ${DIM}$macro_4${RESET}"
    fi
    if [[ -n "$macro_5" ]]; then
        # Append new macro line if slot 5 doesn't exist
        if grep -q '^5 = macro(' "$conf"; then
            sed -i "s|^5 = macro(.*)|5 = macro($macro_5)|" "$conf"
        else
            # Insert after slot 4 if it exists, otherwise after slot 3
            if grep -q '^4 = macro(' "$conf"; then
                sed -i "/^4 = macro(/a 5 = macro($macro_5)" "$conf"
            else
                sed -i "/^3 = macro(/a 5 = macro($macro_5)" "$conf"
            fi
        fi
        success "Slot 5 → ${DIM}$macro_5${RESET}"
    fi

    echo ""
    info "Text macros configured! They will activate the moment keyd restarts."
    separator
}

# ─────────────────────── Uninstall ───────────────────────

do_uninstall() {
    step "Uninstalling J0X Dotfiles"
    warn "This will remove symlinks and attempt to restore backups."

    local targets=(
        "$HOME/.config/niri"
        "$HOME/.config/noctalia"
    )

    for target in "${targets[@]}"; do
        if [[ -L "$target" ]]; then
            local link_dest
            link_dest=$(readlink -f "$target")
            if [[ "$link_dest" == "$DOTFILES_DIR"* ]]; then
                if [[ "$DRY_RUN" == true ]]; then
                    dry "Would remove symlink: $target"
                else
                    rm "$target"
                    success "Removed symlink: $target"
                fi
            else
                info "Skipping $target (not pointing to our dotfiles)"
            fi
        elif [[ -e "$target" ]]; then
            info "Skipping $target (not a symlink — manual config)"
        else
            info "$target does not exist."
        fi
    done

    # Keyd
    if [[ -f /etc/keyd/default.conf ]]; then
        if confirm "Remove keyd config from /etc/keyd/default.conf?" "n"; then
            if [[ "$DRY_RUN" == true ]]; then
                dry "Would remove /etc/keyd/default.conf"
            else
                sudo rm /etc/keyd/default.conf
                success "Removed keyd config."
            fi
        fi
    fi

    # Restore backups
    local backup_base="$HOME/.local/share/j0x-dotfiles-backups"
    if [[ -d "$backup_base" ]]; then
        local latest_backup
        # shellcheck disable=SC2012
        latest_backup=$(ls -1d "$backup_base"/*/ 2>/dev/null | tail -1)
        if [[ -n "$latest_backup" ]]; then
            info "Latest backup found: ${DIM}$latest_backup${RESET}"
            if confirm "Restore configs from this backup?" "n"; then
                for item in "$latest_backup"/*; do
                    local name
                    name=$(basename "$item")
                    if [[ "$name" == "keyd-default.conf" ]]; then
                        sudo cp "$item" /etc/keyd/default.conf && success "Restored keyd config."
                    else
                        cp -a "$item" "$HOME/.config/$name" && success "Restored $name."
                    fi
                done
            fi
        fi
    fi

    separator
}

# ─────────────────────── Interactive Menu ───────────────────────

interactive_menu() {
    echo -e "  ${BOLD}${WHITE}What would you like to install?${RESET}"
    echo ""
    echo -e "    ${BOLD}1)${RESET}  ${GREEN}Everything${RESET}        ${DIM}Niri + Noctalia + Keyd (Recommended)${RESET}"
    echo -e "    ${BOLD}2)${RESET}  Niri Only         ${DIM}Compositor configuration${RESET}"
    echo -e "    ${BOLD}3)${RESET}  Noctalia Only      ${DIM}Shell bar and launcher${RESET}"
    echo -e "    ${BOLD}4)${RESET}  Keyd Only          ${DIM}Keyboard layers and remapping${RESET}"
    echo -e "    ${BOLD}5)${RESET}  Niri + Keyd        ${DIM}Compositor + keyboard (no shell)${RESET}"
    echo -e "    ${BOLD}6)${RESET}  ${YELLOW}Custom${RESET}            ${DIM}Choose individual components${RESET}"
    echo ""
    echo -ne "  ${DIM}Selection [1-6, default=1]:${RESET} "
    read -r choice
    choice="${choice:-1}"

    case $choice in
        1) ;; # defaults are all true
        2) INSTALL_NOCTALIA=false; INSTALL_KEYD=false ;;
        3) INSTALL_NIRI=false; INSTALL_KEYD=false ;;
        4) INSTALL_NIRI=false; INSTALL_NOCTALIA=false ;;
        5) INSTALL_NOCTALIA=false ;;
        6)
            echo ""
            confirm "Install Niri configuration?" "y" && INSTALL_NIRI=true || INSTALL_NIRI=false
            confirm "Install Noctalia configuration?" "y" && INSTALL_NOCTALIA=true || INSTALL_NOCTALIA=false
            confirm "Install Keyd configuration?" "y" && INSTALL_KEYD=true || INSTALL_KEYD=false
            ;;
        *) info "Invalid selection, defaulting to Everything." ;;
    esac

    echo ""

    # App customization prompt
    if [[ "$INSTALL_NIRI" == true ]]; then
        separator
        echo ""
        echo -e "  ${BOLD}${WHITE}Customize Your Applications${RESET}"
        echo -e "  ${DIM}These apps are referenced in keybind shortcuts.${RESET}"
        echo -e "  ${DIM}Press Enter to keep the default.${RESET}"
        echo ""

        echo -ne "  Terminal ${DIM}[$TERMINAL]${RESET}: "
        read -r input; [[ -z "$input" ]] || TERMINAL="$input"

        echo -ne "  Browser  ${DIM}[$BROWSER]${RESET}: "
        read -r input; [[ -z "$input" ]] || BROWSER="$input"

        echo -ne "  File Mgr ${DIM}[$FILE_MANAGER]${RESET}: "
        read -r input; [[ -z "$input" ]] || FILE_MANAGER="$input"
    fi
}

# ─────────────────────── Summary ───────────────────────

print_summary() {
    echo ""
    step "Installation Plan"

    local items=()
    [[ "$INSTALL_NIRI" == true ]]     && items+=("Niri")
    [[ "$INSTALL_NOCTALIA" == true ]] && items+=("Noctalia")
    [[ "$INSTALL_KEYD" == true ]]     && items+=("Keyd")

    echo -e "  ${BOLD}Components:${RESET}    ${items[*]}"
    echo -e "  ${BOLD}Terminal:${RESET}       $TERMINAL"
    echo -e "  ${BOLD}Browser:${RESET}        $BROWSER"
    echo -e "  ${BOLD}File Manager:${RESET}   $FILE_MANAGER"
    [[ "$INSTALL_DEPS" == true ]] && echo -e "  ${BOLD}Dependencies:${RESET}   ${GREEN}Will install missing packages${RESET}"
    echo -e "  ${BOLD}Backup Dir:${RESET}     ${DIM}$BACKUP_DIR${RESET}"
    echo -e "  ${BOLD}Log File:${RESET}       ${DIM}$LOG_FILE${RESET}"
    [[ "$DRY_RUN" == true ]] && echo -e "  ${BOLD}Mode:${RESET}           ${ORANGE}DRY RUN (no changes will be made)${RESET}"
    echo ""
}

print_results() {
    echo ""
    separator
    echo ""

    if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${ORANGE}${BOLD}DRY RUN COMPLETE${RESET}"
        echo -e "  ${DIM}$CHANGES change(s) would be made. Re-run without --dry-run to apply.${RESET}"
    elif [[ $ERRORS -gt 0 ]]; then
        echo -e "  ${RED}${BOLD}⚠ Installation completed with $ERRORS error(s)${RESET}"
        if [[ ${#FAILED_CMDS[@]} -gt 0 ]]; then
            echo -e "  ${RED}Failed Commands:${RESET}"
            for cmd in "${FAILED_CMDS[@]}"; do
                echo -e "    ${DIM}• $cmd${RESET}"
            done
        fi
    else
        echo -e "  ${GREEN}${BOLD}🎉 Installation Complete!${RESET}"
    fi

    echo ""
    [[ $WARNINGS -gt 0 ]] && echo -e "  ${YELLOW}$WARNINGS warning(s)${RESET} — review output above"
    echo -e "  ${DIM}$CHANGES file(s) changed${RESET}"
    echo -e "  ${DIM}Backups saved to: $BACKUP_DIR${RESET}"
    echo -e "  ${DIM}Full log: $LOG_FILE${RESET}"
    echo ""

    if [[ "$DRY_RUN" != true && $ERRORS -eq 0 ]]; then
        separator
        echo ""
        echo -e "  ${BOLD}${WHITE}🚀 Next Steps${RESET}"
        echo ""
        if [[ "$INSTALL_KEYD" == true ]]; then
            echo -e "    ${CYAN}1.${RESET} Restart keyd:     ${DIM}sudo systemctl restart keyd${RESET}"
        fi
        if [[ "$INSTALL_NIRI" == true ]]; then
            echo -e "    ${CYAN}2.${RESET} Reload Niri:      ${DIM}Press Mod+Shift+W or log out and back in${RESET}"
        fi
        echo -e "    ${CYAN}3.${RESET} Test shortcuts:   ${DIM}Try Win+E, Alt+F4, RightAlt+WASD${RESET}"
        echo ""
        echo -e "  ${BOLD}${WHITE}📖 Quick Reference${RESET}"
        echo -e "    ${DIM}Win+E${RESET}              File Explorer"
        echo -e "    ${DIM}Win+R / Alt+Space${RESET}  App Launcher"
        echo -e "    ${DIM}Alt+F4${RESET}             Close Window"
        echo -e "    ${DIM}Ctrl+Shift+Esc${RESET}     Task Manager"
        echo -e "    ${DIM}RightAlt+WASD${RESET}      Arrow Keys"
        echo -e "    ${DIM}RightAlt+UIOJKL${RESET}    Numpad Layer"
        echo -e "    ${DIM}RightAlt+1/2/3${RESET}     Text Expansion Macros"
        echo -e "    ${DIM}CapsLock${RESET}           Escape (tap) / Ctrl (hold)"
        echo ""
        echo -e "  ${BOLD}${WHITE}🔧 Configured Tools${RESET}"
        [[ "$INSTALL_KEYD" == true ]] && echo -e "    ${GREEN}●${RESET} keyd           ${DIM}Keyboard remapping active${RESET}"
        command_exists ydotool && echo -e "    ${GREEN}●${RESET} ydotool        ${DIM}Mouse control via RightAlt+Shift+WASD${RESET}"
        command_exists waybar && echo -e "    ${GREEN}●${RESET} waybar         ${DIM}Status bar auto-starts with Niri${RESET}"
        command_exists cliphist && echo -e "    ${GREEN}●${RESET} cliphist       ${DIM}Clipboard history on Win+V${RESET}"
        command_exists btop && echo -e "    ${GREEN}●${RESET} btop           ${DIM}Task Manager on Ctrl+Shift+Esc${RESET}"
        command_exists brightnessctl && echo -e "    ${GREEN}●${RESET} brightnessctl  ${DIM}Brightness keys active${RESET}"
        echo ""
        echo -e "  ${DIM}Full keybind reference: ${UNDERLINE}https://github.com/John-Varghese-EH/My-Arch-Setup-Configs/blob/main/KEYBINDS.md${RESET}"
    fi

    echo ""
}

# ─────────────────────── Main ───────────────────────

main() {
    parse_args "$@"

    print_header

    log "=== J0X Dotfiles Installer v${VERSION} ==="
    log "Started at $(date)"
    log "DOTFILES_DIR=$DOTFILES_DIR"

    # ── Uninstall Mode ──
    if [[ "$UNINSTALL" == true ]]; then
        do_uninstall
        print_results
        exit 0
    fi

    # ── Environment Checks ──
    if [[ "$SKIP_CHECKS" != true ]]; then
        check_environment
        check_optional_tools
    fi

    # ── Install Dependencies ──
    if [[ "$INSTALL_DEPS" == true ]]; then
        install_dependencies
    fi

    # ── Interactive Menu ──
    if [[ "$NON_INTERACTIVE" != true ]]; then
        interactive_menu
    fi

    # ── Pre-flight Summary ──
    print_summary

    if [[ "$NON_INTERACTIVE" != true && "$DRY_RUN" != true ]]; then
        if ! confirm "Proceed with installation?" "y"; then
            info "Installation cancelled."
            exit 0
        fi
    fi

    # ── Customize App References ──
    if [[ "$INSTALL_NIRI" == true ]]; then
        customize_configs
    fi

    # ── Install Components ──
    if [[ "$INSTALL_NIRI" == true ]]; then
        install_niri
    fi

    if [[ "$INSTALL_NOCTALIA" == true ]]; then
        install_noctalia
    fi

    if [[ "$INSTALL_KEYD" == true ]]; then
        install_keyd
    fi

    # ── Results ──
    print_results

    log "Finished at $(date) with $ERRORS error(s), $WARNINGS warning(s), $CHANGES change(s)"
}

main "$@"
