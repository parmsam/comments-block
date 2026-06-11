#!/bin/bash
# Re-registers the Comments Block Safari extension after it disappears on quit.
# Note: You still need to manually re-enable "Allow Unsigned Extensions" from
# Safari's Develop menu if it was reset.
#
# Usage:
#   ./reregister-safari-extension.sh           # re-register and open Safari
#   ./reregister-safari-extension.sh --no-safari  # re-register only (used by LaunchAgent)

OPEN_SAFARI=true
if [ "$1" = "--no-safari" ]; then
  OPEN_SAFARI=false
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP="$SCRIPT_DIR/Comments Block/build/DerivedData/Build/Products/Debug/Comments Block.app"

LSREGISTER="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"

if [ ! -d "$APP" ]; then
  echo "Error: App not found at: $APP"
  echo "Build the project in Xcode first."
  exit 1
fi

echo "Re-registering app bundle with Launch Services..."
"$LSREGISTER" -f "$APP"

echo "Re-registering extension plugin..."
"$LSREGISTER" -f "$APP/Contents/PlugIns/Comments Block Extension.appex"

echo "Launching Comments Block wrapper app..."
open "$APP"

if [ "$OPEN_SAFARI" = true ]; then
  sleep 2
  echo "Opening Safari..."
  open -a Safari
fi

echo ""
echo "Done. If the extension still doesn't appear:"
echo "  1. Fully quit Safari (Cmd+Q) and reopen it"
echo "  2. Enable Safari > Develop > Allow Unsigned Extensions"
echo "  3. Go to Safari > Settings > Extensions and enable Comments Block"
