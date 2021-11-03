#! /bin/sh

echo "Upgrading System"
sudo apt update
sudo apt upgrade -y

echo "Installing usual"
sudo apt install -y git build-essential clang llvm clangd clang-format lld python3 python3-pip zsh curl wget aria2 fonts-noto direnv neofetch valgrind openssh socat qemu qbittorrent mpv aircrack-ng cmake hashcat openssh-server
#etc
cd ~

python3 -m ensurepip --upgrade
python3 -m pip install --upgrade --user pip beautifulsoup4 youtube-dl yapf rope wheel black thefuck Sublist3r six pygame pipx lxml har2requests Flask Flask-Cors Flask-unsign flake8 ffmpeg autopep8 argon2-cffi asciinema anitopy bitarray bleak cppman


if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  echo "vscode will not be installed in WSL typically."
else
  echo "Installing vscode."
  wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ~/downloads/vscode.deb
  sudo dpkg -i ~/downloads/vscode.deb
fi

sudo apt update

echo "These may require interaction"
echo "Installing extras"
sudo apt install =y python3-pip ffmpeg firefox youtube-dl x264 x265 vlc texlive aegisub asciinema imagemagick
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing terminal themes"
# git clone https://github.com/ohmyzsh/ohmyzsh.git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/romkatv/powerlevel10k.git
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Installing extra plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
make install
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

neofetch
echo "Should be done now! Make sure you copy zshrc file to replace after starting up oh-my-zsh and powerlevel10k"
