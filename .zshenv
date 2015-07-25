export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export EDITOR=nvim
export LSCOLORS=Gxfxcxdxbxegedabagacad
export FZF_DEFAULT_COMMAND='ag -l -g ""'

source /usr/share/doc/pkgfile/command-not-found.zsh

eval $(keychain --eval --quiet --quick --noask --agents ssh id_rsa)
