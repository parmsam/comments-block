# Comments Block

A Safari extension that hides YouTube comments and/or the recommendations sidebar. Toggled per-feature from the Safari toolbar.

## Requirements

- macOS 12 or later
- Safari 15 or later
- Xcode 13 or later (free from the [App Store](https://apps.apple.com/us/app/xcode/id497799835))

## Build & Install

**1. Clone the repo**

```bash
git clone https://github.com/yourname/comments-block.git
cd comments-block
```

**2. Convert the web extension to an Xcode project**

```bash
xcrun safari-web-extension-converter \
  extension \
  --app-name "Comments Block" \
  --bundle-identifier com.yourname.comments-block \
  --swift \
  --project-location . \
  --no-open
```

**3. Open the project and run it**

```bash
open "Comments Block/Comments Block.xcodeproj"
```

In Xcode, press **⌘R** to build and run. This installs a small wrapper app that hosts the extension. Keep Safari open during the build so the extension registers correctly.

**4. Allow unsigned extensions**

Safari blocks unsigned extensions by default. To enable them:

1. Open **Safari → Settings → Advanced** and check **Show Developer menu in menu bar**
2. Open the **Developer** menu and click **Allow Unsigned Extensions**
3. Open **Safari → Settings → Extensions**, enable **Comments Block**, and grant it permission for `youtube.com`

> **Note:** "Allow Unsigned Extensions" resets every time Safari restarts — re-enable it from the Developer menu each session. The extension itself stays installed and enabled; your toggle settings are also remembered. To avoid the Developer menu step entirely, sign the extension with an [Apple Developer account](https://developer.apple.com/programs/) ($99/year).

## Usage

Click the **Comments Block** icon in the Safari toolbar to toggle:

- **Hide comments** — removes the comment section below videos (on by default)
- **Hide recommendations** — removes the suggested videos sidebar (off by default)

Settings are saved per-browser and apply immediately without a page reload.
