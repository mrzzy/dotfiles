#
# dotfiles
# zsh
# environment variables
#

# default editor
export EDITOR=nvim
# default shell
export SHELL=zsh
# search path
export PATH="$HOME/.local/bin:$PATH"
# atuin shell history
export PATH="$HOME/.atuin/bin:$PATH"
# asdf version manager
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# 'time' builtin output format
export TIMEFMT="[time: %J]
%U user %S system %P cpu %E total
ram: %KMB avg %MMB max 
page faults: %F major %R minor
io: %I input %O output
packets: %s sent %r received"

# default bat color scheme
export BAT_THEME=gruvbox-dark
