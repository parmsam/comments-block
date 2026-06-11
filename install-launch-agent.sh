#!/bin/bash
# Installs a LaunchAgent that keeps Comments Block.app running persistently,
# so the Safari extension stays registered whenever Safari opens.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP="$SCRIPT_DIR/Comments Block/build/DerivedData/Build/Products/Debug/Comments Block.app"
APP_BINARY="$APP/Contents/MacOS/Comments Block"
APPEX="$APP/Contents/PlugIns/Comments Block Extension.appex"
PLIST_SRC="$SCRIPT_DIR/com.parmsam.comments-block-register.plist"
PLIST_DEST="$HOME/Library/LaunchAgents/com.parmsam.comments-block-register.plist"
LSREGISTER="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"

if [ ! -f "$APP_BINARY" ]; then
  echo "Error: App binary not found at: $APP_BINARY"
  echo "Build the project in Xcode first."
  exit 1
fi

echo "Registering app with Launch Services..."
"$LSREGISTER" -f "$APP"
"$LSREGISTER" -f "$APPEX"

echo "Installing LaunchAgent..."
sed "s|APP_BINARY_PLACEHOLDER|$APP_BINARY|g" "$PLIST_SRC" > "$PLIST_DEST"

launchctl unload "$PLIST_DEST" 2>/dev/null
launchctl load "$PLIST_DEST"

echo "Done. Comments Block.app will now stay running in the background."
echo "The Safari extension will be registered whenever Safari opens."
echo ""
echo "To uninstall, run: ./uninstall-launch-agent.sh"
