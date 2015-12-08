#!/bin/sh
[ "$(uname -s)" = "Darwin" ] && brew cask install atom
apm install \
    editorconfig \
    atom-beautify \
    pdf-view zen markdown-preview-plus markdown-writer wordcount \
    minimap highlight-selected \
    atom-material-ui atom-material-syntax file-icons \
    save-session \
    linter || true
