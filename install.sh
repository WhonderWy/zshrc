#! /bin/sh

echo "Upgrading System"
sudo apt update
sudo apt upgrade -y
echo "Installing usual"
sudo apt install git build-essential clang llvm python3 zsh curl wget aria2 fonts-noto direnv #etc

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

echo "Should be done now! Make sure you copy zshrc file to replace after starting up oh-my-zsh and powerlevel10k"
