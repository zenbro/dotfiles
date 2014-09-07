export TERM=xterm-256color
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'

[[ -s "$HOME/.bin/tmuxinator.zsh" ]] && source "$HOME/.bin/tmuxinator.zsh"
[[ -s "$HOME/.autojump/etc/profile.d/autojump.zsh" ]] && source "$HOME/.autojump/etc/profile.d/autojump.zsh"
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm_silence_path_mismatch_check_flag=1
