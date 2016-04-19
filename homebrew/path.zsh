
#!bin/zsh

if test "$(expr substr $(uname -s) 1 5)" = "Linux"
  export PATH=$PATH:~/.linuxbrew/bin
fi
