#!bin/zsh

if test "$(echo $(uname -s) | cut -c 1-5)" = "Linux"
then
  export PATH=$PATH:~/.linuxbrew/bin
fi
