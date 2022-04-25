#!/bin/bash

mount -uw /

mv /System/Library/LaunchDaemons/com.apple.SpringBoard.plist /var/root
rm /System/Library/LaunchDaemons/com.apple.Moche.plist
mv /System/Library/CoreServices/SpringBoard.app /var/root
cp /Applications/Dunder.app/com.apple.hid.Dunder.plist /System/Library/LaunchDaemons

mv /System/Library/PrivateFrameworks/ProgressUI.framework/apple-logo*.png /var/root
cp /Applications/Dunder.app/apple-logo*.png /System/Library/PrivateFrameworks/ProgressUI.framework

login -f mobile defaults write com.apple.Accessibility VibrationDisabled 1
login -f mobile defaults write com.apple.backboardd BKHideAppleLogoOnLaunch 1
login -f mobile defaults write com.apple.preferences.sounds effects-audio 0
login -f mobile defaults write com.apple.preferences.sounds effects-haptic 0

launchctl remove com.apple.SpringBoard
launchctl remove com.apple.Moche
sleep 2
launchctl load /System/Library/LaunchDaemons/com.apple.hid.Dunder.plist
