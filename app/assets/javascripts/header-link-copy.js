  var clipboard = new Clipboard('a.header-link', {
    text: function (trigger) {
      return  trigger.href
    }
  });
  clipboard.on('success', function(e) {
    console.log(e);
  });
  clipboard.on('error', function(e) {
    console.log(e);
  });  
