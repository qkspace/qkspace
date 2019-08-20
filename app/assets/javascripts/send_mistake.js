$(document).keydown(function(event) {
  if (event.keyCode == 13 && event.ctrlKey) {
    $('#myModal').modal({
      backdrop: 'static',
      keyboard: true
    });
    var textQuote = copyText();
    pasteText(textQuote);
  };
});

function copyText() { 
  if (window.getSelection) { 
    return textQuote = window.getSelection().toString(); 
  } else if (document.getSelection) { 
    return textQuote = document.getSelection(); 
  } else if (document.selection) { 
    return textQuote = document.selection.createRange().text; 
  } 
} 

function pasteText(textQuote) { 
  if (textQuote=="") { 
    alert("Для вставки цитаты в новое сообщение выделите нужный текст и нажмите - Вставить цитату"); 
    document.getElementById("submit-btn").disabled = true;
  } else if (textQuote.length > 0) { 
    document.getElementById("submit-btn").disabled = false;
    document.getElementById("mistake_field").value += textQuote; 
  } 
}
