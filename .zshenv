export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export EDITOR=nvim
export LSCOLORS=Gxfxcxdxbxegedabagacad
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_DEFAULT_OPTS='
--color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215
'

source /usr/share/doc/pkgfile/command-not-found.zsh

eval $(keychain --eval --quiet --quick --noask --agents ssh id_rsa)
eval $(thefuck --alias)
