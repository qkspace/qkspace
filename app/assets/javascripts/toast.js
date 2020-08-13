//= require tui-code-snippet/dist/tui-code-snippet
//= require markdown-it/dist/markdown-it
//= require to-mark/dist/to-mark
//= require codemirror/lib/codemirror
//= require highlightjs/highlight.pack
//= require squire-rte/build/squire
//= require highlight.min
//= require tui-editor/dist/tui-editor-Editor.min
//= require tui-editor/dist/tui-editor-extScrollSync.min

// ToastUI load on specific page by "form_for" ID and submit text to textarea
$(document).on('turbolinks:load', function () {
  var toastform = $(".js-toast-form");

  if (toastform.length > 0) {
    var form = toastform[0];
    var textarea = $(".toast-textarea")[0];
    var editorElement = $(".edit-section")[0];

    var editor = new tui.Editor({
      el: editorElement,
      initialValue: textarea.value,
      initialEditType: 'markdown',
      previewStyle: 'vertical',
      height: '640px'
    });

    form.addEventListener('submit', function () {
      textarea.value = editor.getValue();
    });
  }
});
