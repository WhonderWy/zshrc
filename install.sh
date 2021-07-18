#! /bin/sh

echo "Upgrading System"
sudo apt update
sudo apt upgrade -y
echo "Installing usual"
sudo apt install -y git build-essential clang llvm python3 zsh curl wget aria2 fonts-noto direnv neofetch valgrind
sudo apt install python3-pip ffmpeg firefox youtube-dl x264 x265 vlc mpv texlive
#etc

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

cd ~

python3 -m pip install --upgrade --user pip beautifulsoup4 youtube-dl yapf rope wheel black thefuck Sublist3r six pygame pipx lxml har2requests Flask Flask-Cors Flask-unsign flake8 ffmpeg autopep8 argon2-cffi asciinema anitopy bitarray bleak

neofetch
echo "Should be done now! Make sure you copy zshrc file to replace after starting up oh-my-zsh and powerlevel10k"
