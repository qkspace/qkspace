$(document).on('turbolinks:load', function() {

  if ('project_slug' in window) {
    var currentSlug = project_slug.value;
  };

  $('input#project_slug').keyup($.debounce(250, function() {
    const input = $(this);
    const hint = input.parent().children('small.text-muted');
    const error = input.parent().children('.invalid-feedback');
    const slug = input.val();
    const locale = input.data("locale");

    error.hide();

    if (slug.length > 0) {
      $.ajax({
        dataType: 'json',
        cache: false,
        url: '/projects/check_slug?locale=' + locale + '&slug=' + slug + '&current_slug=' + currentSlug,
        timeout: 5000,
        success: (xhr) => {
          const data = xhr.data;
          const hint_message = "<span><strong>" + data.slug +
            "</strong>." + data.domain + "</span>" + data.message;

          hint.html(hint_message);

          const span = hint.children('span');

          if (data.availability || slug == currentSlug) {
            input.removeClass('is-invalid');
            input.addClass('is-valid');
            span.addClass("text-success");
          } else {
            input.removeClass('is-valid');
            input.addClass('is-invalid');
            span.addClass("text-danger");
          }
        }
      });
    } else {
      hint.html("");
    }
  }));
});
