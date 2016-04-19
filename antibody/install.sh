#!/bin/sh
curl -s https://raw.githubusercontent.com/getantibody/installer/master/install | bash -s
echo 'source <(antibody init)' >> ~/.zshrc
