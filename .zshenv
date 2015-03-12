export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export EDITOR=vim
export LSCOLORS=Gxfxcxdxbxegedabagacad
export VIRTUAL_ENV_DISABLE_PROMPT=true

[[ -s "/etc/profile.d/autojump.zsh" ]] && source "/etc/profile.d/autojump.zsh"
eval $(keychain --eval --quiet --quick --noask --agents ssh id_rsa)
