#!/bin/bash

# Set number and currency formats
defaults write .GlobalPreferences AppleICUNumberSymbols -dict 0 "." 1 "," 10 "." 17 "."

defaults write -g ApplePressAndHoldEnabled -bool false

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

sudo pmset -a disablesleep 1
