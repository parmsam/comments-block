const STYLE_ID = 'comments-block-styles';

const CSS = {
  comments: 'ytd-comments { display: none !important; }',
  recommendations: '#secondary { display: none !important; }',
  liveChat: 'ytd-live-chat-frame { display: none !important; }',
  shorts: 'ytd-rich-shelf-renderer[is-shorts], ytd-reel-shelf-renderer { display: none !important; }'
};

function applyStyles(settings) {
  let el = document.getElementById(STYLE_ID);
  if (!el) {
    el = document.createElement('style');
    el.id = STYLE_ID;
    document.head.appendChild(el);
  }
  const rules = [];
  if (settings.blockComments) rules.push(CSS.comments);
  if (settings.blockRecommendations) rules.push(CSS.recommendations);
  if (settings.blockLiveChat) rules.push(CSS.liveChat);
  if (settings.blockShorts) rules.push(CSS.shorts);
  el.textContent = rules.join('\n');
}

function refresh() {
  chrome.storage.sync.get({ blockComments: true, blockRecommendations: false, blockLiveChat: false, blockShorts: false }, applyStyles);
}

// YouTube is a SPA — reapply on each navigation
document.addEventListener('yt-navigate-finish', refresh);

// Reapply when settings change via the popup
chrome.storage.onChanged.addListener(refresh);

refresh();
