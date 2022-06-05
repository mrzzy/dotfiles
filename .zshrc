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
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# key bindings
# vi style command editing
bindkey -v
# edit command with double-esc
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '\e' edit-command-line
# ctrl-r interactive history recall
bindkey '^R' history-incremental-search-backward

## settings
# cd without having to type cd
setopt autocd
# shared history file
setopt append_history share_history histignorealldups
# extended globbing syntax
setopt extendedglob
