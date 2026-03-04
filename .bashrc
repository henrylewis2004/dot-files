#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
. "$HOME/.cargo/env"

export PICO_SDK_PATH=~/Documents/code/sdk/raspberrypi/pico-sdk/
export PICO_BOARD=pico2_w
