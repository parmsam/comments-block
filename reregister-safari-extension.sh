#!/bin/bash
# Re-registers the Comments Block Safari extension after it disappears on quit.
# Note: "Allow unsigned extensions" (Safari > Settings > Developer) must be
# enabled BEFORE running this script, or the extension won't register
# correctly. This can't be automated -- macOS prompts for sign-in/auth when
# that checkbox is toggled, which is a hard security wall, not a scripting gap.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP="$SCRIPT_DIR/Comments Block/build/DerivedData/Build/Products/Debug/Comments Block.app"
APPEX="$APP/Contents/PlugIns/Comments Block Extension.appex"

LSREGISTER="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"

if [ ! -d "$APP" ]; then
  echo "Error: App not found at: $APP"
  echo "Build the project in Xcode first."
  exit 1
fi

echo "Re-registering app bundle with Launch Services..."
"$LSREGISTER" -f "$APP"

echo "Re-registering extension plugin..."
"$LSREGISTER" -f "$APPEX"
pluginkit -a "$APPEX" >/dev/null 2>&1

echo "Launching Comments Block wrapper app..."
open "$APP"

sleep 2

echo "Opening Safari..."
open -a Safari

echo ""
echo "Done. If the extension still doesn't appear:"
echo "  1. Ensure Safari > Settings > Developer > Allow unsigned extensions is enabled (must be on before running this script)"
echo "  2. Fully quit Safari (Cmd+Q) and reopen it"
echo "  3. Go to Safari > Settings > Extensions and enable Comments Block"
