#!/usr/bin/env bash
brew cask install iterm2;
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
cp zshrc ~/.zshrc;
source zshrc;

echo "Installing Fonts"
cp /fonts/* ~/Library/Fonts;


echo "Installing oh-my-zsh plugins";
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

brew install zsh-syntax-highlighting;
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc




