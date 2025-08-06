#
# dotfiles
# zsh
# interactive customizations
#

# Settings
# import completions & prompts
autoload -Uz compinit promptinit
compinit
promptinit

# Autocomplete
# tab completion - menu select
zstyle ':completion:*' menu select
# enable colors on path completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# fuzzy suggestions while typing commands
source $HOME/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# fzf key bindings: CTRL-T for files, CTRL-R for history, ALT-C to chdir
if command -v asdf &> /dev/null && command -v fzf &> /dev/null
then
    source "$(asdf where fzf)/shell/key-bindings.zsh"
fi
# kubectl
if command -v kubectl &> /dev/null
then
    source <(kubectl completion zsh)
fi

# History
# cd without having to type cd
setopt autocd
# shared history file
setopt append_history share_history histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
# extended globbing syntax
setopt extendedglob
# expand expr in prompt
setopt PROMPT_SUBST

# Key Bindings
# vi style command editing
bindkey -v
# edit command with double-esc
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '\e' edit-command-line
# fuzzy file completion
bindkey '^T' fzf-file-widget
# fuzzy change directory
bindkey '\ec' fzf-cd-widget
# fix home and end keys
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

# Aliases
alias r=ranger
alias rc=rclone
alias g=git
alias k=kubectl
alias v=nvim
alias py=python
alias m=make
alias tf=terraform
alias d=pushd
alias D=popd
alias docker="sudo docker"
alias dc="sudo docker"
# redirect vim to neovim
alias vim=nvim
# configure less to interpret escape sequences for colored output
alias less="less -R"
# grep with color
alias grep="grep --color=auto"

# Prompt
# display current repo & branch
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:git:*' formats '%u[%b]'
# render prompt before running command
precmd() {
    vcs_info
    # style prompt using https://github.com/sainnhe/gruvbox-material palette
    PROMPT='%B%F{#d4be98}%#%f%b '
    # format: path +[branch] host(status code)
    RPROMPT='%F{#7c6f64} %(3~|%-1~/…/%1~|%2~) ${vcs_info_msg_0_} %m(%f%(?.%F{#6f8352}OK.%F{red}%?)%F{#7c6f64})%f'
}

# Colors
# syntax Highlighting
source $HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
light() {
    alacritty-themes Gruvbox-Light
}
# dark or light theme switching across alacritty terminal, nvim editor & bat pager
theme() {
    # check arguments
    USAGE="Usage: theme <light|dark>"
    if [ $# -lt 1 ] || [ $1 != "light" -a $1 != "dark" ]
    then
        echo "Error: Invalid arguments: $*"
        echo "$USAGE"
        return
    fi

    # alacritty terminal
    alacritty-themes Gruvbox-$(printf $1 | sed -e 's/.*/\u&/')
    # nvim editor: has to be manually reloaded
    sed -i -e "/^vim.o.background =/s/\".*\"/\"$1\"/" ~/.config/nvim/init.lua
    # bat pager
    sed -i -e "/^export BAT_THEME=/s/gruvbox-.*/gruvbox-$1/" ~/.zshenv
    source ~/.zshenv
}

# Tooling
# z jump Tool
source $HOME/.local/share/zsh/site-functions/zsh-z.plugin.zsh
# direnv
eval "$(direnv hook zsh)"
# silence verbose log output from direnv 
export DIRENV_LOG_FORMAT=""
