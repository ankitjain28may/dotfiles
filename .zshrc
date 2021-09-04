# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ankitjain/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  colorize pip python brew
  colored-man-pages
  kubectl
  docker-compose
  kube-ps1
  docker
  terraform
  timer
)

source $ZSH/oh-my-zsh.sh

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
export PATH="/usr/local/sbin:$PATH"
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

PROMPT=$PROMPT'$(kube_ps1) '
DEFAULT_USER="$(whoami)"

# Dir: current working directory
#prompt_dir() {
#  dir=$(print -P %~)
#  parentdir="$(dirname "$dir")"
#  if [[ $parentdir == '~' || $parentdir == '.' ||  $parentdir == '/' ]] then
#    prompt_segment blue $CURRENT_FG '%2~'
#  else
#    prompt_segment blue $CURRENT_FG '../%1~'
#  fi
#}

# Dir: current working directory
prompt_dir() {
  prompt_segment 39d $CURRENT_FG '%~'
}

# added by travis gem
[ -f /Users/ankitjain/.travis/travis.sh ] && source /Users/ankitjain/.travis/travis.sh

# The Fuck
eval $(thefuck --alias)

# Adding path for larahost
export NGINX_DEST="/usr/local/etc/nginx/servers/"
export NGINX_EXAMPLE_FILE="/usr/local/etc/nginx/servers/example.conf"
export AWS_PROFILE="default"
export PATH="/usr/local/sbin:/Users/ankitjain/Library/Python/3.7/bin:/usr/local/opt/mysql-client/bin:/usr/local/opt/ruby/bin:$NGINX_DEST:$NGINX_EXAMPLE_FILE:$AWS_PROFILE:${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export GOPATH=/Users/ankitjain/go
# GO issues https://github.com/golang/go/issues/36900
export CGO_CFLAGS=-mmacosx-version-min=10.11 
# Required by ruby gems
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# Alias for my office work
alias workspace="cd ~/project/workspace"
alias project="cd ~/project"
alias jump="ssh jump"
alias vishnu="cd ~/project/workspace/vishnu"
alias kontext="kubectl config use-context"
alias tf="terraform"
alias curlstatus='curl -sL -w "%{http_code} %{url_effective}\\n" -o /dev/null'
alias keti='kubectl exec -ti'
alias kpf='kubectl port-forward'

# Setting namespace
kns() {
kubectl config set-context $(kubectl config current-context) --namespace=$1
}

clone() {
git clone $1
}

# Terraform
prompt_terraform() {
  local tf=$(tf_prompt_info | awk '{print substr($0,2,length($0)-2)}')
  if [[ -n $tf  ]]; then 
    prompt_segment blue black "TF: $(tf_prompt_info | awk '{print substr($0,2,length($0)-2)}') " 
  fi
}

#AWS Profile:
# - display current AWS_PROFILE name
# - displays yellow on red if profile name contains 'production' or
#   ends in '-prod'
# - displays black on green otherwise
prompt_aws() {
  [[ -z "$AWS_PROFILE" ]] && return
  if [[ -z "$AWS_VAULT" ]];
  then
    case "$AWS_PROFILE" in
      *-prod|*production*) prompt_segment red yellow  "AWS: $AWS_PROFILE" ;;
      *) prompt_segment green black "AWS: $AWS_PROFILE" ;;
    esac
  else
    case "$AWS_VAULT" in
      *-prod|*production*) prompt_segment red yellow  "AWS: $AWS_VAULT" ;;
      *) prompt_segment green black "AWS: $AWS_VAULT" ;;
    esac
  fi
}

PROMPT='$(prompt_terraform)'$PROMPT

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
RPROMPT="%{$fg[cyan]%}[%D{%f/%m/%y}|%@]"

TIMER_FORMAT="$fg[red]/%d"

export PATH="$HOME/.tgenv/bin:$PATH"