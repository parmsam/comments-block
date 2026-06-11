#!/bin/bash
# Re-registers the Comments Block Safari extension after it disappears on quit.
# Note: "Allow Unsigned Extensions" (Safari > Develop menu) must be enabled
# BEFORE running this script, or the extension won't register correctly.

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

sleep 2

echo "Opening Safari..."
open -a Safari

echo ""
echo "Done. If the extension still doesn't appear:"
echo "  1. Ensure Safari > Develop > Allow Unsigned Extensions is enabled (must be on before running this script)"
echo "  2. Fully quit Safari (Cmd+Q) and reopen it"
echo "  3. Go to Safari > Settings > Extensions and enable Comments Block"
