$(document).on('turbolinks:load', function () {
  var new_page = $('#new_page').attr('href');

  $(document).keydown(function(e) {
    if (e.keyCode == 'C'.charCodeAt(0)) {
      location.href = new_page;
    }

    if (e.keyCode == 'N'.charCodeAt(0)) {
      location.href = location.href + "/next";
    }

    if (e.keyCode == 'P'.charCodeAt(0)) {
      location.href = location.href + "/previous";
    }

    if (e.keyCode == 'E'.charCodeAt(0)) {
      location.href = location.href + "/edit";
    }
  });
});
