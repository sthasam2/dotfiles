# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=${ZSH:-$HOME/.oh-my-zsh}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

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
	zoxide
	docker
	mise
	man
	poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

##################################################
###                 CUSTOM                    ###
#################################################

# BASH
export PATH=/usr/bin:/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

check_missing_commands() {
	local missing=()
	for cmd in "$@"; do
		if ! command -v "$cmd" >/dev/null 2>&1; then
			missing+=("$cmd")
		fi
	done

	if ((${#missing[@]})); then
		echo "${missing[@]}"
	fi
}

path_if_exists() {
	if [ -d "$1" ]; then
		export PATH="$1:$PATH"
	fi
}

# Aliases
alias cls=clear
alias zconf="nvim ~/.zshrc"
alias zsrc="source ~/.zshrc"
alias hs="history | fzf | sed 's/.* //' | xargs -I {} $SHELL -c '{}'"
alias jj="just"
alias nv="nvim"

# -----------------------
# |       SHELL         |
# -----------------------

# STARSHIP
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# -----------------------
# |      GIT            |
# -----------------------

alias gg=lazygit

local missing_gch=()
missing_gch=$(check_missing_commands git fzf batcat)

function gch() {
	if [ -n "$missing_gch" ]; then
		echo "Missing command(s) for 'gch': $missing"
		return 1
	fi

	selected_branch=$(git branch --all | fzf --preview "git log -n 20 {+1} | batcat" | sed 's/^* //;s|^.*origin/||;s/ *$//')
	if [ -n "$selected_branch" ]; then
		git switch "$selected_branch"
	fi
}

local missing_ghpr=()
missing_ghpr=$(check_missing_commands gh fzf awk)

function ghpr() {
	if [ -n "$missing_ghpr" ]; then
		echo "Missing command(s) for 'ghpr': $missing"
		return 1
	fi

	gh pr list | fzf --preview "gh pr view {+1}" | awk '{ print $1}' | xargs -I {} gh pr checkout {}
}

function gsfe() {
	if command -v git >/dev/null 2>&1; then
		git submodule foreach "git $*"
	else
		echo "Git is not available for gsfe."
	fi
}

function gprune() {
	if command -v git >/dev/null 2>&1; then
		git branch | grep -v -e "master" -e "main" | xargs git branch -D
	else
		echo "Git is not available for gprune."
	fi
}

# -----------------------
# |      GITHUB         |
# -----------------------

function coex() {
	if command -v gh >/dev/null 2>&1; then
		gh copilot explain "$*"
	else
		echo "GitHub CLI is not available for coex."
	fi
}

function cosu() {
	if command -v gh >/dev/null 2>&1; then
		gh copilot suggest "$*"
	else
		echo "GitHub CLI is not available for cosu."
	fi
}

# -----------------------
# |       GROOVY        |
# -----------------------

if [ -d "/opt/groovy" ]; then
	export GROOVY_HOME=/opt/groovy
	export PATH=$GROOVY_HOME/bin:$PATH
fi

# -----------------------
# |      ANDROID        |
# -----------------------

ANDROID_HOME_DEFAULT="$HOME/Android"

if [ -d "$ANDROID_HOME_DEFAULT" ]; then
	export ANDROID_HOME=$ANDROID_HOME_DEFAULT

	# Uncomment and adjust the following lines based on your Android SDK installation
	# path_if_exists "$ANDROID_HOME/cmdline-tools"
	# export ANDROID_SDK_ROOT=$ANDROID_HOME
	# path_if_exists "$ANDROID_SDK_ROOT"
	# path_if_exists "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
	# path_if_exists "$ANDROID_SDK_ROOT/platform-tools"
	# path_if_exists "$ANDROID_SDK_ROOT/emulator"
	# alias_if_exists runemu "emulator @Pixel_4_API_30"
fi

# FLUTTER
# path_if_exists "$HOME/Android/flutter/bin"

# -----------------------
# |         PYTHON      |
# -----------------------

alias py=python3

alias po=poetry
alias pos="poetry shell"

alias pym="python3 manage.py"
alias vact="source .venv/bin/activate"

# -----------------------
# |         MOJO        |
# -----------------------

MODULAR_HOME_DEFAULT="$HOME/.modular"

if [ -d "$MODULAR_HOME_DEFAULT/pkg/packages.modular.com_mojo/bin" ]; then
	export MODULAR_HOME=$MODULAR_HOME_DEFAULT
	export PATH=$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH
fi

# -----------------------
# |         GO          |
# -----------------------

## Handled by mise now

# Uncomment and set GOROOT if Go is installed in a custom location
# if [ -d "/usr/local/go" ]; then
#   export GOROOT=/usr/local/go
#   export PATH=$PATH:$GOROOT/bin
#   export GO111MODULE=off
#   export GOPATH=$HOME/.go/go
#   export PATH=$PATH:$GOPATH/bin
# fi

# -----------------------
# |         JAVA        |
# -----------------------

JAVA_HOME_DEFAULT="/usr/lib/jvm/java-8-openjdk-amd64"

if [ -d "$JAVA_HOME_DEFAULT" ]; then
	export JAVA_HOME=$JAVA_HOME_DEFAULT
	export PATH=$JAVA_HOME/bin:$PATH
fi

# -----------------------
# |         NODE        |
# -----------------------

alias pn="pnpm"
alias pnd="pnpm dlx"
alias pnr="pnpm run"
alias pnx="pnpx"

## Bun

# Uncomment if Bun is installed and paths are correct
# if [ -s "$HOME/.bun/_bun" ]; then
#   source "$HOME/.bun/_bun"
#   export BUN_INSTALL="$HOME/.bun"
#   export PATH="$BUN_INSTALL/bin:$PATH"
# fi

# -----------------------
# |      ZOXIDE         |
# -----------------------
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi

# -----------------------
# |     MINIO           |
# -----------------------
# MINIO_BIN_DEFAULT="$HOME/minio-binaries"
# if [ -d "$MINIO_BIN_DEFAULT" ]; then
#   export PATH=$PATH:$MINIO_BIN_DEFAULT
# fi
# alias mc=$MINIO_BIN_DEFAULT/mc

# -----------------------
# |     DOCKER          |
# -----------------------

alias dd="lazydocker"

alias dps="docker ps"
alias dpsa="docker ps -a"
alias dim="docker images"
alias dima="docker images -a"
alias dl="docker logs"
alias dlf="docker logs -f"
alias deit="docker container exec -it"
alias dex="docker container exec"
alias dprune="docker system prune -f && docker volume prune -f"
alias dpsf="docker ps --format '{{.Names}}:\n\tstatus: {{.Status}}\n\tports: {{.Ports}}\n'"

if command -v docker >/dev/null 2>&1; then
	function dkrm() {
		echo "Killing containers..."
		docker kill $(docker ps --format "{{.Names}}")
		echo "\nRemoving containers..."
		docker rm $(docker ps -a --format "{{.Names}}")
	}

	function kc-rmi() {
		docker images --format '{{.Repository}}:{{.Tag}}' | grep -e "k-v2" -e "konnectcraft" | xargs -I {} docker rmi {}
	}

	# export DOCKER_HOST=unix:///run/user/1000/docker.sock
	export DOCKER_CLIENT_TIMEOUT=120
	export COMPOSE_HTTP_TIMEOUT=120
fi

# -----------------------
# |         NVIM        |
# -----------------------
NVIM_BIN_DEFAULT="$HOME/.local/share/bob/nvim-bin"

if [ -d "$NVIM_BIN_DEFAULT" ]; then
	export PATH="$NVIM_BIN_DEFAULT:$PATH"
fi

# -----------------------
# |         ZELLIJ      |
# -----------------------

if command -v zellij >/dev/null 2>&1; then
	# Uncomment the following line if you want to enable auto-start
	# eval "$(zellij setup --generate-auto-start zsh)"

	function zes() {
		local session
		session=$(zellij ls -n | fzf | awk '{print $1}' | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g')
		if [ -n "$session" ]; then
			zellij attach "$session"
		else
			echo "No session selected."
		fi
	}
fi

# -----------------------
# |        MISE         |
# -----------------------

MISE_ACTIVATE_SCRIPT="$HOME/.local/bin/mise"

if [ -x "$MISE_ACTIVATE_SCRIPT" ]; then
	eval "$($MISE_ACTIVATE_SCRIPT activate zsh)"
fi

# -----------------------
# |         MISC        |
# -----------------------

# NGROK
NGROK_PATH="$HOME/Programming/ngrok"

if [ -x "$NGROK_PATH" ]; then
	alias ngrok="$NGROK_PATH"
fi

# DIRENV
if command -v direnv >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

# TMUX
# Uncomment the following lines if you want to auto-start tmux
# if [[ -z "$TMUX" ]] && command -v tmux >/dev/null 2>&1; then
#    tmux
# fi

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# For ansible locale errors
export LC_ALL=${LC_ALL:-C.UTF-8}

##############################
#       KONNECTCRAFT
##############################

# Rust environment
if [ -f "$HOME/.cargo/env" ]; then
	source "$HOME/.cargo/env"
fi
