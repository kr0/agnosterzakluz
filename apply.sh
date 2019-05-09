#!/usr/bin/env bash
echo "Install iterm2"
brew cask install iterm2;

echo "Install fonts"
brew tap homebrew/cask-fonts
while read line; do brew cask install $line; done < fonts;

echo "Install bash_it"
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --interactive

echo "Adding config to .ssh so that keys are adding automagically"
cp config ~/.ssh/config

echo "Install fancy vim"
sh <(curl https://j.mp/spf13-vim3 -L)

echo "Remember to import styles on iterm from iterm2/"
echo "App Store --> Spectacle, Amphetamine"

cp ./bash_profile ~/.bash_profile
source ~/.bash_profile;
cp ./inputrc ~/.inputrc
