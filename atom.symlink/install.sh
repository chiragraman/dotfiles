#!/bin/sh
[ "$(uname -s)" = "Darwin" ] && brew cask install atom
apm install \
    editorconfig \
    atom-beautify \
    pdf-view zen markdown-preview-plus markdown-writer wordcount \
    minimap highlight-selected minimap-highlight-selected \
    atom-material-ui atom-material-syntax file-icons \
    tool-bar tool-bar-main \
    docblockr linter \
    autocomplete-clang linter-clang switch-header-source \
    swift-debugger language-swift \
    save-session || true
