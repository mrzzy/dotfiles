#
# dotfiles
# zsh
# interactive customizations
#

# Settings
# cd without having to type cd
setopt autocd
# shared history file
setopt append_history share_history histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# extended globbing syntax
setopt extendedglob
# expand expr in prompt
setopt PROMPT_SUBST

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
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# fzf key bindings: CTRL-T for files, CTRL-R for history, ALT-C to chdir
source /usr/local/share/fzf/key-bindings.zsh

# Key bindings
# vi style command editing
bindkey -v
# edit command with double-esc
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '\e' edit-command-line
# fuzzy history recall
bindkey '^R' fzf-history-widget
# fuzzy file completion
bindkey '^T' fzf-file-widget
# fuzzy change directory
bindkey '\ec' fzf-cd-widget

# Aliases
alias r=ranger
alias g=git

# Prompt
# display current repo & brnach
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:git:*' formats '%u%r[%b]'
# render prompt before running command
precmd() {
    vcs_info
    # style prompt using https://github.com/sainnhe/gruvbox-material palette
    PROMPT='%B%F{#d4be98}%#%f%b '
    RPROMPT='%F{#7c6f64}${vcs_info_msg_0_} %m(%f%(?.%F{#6f8352}OK.%F{red}%?)%F{#7c6f64})%f'
}

# Syntax Highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Tooling
# z jump Tool
source ~/.local/share/zsh/zsh-z.plugin.zsh

# sdkman: jvm sdk manager
export SDKMAN_DIR="/usr/local/lib/sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"
