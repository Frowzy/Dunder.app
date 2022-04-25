#!/bin/bash

mount -uw /

mv /var/root/com.apple.SpringBoard.plist /System/Library/LaunchDaemons
mv /var/root/SpringBoard.app /System/Library/CoreServices
rm /System/Library/LaunchDaemons/com.apple.hid.Dunder.plist

rm /System/Library/PrivateFrameworks/ProgressUI.framework/apple-logo*.png
mv /var/root/apple-logo*.png /System/Library/PrivateFrameworks/ProgressUI.framework

login -f mobile defaults write com.apple.Accessibility VibrationDisabled 0
login -f mobile defaults write com.apple.backboardd BKHideAppleLogoOnLaunch 0
login -f mobile defaults write com.apple.preferences.sounds effects-audio 1
login -f mobile defaults write com.apple.preferences.sounds effects-haptic 1

launchctl remove com.apple.hid.Dunder
sleep 2
launchctl load /System/Library/LaunchDaemons/com.apple.SpringBoard.plist
