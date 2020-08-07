$(document).on('turbolinks:load', function() {
  var clipboard = new Clipboard('a.header-link', {
    text: function (trigger) {
      return  trigger.href;
    }
  });
});
