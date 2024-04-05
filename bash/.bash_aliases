#!bin/usr/env bash


fgd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}


# alias fgd="git diff $@ --name-only | fzf -m --ansi"
