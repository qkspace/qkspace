$(document).on('turbolinks:load', function () {
  $(document).keydown(function(e) {
    if (e.ctrlKey && e.keyCode == 13) {
      $(':focus').parents('form').submit();
    }

    if (e.keyCode == 27) {
      history.back();
    }
  });
});
