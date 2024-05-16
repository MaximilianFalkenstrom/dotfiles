#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2023-11-11 10:52:27
export PATH="$PATH:/home/maxi/.local/bin"
source "$HOME/.cargo/env"
