#
# dotfiles
# zsh
# environment variables
#

# default editor
export EDITOR=nvim
# search path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"

# 'time' builtin output format
export TIMEFMT="[time: %J]
%U user %S system %P cpu %E total
ram: %KMB avg %MMB max 
page faults: %F major %R minor
io: %I input %O output
packets: %s sent %r received"

# default bat color scheme
export BAT_THEME=gruvbox-dark
