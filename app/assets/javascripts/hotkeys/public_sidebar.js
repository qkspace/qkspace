$(document).on('turbolinks:load', function () {
  window.usedHotkeys = {};
  usedHotkeys['N'.charCodeAt(0)] = 'next_page';
  usedHotkeys['P'.charCodeAt(0)] = 'previous_page';
  usedHotkeys['W'.charCodeAt(0)] = 'previous_page';
  usedHotkeys['S'.charCodeAt(0)] = 'next_page';
});
