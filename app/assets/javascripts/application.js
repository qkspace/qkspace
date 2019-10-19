// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-throttle-debounce
//= require jquery-ui/widgets/sortable
//= require jquery-ui/effects/effect-highlight
//= require bootstrap
//= require clipboard
//= require sortable
//= require turbolinks
//= require highlight.min
//= require hotkeys
//= require header-link.js
//= require project_slug

// Toast UI
//= require toast

//= require_self

$(document).on('turbolinks:load', function() {
  new Clipboard('.clipboard');
});

$(document).on('turbolinks:load', function() {
  $('#project-private-checkbox').change(function() {
    let projectPrivate = $(this).prop('checked');
    $('#project-secret-enabled-checkbox').prop('disabled', !projectPrivate);
  })
});

$(document).on('turbolinks:load', function() {
  $('#project-comments-enabled-checkbox').change(function() {
    let commentsEnabled = $(this).prop('checked');
    $('#project-alow-unregistered-comments-checkbox').prop('disabled', !commentsEnabled);
  })
});

$(document).on('turbolinks:load', function() {
  $('*[data-role=activerecord_sortable]').activerecord_sortable();
  hljs.initHighlighting.called = false;
  hljs.initHighlighting();
});

$(document).on('input', '.validates-presence', function() {
  let submit = $(this).parents('form').find('input[type=submit]');

  if ($(this).val() === "") {
    submit.prop('disabled', true);
  } else {
    submit.prop('disabled', false);
  }
});


$(document).on('turbolinks:load', function() {
  hash = $(location).attr('hash');

  if (hash != "") {
    $(hash).effect("highlight");
  };
});
