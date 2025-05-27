#!/bin/bash
set -euo pipefail

echo "🔍 Detecting Linux distribution..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID=${ID,,}
else
    echo "❌ Could not detect OS."
    exit 1
fi

echo "✅ Detected: $DISTRO_ID"

PKG_FAIL_LOG="$HOME/package_install_failures.txt"
PIP_FAIL_LOG="$HOME/PIP_INSTALL_FAIL.txt"
: > "$PKG_FAIL_LOG"
: > "$PIP_FAIL_LOG"

# Set install commands and naming conventions
case "$DISTRO_ID" in
    ubuntu|debian)
        PKG_MGR="apt"
        INSTALL_CMD="sudo apt install -y"
        UPDATE_CMD="sudo apt update && sudo apt upgrade -y"
        PKG_PREFIX="python3-"
        ;;
    fedora|rhel|centos)
        PKG_MGR="dnf"
        INSTALL_CMD="sudo dnf install -y"
        UPDATE_CMD="sudo dnf upgrade -y"
        PKG_PREFIX="python3-"
        ;;
    arch|manjaro)
        PKG_MGR="pacman"
        INSTALL_CMD="sudo pacman -S --noconfirm"
        UPDATE_CMD="sudo pacman -Syuu --noconfirm"
        PKG_PREFIX="python-"
        ;;
    *)
        echo "❌ Unsupported distribution: $DISTRO_ID"
        exit 1
        ;;
esac

echo "⬆️ Updating system..."
$UPDATE_CMD

echo "📦 Installing base packages..."

case "$DISTRO_ID" in
    ubuntu|debian)
        $INSTALL_CMD git build-essential clang llvm clangd clang-format lld python3 python3-pip zsh curl wget aria2 fonts-noto direnv fastfetch valgrind openssh socat qemu qbittorrent mpv aircrack-ng cmake hashcat openssh-server ffmpeg firefox yt-dlp x264 x265 vlc texlive aegisub imagemagick asciinema || echo "Warning: Some packages failed to install."
        ;;
    fedora|rhel|centos)
        $INSTALL_CMD @development-tools clang llvm python3 python3-pip zsh curl wget aria2 google-noto-sans-fonts direnv valgrind openssh qemu qbittorrent mpv aircrack-ng cmake hashcat openssh-server ffmpeg firefox yt-dlp x264 x265 vlc texlive aegisub ImageMagick asciinema || echo "Warning: Some packages failed to install."
        ;;
    arch|manjaro)
        $INSTALL_CMD base-devel clang llvm python-pip zsh curl wget aria2 noto-fonts direnv valgrind openssh qemu qbittorrent mpv aircrack-ng cmake hashcat ffmpeg openssh firefox yt-dlp x264 x265 vlc texlive-most aegisub imagemagick asciinema || echo "Warning: Some packages failed to install."
        ;;
esac

# Paru installation for Arch
install_paru() {
    if ! command -v paru >/dev/null 2>&1; then
        echo "🛠 Paru not found. Installing paru AUR helper..."
        sudo pacman -S --needed --noconfirm base-devel git
        tempdir=$(mktemp -d)
        git clone https://aur.archlinux.org/paru.git "$tempdir/paru"
        pushd "$tempdir/paru"
        makepkg -si --noconfirm
        popd
        rm -rf "$tempdir"
    else
        echo "✅ paru is already installed."
    fi
}
[ "$PKG_MGR" = "pacman" ] && install_paru

# Install Python system packages (try to install, log fails)
PYTHON_PKGS=(
    2to3 beautifulsoup4 yt-dlp yapf rope wheel black thefuck Sublist3r six pygame pipx lxml har2requests
    Flask Flask-Cors Flask-unsign flake8 ffmpeg autopep8 argon2-cffi asciinema anitopy bitarray bleak cppman
    dnspython discord.py mariadb pandoc pillow passlib tqdm
)

echo "🐍 Installing Python system packages..."

for pkg in "${PYTHON_PKGS[@]}"; do
    full_pkg="${PKG_PREFIX}${pkg}"
    if ! $INSTALL_CMD "$full_pkg" &>/dev/null; then
        echo "❌ Failed system package: $full_pkg"
        echo "$pkg" >> "$PKG_FAIL_LOG"
    else
        echo "✅ Installed system package: $full_pkg"
    fi
done

# VSCode install unless in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    echo "ℹ️ Skipping VSCode installation in WSL."
else
    echo "💻 Installing VSCode..."

    case "$DISTRO_ID" in
        ubuntu|debian)
            wget -O /tmp/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
            sudo dpkg -i /tmp/vscode.deb || sudo apt --fix-broken install -y
            ;;
        fedora|rhel|centos)
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            sudo dnf check-update || true
            sudo dnf install -y code
            ;;
        arch|manjaro)
            paru -S --noconfirm visual-studio-code-bin || echo "Failed to install VSCode from AUR"
            ;;
    esac
fi

# Install Rust
echo "🦀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Oh My Zsh and plugins
echo "🎨 Installing Oh My Zsh and Powerlevel10k..."

export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/mroth/evalcache "$ZSH_CUSTOM/plugins/evalcache"

# Python pip install with fallback + logging
echo "🐍 Installing pip packages..."

python3 -m ensurepip --upgrade || true
python3 -m pip install --upgrade pip --user || true

PIP_CMD="python3 -m pip install --user --upgrade"

# Install pip packages from PYTHON_PKGS fail log + extras
PIP_EXTRAS=(
    2to3 beautifulsoup4 yt-dlp yapf rope wheel black thefuck Sublist3r six pygame pipx lxml har2requests
    Flask Flask-Cors Flask-unsign flake8 ffmpeg autopep8 argon2-cffi asciinema anitopy bitarray bleak cppman
    dnspython discord.py mariadb pandoc pillow passlib tqdm
)

# Combine failed + extras (remove duplicates by using associative array)
declare -A pip_pkgs_to_install=()
while IFS= read -r line; do
    pip_pkgs_to_install["$line"]=1
done < "$PKG_FAIL_LOG"

for pkg in "${PIP_EXTRAS[@]}"; do
    pip_pkgs_to_install["$pkg"]=1
done

for pkg in "${!pip_pkgs_to_install[@]}"; do
    echo "➤ pip installing $pkg ..."
    if ! $PIP_CMD "$pkg" &>/dev/null; then
        echo "❌ Failed pip install: $pkg"
        echo "$pkg" >> "$PIP_FAIL_LOG"
    else
        echo "✅ Installed: $pkg"
    fi
done

echo "📝 Pip failures (if any) logged to $PIP_FAIL_LOG"

# Setup Playlist Manager
echo "🎛 Setting up Playlist Manager..."

mkdir -p "$HOME/bin/playlist_manager"
ln -snf playnext.py "$HOME/bin/playlist_manager/playnext.py"

mkdir -p "$HOME/.local/share/kio/servicemenus"
envsubst < playlistmanager.desktop > "$HOME/.local/share/kio/servicemenus/playlistmanager.desktop"

echo "🚀 Running fastfetch..."
fastfetch

echo "✅ All done! Don’t forget to copy your .zshrc, .zshenv, and .p10k.zsh configs if needed."
