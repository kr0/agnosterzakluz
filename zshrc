# Path to your oh-my-zsh installation.
export ZSH=/Users/lmunda/.oh-my-zsh

#setopt xtrace

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="cloud"
#ZSH_THEME="agnosterzak"
#ZSH_THEME="agnoster"
#ZSH_THEME="agnosterLuz"
#ZSH_THEME="agnosterzak_original"

#ZSH_THEME="powerlevel9k/powerlevel9k"

ZSH_THEME="agnosterzakluz"
#ZSH_THEME="ohmygit"

#ZSH_THEME="bullet-train"

#ZSH_THEME="sheeptheme"
#ZSH_THEME="candy"
#ZSH_THEME="robbyrussell"
#source ~/.oh-my-git/prompt.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo wd osx)

# User configuration

export PATH="/usr/local/Cellar:Users/lmunda/.sdkman/groovy/current/bin:/usr/local/php5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/lmunda/Library/Android/sdk/tools:/Users/lmunda/Library/Android/sdk/platform-tools"
# export MANPATH="/usr/local/man:$MANPATH"
export LC_CTYPE="en_US.UTF-8"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias gpr="git pull --rebase"

alias his="history | grep"
alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias et="atom ~/.oh-my-zsh/themes/agnosterzakluz.zsh-theme"

alias glol2="git log --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'''%Cred%h%Creset -%C(yellow)%d %Cgreen(%cd)%C(bold blue) [%an]%Creset %s %Creset'"

alias gph="git push heroku master"
alias tree="tree -FC"

alias rbc="rubocop -aDE"

alias theme="atom ~/.oh-my-zsh/themes/agnosterzakluz.zsh-theme"

alias longpressoff="defaults write -g ApplePressAndHoldEnabled -bool false"
alias longpresson="defaults write -g ApplePressAndHoldEnabled -bool true"

alias configenergia="sudo pmset -g"
alias standbyoff="sudo pmset standby 0"

export SDKMAN_DIR="/Users/lmunda/.sdkman"
[[ -s "/Users/lmunda/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/lmunda/.sdkman/bin/sdkman-init.sh"


#eval "$(rbenv init -)"

#source "$HOME/.antigen/antigen.zsh"
#antigen-use oh-my-zsh
#antigen-bundle luzma87/oh-my-git
#antigen-bundle jderusse/oh-my-git
#antigen theme arialdomartini/oh-my-git-themes oppa-lana-style
#antigen theme luzma87/oh-my-git-themes oppa-lana-style
#antigen theme arialdomartini/oh-my-git-themes arialdo-pathinline
#antigen theme arialdomartini/oh-my-git-themes arialdo-granzestyle
#antigen-apply


BULLETTRAIN_GIT_PREFIX=""
BULLETTRAIN_DIR_EXTENDED=2
BULLETTRAIN_GIT_MODIFIED=" %F{blue}✹%F{black}"

export STAGE=local

export SKIP_DM=true

export SNAP_DB_PG_JDBC_URL="jdbc:postgresql://localhost:5432/twparking_integration?user=postgres&password=postgres"
export LC_CTYPE="en_US.UTF-8"

export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
