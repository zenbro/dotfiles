alias vi='vim'
alias sy='systemctl'
alias ls='ls --color=auto'
alias ll='ls --color=auto -GFhl'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ra='ranger'
alias ya='xmodmap -e "keycode 135 = z Z Cyrillic_ya Cyrillic_YA"'
alias update_node_bin='n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local'
alias git='LANG=en_US.UTF-8 git'
alias gitc='git add . && git commit'
alias gita='git add . && git commit --amend'
alias gitd='git diff HEAD~'
alias github="git config --local user.name 'zenbro'; git config --local user.email 'capybarov@gmail.com'"

alias lg='nocorrect lg'
alias vlog='vim +"normal G" <(journalctl --merge -b --no-pager)'
alias vimprove='vim +Goyo $HOME/Dropbox/notes/improve.txt'
alias pacaur4="pacaur --domain aur4.archlinux.org"
