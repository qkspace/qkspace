$(document).on('turbolinks:load', function () {
  window.hotkeysConfig = {
    'next_page': {
      ctrl:   false,
      action: function() {
        location.href = location.href + "/next";
      }
    },

    'previous_page': {
      ctrl:   false,
      action: function() {
        location.href = location.href + "/previous";
      }
    },

    'edit_page': {
      ctrl:   false,
      action: function() {
        location.href = location.href + "/edit";
      }
    },

    'new_page': {
      ctrl:   false,
      action: function() {
        location.href = $('#new_page').attr('href');
      }
    },

    'post_form': {
      ctrl:   true,
      action: function() {
        $(':focus').parents('form').submit();
      }
    },

    'abort_form': {
      ctrl:   false,
      action: function() {
        history.back();
      }
    }
  };

  window.usedHotkeys = {};

  $(document).keydown(function(e) {
    var currentAction = hotkeysConfig[usedHotkeys[e.keyCode]];

    if (currentAction) {
      if (!currentAction.ctrl || (e.ctrlKey || e.metaKey)) {
        currentAction.action();
      }
    }
  });
});
