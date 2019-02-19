$(document).on('turbolinks:load', function () {
    $("h1, h2, h3, h4, h5, h6").each(function(i, el) {
        var $el, id;
        $el = $(el);
        id = $el.attr('id');

        if (id !== undefined) {
            $el.prepend($("<a href='#" + id + "' class='header-link'>")
                .html('#'));
        }
    });
});
