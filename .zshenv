export EDITOR=vim
export LSCOLORS=Gxfxcxdxbxegedabagacad
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

[[ -s "/etc/profile.d/autojump.zsh" ]] && source "/etc/profile.d/autojump.zsh"
PATH="`ruby -rubygems -e 'puts Gem.user_dir'`/bin:$PATH"
eval $(keychain --eval --quiet --quick --noask --agents ssh id_rsa)
