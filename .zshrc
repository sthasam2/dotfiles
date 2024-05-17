# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-interactive-cd
  zsh-navigation-tools
  zsh-syntax-highlighting
  autojump
  docker
  mise
  virtualenv
  man
 poetry)

source $ZSH/oh-my-zsh.sh

alias cls="clear"
alias zconf="nvim ~/.zshrc"
alias zsrc="source ~/.zshrc"
alias hs="history | fzf | sed 's/.* //' | xargs -I {} $SHELL -c '{}'"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##################################################
###                 CUSTOM                    ###
#################################################

# BASH
export PATH=/usr/bin:/bin:$PATH

alias nv=nvim 

# -----------------------
# |       SHELL         |
# -----------------------

# STARSHIP
eval "$(starship init zsh)"

# -----------------------
# |      GIT            |
# -----------------------

alias lzg=lazygit

function gch() {
  git switch $(git branch --all | fzf --preview "sed 's/^.* //;s/ .*$//' | git log -n 20 {+1} | batcat --color=always --style=numbers" | sed 's/^* //;s|^.*origin/||;s/ *$//')
}

function ghpr() {
  gh pr list | fzf --preview "gh pr view {+1}" | awk '{ print $1}' | xargs -I {} gh pr checkout {}
}

function gsfe {
  git submodule foreach "git $1"
}

function gprune {
  git branch | grep -v -e "master" -e "main" | xargs git branch -D
}

# -----------------------
# |      GITHUB         |
# -----------------------

function coex {
    gh copilot explain "$*"
}

function cosu {
    gh copilot suggest "$*"
}

# -----------------------
# |       GROOVY        |
# -----------------------

export GROOVY_HOME=/opt/groovy
export PATH=$GROOVY_HOME/bin:$PATH

# -----------------------
# |      ANDROID        |
# -----------------------

# # ANDROID
# export ANDROID_HOME=$HOME/Android
# export PATH=$ANDROID_HOME/cmdline-tools:$PATH
# 
# # ANDROID SDK
# export ANDROID_SDK_ROOT=$ANDROID_HOME
# export PATH=$ANDROID_SDK_ROOT:$PATH
# export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
# 
# #  PLATFORM TOOLS
# export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK_ROOT/platform-tools
# export PATH=$ANDROID_PLATFORM_TOOLS:$PATH
# 
# # EMULATOR
# export ANDROID_EMULATOR=$ANDROID_SDK_ROOT/emulator
# export PATH=$ANDROID_EMULATOR:$PATH
# 
# alias runemu="emulator @Pixel_4_API_30"

# FLUTTER
# export PATH=$HOME/Android/flutter/bin:$PATH

# -----------------------
# |         PYTHON      |
# -----------------------

# PYTHON
export PATH=$HOME/.local/bin:$PATH

alias py=python3
alias po=poetry
alias pym="python3 manage.py"
alias vact="source .venv/bin/activate"
alias pos="poetry shell"

# PYENV
# export PYENV_ROOT=$HOME/.pyenv
# export PATH=$PYENV_ROOT/bin:$PATH
# eval "$(pyenv init -)"

# Poetry
#   export POETRY_HOME="$HOME/.local"
#   export PATH="$POETRY_HOME/bin:$PATH"

# -----------------------
# |         MOJO        |
# -----------------------

export MODULAR_HOME=$HOME/.modular
export PATH=$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH

# -----------------------
# |         GO          |
# -----------------------

# export GOROOT=/usr/local/go
# export PATH=$PATH:$GOROOT/bin
# export GO111MODULE=off
# export GOPATH=$HOME/.go/go
# export PATH=$PATH:$GOPATH/bin

# -----------------------
# |         JAVA        |
# -----------------------

# JAVA
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# -----------------------
# |         NNN         |
# -----------------------

export NNN_PLUG='f:finder;o:fzopen;p:preview-tabbed;v:imgview'

# -----------------------
# |         NODE        |
# -----------------------

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias pn="pnpm"
alias pnd="pnpm dlx"
alias pnr="pnpm run"
alias pnx="pnpx"

# bun completions
[ -s "/home/sthasam/.bun/_bun" ] && source "/home/sthasam/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# -----------------------
# |         VOLTA       |
# -----------------------
#export VOLTA_HOME="$HOME/.volta"
#export PATH="$VOLTA_HOME/bin:$PATH"

# -----------------------
# |       AUTOJUMP      |
# -----------------------

. /usr/share/autojump/autojump.sh

# -----------------------
# |     DOCKER          |
# -----------------------
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dim="docker images"
alias dima="docker images -a"
alias dl="docker logs"
alias dlf="docker logs -f"
alias deit="docker container exec -it"
alias dkrm="docker kill $(docker ps -q); docker rm $(docker ps -a -q)"
alias dprune="docker system prune -f && docker volume prune -f"
alias dpsb="docker ps --format '{{.Names}}:\n\tstatus: {{.Status}}\n\tports: {{.Ports}}\n'"

# export DOCKER_HOST=unix:///run/user/1000/docker.sock
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120

alias lzd="lazydocker"

# -----------------------
#           CUDA        |
# -----------------------

#CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/sthasam/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
# else if [ -f "/home/sthasam/miniconda3/etc/profile.d/conda.sh" ];
#         then . "/home/sthasam/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/sthasam/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# -----------------------
# |         CONDA       |
# -----------------------
# export PATH=~/miniconda3/bin:$PATH

# -----------------------
# |         NVIM        |
# -----------------------
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# -----------------------
# |         ZELLIJ      |
# -----------------------

#   eval "$(zellij setup --generate-auto-start zsh)"

function zes(){
    zellij a $(zellij ls -n | fzf | awk '{print $1}' | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g')
}

# -----------------------
# |        MISE         |
# -----------------------

eval "$($HOME/.local/bin/mise activate zsh)"

# -----------------------
# |         MISC        |
# -----------------------

# NGROK
alias ngrok=$HOME/Programming/ngrok

# DIRENV
eval "$(direnv hook zsh)"

# TMUX
#    if [[ -z "$TMUX" ]]; then
#       tmux
#    fi

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# For ansible locale errors
export LC_ALL=C.UTF-8

PATH=~/.console-ninja/.bin:$PATH


##############################
#       KONNECTCRAFT
##############################

function kon-prune(){
    docker images --format '{{.Repository}}:{{.Tag}}' | grep -e "k-v2" -e "konnectcraft" | xargs -I {} docker rmi {}
}

