alias ls='ls --color=auto'
alias ll='ls --color=auto -GFhl'
alias be='bundle exec'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ya='xmodmap -e "keycode 135 = z Z Cyrillic_ya Cyrillic_YA"'
alias update_node_bin='n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local'
alias github="git config --local user.name 'zenbro'; git config --local user.email 'capybarov@gmail.com'"
alias vimf="vim '+VimFilerDouble -status'"

alias lg='nocorrect lg'
