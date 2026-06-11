document.addEventListener('DOMContentLoaded', () => {
  const commentsToggle = document.getElementById('blockComments');
  const recsToggle = document.getElementById('blockRecommendations');

  chrome.storage.sync.get({ blockComments: true, blockRecommendations: false }, (s) => {
    commentsToggle.checked = s.blockComments;
    recsToggle.checked = s.blockRecommendations;
  });

  commentsToggle.addEventListener('change', () => {
    chrome.storage.sync.set({ blockComments: commentsToggle.checked });
  });

  recsToggle.addEventListener('change', () => {
    chrome.storage.sync.set({ blockRecommendations: recsToggle.checked });
  });
});
