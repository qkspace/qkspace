$(document).on('turbolinks:load', function () {
  $(document).keydown(function(e) {
    if (e.keyCode == 'N'.charCodeAt(0)) {
      location.href = location.href + "/next";
    }

    if (e.keyCode == 'P'.charCodeAt(0)) {
      location.href = location.href + "/previous";
    }
  });
});
