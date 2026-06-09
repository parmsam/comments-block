#!/bin/bash
# Re-registers the Comments Block Safari extension after it disappears on quit.
# Note: You still need to manually re-enable "Allow Unsigned Extensions" from
# Safari's Develop menu if it was reset.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP="$SCRIPT_DIR/Comments Block/build/DerivedData/Build/Products/Debug/Comments Block.app"

if [ ! -d "$APP" ]; then
  echo "Error: App not found at: $APP"
  echo "Build the project in Xcode first."
  exit 1
fi

echo "Launching Comments Block wrapper app..."
open "$APP"

sleep 2

echo "Opening Safari Extensions preferences..."
open "x-apple.systempreferences:com.apple.preferences.extensions"

echo ""
echo "Done. If the extension still doesn't appear:"
echo "  1. Enable Safari > Develop > Allow Unsigned Extensions"
echo "  2. Check the extension checkbox in Safari > Settings > Extensions"
