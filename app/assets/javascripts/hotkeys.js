$(document).on('turbolinks:load', function () {
  window.hotkeysConfig = {
    'next_page': {
      ctrl:       false,
      key_codes:  ["N".charCodeAt(0), "S".charCodeAt(0)],
      action:     function() {
        location.href = location.href + "/next";
      }
    },

    'previous_page': {
      ctrl:       false,
      key_codes:  ["P".charCodeAt(0), "W".charCodeAt(0)],
      action:     function() {
        location.href = location.href + "/previous";
      }
    },

    'edit_page': {
      ctrl:       false,
      key_codes:  ["E".charCodeAt(0)],
      action:     function() {
        location.href = location.href + "/edit";
      }
    },

    'new_page': {
      ctrl:       false,
      key_codes:  ["C".charCodeAt(0)],
      action:     function() {
        location.href = $('#new_page').attr('href');
      }
    },

    'post_form': {
      ctrl:       true,
      key_codes:  [13],
      action:     function() {
        $(':focus').parents('form').submit();
      }
    },

    'abort_form': {
      ctrl:       false,
      key_codes:  [27],
      action:     function() {
        history.back();
      }
    }
  };

  window.hotkeys = {
    activate: function(preset = '') {
      switch(preset) {
        case 'form':
          window.usedHotkeys = ['post_form', 'abort_form'];
          break;
        case 'public_project_page':
          window.usedHotkeys = ['next_page', 'previous_page'];
          break;
        case 'private_project_page':
          window.usedHotkeys = ['next_page', 'previous_page', 'new_page', 'edit_page'];
          break;
        default:
          window.usedHotkeys = [];
      }
    }
  };

  hotkeys.activate();

  $(document).keydown(function(e) {
    for (var key in usedHotkeys) {
      var currentAction = hotkeysConfig[usedHotkeys[key]];

      if (currentAction.key_codes.includes(e.keyCode)) {
        if (!currentAction.ctrl || (e.ctrlKey || e.metaKey)) {
          currentAction.action();
        }
      }
    }
  });
});
