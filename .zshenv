export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export EDITOR=vim
export LSCOLORS=Gxfxcxdxbxegedabagacad
export FZF_DEFAULT_COMMAND='ag -l -g ""'

eval $(keychain --eval --quiet --quick --noask --agents ssh id_rsa)
