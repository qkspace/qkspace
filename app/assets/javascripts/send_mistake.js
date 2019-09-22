$(document).keydown(function(event) {
  if (event.keyCode == 13 && event.ctrlKey) {
    $('#sendMistake').modal({
      backdrop: 'static',
      keyboard: true
    });
    var textQuote = copyText();
    pasteText(copyText());
  };
});

function copyText() { 
  if (window.getSelection) { 
    return window.getSelection().toString(); 
  } else if (document.getSelection) { 
    return document.getSelection(); 
  } else if (document.selection) { 
    return document.selection.createRange().text; 
  } 
} 

function pasteText(textQuote) { 
  if (textQuote == "") { 
    alert("Вы не выделили текст с ошибкой. Выделите его и нажмите Ctrl+Enter."); 
    document.getElementById("submitButton").disabled = true;
  } else if (textQuote.length > 0) { 
    document.getElementById("submitButton").disabled = false;
    document.getElementById("mistakeField").value += textQuote; 
  } 
}

$(document).on('turbolinks:load', function() {
  $('#sendMistakeButton').on('click', function(e) {
    if (isValid) {
      grecaptcha.execute();
    }
  })
});

let submitInvisibleRecaptchaForm = function () {
  $("#invisibleRecaptchaForm").submit();
};
