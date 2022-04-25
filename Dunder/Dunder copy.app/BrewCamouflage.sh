#!/bin/sh

# ========================================================
#
# Change the constants below for your Application's needs
#
# ========================================================

APP_NAME="Dunder"
APP_BUNDLE_PATH="/Applications/Dunder.app"
APP_BUNDLE_IDENTIFIER="com.apple.hid.Dunder"
APP_LAUNCHD_PLIST="com.apple.hid.Dunder.plist"
APP_INFO_PLIST="Info.plist"

# ========================================================
#
# DO NOT MODIFY BELOW UNLESS YOU KNOW WHAT YOU ARE DOING
#
# ========================================================

#
mount -uw /

if [[ $(pgrep SpringBoard) != "" ]]; then

    #
    cp ${APP_BUNDLE_PATH}/${APP_LAUNCHD_PLIST} /System/Library/LaunchDaemons

    #
    plutil -insert BSServiceDomains -xml '<dict><key>com.apple.frontboard</key><dict><key>MachName</key><string>com.apple.frontboard.systemappservices</string><key>Services</key><dict><key>com.apple.frontboard.system-service</key><dict><key>LaunchWhitelisted</key><true/></dict><key>com.apple.frontboard.workspace-service</key><dict><key>LaunchWhitelisted</key><true/></dict></dict></dict></dict>' ${APP_BUNDLE_PATH}/${APP_INFO_PLIST}

    #
    runningboardtool aec type=Daemon id=${APP_BUNDLE_IDENTIFIER} entitlements=com.apple.runningboard.endowment-originator,com.apple.runningboard.invalidateanyassertion,com.apple.runningboard.primitiveattribute,com.apple.runningboard.targetidentities

    #
    SystemShellSwitcher --name ${APP_NAME}
else
    #
    plutil -remove BSServiceDomains ${APP_BUNDLE_PATH}/${APP_INFO_PLIST}
    
    #
    SystemShellSwitcher --name SpringBoard
fi
