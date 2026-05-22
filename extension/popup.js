document.addEventListener('DOMContentLoaded', () => {
  const commentsToggle = document.getElementById('blockComments');
  const recsToggle = document.getElementById('blockRecommendations');
  const liveChatToggle = document.getElementById('blockLiveChat');
  const shortsToggle = document.getElementById('blockShorts');

  chrome.storage.sync.get({ blockComments: true, blockRecommendations: false, blockLiveChat: false, blockShorts: false }, (s) => {
    commentsToggle.checked = s.blockComments;
    recsToggle.checked = s.blockRecommendations;
    liveChatToggle.checked = s.blockLiveChat;
    shortsToggle.checked = s.blockShorts;
  });

  commentsToggle.addEventListener('change', () => {
    chrome.storage.sync.set({ blockComments: commentsToggle.checked });
  });

  recsToggle.addEventListener('change', () => {
    chrome.storage.sync.set({ blockRecommendations: recsToggle.checked });
  });

  liveChatToggle.addEventListener('change', () => {
    chrome.storage.sync.set({ blockLiveChat: liveChatToggle.checked });
  });

  shortsToggle.addEventListener('change', () => {
    chrome.storage.sync.set({ blockShorts: shortsToggle.checked });
  });
});
