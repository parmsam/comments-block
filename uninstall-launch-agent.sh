#!/bin/bash
# Removes the Comments Block LaunchAgent and stops the background process.

PLIST_DEST="$HOME/Library/LaunchAgents/com.parmsam.comments-block-register.plist"

if [ ! -f "$PLIST_DEST" ]; then
  echo "LaunchAgent not found — already uninstalled."
  exit 0
fi

launchctl unload "$PLIST_DEST"
rm "$PLIST_DEST"

echo "LaunchAgent removed. Comments Block.app will no longer run in the background."
echo "You can still re-register manually with: ./reregister-safari-extension.sh"
