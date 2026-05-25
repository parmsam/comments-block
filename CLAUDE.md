# CLAUDE.md

Context for AI assistants working in this repo.

## What this is

A browser extension that hides distracting YouTube UI elements (comments, recommendations, live chat, Shorts). The user toggles each feature from the browser toolbar popup. Works in Chrome, Firefox, and Safari.

## Repo structure

```
comments-block/
├── extension/           # Shared web extension source (MV3)
│   ├── manifest.json    # Works for Chrome and Firefox; browser_specific_settings.gecko for Firefox
│   ├── content.js       # Injected into youtube.com — applies CSS rules based on stored settings
│   ├── popup.html       # Toolbar popup UI (toggle switches)
│   ├── popup.js         # Reads/writes chrome.storage.sync; updates toggles in the popup
│   └── icon-*.png       # Extension icons (16, 32, 48, 128px)
├── Comments Block/      # Safari wrapper — Xcode project generated from extension/
│   └── ...              # Do NOT hand-edit; regenerate with safari-web-extension-converter if needed
├── screenshots/         # Popup screenshots used in README
├── generate_icons.py    # Generates icon-*.png from a source image
├── .gitignore
├── README.md
└── CLAUDE.md            # This file
```

## How the three browsers relate

- **Chrome and Firefox** load `extension/` directly (no build step). The `chrome.*` APIs used in the extension are supported natively in Chrome and via the `chrome` alias in Firefox.
- **Safari** wraps `extension/` in a native macOS/iOS app via `xcrun safari-web-extension-converter`. The resulting `Comments Block/` Xcode project hosts the extension. Rebuild this project when the extension source changes significantly.

## Key files

### `extension/content.js`
- Listens for `yt-navigate-finish` to reapply styles after YouTube SPA navigation — this is important; applying styles once on page load is not enough.
- Reads settings from `chrome.storage.sync` and writes a `<style>` tag with id `comments-block-styles`.
- Also listens to `chrome.storage.onChanged` so popup changes apply without a page reload.

### `extension/popup.js`
- On load, reads current settings from `chrome.storage.sync` and sets checkbox state.
- Each toggle writes a single key back to `chrome.storage.sync` on `change`.

### `extension/manifest.json`
- Manifest V3.
- `browser_specific_settings.gecko` is for Firefox only; Chrome ignores it.
- `permissions: ["storage"]` covers `chrome.storage.sync` in both browsers.

## Common tasks

### Add a new toggle (e.g. "Hide end cards")
1. Add a CSS rule to the `CSS` object in `content.js`.
2. Add the toggle row to `popup.html`.
3. Add the read/write logic to `popup.js` (follow the pattern of existing toggles).
4. Update the default in `chrome.storage.sync.get({...})` in both `content.js` and `popup.js`.
5. Update the Usage table in `README.md`.

### Update a CSS selector
Edit `content.js` — the `CSS` object at the top maps feature names to CSS rules. YouTube's DOM can change; check with DevTools on youtube.com if a rule stops working.

### Regenerate the Safari Xcode project
```bash
xcrun safari-web-extension-converter \
  extension \
  --app-name "Comments Block" \
  --bundle-identifier com.yourname.comments-block \
  --swift \
  --project-location . \
  --no-open
```

### Package for Firefox
```bash
cd extension
web-ext build    # output in web-ext-artifacts/ (gitignored)
```

## Gotchas

- YouTube is a single-page app. Always ensure `yt-navigate-finish` listener is present in `content.js` or selector changes won't apply after navigation.
- The `Comments Block/` Xcode project should not be manually edited for extension logic — make changes in `extension/` and rebuild.
- `chrome.storage.sync` is used (not `local`) so settings sync across devices when the user is signed into their browser.
- "Allow Unsigned Extensions" in Safari resets on every browser restart — this is a Safari limitation, not a bug in the extension.
