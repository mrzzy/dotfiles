#
# dotfiles
# zsh
# interactive customizations
#

# import completions & prompts
autoload -Uz compinit promptinit
compinit
promptinit

# autocomplete
# tab completion - menu select
zstyle ':completion:*' menu select
# enable colors on path completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# fuzzy suggestions while typing commands
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# key bindings
# vi style command editing
bindkey -v
# edit command with double-esc
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '\e' edit-command-line
# ctrl-r interactive history recall
bindkey '^R' history-incremental-search-backward

# settings
# cd without having to type cd
setopt autocd
# shared history file
setopt append_history share_history histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# extended globbing syntax
setopt extendedglob


# prompt
# expand expr in prompt
setopt PROMPT_SUBST

# display current repo & brnach
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:git:*' formats '%u%r[%b]'
# render prompt before running command
precmd() {
    vcs_info
    PROMPT='%B%F{yellow}%#%f%b '
    RPROMPT='${vcs_info_msg_0_}%f %m(%(?.%F{green}OK.%F{red}%?)%f)'
}

# syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# z jump tool
source ~/.local/share/zsh/zsh-z.plugin.zsh
